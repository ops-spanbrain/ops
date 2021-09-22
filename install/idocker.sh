#!/bin/bash

yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-edge
yum-config-manager --enable docker-ce-test

yum -y install docker-ce

echo "docker run start"

systemctl start docker.service
systemctl enable docker.service

docker -v

curl -L https://github.com/docker/compose/releases/download/1.27.3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

docker-compose --version
