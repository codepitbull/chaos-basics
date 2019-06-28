#!/bin/bash
set -o nounset
set -o errexit

if [[ $# -eq 0 ]] || [[ $# -eq 1  && $1=="--help-chaos" ]]
  then
    printf "disk_random_hole_puncher: <size-in-k>"
  exit 0
fi

#Create device with 128MB
device='/dev/loop1'
k_blocks=$1
half_k_blocks=$((k_blocks*2))
dd if=/dev/zero of=/tmp/error_random_holes.img bs=512 count=$half_k_blocks
losetup $device /tmp/error_random_holes.img

start_sector=0
good_sector_size=0

for sector in {0..128000}; do

    if [[ ${RANDOM} == 0 ]]; then
        echo "${start_sector} ${good_sector_size} linear ${device} ${start_sector}"
        echo "${sector} 1 error"
        start_sector=$((${sector}+1))
        good_sector_size=0
    else
        good_sector_size=$((${good_sector_size}+1))
    fi
done

echo "${start_sector} $((${good_sector_size}-1)) linear ${device} ${start_sector}"

