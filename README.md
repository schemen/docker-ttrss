# docker-ttrss

This is a collection of two docker containers to run ttrss.
I've added two compose files as examples, you can modify them as you want.

## The containers

The two containers share the same data volume. The user that runs those is id 1001:1001. Make sure `ttrss-data` writtable.

### ttrss-app

Container running php-fpm. This container is also used to run the update daemon and git for updates to ttrss code.
Each function can only run once. (replicas=1)

* worker start

You can start this container as worker (updating the feeds).

* web start

this will start the php-fpm process.

* update start

this will start an update loop that runs a git pull all 24h

#### Environment variables

`TTRRS_GIT="https://git.tt-rss.org/fox/tt-rss.git"`

 You can set a repository to use to pull the ttrss code as sometimes it might be unavailable in the original location

### ttrss-nginx

Container with a simple config file to serve the content