FROM redis:3.0.2
MAINTAINER Sacha Dubois 
ENV REDIS_VERSION 3.0.2
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.0.2.tar.gz
ENV REDIS_DOWNLOAD_SHA1 a38755fe9a669896f7c5d8cd3ebbf76d59712002

RUN buildDeps='gcc-c++ libc6-dev tar git unzip wget libevent clang libstdc++-static'; \
    baseDeps='make gcc curl libffi-devel'; \
    set -x \
    && sed -i 's/tcp-keepalive 0/tcp-keepalive 60/g' /etc/redis.conf \
    && sed -i 's/bind 127.0.0.1/#bind 127.0.0.1/g' /etc/redis.conf \
    && sed -i 's/# maxmemory-policy volatile-lru/maxmemory-policy noeviction/g' /etc/redis.conf \
    && sed -i 's/appendonly no/cppendonly yes/g' /etc/redis.conf \
    && echo "#gaga" >> /etc/redis.conf

