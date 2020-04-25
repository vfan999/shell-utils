#!/bin/bash

#ssh端口设置，去掉dns

sh(){
        sed -i "/^Port/c Port=${PORT}" /etc/ssh/sshd_config
        sed -i "/^#Port/c Port=${PORT}" /etc/ssh/sshd_config
#       service sshd restart
        if service firewalld status|awk '{print $2}'|grep "^active";then
                echo 'firewall已打开，添加入规则'
                firewall-cmd --add-port=$PORT/tcp --permanent
                firewall-cmd --reload
        fi
}

op(){
	sed -i "/^UseDNS/c UseDNS no" /etc/ssh/sshd_config
	sed -i "/^#UseDNS/c UseDNS no" /etc/ssh/sshd_config
}

reset(){
	sed -i "/^Port/c #Port=22" /etc/ssh/sshd_config
}

read -p "输入更改的SSH端口号" PORT
if grep '^[[:digit:]]*$' <<< $PORT;then
	sh
	op	
else 
	echo 'ssh,请输入正确数字'
	exit 1
fi

