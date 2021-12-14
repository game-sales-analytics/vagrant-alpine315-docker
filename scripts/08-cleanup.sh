#!/bin/sh -eux

# update all packages, especially the kernel.
apk update && apk upgrade

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
