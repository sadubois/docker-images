#!/bin/bash

REDIS_SERVER=`docker inspect --format='{{.NetworkSettings.IPAddress}}' redis-standalone`

echo "REDIS_SERVER: $REDIS_SERVER"

