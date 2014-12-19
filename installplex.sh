if [ -z "$VERSION" ]; then
    PLEX_URL=$(curl -sL http://plex.baconopolis.net/latest.php)
else
    PLEX_URL=$(curl -sL http://plex.baconopolis.net/version.php?version=${VERSION})
fi
PLEX_VERSION=$(echo $PLEX_URL | awk -F_ '{print $2}')

echo Installing Plex Media Server $PLEX_VERSION

wget -P /tmp "$PLEX_URL"
gdebi -n /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb
rm -f /tmp/plexmediaserver_${PLEX_VERSION}_amd64.deb
echo $PLEX_VERSION > /tmp/version
