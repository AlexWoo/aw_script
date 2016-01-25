#! /usr/bin/env python

import commands
import time

ports = {
    "Nginx": "8080",
    "Mysql": "3306",
    "Redis": "6379"
}

processes = [
    "nginx: worker process",
    "/usr/local/mysql/bin/mysqld ",
    "redis-server"
]

syscput = {}
syscpun = {}

processt = {}
processn = {}

def syscpu(procstat):
    words = procstat.split()
    cpudict = {}
    name = words[0]
    cpudict["total"] = 0
    for n in words[1:]:
        cpudict["total"] += int(n)
    cpudict["user"] = int(words[1]) + int(words[2])
    cpudict["sys"] = int(words[3])
    cpudict["idle"] = int(words[4])
    return name, cpudict

def process(pid):
    cmdstr = "cat /proc/" + pid + "/stat"
    status, output = commands.getstatusoutput(cmdstr)
    process = {}

    if status == 0:
        words = output.split()        
        process["pid"] = words[0]
        process["name"] = words[1][1:-1]
        process["state"] = words[2]
        process["user"] = int(words[13]) + int(words[15])
        process["sys"] = int(words[14]) + int(words[16])
        return process

def initsyscpus():
    cmdstr = "cat /proc/stat | grep cpu"
    status, output = commands.getstatusoutput(cmdstr)
    if status == 0:
        lines = output.split("\n")
        syscput["cpunum"] = len(lines) - 1
        for line in lines:
            name, cpudict = syscpu(line)
            syscput[name] = cpudict

def initprocesses():
    for searchstr in processes:
        cmdstr = "ps -ef |grep \"" + searchstr + "\"|grep -v grep | awk '{print $2}'"
        status, output = commands.getstatusoutput(cmdstr)
        if status == 0:
            pids = output.split()
            for pid in pids:
                p = process(pid)
                processt[pid] = p

def init():
    initsyscpus()
    initprocesses()

def monitorport(name, port):
    cmdstr = "netstat -anp | grep \":" + port + " \" | grep ESTABLISH | wc -l"
    status, output = commands.getstatusoutput(cmdstr)
    if status == 0:
        print "%s: %s" % (name, output)
    else:
        print "watch %s link failed" % name

def monitorports():
    print "++++++++++++++++++++ link state ++++++++++++++++++++"
    for name, port in ports.items():
        monitorport(name, port)
    print "++++++++++++++++++++++++++++++++++++++++++++++++++++"

def recordcpus():
    cmdstr = "cat /proc/stat | grep cpu"
    status, output = commands.getstatusoutput(cmdstr)
    if status == 0:
        lines = output.split("\n")
        for line in lines:
            name, cpudict = syscpu(line)
            syscpun[name] = cpudict

def recordprocesses():
    for pid in processt.iterkeys():
        p = process(pid)
        if p is None:
            print pid, "is Dead"
            del processt[pid]
        else:
            processn[pid] = p

def cpuspent(name):
    spent = {}
    spent["total"] = syscpun[name]["total"] - syscput[name]["total"]
    spent["user"] = syscpun[name]["user"] - syscput[name]["user"]
    spent["sys"] = syscpun[name]["sys"] - syscput[name]["sys"]
    spent["idle"] = syscpun[name]["idle"] - syscput[name]["idle"]
    return spent

def processspent(name):
    spent = cpuspent("cpu")
    puser = float(processn[name]["user"]-processt[name]["user"])*100/spent["total"]
    psys = float(processn[name]["sys"]-processt[name]["sys"])*100/spent["total"]
    print "%16s(%5s)[%s]: %.6f  %.6f" % (processn[name]["name"], processn[name]["pid"], processn[name]["state"], puser, psys)

def monitorsys():
    print "++++++++++++++++++++ sys state +++++++++++++++++++++"
    print "%4s| %8s| %8s| %8s|" % ("name", "user", "sys", "idle")
    print "-----------------------------------------------------"
    for k in syscpun.iterkeys():
        spent = cpuspent(k)
        print "%4s: %.6f  %.6f  %.6f" % (k, float(spent["user"])*100/spent["total"], float(spent["sys"])*100/spent["total"], float(spent["idle"])*100/spent["total"])
    print "++++++++++++++++++++ process state ++++++++++++++++++"
    print "%26s| %8s| %8s|" % ("process(pid)[state]", "user", "sys")
    print "-----------------------------------------------------"
    for k in processn.iterkeys():
        processspent(k)

def monitor():
    recordcpus()
    recordprocesses()
    monitorsys()
    monitorports()
    for k, v in syscpun.items():
        syscput[k] = v
    for k, v in processn.items():
        processt[k] = v

if __name__ == '__main__':
    init()

    n = 0
    while 1:
        time.sleep(1)
        print "\n############################## loop(%d) ##############################" % n
        print time.strftime("%Y-%m-%d %H:%M:%S")
        monitor()
        n = n + 1