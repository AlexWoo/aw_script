#!/bin/bash

# yum repos
curl -L  http://mirrors.163.com/.help/CentOS7-Base-163.repo -o /etc/yum.repos.d/CentOS-163.repo
curl -L  http://mirrors.aliyun.com/repo/Centos-7.repo -o /etc/yum.repos.d/CentOS-aliyun.repo
if [ ! -f /etc/yum.repos.d/CentOS-Base.repo.orig ];then
    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.orig
fi
cp /etc/yum.repos.d/CentOS-aliyun.repo /etc/yum.repos.d/CentOS-Base.repo

# for network
yum install -y net-tools
yum install -y wget
yum install -y tcpdump
yum install -y traceroute
yum install -y nmap

# for compress
yum install -y bzip2
yum install -y zip unzip

# for development
yum install -y git
yum install -y svn
yum install -y man-pages
yum install -y dos2unix

# for debug tools
yum install -y dstat
yum install -y strace
yum install -y gperf
yum install -y perf
yum install -y systemtap
yum install -y systemtap-sdt-devel #drace
# flame graph
git clone https://github.com/brendangregg/FlameGraph.git  /usr/local/flamegraph
cp flameperf.sh /usr/local/bin/

# for gcc and g++
yum install -y gcc
yum install -y gcc-c++
yum install -y gdb
# cgdb
yum install -y ncurses-devel flex texinfo help2man readline-devel
wget https://cgdb.me/files/cgdb-0.6.8.tar.gz
tar xzf cgdb-0.6.8.tar.gz
cd cgdb-0.6.8
./configure --prefix=/usr/local
make && make install
cd ..

# for python
yum install -y python-devel

# for vim
yum install -y vim
git clone https://github.com/AlexWoo/vim.git
cd vim
./install
cd ..

# for nginx
yum install -y openssl-devel
yum install -y pcre-devel
yum install -y httpd-tools

