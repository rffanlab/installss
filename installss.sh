#!/usr/bin/env bash
# You Must be root to run this script.
yum install -y wget gcc* openssl* sqlite*
wget -c https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz --no-check-certificate
tar zxvf Python-2.7.13.tgz
cd Python-2.7.13
./configure --prefix=/usr/local/python27
make && make install
wget https://bootstrap.pypa.io/get-pip.py
/usr/local/python27/bin/python python get-pip.py
/usr/local/python27/pip install shadowsocks
ln -s /usr/local/python27/bin/ssserver /usr/bin

cat >/etc/init.d/ss<<EOF
#! /bin/sh
# chkconfig: 2345 55 25
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
/usr/local/python27/bin/ssserver -p 10040 -k rffanlab -m rc4-md5 --user nobody -d start
EOF
chkconfig --add /etc/init.d/ss
chkconfig ss on
