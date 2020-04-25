#!/bin/bash

URL=http://download.redis.io/releases/redis-5.0.8.tar.gz
ROOT=/root

FILE=$(echo $URL|awk -F/ '{print $NF}')
DIR=$(echo $FILE|sed 's/.tar.gz//g')
D=$(pwd)

yum install -y gcc
wget $URL && \
tar xzf $FILE
rm -f $FILE
cd $DIR && \
make MALLOC=libc && \
make PREFIX=$ROOT/redis install && \
cp redis.conf $ROOT/redis && \
sed -i '/daemonize no/c daemonize yes' $ROOT/redis.conf
rm -rf $D/$DIR
