#!/bin/sh -x

# Install the Virtual Box Tools from the Linux Guest Additions ISO.
printf "Installing the Virtual Box Tools.\n"

# Add the edge package repo.
# printf "@edge-main https://sjc.edge.kernel.org/alpine/edge/main\n" >> /etc/apk/repositories
# printf "@edge-testing https://sjc.edge.kernel.org/alpine/edge/testing\n" >> /etc/apk/repositories
# printf "@edge-community https://sjc.edge.kernel.org/alpine/edge/community\n" >> /etc/apk/repositories

# Update the package list.
# retry apk update --no-cache

# Install the VirtualBox kernel modules for guest services.
# retry apk add virtualbox-guest-modules-virt@edge-community virtualbox-guest-additions@edge-community
retry apk add virtualbox-guest-additions

# Autoload the virtualbox kernel modules.
rc-update add virtualbox-guest-additions default && rc-service virtualbox-guest-additions start

# Cleanup.
rm -rf /root/VBoxVersion.txt
rm -rf /root/VBoxGuestAdditions.iso

# Boosts the available entropy which allows magma to start faster.
retry apk add haveged

# Autostart the haveged daemon.
rc-update add haveged default && rc-service haveged start
