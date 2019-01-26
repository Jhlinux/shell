#!/bin/bash
#用户名为tom并且密码为123456，若正确，则提示登陆成功，否则提示登陆失败
read -p "请输入您的用户名：" user
read -p "请输入您的秘密：" pass
if  [ $user == "tom" -a $pass == "123456" ];then 
      echo "Login successful"
else 
    echo "Login failed"
fi
