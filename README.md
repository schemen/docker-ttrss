# docker-ttrss
This is a collection of two docker containers to run ttrss.
I've added two compose files as examples, you can modify them as you want.


## The containers
The two containers share the same data volume.

### ttrss-app
Container running php-fpm. This container is also used to run the update daemon and git for updates to ttrss code.

#### Environment variables
> TTRRS_GIT="https://git.tt-rss.org/fox/tt-rss.git"

 You can set a repository to use to pull the ttrss code as sometimes it might be unavailable in the original location

### ttrss-nginx
Container with a simple config file to serve the content