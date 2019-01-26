#!/bin/bash
ulist=$(cat /root/users.txt)
for uname in $ulist
do
   useradd $uname &> /dev/null 
   echo 123456 | passwd --stdin $uname &> /dev/null
done
echo "主人，您要创建的用户都创建好了"
