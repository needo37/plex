This is a Dockerfile setup for plex with plexpass - http://plex.tv/

To run the latest plexpass version:

docker run -d --net="host" --name="plex" -v /path/to/plex/config:/config -v /path/to/video/files:/data -v /etc/localtime:/etc/localtime:ro -p 32400:32400 needo/plex

If you would like to specify a specific version of plex to run:

docker run -d --net="host" --name="plex" -v /path/to/plex/config:/config -v /path/to/video/files:/data -v /etc/local
time:/etc/localtime:ro -e VERSION=0.9.9.8.436-8abe5c0 -p 32400:32400 needo/plex

NOTE: It *must* be the full version name (i.e. 0.9.9.8.436-8abe5c0) replace with the version you desire in the command above

After install go to:

http://server:32400/web/index.html#!/dashboard and login with your myPlex credentials
