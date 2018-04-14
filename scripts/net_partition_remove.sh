#!/usr/bin/env bash
sudo iptables -D INPUT -s $1 -j DROP
sudo iptables -D OUTPUT -d $1 -j DROP
