#!/bin/bash

docker_stop () {
  REDIS_SERVER=`docker inspect --format='{{.NetworkSettings.IPAddress}}' $1 2>/dev/null`

  if [ "$REDIS_SERVER" != "" ]; then
    echo "# Stoping/Deleting $1"
    docker stop $1 >/dev/null 2>&1
    docker rm $1 >/dev/null 2>&1
  fi

  docker images $1 > /dev/null 2>&1; ret=$?
  if [ "$ret" -eq 0 ]; then
    docker rm $1 >/dev/null 2>&1
  fi
}

docker_stop redis-master
docker_stop redis-slave-01
docker_stop redis-slave-02

docker run -itd --name redis-master redis-master:3.0.2 /usr/bin/redis-server >/dev/null 2>&1
REDIS_SERVER=`docker inspect --format='{{.NetworkSettings.IPAddress}}' redis-master`

#/usr/bin/redis-cli/redis-cli -h $REDIS_SERVER ping
#/usr/bin/redis-cli/redis-benchmark -h $REDIS_SERVER -q -n 1000 -c 10 -P 5

echo "# Build Redis Slave "
cat redis-slave/Dockerfile.template | sed "s/REDISMASTER/$REDIS_SERVER/g" > redis-slave/Dockerfile
(cd redis-slave; ./build.sh)

docker run -itd --name redis-slave-01 redis-slave:3.0.2 /usr/bin/redis-server /etc/redis.conf > /dev/null 2>&1
docker run -itd --name redis-slave-02 redis-slave:3.0.2 /usr/bin/redis-server /etc/redis.conf > /dev/null 2>&1

REDIS_SLAVE_01=`docker inspect --format='{{.NetworkSettings.IPAddress}}' redis-slave-01`
REDIS_SLAVE_02=`docker inspect --format='{{.NetworkSettings.IPAddress}}' redis-slave-02`

echo "# REDIS MASTER ....: $REDIS_SERVER"
echo "# REDIS SLAVE-01 ..: $REDIS_SLAVE_01"
echo "# REDIS SLAVE-02 ..: $REDIS_SLAVE_02"

echo "/usr/bin/redis-cli -h $REDIS_SERVER set hello world"
echo "/usr/bin/redis-cli -h $REDIS_SLAVE_01 get hello"
echo "/usr/bin/redis-cli -h $REDIS_SLAVE_02 get hello"




