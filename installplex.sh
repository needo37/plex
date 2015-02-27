#!/bin/bash
if [ -z "$VERSION" ]; then
    PLEX_URL=$(curl -sL http://plex.baconopolis.net/latest.php | sed -nr 's#(http.+?/plexmediaserver_.+?_amd64\.deb)#\1#p')
else
    PLEX_URL=$(curl -sL http://plex.baconopolis.net/version.php?version=${VERSION} | sed -nr 's#(http.+?/plexmediaserver_.+?_amd64\.deb)#\1#p')
fi
PLEX_VERSION=$(echo $PLEX_URL | awk -F_ '{print $2}')

if [ -z "$PLEX_VERSION" ]; then
    # Fallback to public release if latest PlexPass call fails
    PLEX_URL=$(curl -sL https://plex.tv/downloads | sed -nr 's#.*href="(.+?/plexmediaserver_.+?_amd64\.deb)".*#\1#p')
    PLEX_VERSION=$(echo $PLEX_URL | awk -F_ '{print $2}')
fi

echo Installing Plex Media Server $PLEX_VERSION

wget -q "$PLEX_URL" -O /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb
if [ $? -eq 0 ]; then
    gdebi -n /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb
    rm -f /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb
    echo $PLEX_VERSION > /tmp/version
else
    echo "ERROR! Problem downloading Plex"
fi