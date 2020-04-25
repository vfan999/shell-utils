#!/bin/bash

#Docker-ce安装,安装方式为yum

install_docker(){
	yum install -y wget
        [[ -f /etc/yum.repos.d/docker-ce.repo ]] || wget -P /etc/yum.repos.d/ https://download.docker.com/linux/centos/docker-ce.repo
        if [[ $? == 0 ]];then
                yum clean all;
                yum install -y docker-ce
        else
                echo '网络错误'
                exit 1
        fi
}

install_docker
service docker restart
