#!/bin/sh -eux

# clear apk cache to reduce final box size
rm -rf /var/cache/apk/*

dd if=/dev/zero of=/EMPTY || true
rm -rf /EMPTY
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
