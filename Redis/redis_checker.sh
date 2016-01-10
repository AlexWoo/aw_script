#! /bin/bash

REDISCLI=/home/redis/redis/bin/redis-cli
REDISPORT=16379

RESULT=`$REDISCLI -p $REDISPORT PING`
if [ "$RESULT" == 'PONG' ];
then
    echo $RESULT
    exit 0
else
    echo $RESULT
    exit 1
fi
