#!/bin/bash

usage()
{
	echo "usage: $0 redis_pack_director [port]"
	echo "Sample: $0 redis-2.8.17 16379"
	exit 1
}

check_install_pack()
{
    echo "check install package $1"
	if [ ! -d $1 ];
	then
		echo "$1 does not exist or is not a director, check it!"
		usage
		exit 1
	fi
	
	if [ ! -f $1/Makefile ];
	then
	    echo "$1/Makefile does not exist, check it!"
		exit 1
	fi

	echo "check install package: $REDISPACKAGE OK"
}

create_redis_dir()
{
    REDISPATH=~/redis
    echo "create redis dir $REDISPATH"

	#如果redis目录不存在, 则创建, 如果存在备份
	if [ ! -d $REDISPATH ];
	then
		mkdir -p $REDISPATH
		echo "$REDISPATH does not exist, create $REDISPATH"
	fi
	
	REDISBIN=${REDISPATH}/bin
	if [ ! -d $REDISBIN ];
	then
		mkdir -p $REDISBIN
		echo "$REDISBIN does not exist, create $REDISBIN"
	fi
	
	REDISCFG=${REDISPATH}/etc
	if [ ! -d $REDISCFG ];
	then
		mkdir -p $REDISCFG
		echo "$REDISCFG does not exist, create $REDISCFG"
	fi
	
	REDISLIB=${REDISPATH}/lib
	if [ ! -d $REDISLIB ];
	then
		mkdir -p $REDISLIB
		echo "$REDISLIB does not exist, create $REDISLIB"
	fi
	
	REDISLOG=${REDISPATH}/log
	if [ ! -d $REDISLOG ];
	then
		mkdir -p $REDISLOG
		echo "$REDISLOG does not exist, create $REDISLOG"
	fi
	
	REDISDB=${REDISPATH}/db
	if [ ! -d $REDISDB ];
	then
		mkdir -p $REDISDB
		echo "$REDISDB does not exist, create $REDISDB"
	fi

	echo "$REDISPATH is created"
}

compile_redis()
{
    echo "start compile redis"

    cd $REDISPACKAGE
    make && make PREFIX=${REDISPATH} install 

    if [ $? -ne 0 ];
    then
        echo "compile redis failed!!"
        exit 2
    fi
    cd ~/

    echo "compile redis OK"
}

config_redis()
{
    echo "config redis"

    if [ -f $REDISCFG/redis.conf ];
    then
        echo "$REDISCFG/redis.conf exist"
        return
    fi

read -r SED_EXPR <<-EOF
s#^logfile .+\$#logfile ${REDISLOG}/redis.log#; \
s#^dir .+\$#dir ${REDISDB}#; \
s#^pidfile .+\$#pidfile ${REDISPATH}/redis.pid#; \
s#^daemonize no\$#daemonize yes#; \
s#^port .+\$#port $PORT#; \
s@^# maxclients .+\$@maxclients 10000@;
EOF
    sed -r "$SED_EXPR" $REDISPACKAGE/redis.conf >> ${REDISCFG}/redis.conf
    echo "rename-command CONFIG \"\"" >> ${REDISCFG}/redis.conf

    echo "config redis OK"
}

config_profile()
{
    echo "config profile"

    tmp=`grep $REDISBIN ~/.bash_profile`
    echo $tmp
    if [ -z "$tmp" ];
    then
        echo "export PATH=$REDISBIN:$PATH" >> ~/.bash_profile
    fi
    tmp=`grep redis-server ~/.bashrc`
    echo $tmp
    if [ -z "$tmp" ];
    then
        echo "alias redis-server='redis-server $REDISCFG/redis.conf'"  >> ~/.bashrc
    fi
    
    echo "config profile OK"
}

config_service_sysvinit()
{
    echo "config service with sysvinit"
    TMPFILE=$HOME/redis.tmp

cat > $TMPFILE <<EOT
#!/bin/sh
#Configurations injected by install_server below....

USER=$USER
EXEC=$REDISBIN/redis-server
CLIEXEC=$REDISBIN/redis-cli
PIDFILE=$REDISPATH/redis.pid
CONF=$REDISCFG/redis.conf
REDISPORT="$PORT"
###############
# SysV Init Information
# chkconfig: - 58 74
# description: redis_${REDIS_PORT} is the redis daemon.
### BEGIN INIT INFO
# Provides: redis_${REDIS_PORT}
# Required-Start: \$network \$local_fs \$remote_fs
# Required-Stop: \$network \$local_fs \$remote_fs
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Should-Start: \$syslog \$named
# Should-Stop: \$syslog \$named
# Short-Description: start and stop redis_${REDIS_PORT}
# Description: Redis daemon
### END INIT INFO
EOT
    cat $REDISPACKAGE/utils/redis_init_script.tpl >> $TMPFILE
    sed "s/\$EXEC \$CONF/su - \$USER -c \"\$EXEC \$CONF\"/g" $TMPFILE > $HOME/redis.service
    chmod u+x $HOME/redis.service
    rm -f $TMPFILE

    echo ""
    echo "You should do next opeation by your own with root:"
    echo "chown -R root:root $HOME/redis.service"
    echo "mv $HOME/redis.service /etc/init.d"
    echo ""
    echo "for init when server startup:"
    echo "chkconfig --add redis.service"
    echo "chkconfig redis.service on"
}

config_service_systemd()
{
    echo "config service with systemd"

    cd ~/
echo "[Unit]
Description=Redis server
BindTo=network.target

[Install]
WantedBy=multi-user.target

[Service]
User=$USER
Group=$GROUP
Type=forking
Environment=PATH=$REDISBIN:/usr/bin:/bin
ExecStart=$REDISBIN/redis-server $REDISCFG/redis.conf
ExecStop=ExecStop=$REDISBIN/redis-cli -p $PORT shutdown
PrivateTmp=true
Restart=on-failure
" > $HOME/redis.service

    echo ""
    echo "You should do next opeation by your own with root:"
    echo "chown -R root:root $HOME/redis.service"
    echo "mv $HOME/redis.service /etc/systemd/system"
    echo ""
    echo "for init when server startup:"
    echo "systemctl enable redis.service"
}

config_service()
{
    echo "config service"
    tmp=`systemctl`
    if [ $? -ne 0 ];
    then
        config_service_sysvinit
        return
    else
        config_service_systemd
    fi
}

if [ $# -eq 1 ];
then
    REDISPACKAGE=$HOME/$1
    PORT=16379
elif [ $# -eq 2 ];
then
    REDISPACKAGE=$HOME/$1
    PORT=$2
else
	usage
fi

REDISPACKAGE=$HOME/$1
USER=`whoami`
GROUP=`ls -ld $HOME | awk '{print $4}'`

check_install_pack $REDISPACKAGE
create_redis_dir
compile_redis
config_redis
config_profile
config_service
