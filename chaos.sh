#!/bin/bash

hosts=(null "192.168.6.2" "192.168.6.3" "192.168.6.4")
joined=$(printf ",%s" "${hosts[@]}")
joined=${joined:1}

if [[ $# -eq 0 || $1 == "help" ]]
then
    echo -e "Usage:\n chaos.sh help => Usage information\n chaos.sh list => List available scenarios\n chaos.sh <scenario-name> <machine-id> <arg1> <arg2> ..\n"
    exit 0
fi

if [ $1 == "list" ]
then
    ls scripts|sed "s/.sh//"
    exit 0
fi

arg=""
for (( i=3; i<=$#; i+=1 ))
do
    arg="${arg} ${!i}"
done

echo $joined
echo $2
echo $arg
echo scripts/$2.sh $joined $arg

ssh vagrant@${hosts[$1]} -q -i ~/.vagrant.d/insecure_private_key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o PasswordAuthentication=no -o IdentitiesOnly=yes "sudo bash -s" < scripts/$2.sh $joined $arg 
