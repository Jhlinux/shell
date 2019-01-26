#!/bin/bash
#编写脚本测试192.168.4.0/24 整个网段中哪些主机处于开机状态，哪些主机处于关机状态
i=1
while [ $i -le 254 ]
do
    ping -c 2 -i 0.3 -w 0.2 192.168.4.$i &> /dev/null
    if [ $? -eq 0 ];then
         echo  "192.168.4.$i is up !!"
    else 
         echo  "192.168.4.$i is down!!"
    fi
    let i++
done
#####################################
#编写脚本实现判断用户的输入，当用户输入tom时，提示用户猜对了并退出程序，否则提示用户输入
#  while : ====>>> 无限循环
while :
do 
     read -p "请输入您要猜的名字：" uname
     if [ $uname == "tom" ];then
           echo "you are gussing right"
           exit
     fi
done
###############################################################################这是个类加的while循环,将用户输入数字加起来求和，当输入0的时候退出脚本并输出总和
while : 
do 
    read -p "请输入一个数：" num
    [ $num -eq 0 ] && break
    let sum+=num
done
echo 总和是$sum
