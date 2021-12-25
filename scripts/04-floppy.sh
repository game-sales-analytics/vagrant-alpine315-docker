#!/bin/sh -eux

printf 'blacklist floppy\n' >/etc/modprobe.d/floppy.conf
mkinitfs
