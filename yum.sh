#!/bin/bash
mkdir /etc/yum.repos.d/hehe
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/hehe
touch /etc/yum.repos.d/centos.repo
echo '
[centos]
name=centos
baseurl=http://classroom.example.com/content/rhel7.0/x86_64/dvd/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/centos.repo

