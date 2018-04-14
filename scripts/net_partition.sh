#!/usr/bin/env bash
IFS=', ' read -r -a hosts <<< "$1"
sudo iptables -I INPUT -s ${hosts[$2]} -j DROP
sudo iptables -I OUTPUT -d ${hosts[$2]} -j DROP
