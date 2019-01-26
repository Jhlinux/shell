#!/bin/bash
if [ $(who | wc -l) -gt 1 ];then
     echo '主人，有黑客入侵您的系统！！'
else
   echo "平安无事 ！！"
fi
