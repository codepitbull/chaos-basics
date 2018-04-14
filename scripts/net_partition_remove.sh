#!/usr/bin/env bash
IFS=', ' read -r -a hosts <<< "$1"
sudo iptables -D INPUT -s ${hosts[$2]} -j DROP
sudo iptables -D OUTPUT -d ${hosts[$2]} -j DROP
