#!/bin/bash

#添加虚拟内存
#echo 500 | sh swap_config.sh

check(){
	[[ -f /swapfile ]] && echo 'swap已存在' && exit 0
}

add(){
        dd if=/dev/zero of=/swapfile bs=1024 count=$SWAP
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile
        echo '/swapfile swap swap defaults 0 0'>>/etc/fstab
        #cat /proc/sys/vm/swappiness
}

remove(){
	swapoff /swapfile
	sed -i '/^\/swapfile/d' /etc/fstab
}

if [[ $# != 1 ]];then
	echo '输入参数，install 或 remove' && exit 1
elif [[ $1 == 'install' ]];then
	echo '虚拟内存安装.......'
	read -p "输入虚拟内存总量(M为单位)      " SWAPM
	echo "内存总量${SWAPM}M"
	SWAP=$(( ${SWAPM} * 1024 ))
	check
	add
elif [[ $1 == 'remove' ]];then
	[[ -f /swapfile ]] && remove || echo '未安装虚拟内存！'
else
	echo '输入参数不正常，请输入install 或 remove'
	exit 1
fi
