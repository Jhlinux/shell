#!/bin/bash
#执行这个脚本之前，先确保本机的dns为8.8.8.8 ip为192.168.4.13/24 
#提前将ks.cfg文件放到/root/ ====>>> ls /root/  ===>>>  ks.cfg
rm -rf /etc/yum.repos.d/*.repo
touch /etc/yum.repos.d/pxe.repo
umount /mnt
echo '
[development]
name=jh
baseurl=file:///mnt
enabled=1
gpgcheck=0' > /etc/yum.repos.d/pxe.repo
mount /dev/cdrom /mnt &> /dev/null
nmcli connection modify eth0 ipv4.method manual ipv4.addresses 192.168.4.13/24 connection.autoconnect yes 
nmcli connection up eth0 &> /dev/null
yum -y install syslinux &> /dev/null   #产生pxelinux.0文件
cp /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot/
yum -y install dhcp &> /dev/null
echo '
subnet 192.168.4.0 netmask 255.255.255.0 {
    range 192.168.4.1 192.168.4.200;
    option domain-name-servers 8.8.8.8;
    option routers 192.168.4.254;
    default-lease-time 600;
    max-lease-time 7200;
    next-server 192.168.4.13;
    filename "pxelinux.0";
}' > /etc/dhcp/dhcpd.conf
systemctl restart dhcpd
systecmtl enable dhcpd &> /dev/null
yum -y install tftp-server &> /dev/null
systemctl restart tftp
systemctl enable tftp &> /dev/null
mkdir /var/lib/tftpboot/pxelinux.cfg &> /dev/null
cp /mnt/isolinux/isolinux.cfg /var/lib/tftpboot/pxelinux.cfg/default
chmod u+w /var/lib/tftpboot/pxelinux.cfg/default
echo '
default vesamenu.c32
timeout 60
menu backgroud splash.png
menu title Red Hat jhh
label linux
    menu label install redhat
    kernel vmlinuz
    menu default
    append initrd=initrd.img ks=http://192.168.4.13/ks.cfg' > /var/lib/tftpboot/pxelinux.cfg/default
cp /mnt/isolinux/{vesamenu.c32,initrd.img,splash.png,vmlinuz} /var/lib/tftpboot/
yum -y install httpd &>  /dev/null
systemctl restart httpd
systemctl enable httpd &> /dev/null
mkdir /var/www/html/he &> /dev/null
mount /dev/cdrom /var/www/html/he &> /dev/null
cp /root/ks.cfg /var/www/html/
echo "主人，yum搭好了，ip配好了，就连pxe批量装机服务也弄好了！！！ 请您创建新的虚拟机体验一把！！！"
