#!/bin/bash

yum -y install wget gcc gcc-c++ make pcre pcre-devel libffi libffi-devel zlib zlib-devel bzip2 bzip2-devel ncurses ncurses-devel readline readline-devel openssl openssl-devel openssl-static xz lzma xz-devel sqlite sqlite-devel gdbm gdbm-devel tk tk-devel expat expat-devel

echo "cd dir"

cd /usr/local/src
mkdir -p /usr/local/python3

wget --no-check-certificate https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz

tar -xzvf Python-3.7.9.tgz

cd Python-3.7.9

./configure --prefix=/usr/local/python3

make && make install

ln -s /usr/local/python3/bin/python3 /usr/bin/python3

cp /usr/bin/yum /usr/bin/yumBACK
cp /usr/libexec/urlgrabber-ext-down /usr/libexec/urlgrabber-ext-downBACK

sed -i '1c \#\!/usr/bin/python2' /usr/bin/yum

sed -i '1c \#\!/usr/bin/python2' /usr/libexec/urlgrabber-ext-down

ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3

echo "pip3 update"

pip3 install --upgrade pip

echo "alias py='/usr/bin/python3'" >>/etc/profile