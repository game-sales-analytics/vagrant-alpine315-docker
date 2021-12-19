#!/bin/sh -eux

# docker requires / mount point to be shared or slaved.
tee /etc/local.d/share-root-mnt.start <<-EOF
#!/bin/sh

mount --make-shared /
EOF
chmod 755 /etc/local.d/share-root-mnt.start
rc-update add local boot
