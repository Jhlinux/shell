#!/bin/bash
read -p "请输入您的分数：" sore
if  [ $sore -gt 90 ];then
     echo "神功盖世！！"
elif [ $sore -gt 80 ];then
     echo "登峰造极！！"
elif [ $sore -gt 70 ];then
     echo  "炉火纯青！！！"
elif [ $sore -gt 60 ];then
     echo "略有小成！！！"
else 
    echo  "出来匝道！！！"
fi
