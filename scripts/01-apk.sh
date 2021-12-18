#!/bin/sh -eux

# Configure the main repository mirrors.
printf 'https://mirror.math.princeton.edu/pub/alpinelinux/v3.15/main\n' >/etc/apk/repositories
printf 'https://mirror.math.princeton.edu/pub/alpinelinux/v3.15/community\n' >>/etc/apk/repositories

# Update the package list and then upgrade.
apk update --no-cache
apk upgrade

apk add docker
rc-update add docker default

rm -rf /var/cache/apk/*
