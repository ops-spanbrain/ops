#!/bin/bash

echo "请选择要安装的程序"

echo "
-------------------------------------------------
设置iptables端口流量转发脚本:iptables-port
安装git2.9.5:git
centos7.x安装python3.7.5:py37
centos7.X安装golang1.13.6:go1136
yum安装nginx:nginx
编译安装php7.2.11:php72
yum安装php7.2包含swoole和composer:ips72
yum安装php7.3包含swoole和composer:ips73
-------------------------------------------------
"

read HOSTNAME

case $HOSTNAME in

 "iptables-port") wget --no-check-certificate https://raw.githubusercontent.com/ops-spanbrain/ops/master/install/iptablesForward.sh && chmod +x iptablesForward.sh && ./iptablesForward.sh
;;

 "git") wget -qO- https://raw.githubusercontent.com/ops-spanbrain/ops/master/install/gitInstall.sh | bash && source /etc/bashrc && git --version
;;

 "php72") wget -qO- https://raw.githubusercontent.com/ops-spanbrain/ops/master/install/gitInstall.sh | bash && source /etc/bashrc && git --version
;;

 "nginx") wget -qO- https://raw.githubusercontent.com/ops-spanbrain/ops/master/install/inginx.sh | bash
;;

 "ips72") wget -qO- https://raw.githubusercontent.com/ops-spanbrain/ops/master/install/iphp7.2.sh | bash
;;

 "php73") wget -qO- https://raw.githubusercontent.com/ops-spanbrain/ops/master/install/iphp7.3.sh | bash
;;

 "py37") wget -qO- https://raw.githubusercontent.com/ops-spanbrain/ops/master/install/ipy3-7-5.sh | bash && source /etc/profile
;;

 "go1136") wget -qO- https://raw.githubusercontent.com/ops-spanbrain/ops/master/install/igo.sh | bash && source /etc/bashrc && go env
;;

	 *) echo "Can't find the related server name"
	 exit
;;
esac
