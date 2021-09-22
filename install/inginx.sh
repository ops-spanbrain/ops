#!/bin/bash

tee /etc/yum.repos.d/nginx.repo <<-'EOF'
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
EOF

yum -y install nginx


rm -rf /etc/nginx/nginx.conf

tee /etc/nginx/nginx.conf <<-'EOF'

user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;

worker_rlimit_nofile 65535;

events{
  use epoll;
  worker_connections 65535;
}


http{
  include       /etc/nginx/mime.types;
  default_type  application/octet-stream;

  client_max_body_size 8m;

  sendfile on;
  keepalive_timeout 15;


  gzip on;
  gzip_min_length  1k;
  gzip_buffers     4 16k;
  gzip_http_version 1.0;
  gzip_comp_level 2;
  gzip_types       text/plain application/x-javascript text/css application/xml;
  gzip_vary on;
  gzip_disable msie6;
  log_format '$remote_addr - $remote_user [$time_local] "$request" '
                '$status $body_bytes_sent "$http_referer" '
                '"$http_user_agent" "$http_x_forwarded_for"';
  include /etc/nginx/conf.d/*;
}
EOF

echo "load system service"

systemctl --system daemon-reload

systemctl start nginx.service

systemctl enable nginx.service
