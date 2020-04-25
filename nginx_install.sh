#!/bin/bash


URL=http://nginx.org/download/nginx-1.16.1.tar.gz
PREFIX=/root/nginx

NAME=$(echo $URL | awk -F/ '{print $NF}')
FILE=$(echo $NAME | sed 's/.tar.gz//g')

cd $(dirname $0 )
yum install -y gcc pcre-devel zlib-devel
wget $URL && \
tar -xzvf $NAME
rm -y $NAME
cd $FILE && \
./configure --prefix=${PREFIX} --with-stream && \
#--with-http_stub_status_module
#--with-http_ssl_module支持https ,需要依赖openssl-devel
make && make install 
cd ..
rm -rf $NAME
