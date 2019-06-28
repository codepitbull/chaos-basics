#!/usr/bin/env bash
IFS=', ' read -r -a hosts <<< "$2"
iptables -I INPUT -s ${hosts[$1]} -j DROP
iptables -I OUTPUT -d ${hosts[$1]} -j DROP
