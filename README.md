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
- Integrate ntpdsim

#NTPDSIM
ntpdsim was removed from all debian absed distros ...
So we need to build it from scratch (best inside one of the vagrant boxes, build is quite fast)


```apt-get source ntp```
Switch to the now created source-folder.

```sudo apt-get install dpkg-dev libtool lynx automake autotools-dev make -y```

Create scripts/ntpver.in with the following content (taken from https://github.com/dfc/ntp-mirror/blob/master/scripts/ntpver.in)
```
#!@CONFIG_SHELL@
# print version string of NTP daemon
# Copyright (c) 1997 by Ulrich Windl
# Modified 970318: Harlan Stenn: rewritten...
# usage: ntpver hostname

ntpq -c "rv 0 daemon_version" $* | @AWK@ '/daemon_version/ { print $2 }'
```

```
./bootstrap
./configure --enable-simulator
make
```

The simulator is now here: *ntp/ntpdsim*

##Quick example
from https://www.eecis.udel.edu/~mills/ntp/html/ntpdsim.html:
rm ./ntpstats/*
ntpdsim -O 0.1 -C .001 -T 400 -W 1 -c ./ntp.conf,

which starts the simulator with a time offset 100 ms, network jitter 1 ms, frequency offset 400 PPM and oscillator wander 1 PPM/s. These parameters represent typical conditions with modern workstations on a Ethernet LAN. The ntp.conf file should contain something like

disable kernel
server pogo
driftfile ./ntp.drift
statsdir ./ntpstats/
filegen loopstats type day enable
filegen peerstats type day enable
