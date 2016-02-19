# install_redis
---
## install_redis.sh

A bash script for installing redis with non-root account.

**install redis with install_redis.sh**

The operation below will be under a non-root's $HOME directory

	wget https://github.com/antirez/redis/archive/2.8.23.tar.gz
	tar xzf 2.8.23.tar.gz
	./install_redis.sh redis-2.8.23

After installing, a redis director will be installed at user $HOME directory, and config file will be configured as below

- bin：redis executable file will be installed here
- etc：redis config file(redis.conf) will be installed here
- db： redis db file(dump.rdb) will be installed here
- log：redis log file(redis.log) will be installed here
- pidfile(redis.pid) will be isntalled under redis directory
- the default port will be set to 16379
- config command in redis will be forbidon
- maxclients will be set to 10000

alias and PATH will be set, you can reload .bash_profile and .bashrc, then run the command below to startup redis-server

	redis-server

and run the command below to stop redis-server

	redis-cli -p 16379 shutdown

You can also get service file(redis.service) after install.

**sysvinit**

use root account to install redis service

	chown -R root:root /non-root/home/path/redis.service
	mv /non-root/home/path/redis.service /etc/init.d

then you can start redis service as below

	service redis.service start

stop redis service as below

	service redis.service stop

restart redis service as below

	service redis.service restart

set redis service boot with your Linux system

	chkconfig --add redis.service
	chkconfig redis.service on

**systemd**

use root account to install redis service

	chown -R root:root /non-root/home/path/redis.service
	mv /non-root/home/path/redis.service /etc/systemd/system

then you can start redis service as below

	systemctl start redis.service

stop redis service as below

	systemctl stop redis.service

restart redis service as below

	systemctl restart redis.service

set redis service boot with your Linux system

	systemctl enable redis.service