#!/bin/bash
###############################################################################这是一些自定义函数
# shell中函数的调用直接用函数名即可，函数名后面千万不要加括号
#############################################################################
#这是个搭建yum的函数，执行这个脚本快速搭yum
create_yum(){
    rm -rf /etc/yum.repos.d/*.repo
    mount /dev/cdrom /mnt &> /dev/null
    echo '
[development]
name=rht
baseurl=file:///mnt
enabled=1
gpgcheck=0' > /etc/yum.repos.d/rht.repo
yum clean all &> /dev/null
yum repolist  &> /dev/null
echo  "yum搭建完毕"
}
#########################################################################################
#这个是搭建dhcpd服务,dns为8.8.8.8  ip为192.168.4.13/24
create_dhcpd(){
     yum -y install dhcp &> /dev/null
     echo '
subnet 192.168.4.0 netmask 255.255.255.0 {
     range 192.168.4.2 192.168.4.200;
     option domain-name-servers 0.0.0.0;
     option routers 192.168.4.254;
     default-lease-time 600;
     max-lease-time 7200;
     next-server 192.168.4.13;
     filename "pxelinux.0";
}' > /etc/dhcp/dhcpd.conf
systemctl restart dhcpd 
systemctl enable dhcpd  &> /dev/null
echo "dhcpd服务搭好了"
}
###############################################################################这是搭建tftp服务,该服务的共享目录在/var/lib/tftpboot/
create_tftp(){
      yum -y install tftp-server  &> /dev/null
      systemctl restart tftp
      systemctl enable tftp &> /dev/null
      echo "tftp服务搭好了"
}
############################################################################
#这是搭建httpd服务，该服务的共享目录在/var/www/html/
create_httpd(){
      yum -y install httpd  &> /dev/null
      systemctl restart httpd
      systemctl enable httpd &> /dev/null
      echo "httpd 服务搭好了"
}
###########################################################################这是部署LNMP开发技术栈的函数 linux nginx mariadb/mysql php/python
create_LNMP(){
       yum -y install httpd &> /dev/null
       yum -y install mariadb mariadb-devel mariadb-server &> /dev/null
       yum -y install php php-mysql &> /dev/null
       systemctl restart httpd
       systemctl enable httpd &> /dev/null
       systemctl restart mariadb 
       systemctl enable mariadb  &> /dev/null
}
