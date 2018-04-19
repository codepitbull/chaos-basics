#!/usr/bin/env bash
#Config using FIFO adding a fixed delay of 100ms
tc qdisc add dev enp0s8 root netem delay $2
