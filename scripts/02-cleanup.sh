#!/bin/sh -eux

# remove unnecessary tools already installed by generic base box
apk del virtualbox-guest-additions haveged vim man-pages lsof file mdocml mlocate sysstat findutils sysfsutils dmidecode libmagic sqlite-libs ncurses-terminfo psmisc

# clear apk cache to reduce final box size
rm -rf /var/cache/apk/*

dd if=/dev/zero of=/EMPTY bs=1M
rm -rf /EMPTY
rm -rf /var/cache/apk/*
# Block until the empty file has been removed, otherwise, Packer
# will try to kill the box while the disk is still full and that's bad
sync
sync
sync
sync
sync
sync
sync

exit 0
