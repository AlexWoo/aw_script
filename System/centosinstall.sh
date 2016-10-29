#!/usr/bash

# yum repos
curl -L  http://mirrors.163.com/.help/CentOS7-Base-163.repo -o /etc/yum.repos.d/CentOS-163.repo
curl -L  http://mirrors.aliyun.com/repo/Centos-7.repo -o /etc/yum.repos.d/CentOS-aliyun.repo

# for network
yum install -y net-tools
yum install -y wget
yum install -y tcpdump
yum install -y traceroute

# for compress
yum install -y bzip2
yum install -y zip unzip

# for development
yum install -y git
yum install -y svn
yum install -y man-pages
yum install -y dos2unix

# for gcc and g++
yum install -y gcc
yum install -y gcc-c++

# for vim
yum install -y vim
git clone https://github.com/AlexWoo/vim.git
cd vim
./install
cd ..

# for nginx
yum install -y openssl-devel
yum install -y pcre-devel

