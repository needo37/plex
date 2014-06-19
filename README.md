This is a Dockerfile setup for plex with plexpass - http://plex.tv/

To run:

docker run -d --net="host" --name="plex" -v /path/to/plex/config:/config -v /path/to/video/files:/data -p 32400:32400 needo/plex

After install go to:

http://server:32400/web/index.html#!/dashboard and login with your myPlex credentials

ACKNOWLEDGEMENT:

The majority of this was blantantly copied from https://registry.hub.docker.com/u/eschultz/docker-plex/ I just needed some small tweaks to suit my needs
