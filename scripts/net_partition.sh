#!/usr/bin/env bash
sudo iptables -I INPUT -s $1 -j DROP
sudo iptables -I OUTPUT -d $1 -j DROP
