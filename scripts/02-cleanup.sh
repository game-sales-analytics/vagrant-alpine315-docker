#!/bin/sh -eux

# remove unnecessary tools already installed by generic base box
apk del virtualbox-guest-additions haveged vim man-pages lsof file mdocml mlocate sysstat findutils sysfsutils dmidecode libmagic sqlite-libs ncurses-terminfo psmisc

# clear apk cache to reduce final box size
rm -rf /var/cache/apk/*
