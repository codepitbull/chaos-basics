#!/usr/bin/env bash
set -o nounset
set -o errexit

if [[ $# -eq 0 ]] || [[ $# -eq 1  && $1=="--help-chaos" ]]
  then
    printf "net_clear <dev> : Clear all tc-rules from device <dev>"
  exit 0
fi

tc qdisc delete dev $2 root
