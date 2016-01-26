# hackredis
---
## Instructions

HTTP Server kenerl optimization

## Usage

modify the line following to your HTTP Server startup account:

	user=www

then run the script:

	./sysmonitor.py

you will get output as following:

	[root@123 ~]# ./sys_http_optim.sh 
	vm.swappiness = 0
	net.ipv4.neigh.default.gc_stale_time = 120
	net.ipv4.conf.all.rp_filter = 0
	net.ipv4.conf.default.rp_filter = 0
	net.ipv4.conf.default.arp_announce = 2
	net.ipv4.conf.all.arp_announce = 2
	net.ipv4.tcp_max_tw_buckets = 5000
	net.ipv4.tcp_syncookies = 1
	net.ipv4.tcp_max_syn_backlog = 8192
	net.ipv4.tcp_synack_retries = 2
	net.ipv6.conf.all.disable_ipv6 = 1
	net.ipv6.conf.default.disable_ipv6 = 1
	net.ipv6.conf.lo.disable_ipv6 = 1
	net.ipv4.conf.lo.arp_announce = 2
	net.ipv4.ip_forward = 0
	net.ipv4.tcp_tw_reuse = 1
	net.ipv4.tcp_tw_recycle = 1
	net.ipv4.tcp_keepalive_time = 1200
	net.ipv4.ip_local_port_range = 10000 65000
	net.core.netdev_max_backlog = 32768
	net.core.somaxconn = 65535
	net.core.wmem_default = 8388608
	net.core.rmem_default = 8388608
	net.core.rmem_max = 16777216
	net.core.wmem_max = 16777216
	net.ipv4.tcp_timestamps = 0
	net.ipv4.tcp_syn_retries = 2
	net.ipv4.tcp_wmem = 8192 436600 873200
	net.ipv4.tcp_rmem = 32768 436600 873200
	net.ipv4.tcp_mem = 94500000 91500000 92700000
	net.ipv4.tcp_max_orphans = 3276800
	net.ipv4.tcp_fin_timeout = 30
	[root@123 ~]#