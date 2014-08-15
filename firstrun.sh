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

# Grab the latest Plexpass verion of Plex from the plex.tv site

LATEST=`wget -q --no-check-certificate -O - "https://plex.tv/downloads"| grep -o '[^"'"'"']*plexmediaserver_.*amd64.deb'| cut -d "/" -f 5`

if [ -z "$VERSION" ]; then
  echo "Version not specified."
  exit 0
fi

if [ "$VERSION" = "$INSTALLED" ]; then
  echo "Version not changed"
elif ["$VERSION" = "Latest"]; then
  mv /etc/default/plexmediaserver /tmp/
  apt-get remove --purge -y plexmediaserver
  wget -P /tmp "http://downloads.plexapp.com/plex-media-server/$LATEST/plexmediaserver_${LATEST}_amd64.deb"
  gdebi -n /tmp/plexmediaserver_${LATEST}_amd64.deb
  mv /tmp/plexmediaserver /etc/default/
else
  mv /etc/default/plexmediaserver /tmp/
  apt-get remove --purge -y plexmediaserver
  wget -P /tmp "http://downloads.plexapp.com/plex-media-server/$VERSION/plexmediaserver_${VERSION}_amd64.deb"
  gdebi -n /tmp/plexmediaserver_${VERSION}_amd64.deb
  mv /tmp/plexmediaserver /etc/default/
fi
