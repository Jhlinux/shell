#!/bin/bash
read -p "请输入创建虚拟机的编号" p
cd /var/lib/libvirt/images/
qemu-img create -b node.qcow2 -f qcow2 node$p.img 30G
 cd /etc/libvirt/qemu
 cp node.xml node$p.xml
 sed -i "s/node/node$p/g" node$p.xml
virsh define node$p.xml

