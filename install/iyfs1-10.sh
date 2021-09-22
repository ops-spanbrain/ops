#!/bin/bash

yum -y install epel-release 
yum -y update
yum -y install wget bind-utils jwhois mtr traceroute tcpdump tshark
yum install -y https://files.freeswitch.org/repo/yum/centos-release/freeswitch-release-repo-0-1.noarch.rpm
yum install -y freeswitch-config-vanilla freeswitch-lang-* freeswitch-sounds-*
yum install -y freeswitch-event-format-cdr freeswitch-xml-curl

#rpm -ivh https://files.freeswitch.org/repo/yum/centos-release/7/x86_64/freeswitch-xml-curl-1.10.2.release.4-1.el7.x86_64.rpm
#rpm -ivh https://files.freeswitch.org/repo/yum/centos-release/7/x86_64/freeswitch-event-format-cdr-1.10.2.release.4-1.el7.x86_64.rpm

systemctl enable freeswitch

curl -s https://raw.githubusercontent.com/ghosts1995/ops/master/install/igit.sh | bash && source /etc/bashrc && git --version

serverId=$(sed -n 1p /var/log/voip.log)
serverAddr=$(sed -n 1p /var/log/voipAddr.log)

echo $serverId
echo $serverAddr

rm -rf /etc/freeswitch/vars.xml
curl -o /etc/freeswitch/vars.xml "$serverAddr/init/$serverId/vars"

rm -rf /etc/freeswitch/autoload_configs/modules.conf.xml
curl -o /etc/freeswitch/autoload_configs/modules.conf.xml "$serverAddr/init/$serverId/modules"

rm -rf /etc/freeswitch/autoload_configs/format_cdr.conf.xml
curl -o /etc/freeswitch/autoload_configs/format_cdr.conf.xml "$serverAddr/init/$serverId/cdr"

rm -rf /etc/freeswitch/autoload_configs/xml_curl.conf.xml
curl -o /etc/freeswitch/autoload_configs/xml_curl.conf.xml "$serverAddr/init/$serverId/curl"

rm -rf /etc/freeswitch/autoload_configs/event_socket.conf.xml
curl -o /etc/freeswitch/autoload_configs/event_socket.conf.xml "$serverAddr/init/$serverId/es"

rm -rf /etc/freeswitch/autoload_configs/acl.conf.xml
curl -o /etc/freeswitch/autoload_configs/acl.conf.xml "$serverAddr/init/$serverId/acl"


echo "install done"

curl -s "$serverAddr/init/$serverId/install"

chown -R freeswitch:daemon /etc/freeswitch

mkdir -p /recordings
chown -R freeswitch:daemon /recordings

systemctl start freeswitch
