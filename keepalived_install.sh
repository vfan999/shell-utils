#!/bin/bash

URL=https://www.keepalived.org/software/keepalived-2.0.20.tar.gz
ROOT=/root

TAR=$(echo $URL|awk -F/ '{print $NF}')
DIR=$(echo $TAR|sed 's/.tar.gz//1')

back(){
   yum install -y openssl-devel
   rm -rf $TAR
}

install(){
   wget $URL && \
   tar -zxvf $TAR -C $ROOT && \
   rm -rf $TAR && \
   cd $ROOT/$DIR && \
   ./configure --prefix=$ROOT/keepalived && \
   make && make install && \
   rm -rf $ROOT/$DIR
}

back && install
