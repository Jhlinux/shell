#!/bin/bash
uip=192.168.4
for ((ip=1;ip<=254;ip++ ))
do
   ping -c -i 0.2 -w 0.2 $uip.$ip &> /dev/null
   if [ $? -eq 0 ];then
      echo "$uip.$ip 是通的" >> /root/ip.txt
   else 
      echo "$uip.$ip 是不通的" >> /root/ip.txt
   fi
done
echo "主人，ping的结果已经过保存到/root/ip.txt 中了，快去查看吧！！！" 
