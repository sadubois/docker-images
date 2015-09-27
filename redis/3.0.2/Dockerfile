FROM registry.access.redhat.com/rhel 
MAINTAINER Sacha Dubois 
ENV REDIS_VERSION 3.0.2
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.0.2.tar.gz
ENV REDIS_DOWNLOAD_SHA1 a38755fe9a669896f7c5d8cd3ebbf76d59712002

RUN buildDeps='gcc-c++ libc6-dev tar git unzip wget libevent clang libstdc++-static'; \
    baseDeps='make gcc curl libffi-devel'; \
    set -x \
    && rpm -i https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum install -y $baseDeps $buildDeps \
    && yum install -y redis \
    && systemctl enable redis.service

VOLUME /redis

EXPOSE 5000
EXPOSE 6379
EXPOSE 16379
EXPOSE 8889
