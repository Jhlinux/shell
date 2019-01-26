#!/bin/bash
case $1 in 
uname|-uname)
          echo $2;;
passwd)
          echo $2;;
*)
          echo "请输入uname,passwd"
esac
