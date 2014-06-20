#! /bin/sh

rm -rf /var/run/*
rm -f "/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"

mkdir -p /var/run/dbus
chown messagebus:messagebus /var/run/dbus
dbus-uuidgen --ensure
dbus-daemon --system --fork
sleep 1

avahi-daemon -D
sleep 1

su -c "HOME=/config /usr/sbin/start_pms &" plex
sleep 5

tail -f /config/Library/Application\ Support/Plex\ Media\ Server/Logs/**/*.log
