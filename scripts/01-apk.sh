#!/bin/sh -eux

# Configure the main repository mirrors.
printf 'https://mirror.math.princeton.edu/pub/alpinelinux/v3.15/main\n' >/etc/apk/repositories
printf 'https://mirror.math.princeton.edu/pub/alpinelinux/v3.15/community\n' >>/etc/apk/repositories

apk update --no-cache
apk upgrade

apk add docker
rc-update add docker default

# remove pre-installed apps and daemons
rc-service virtualbox-guest-additions stop
rc-update delete virtualbox-guest-additions default

apk del virtualbox-guest-additions

rc-service haveged stop
rc-update delete haveged default

apk del haveged

apk del man-pages gawk lsof file grep readline mdocml mlocate sysstat findutils sysfsutils dmidecode libmagic sqlite-libs ca-certificates ncurses-libs ncurses-terminfo ncurses-terminfo-base psmisc
