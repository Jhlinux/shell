#!/bin/bash
mkdir /opt/mnt
if [ $? -eq 0 ];then
   echo "/opt下没有mnt目录,刚把该目录创建成功"
else
  echo "opt/有mnt目录"
fi
