#!/bin/bash

#安装zabbix被监控端

IP=            #输入监控主机IP
URL=https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-release-4.4-1.el7.noarch.rpm

install_zabbix(){
        rpm -qa|grep "zabbix-release*" || rpm -Uvh $URL || exit 1
        yum clean all
        yum install -y zabbix-agent
        sed -i "/^Server/s/$/,$IP/g" /etc/zabbix/zabbix_agentd.conf
        service zabbix-agent restart
}

firewall(){
        if service firewalld status|awk '{print $2}'|grep "^active";then
                echo 'firewall已打开，添加入规则'
                firewall-cmd --add-service=zabbix-agent --permanent
                firewall-cmd --reload
        fi
}

read -p "输入监控主机IP     " IP
install_zabbix
firewall
