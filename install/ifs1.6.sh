#!/bin/bash

cd /usr/local/src

yum clean all 
yum makecache
yum -y install epel-release 
yum -y update
yum -y install wget jwhois bind-utils tmux screen mtr traceroute tcpdump tshark

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/igit.sh | bash && source /etc/bashrc && git --version

yum install -y http://files.freeswitch.org/freeswitch-release-1-6.noarch.rpm epel-release
 
yum install -y alsa-lib-devel autoconf automake bison broadvoice-devel bzip2 curl-devel libdb4-devel e2fsprogs-devel erlang flite-devel g722_1-devel gcc-c++ gdbm-devel gnutls-devel ilbc2-devel ldns-devel libcodec2-devel libcurl-devel libedit-devel libidn-devel libjpeg-devel libmemcached-devel libogg-devel libsilk-devel libsndfile-devel libtheora-devel libtiff-devel libtool libuuid-devel libvorbis-devel libxml2-devel lua-devel lzo-devel mongo-c-driver-devel ncurses-devel net-snmp-devel openssl-devel opus-devel pcre-devel perl perl-ExtUtils-Embed pkgconfig portaudio-devel postgresql-devel python-devel python-devel soundtouch-devel speex-devel sqlite-devel unbound-devel unixODBC-devel wget which yasm zlib-devel libshout-devel libmpg123-devel lame-devel

yum install -y gcc-c++ alsa-lib-devel autoconf automake bison bzip2 curl-devel e2fsprogs-devel flite-devel gdbm-devel gnutls-devel ldns-devel libcurl-devel libedit-devel libidn-devel libjpeg-devel libmemcached-devel libogg-devel libsndfile-devel libtiff-devel libtheora-devel libtool libvorbis-devel libxml2-devel lua-devel lzo-devel mongo-c-driver-devel ncurses-devel net-snmp-devel openssl-devel opus-devel pcre-devel perl perl-ExtUtils-Embed pkgconfig portaudio-devel postgresql-devel python-devel soundtouch-devel speex-devel sqlite-devel unbound-devel unixODBC-devel libuuid-devel which yasm zlib-devel


git clone -b v1.6 https://github.com/signalwire/freeswitch.git freeswitch

chmod -R 777 /usr/local/src/freeswitch

cd /usr/local/src/freeswitch

./bootstrap.sh 

#vi modules.conf
#applications/mod_curl 


./configure
make && make install
make cd-sounds-install
make cd-moh-install
ln -sf /usr/local/freeswitch/bin/freeswitch /usr/bin/ 
ln -sf /usr/local/freeswitch/bin/fs_cli /usr/bin/


echo "load server"

touch /usr/lib/systemd/system/freeswitch.service

tee /usr/lib/systemd/system/freeswitch.service <<-'EOF'

[Unit]
Description=FreeSWITCH
After=syslog.target network.target
After=mysqld.service

[Service]
User=root
EnvironmentFile=-/etc/sysconfig/freeswitch
WorkingDirectory=/usr/local/freeswitch
ExecStart=/usr/local/freeswitch/bin/freeswitch -nc -nf $FREESWITCH_PARAMS 
ExecReload=/usr/bin/kill -HUP $MAINPID
Restart=always

[Install]
WantedBy=multi-user.target graphical.target

EOF

echo "load system service"

systemctl --system daemon-reload

# cd /usr/local
# useradd --system --home-dir /usr/local/freeswitch -G daemon freeswitch
# passwd -l freeswitch
# chown -R freeswitch:daemon /usr/local/freeswitch/ 
# chmod -R 770 /usr/local/freeswitch/
# chmod -R 750 /usr/local/freeswitch/bin/*
# mkdir /var/run/freeswitch
# chown -R freeswitch:daemon  /var/run/freeswitch
# ln -s /usr/local/freeswitch/bin/freeswitch /usr/bin/

systemctl start freeswitch.service

systemctl status freeswitch.service

systemctl enable freeswitch.service