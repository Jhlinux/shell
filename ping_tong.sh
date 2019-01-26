#!/bin/bash
#这是个ping 主机的脚本用于测试192.168.4.0/24网段内的所有主机，判断哪些主机是开机的，哪些主机是关机的 并且统计有多少台主机是开着的，有多少主机是关着的
###########   写法一：
uip='192.168.4'
sum_tong=0
sum_ntong=0
for ip in {1..255}
do 
     ping -c 3 -i 0.2 -w 0.5 $uip.$ip  &> /dev/null
     if [ $? -eq 0 ];then
          echo "$uip.$ip is up !!!"
          let sum_tong++
     else
          echo "$uip.$ip is down !!!"
          let sum_ntong++
     fi
     
done
echo "$sum_tong 台主机是开着的"
echo "$sum_ntong 台主机是关着的" 
##########################################################################   写法二
uip=192.168.4
sum_tong=0
sum_ntong=0
for ((ip=1;ip<=255;ip++ ))
do 
    ping -c 3 -i 0.3 -w 0.5 $uip.$ip &> /dev/null
    if [ $? -eq 0 ];then
        echo "$uip.$ip is up!!!"
        let sum_tong++
    else
        echo "$uip.$ip is down!!!"
        let sum_ntong++
    fi
done
echo "$sum_tong 台主机是开着的"
echo "$sum_ntong 台主机是关着的"
