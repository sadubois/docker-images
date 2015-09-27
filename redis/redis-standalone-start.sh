#!/bin/bash

REDIS_SERVER=`docker inspect --format='{{.NetworkSettings.IPAddress}}' redis-standalone`

if [ "$REDIS_SERVER" != "" ]; then
  docker stop redis-standalone
  docker rm redis-standalone
fi

docker run -itd --name redis-standalone redis:3.0.2 /usr/bin/redis-server > /dev/null 2>&1
REDIS_SERVER=`docker inspect --format='{{.NetworkSettings.IPAddress}}' redis-standalone`

#redis-cli -h $REDIS_SERVER ping
#redis-benchmark -h $REDIS_SERVER -q -n 1000 -c 10 -P 5

