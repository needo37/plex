#!/bin/bash

# Check to see what version of Plex is installed vs what is being requested. If requested version is different
# install that one 

INSTALLED=`dpkg-query -W -f='${Version}' plexmediaserver`

if [ -z "$VERSION" ]; then
    PLEX_URL=$(curl -sL http://plex.baconopolis.net/latest.php | sed -nr 's#(http.+?/plexmediaserver_.+?_amd64\.deb)#\1#p')
else
    PLEX_URL=$(curl -sL http://plex.baconopolis.net/version.php?version=${VERSION} | sed -nr 's#(http.+?/plexmediaserver_.+?_amd64\.deb)#\1#p')
fi
PLEX_VERSION=$(echo $PLEX_URL | awk -F_ '{print $2}')

if [ -z "$PLEX_VERSION" ]; then
    echo "Unable to get plex version"
    exit 0
fi
if [ "$PLEX_VERSION" = "$INSTALLED" ]; then
    echo "Version not changed - $PLEX_VERSION"
else
    echo "Updating to $PLEX_VERSION from $INSTALLED"
    # Don't uninstall the old version of plex if the download fails
    wget -q "${PLEX_URL}" -O /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb
    if [ $? -eq 0 ]; then
        mv /etc/default/plexmediaserver /tmp/
        apt-get remove --purge -y plexmediaserver
        gdebi -n /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb
        mv /tmp/plexmediaserver /etc/default/
        rm -f /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb
        echo $PLEX_VERSION > /tmp/version
    else
        echo "Download failed, please try again later"
    fi
fi
