#!/bin/sh -eux

# Configure the main repository mirrors.
printf 'https://mirror.math.princeton.edu/pub/alpinelinux/v3.15/main\n' >/etc/apk/repositories
printf 'https://mirror.math.princeton.edu/pub/alpinelinux/v3.15/community\n' >>/etc/apk/repositories

# update package cache and then upgrade.
apk update --no-cache
apk upgrade

# install docker
apk add docker

# set vagrant user permissions to use docker commands without sudo
addgroup vagrant docker

# add docker to OpenRC default run-level
rc-update add docker default
