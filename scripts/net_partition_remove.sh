#!/usr/bin/env bash
IFS=', ' read -r -a hosts <<< "$2"
iptables -D INPUT -s ${hosts[$1]} -j DROP
iptables -D OUTPUT -d ${hosts[$1]} -j DROP
