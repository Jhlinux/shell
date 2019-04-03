#!/bin/bash
#yum和ip 提前配置好
systemctl stop firewalld
systemctl disable firewalld
sed -i 's/^SELINUX=enforcing/SELINUX=permissive/g' /etc/sysconfig/selinux 
setenforce 0
#yum -y install nginx > /dev/null
yum -y install gcc make openssl-devel pcre-devel
tar -xvf /root/nginx-1.12.2.tar.gz > /dev/null
cd nginx-1.12.2
./configure --with-http_ssl_module --with-http_upstream --user=nginx --group=nginx --prefix=/usr/local/nginx
make 
make install
useradd -s /sbin/nologin nginx
/usr/local/nginx/sbin/nginx
yum -y install mariadb mariadb-server mariadb-devel
yum -y install php php-mysql
yum -y install php-fpm
systemctl start maraidb 
systemctl enable mariadb
systemctl start php-fpm
systemctl enable php-fpm


