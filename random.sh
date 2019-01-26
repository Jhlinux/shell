#!/bin/bash
a=$[ RANDOM%11]
read -p "请输入10以内的数字：" sore
if [ $a -eq $sore ];then 
    echo "你猜对了"
    break
elif [ $a -lt $sore ];then
    echo "你猜大了"
else
    echo "你猜小了"
fi
##
