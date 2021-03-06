#!/bin/sh -eux

tee /usr/bin/lsb_release <<-EOF
#!/bin/sh
printf "Distributor ID:	Alpine3.15\n"
EOF
chmod 755 /usr/bin/lsb_release

# So the vagrant halt command works properly.
tee /usr/sbin/shutdown <<-EOF
#!/bin/sh
sudo /sbin/poweroff
EOF
chmod 755 /usr/sbin/shutdown

# docker requires / mount point to be shared or slaved.
tee /etc/local.d/share-root-mnt.start <<-EOF
#!/bin/sh
mount --make-shared /
EOF
chmod 755 /etc/local.d/share-root-mnt.start
rc-update add local boot
