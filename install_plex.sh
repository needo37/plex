#!/bin/bash
set -e
set -u
set -o pipefail

DEB_URL=$(curl -sL https://plex.tv/downloads | sed -nr 's#.*href="(.+?/plexmediaserver_.+?_amd64\.deb)".*#\1#p')
PLEX_VERSION=$(echo $DEB_URL | awk -F_ '{print $2}')

echo Installing Plex Media Server $PLEX_VERSION

curl -sL $DEB_URL > /tmp/plexmediaserver.deb
apt-get update
gdebi -n /tmp/plexmediaserver.deb
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

echo $PLEX_VERSION > /tmp/version
