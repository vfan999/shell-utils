#!/bin/bash

#安装最新kernel,并设置bbr加速

install_bbr(){
        rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org && \
        rpm -Uvh https://www.elrepo.org/elrepo-release-7.0-4.el7.elrepo.noarch.rpm && \
        yum --enablerepo=elrepo-kernel install -y kernel-ml kernel-ml-devel && \
        egrep ^menuentry /etc/grub2.cfg | cut -f 2 -d \' && \
        grub2-set-default 0
}

bbr_x(){
        yum remove kernel-headers
        yum --enablerepo=elrepo-kernel install -y kernel-ml-headers
        yum install -y gcc
        #lsmod | grep bbr
}

set_bbr(){
        echo 'net.core.default_qdisc = fq' >> /etc/sysctl.conf
        echo 'net.ipv4.tcp_congestion_control = bbr' >> /etc/sysctl.conf
}

bbr_update(){
        yum --enablerepo=elrepo-kernel install -y kernel-ml-headers kernel-ml kernel-ml-devel
}

install_bbr && bbr_x && set_bbr && echo "安装bbr成功，请重启"
