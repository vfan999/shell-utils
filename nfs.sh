#!/bin/bash

#挂载nfs,SETBOOT参数0为不开机启动

SETBOOT=0
MOUNT=192.168.1.174:/root/shell

boot="#!/bin/bash \n
\n
mount -t nfs $MOUNT /nfs \n
#umount /nfs/
"

cd $(dirname $0)
if ! mountpoint -q /nfs/ ;then
	yum list installed | grep nfs-utils || yum install -y nfs-utils
	[[ -d /nfs ]] || mkdir /nfs
	if mount -t nfs $MOUNT /nfs ;then
		echo '/nfs/ mount'
	else 
		echo 'nfs服务器未启动'
		exit 1
	fi
else
	umount /nfs/
	echo '/nfs/ already umount'
fi

[[ $SETBOOT == 0 ]] && exit 0
chmod +x /etc/rc.d/rc.local
grep "^sh ~/boot.sh" /etc/rc.local || echo 'sh ~/boot.sh' >> /etc/rc.local
if [[ -f ~/boot.sh ]];then
	grep "mount -t nfs $MOUNT /nfs" ~/boot.sh || echo "mount -t nfs $MOUNT /nfs" >> ~/boot.sh
else
	echo -e $boot > ~/boot.sh
fi
