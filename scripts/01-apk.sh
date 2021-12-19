#!/bin/sh -eux

# Configure the main repository mirrors.
printf 'https://mirror.math.princeton.edu/pub/alpinelinux/v3.15/main\n' >/etc/apk/repositories
printf 'https://mirror.math.princeton.edu/pub/alpinelinux/v3.15/community\n' >>/etc/apk/repositories

# update package cache and then upgrade.
apk update --no-cache
apk upgrade

# install docker
apk add docker

# add docker to OpenRC default run-level
rc-update add docker default

# set vagrant user permissions to use docker commands without sudo
addgroup vagrant docker

# remove unnecessary tools already installed by generic base box
apk del vim man-pages lsof file mdocml mlocate sysstat findutils sysfsutils dmidecode libmagic sqlite-libs ncurses-terminfo psmisc

# clear apk cache to reduce final box size
rm -rf /var/cache/apk/*
