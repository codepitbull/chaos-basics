#!/bin/sh
set -o nounset
set -o errexit

if [[ $# -eq 0 ]] || [[ $# -eq 1  && $1=="--help-chaos" ]]
  then
    printf "disk_delay <size-in-blocks> <read-delay-in-ms> <write-delay-in-ms>: Create a disk of size <size-in-blocks> with a <read-delay-in-ms> and a <write-delay-in-ms>."
  exit 0
fi

device='/dev/ram0'
#create a RAM disk
modprobe brd rd_nr=1 rd_size=$2
readdelay=$3
writedelay=$4
size=$(blockdev --getsize $device) # Size in 512-bytes sectors
mkfs.ext4 $device
echo -e '0 '$size' delay '$device' 0 '$readdelay' '$device' 0 '$writedelay | dmsetup create delay
