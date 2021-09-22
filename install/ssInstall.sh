#!/bin/bash

cd /usr/local/src

yum -y install epel-release
yum -y install wget git jwhois bind-utils tmux screen mtr traceroute


yum install -y python-setuptools && easy_install pip
pip install --upgrade pip
pip install git+https://github.com/shadowsocks/shadowsocks.git@master
pip install shadowsocks


#Chacha20
yum install m2crypto gcc -y
wget -N --no-check-certificate https://github.com/jedisct1/libsodium/releases/download/1.0.17/libsodium-1.0.17.tar.gz
tar zfvx libsodium-1.0.17.tar.gz
cd libsodium-1.0.17
./configure
make && make install
echo "include ld.so.conf.d/*.conf" > /etc/ld.so.conf
echo "/lib" >> /etc/ld.so.conf
echo "/usr/lib64" >> /etc/ld.so.conf
echo "/usr/local/lib" >> /etc/ld.so.conf
ldconfig


#读取外网 IP: curl -s ipecho.net/plain;echo

#多用户配置
#touch /etc/shadowsocks.json

cat >/etc/shadowsocks.json <<EOF
{
 "server":"0.0.0.0",
 "local_address": "127.0.0.1",
 "local_port":1080,
  "port_password": {
     "3022": "!@!@##9090",
     "3011": "#ck@!$2022"
 },
 "timeout":120,
 "method":"chacha20-ietf-poly1305",
 "fast_open": false
}
EOF

#设置自启
echo -e "/usr/bin/ssserver  -c /etc/shadowsocks.json -d start \n" >> /etc/rc.local

chmod +x /etc/rc.d/rc.local

/usr/bin/ssserver -c /etc/shadowsocks.json -d start


echo > /var/log/wtmp
echo > /var/log/btmp
echo > /var/log/lastlog
history -r
history -cw
