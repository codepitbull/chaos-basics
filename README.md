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

#Notes
tc qdisc show dev enp0s8

#Demo
java -jar /vagrant/shared/counter-demo-assembly-0.1-SNAPSHOT.jar --config /vagrant/shared/target-host1.json
java -jar /vagrant/shared/counter-demo-assembly-0.1-SNAPSHOT.jar --config /vagrant/shared/target-host2.json

./chaos.sh 1 net_delay enp0s8 100000 70000
./chaos.sh 1 net_clear enp0s8
./chaos.sh 1 net_delay_rate_limit enp0s8 10000
./chaos.sh 1 net_clear enp0s8
./chaos.sh 1 net_loss enp0s8 20
./chaos.sh 1 disk_delay 30000000 500 500

mount /dev/mapper/delay /mnt
time touch /mnt/1

badblocks -v /dev/mapper/error

badblocks -v /dev/mapper/stretch--vg-root
Checking blocks 0 to 32776191
Checking for bad blocks (read-only test): done
Pass completed, 0 bad blocks found. (0/0/0 errors)

#TODO
- Use *change* for tc if roort already exists to allow stacking and changing of values.
