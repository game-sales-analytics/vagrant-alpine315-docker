#!/bin/sh -eux

# Ensure the network shuts down properly.
printf 'keep_network="NO"\n' >>/etc/rc.conf

# source: https://github.com/OpenRC/openrc/blob/master/conf.d/net-online
tee /etc/conf.d/net-online <<-EOF
interfaces="eth0"

include_ping_test=no

timeout=20
EOF
chmod 644 /etc/conf.d/net-online

# Ensure SSHD waits until the network is up and running before launching.
printf 'rc_need="net-online"\n' >>/etc/conf.d/sshd

# Enable the net-online target.
rc-update add net-online default
rc-update -u
