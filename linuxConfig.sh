#!/bin/bash
cd /usr/local/src

yum -y install epel-release
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum -y update
yum -y install wget git jwhois bind-utils tmux screen mtr traceroute net-tools

