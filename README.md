git clone https://github.com/ntp-project/ntp.git
cd ntp

ntpver.in is currently missing in stable, I added one from here:
https://github.com/dfc/ntp-mirror/blob/master/scripts/ntpver.in

vi scripts/ntpver.in
```
#!@CONFIG_SHELL@
# print version string of NTP daemon
# Copyright (c) 1997 by Ulrich Windl
# Modified 970318: Harlan Stenn: rewritten...
# usage: ntpver hostname

ntpq -c "rv 0 daemon_version" $* | @AWK@ '/daemon_version/ { print $2 }'
```

apt-get source ntp
sudo apt-get install dpkg-dev libtool lynx automake autotools-dev make -y
./bootstrap
./configure --enable-simulator
make

ntp/ntpdsim


In its current state the source provided by Ubuntu for the ntp package won't build.

#Usage
Bring up he three test-nodes using `vagrant up`.

Use `chaos.sh <scenario> <machine-id> <arg1> <arg2> ...` to launch the different scenarios.
#Tools used
tc
iptables
tcpkill
dmsetup
stress
wrk
