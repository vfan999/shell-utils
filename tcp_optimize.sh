#!/bin/bash

#TCP优化

optimize(){
	grep "^* soft nofile" /etc/security/limits.conf || echo '* soft nofile 51200' >> /etc/security/limits.conf
	grep "^* hard nofile" /etc/security/limits.conf || echo '* hard nofile 51200' >> /etc/security/limits.conf
}

tcp(){
	grep '^fs.file-max' /etc/sysctl.conf || echo -e "#fs.file-max = 51200\n" >> /etc/sysctl.conf
	grep '^net.core.rmem_max' /etc/sysctl.conf || echo 'net.core.rmem_max = 67108864' >> /etc/sysctl.conf
	grep '^net.core.wmem_max' /etc/sysctl.conf || echo 'net.core.wmem_max = 67108864' >> /etc/sysctl.conf
	grep '^net.core.netdev_max_backlog' /etc/sysctl.conf || echo 'net.core.netdev_max_backlog = 250000' >> /etc/sysctl.conf
	grep '^net.core.somaxconn' /etc/sysctl.conf || echo -e "net.core.somaxconn = 4096\n" >> /etc/sysctl.conf
	grep '^net.ipv4.tcp_syncookies' /etc/sysctl.conf || echo 'net.ipv4.tcp_syncookies = 1' >> /etc/sysctl.conf
	grep '^net.ipv4.tcp_tw_reuse' /etc/sysctl.conf || echo 'net.ipv4.tcp_tw_reuse = 1' >> /etc/sysctl.conf
	grep '^net.ipv4.tcp_tw_recycle' /etc/sysctl.conf || echo 'net.ipv4.tcp_tw_recycle = 0' >> /etc/sysctl.conf
	grep '^net.ipv4.tcp_fin_timeout' /etc/sysctl.conf || echo 'net.ipv4.tcp_fin_timeout = 30' >> /etc/sysctl.conf
	grep '^net.ipv4.tcp_keepalive_time' /etc/sysctl.conf || echo 'net.ipv4.tcp_keepalive_time = 1200' >> /etc/sysctl.conf
	grep '^net.ipv4.ip_local_port_range' /etc/sysctl.conf || echo 'net.ipv4.ip_local_port_range = 10000 65000' >> /etc/sysctl.conf
	grep '^net.ipv4.tcp_max_syn_backlog' /etc/sysctl.conf || echo 'net.ipv4.tcp_max_syn_backlog = 8192' >> /etc/sysctl.conf
	grep '^net.ipv4.tcp_max_tw_buckets' /etc/sysctl.conf || echo 'net.ipv4.tcp_max_tw_buckets = 5000' >> /etc/sysctl.conf
	grep '^net.ipv4.tcp_fastopen' /etc/sysctl.conf || echo 'net.ipv4.tcp_fastopen = 3' >> /etc/sysctl.conf
	grep '^net.ipv4.tcp_mem' /etc/sysctl.conf || echo 'net.ipv4.tcp_mem = 25600 51200 102400' >> /etc/sysctl.conf
	grep '^net.ipv4.tcp_rmem' /etc/sysctl.conf || echo 'net.ipv4.tcp_rmem = 4096 87380 67108864' >> /etc/sysctl.conf
	grep '^net.ipv4.tcp_wmem' /etc/sysctl.conf || echo 'net.ipv4.tcp_wmem = 4096 65536 67108864' >> /etc/sysctl.conf
	grep '^net.ipv4.tcp_mtu_probing' /etc/sysctl.conf || echo 'net.ipv4.tcp_mtu_probing = 1' >> /etc/sysctl.conf
	grep '^net.ipv4.tcp_congestion_control' /etc/sysctl.conf || echo 'net.ipv4.tcp_congestion_control = hybla' >> /etc/sysctl.conf
}

optimize
tcp
echo "TCP优化完成，重启生效"
