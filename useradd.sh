#!/bin/bash
#这是个批量创建帐号的小教本
#帐号名单要提前写好，使用cat 读入
ulist=$(cat /root/useradd.txt)
for uname in $ulist
do
    if  [ $USER==$uname ];then
        echo "$uname 已经存在啦！！" &> /dev/null
    else 
        useradd  $uname &> /dev/null
        echo 123456 | passwd --stdin $uname &> /dev/null
    fi
done
echo "您要创建的帐号已经创建好了"
###############################################################################################################################
# n 是用户总数  用户密码存放在/root/pass.txt  i是从1开始取值一直到n
n=$(cat /root/useradd.txt | wc -l)
for i in $n
do
     useradd $(head -$i /root/useradd.txt | tail -1) 
     echo $(head -$i /root/pass.txt | tail -1) | passwd --stdin $(head -$i /root/useradd.txt | tail -1)
done

#################################

