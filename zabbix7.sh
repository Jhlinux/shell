#!/bin/bash
#Zabbix 一键部署脚本
#安装zabbix3.4
#by Abel 2018.3
###################################################### 
echo  "正在配置firewall防火墙……"
systemctl stop firewalld >> /dev/null
systemctl disable firewalld >>/dev/null
if [ $? -eq 0 ];then
echo  "Firewall防火墙初始化完毕！"
fi
######################################################
echo  "正在关闭SELinux……"
setenforce 0 > /dev/null 2>&1
sed -i '/^SELINUX=/s/=.*/=disabled/' /etc/selinux/config
if [ $? -eq 0 ];then
        echo  "SELinux初始化完毕！"
fi 
################################获取zabbix、yum源##############
echo  "正在安装zabbix_repo源..."
rpm -ivh http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-1.el7.centos.noarch.rpm
if [ $? -eq 0 ];then
	echo  "zabbix 源安装完毕"
fi
###############################安装epel扩展源#################
echo  "正在安装epel源..."
yum -y install epel-release &>/dev/null
if [ $? -eq 0 ];then
	echo  "epel扩展源安装完成"
fi
##############################安装zabbix#######
echo  "正在安装zabbix...."
yum install zabbix-server-mysql zabbix-web-mysql -y &>/dev/null
if [ $? -eq 0 ];then
	echo  "zabbix-server安装完成"
fi
##########################准备数据库环境########
echo "正在执行mysql语句，创建zabbix数据库，授权zabbix访问数据库"
mysql -e "create database zabbix character set utf8;grant all privileges on zabbix.* to zabbix@'localhost' identified by 'zabbix';grant all privileges on zabbix.* to zabbix@'127.0.0.1' identified by 'zabbix';flush privileges;"
if [ $? -eq 0 ];then
	echo  "数据库初始化完成"
fi
###########################导入数据################
zcat /usr/share/doc/zabbix-server-mysql-3.4.7/create.sql.gz | mysql -uzabbix -pzabbix zabbix &>/dev/null
if [ $? -eq 0 ];then
	echo  "数据导入完成"
fi
###########################修改zabbix配置文件############# 
echo  "正在配置zabbix配置文件...."
cd /etc/zabbix
sed -i '/# DBHost=localhost/a\DBHost=localhost' zabbix_server.conf
sed -i '/# DBPassword=/a\DBPassword=zabbix' zabbix_server.conf
if [ $? -eq 0 ];then
        echo  "zabbix配置完毕！"
fi
#########################启动zabbix服务###############
systemctl start zabbix-server && systemctl enable zabbix-server &>/dev/null
if [ $? -eq 0 ];then
	echo  "zabbix-server 服务已经启动"
fi
#########################编辑zabbix前端php配置######### 
echo  "正在进行最后的zabbix Install ,php参数修改....."
sed -i '/^;date.timezone/a\date.timezone =  Asia/Shanghai' /etc/php.ini
echo  "恭喜你,Zabbix 部署到此完成，如有问题，请参照脚本单独解决！！！"
echo -e  "后续的操作:1、通过http://ip/zabbix 访问你的zabbix Web页面,下一步....一直到底。 2、你需要自己自定义或者使用系统自带模板，添加主机等等...."

