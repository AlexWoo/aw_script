#! /bin/bash

sysctlfile=/etc/sysctl.conf
limitsfile=/etc/security/limits.conf
user=www
SYSCTLTMPFILE=./sysctl.conf.tmp

sysctlitems="net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.ip_local_port_range = 10000 65000
net.ipv4.tcp_max_syn_backlog = 8192
net.core.netdev_max_backlog = 32768
net.core.somaxconn = 65535
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_wmem = 8192 436600 873200
net.ipv4.tcp_rmem  = 32768 436600 873200
net.ipv4.tcp_mem = 94500000 91500000 92700000
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_fin_timeout = 30"

sysctlconf()
{
    TMPFILE=.tmp
    srchstr=$1
    rplcstr=$@
    tmp=`sed -n "/$srchstr .*/"p $SYSCTLTMPFILE`
    if [ -n "$tmp" ];
    then
        sed "s/$srchstr .*/$rplcstr/g" $SYSCTLTMPFILE > $TMPFILE
        mv $TMPFILE $SYSCTLTMPFILE
    else
        echo "$rplcstr" >> $SYSCTLTMPFILE
    fi
}

limitsconf()
{
    TMPFILE=.tmp

    tmp=`sed -n "/^$user soft .*/"p $limitsfile`
    if [ -n "$tmp" ];
    then
        sed "s/^$user soft .*/$user soft nofile 102400/g" $limitsfile > $TMPFILE
        mv $TMPFILE $limitsfile
    else
        echo "$user soft nofile 102400" >> $limitsfile
    fi
    
    tmp=`sed -n "/^$user hard .*/"p $limitsfile`
    if [ -n "$tmp" ];
    then
        sed "s/^$user hard .*/$user hard nofile 102400/g" $limitsfile > $TMPFILE
        mv $TMPFILE $limitsfile
    else
        echo "$user hard nofile 102400" >> $limitsfile
    fi
}

cp $sysctlfile $SYSCTLTMPFILE
IFS="
"
for item in $sysctlitems
do
    IFS=" "
    sysctlconf $item
    IFS="
"
done
IFS=" "

mv $SYSCTLTMPFILE $sysctlfile
rm -f $SYSCTLTMPFILE
sysctl -p

limitsconf
