# hackredis
---
## Instructions

crack Linux system through Redis loophole

## Usage

First Use nmap to scan redis server in network

	nmap -sS xxx.xxx.xx.0/24 -p6379 --open |grep "Nmap scan"|awk '{print $5}' > iplist

After that you will get a iplist which Redis-Server port is open, the Use this script

	./hackredis.py iplist

then you will get a file named crackresult containing server list that be crack. You can use ssh to login in the server