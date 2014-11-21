#!/bin/bash

mkdir -p /var/run/dbus
chown messagebus:messagebus /var/run/dbus
dbus-uuidgen --ensure
dbus-daemon --system --fork
sleep 1

avahi-daemon -D
sleep 1

# Check to see what version of Plex is installed vs what is being requested. If requested version is different
# install that one 

INSTALLED=`dpkg-query -W -f='${Version}' plexmediaserver`

if [ -z "$VERSION" ]; then
  echo "Version not specified."
  exit 0
fi

if [ "$VERSION" = "$INSTALLED" ]; then
  echo "Version not changed"
else
  mv /etc/default/plexmediaserver /tmp/
  apt-get remove --purge -y plexmediaserver
  wget -P /tmp "http://downloads.plexapp.com/plex-media-server/$VERSION/plexmediaserver_${VERSION}_amd64.deb"
  gdebi -n /tmp/plexmediaserver_${VERSION}_amd64.deb
  mv /tmp/plexmediaserver /etc/default/
fi
