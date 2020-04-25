#!/bin/bash

#设置selinux

check_selinux(){
	result = $(cat /etc/selinux/config|grep "^SELINUX="|awk -F= '{print $2}')
}

enable_selinux(){
	sed -i '/^SELINUX=/c SELINUX=enforcing' /etc/selinux/config
}

disable_selinux(){
	sed -i '/^SELINUX=/c SELINUX=disabled' /etc/selinux/config
}

if [[ $# != 1 ]];then
	echo '输入参数，check 或 enable 或 disable'
	exit 1
elif [[ $1 == 'check' ]];then
	echo "当前状态为$result"
elif [[ $1 == 'enable' ]];then
	enable_selinux
	echo '开启完成，请重启生效'
elif [[ $1 == 'disable' ]];then
	disable_selinux
        echo '关闭完成，请重启生效'
else 
	echo '输入正确参数，check 或 enable 或 disable'
fi
