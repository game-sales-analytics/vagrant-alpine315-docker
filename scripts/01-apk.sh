#!/bin/sh -eux

# Configure the main repository mirrors.
printf 'https://mirror.math.princeton.edu/pub/alpinelinux/v3.15/main\n' >/etc/apk/repositories
printf 'https://mirror.math.princeton.edu/pub/alpinelinux/v3.15/community\n' >>/etc/apk/repositories

# Update the package list and then upgrade.
apk update --no-cache
apk upgrade

apk add docker
rc-update add docker default

apk del vim man-pages lsof file mdocml mlocate sysstat findutils sysfsutils dmidecode libmagic sqlite-libs ncurses-terminfo psmisc

rm -rf /var/cache/apk/*
