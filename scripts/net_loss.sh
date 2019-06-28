#!/usr/bin/env bash
set -o nounset
set -o errexit

if [[ $# -eq 0 ]] || [[ $# -eq 1  && $1=="--help-chaos" ]]
  then
    printf "net_loss <dev> <loss-in-percent>>: Add a package loss percentage of <loss-in-percent> to device <dev>."
  exit 0
fi
#Lose 1% of incoming packages
tc qdisc add dev $1 root netem loss $2.0%
