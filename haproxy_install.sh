#!/bin/bash

cd $(dirname $0 )

URL=https://www.haproxy.org/download/2.1/src/haproxy-2.1.4.tar.gz
INSTALL_DIR=/root

FILE=$(echo $URL|awk -F/ '{print $NF}')
DIR_NAME=$(echo $FILE  | sed 's/.tar.gz//1')

rely(){
    rm -rf rm -rf $INSTALL_DIR/$DIR_NAME
    rm -rf ${FILE}*
    yum install -y gcc
}

install(){
   wget $URL && \ 
   tar -zxvf ${FILE} -C ${INSTALL_DIR} && \
   rm -rf $FILE && \
   
   cd $INSTALL_DIR/$DIR_NAME && \
   make TARGET=linux31  && \        #centos6.X需要使用TARGET=linux26  centos7.x使用linux31
   make install PREFIX=$INSTALL_DIR/haproxy && \

   rm -rf $INSTALL_DIR/$DIR_NAME 
}


rely && install
