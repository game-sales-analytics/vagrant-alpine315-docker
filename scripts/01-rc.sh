#!/bin/sh -eux

# add docker to OpenRC default run-level
rc-update add docker default

# remove/disable pre-installed apps and daemons
rc-service virtualbox-guest-additions stop
rc-update delete virtualbox-guest-additions default
rc-service haveged stop
rc-update delete haveged default

# docker requires / mount point to be shared or slaved.
tee /etc/local.d/share-root-mnt.start <<-EOF
#!/bin/sh

mount --make-shared /
EOF
chmod 755 /etc/local.d/share-root-mnt.start
rc-update add local boot
