#! /bin/bash

REDISCLI=/home/redis/redis/bin/redis-cli
REDISPORT=16379
REDISHOST=127.0.0.1

RESULT=`$REDISCLI -p $REDISPORT -h $REDISHOST PING`
if [ "$RESULT" == 'PONG' ];
then
    echo $RESULT
    exit 0
else
    echo $RESULT
    exit 1
fi
