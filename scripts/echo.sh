#!/bin/bash
for (( i=3; i<=$#; i+=1 ))
do
    arg="${arg} ${!i}"
done

echo "Narf $arg"
