#!/bin/bash
set -e

# Get Github Repository
if [ -z $TTRRS_GIT ]; then
    TTRRS_GIT="https://git.tt-rss.org/fox/tt-rss.git"
else
    TTRRS_GIT=$TTRRS_GIT
fi  


if [ "$1" = 'web' ]; then
    # Check if version is checked out or not, if not, clone repository
    if git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Repository already cloned"
    else
        git clone $TTRRS_GIT .
    fi
    /usr/sbin/php-fpm8 -F
fi

if [ "$1" = 'worker' ]; then
    # Verify that lock files are gone
    # Please make sure that there is always ONLY 1 worker running
    echo "Removing previous/old update_daemon lockfiles..."
    rm -f ./lock/update_daemon*
    while true;
    do
        /usr/bin/php8 /data/update_daemon2.php
    done
fi


if [ "$1" = 'updater' ]; then
    # Check if version is checked out or not, if not, clone repository
    while true;
    do
        if git rev-parse --git-dir > /dev/null 2>&1; then
            echo "Trying to update..."
            git pull
            echo "sleeping for 24h..."
            sleep 24h
        else
            echo "No codebase to update yet, waiting a bit..."
            sleep 60
        fi
    done
fi

exec "$@"
