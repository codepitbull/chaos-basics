#!/bin/bash

hosts=(null "192.168.6.2" "192.168.6.3" "192.168.6.4")

arg=""
for (( i=3; i<=$#; i+=1 ))
do
    arg="${arg} ${!i}"
done

ssh vagrant@${hosts[$1]} -q -i ~/.vagrant.d/insecure_private_key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o IdentitiesOnly=yes "bash -s" < scripts/$2.sh $arg 
