#!/bin/sh -eux

printf "\n127.0.0.1\talpine315 alpine315.localdomain\n" >>/etc/hosts
echo "alpine315.localdomain" >/etc/hostname
hostname alpine315.localdomain
