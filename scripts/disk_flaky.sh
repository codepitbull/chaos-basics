#!/bin/sh
device='/dev/loop1'
mknod -m 0660 $device b 7 8
#Create device with 128MB
dd if=/dev/zero of=/tmp/flaky.img bs=512 count=256000
losetup $device /tmp/flaky.img
mkfs.ext4 $device

#Add drop_writes/error_writes/corrupt_bio_byte
#https://github.com/torvalds/linux/blob/master/Documentation/device-mapper/dm-flakey.txt
dmsetup create flakey --table '0 255978 flakey /dev/loop1 0 10 2'