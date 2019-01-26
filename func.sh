#!/bin/bash
#编写脚本测试192.168.4.0/24 整个网段中哪些主机处于开机状态，哪些主机处于关机状态#定义一个函数 ping某一台主机，并检测主机的存活状态
myping(){
   ping -c 2 -i 0.2 -w 0.3 $1 &> /dev/null
   if  [ $? -eq 0 ];then
        echo "$1 is up !!"
   else
        echo "$1 is down !!"
   fi
}
for i in {1..254}
do 
    myping 192.168.4.$i &
done

