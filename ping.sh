#!/bin/bash
ping  -c 3 -i 0.2 -w 1 $1 &> /dev/null
if  [ $? -eq 0 ];then
    echo "$1 is up" >> /opt/log.txt
    echo "$1 is up"
else 
    echo  "$1 is not up" >> /opt/log.txt
    echo  "$1 is not up"
fi
