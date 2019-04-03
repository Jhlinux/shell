#!/bin/bash
#函数参数的传递
function sum()
{
   echo "函数练习"
   if [ $# -eq 2 ];then
      echo "函数参数正确"
	  a1=$1
	  a2=$2
	 let sum=a1+a2
　 else 
      echo "函数参数不正确"
   fi
   echo "$a1+$a2=$sum"
}
sum 10 340 
