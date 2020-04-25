#!/bin/bash

#安装mysql,安装方式为yum

new_password=A123456


if [ ! -f mysql80-community-release-el7-3.noarch.rpm ]
then
   wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
fi
yum install -y mysql80-community-release-el7-3.noarch.rpm
sed -i '21s/0/1/g' /etc/yum.repos.d/mysql-community.repo
sed -i '28s/1/0/g' /etc/yum.repos.d/mysql-community.repo
yum install -y mysql-community-server
# open 3306
service firewalld stop
service mysqld start
password=$(grep 'password' /var/log/mysqld.log | awk '{print $NF}' | head -n1)
mysqladmin -uroot -p$password password "$new_password"
sql="update mysql.user set host='%' where user='root'"
mysql -uroot -p$new_password -e"$sql"
service mysqld restart
rm -f mysql80-community-release-el7-3.noarch.rpm
