# sysmonitor
---
## Instructions

monitor system cpu load
monitor process(user define) load
monitor socket link (user define) state

## Usage

	ports = {
	    "Nginx": "8080",
	    "Mysql": "3306",
	    "Redis": "6379"
	}

add the socket port you want to monitor in ports dict

	processes = [
	    "nginx: worker process",
	    "/usr/local/mysql/bin/mysqld ",
	    "redis-server"
	]

add process search keywords into processes list

then run the script

	./sysmonitor.py

or 
	
	python ./sysmonitor.py

the result as following:

	[root@123 ~]# ./sysmonitor.py 

	############################## loop(0) ##############################
	2016-01-26 03:28:34
	++++++++++++++++++++ sys state +++++++++++++++++++++
	name|     user|      sys|     idle|
	-----------------------------------------------------
	 cpu: 0.961538  1.442308  97.596154
	cpu0: 1.923077  1.923077  96.153846
	cpu1: 0.000000  0.961538  99.038462
	++++++++++++++++++++ process state ++++++++++++++++++
	       process(pid)[state]|     user|      sys|
	-----------------------------------------------------
	    redis-server( 4735)[S]: 0.000000  0.000000
	    redis-server( 4750)[S]: 0.000000  0.000000
	           nginx(15539)[S]: 0.000000  0.000000
	           nginx(29910)[S]: 0.000000  0.000000
	           nginx(29911)[S]: 0.000000  0.000000
	          mysqld(24843)[S]: 0.000000  0.000000
	++++++++++++++++++++ link state ++++++++++++++++++++
	Nginx: 0
	Redis: 0
	Mysql: 0
	++++++++++++++++++++++++++++++++++++++++++++++++++++
	
	############################## loop(1) ##############################
	2016-01-26 03:28:35
	++++++++++++++++++++ sys state +++++++++++++++++++++
	name|     user|      sys|     idle|
	-----------------------------------------------------
	 cpu: 0.961538  1.442308  97.596154
	cpu0: 0.961538  1.923077  97.115385
	cpu1: 0.952381  1.904762  97.142857
	++++++++++++++++++++ process state ++++++++++++++++++
	       process(pid)[state]|     user|      sys|
	-----------------------------------------------------
	    redis-server( 4735)[S]: 0.000000  0.000000
	    redis-server( 4750)[S]: 0.480769  0.000000
	           nginx(15539)[S]: 0.000000  0.000000
	           nginx(29910)[S]: 0.000000  0.000000
	           nginx(29911)[S]: 0.000000  0.000000
	          mysqld(24843)[S]: 0.000000  0.000000
	++++++++++++++++++++ link state ++++++++++++++++++++
	Nginx: 0
	Redis: 0
	Mysql: 0
	++++++++++++++++++++++++++++++++++++++++++++++++++++