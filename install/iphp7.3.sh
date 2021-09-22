#!/bin/bash

cd /usr/local/src

yum -y install wget git jwhois bind-utils tmux screen mtr traceroute
yum -y install epel-release

rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum --enablerepo=remi-php73 -y install php-fpm php-common
yum --enablerepo=remi-php73 -y install php-opcache php-pecl-apcu php-cli \
php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached \
php-pecl-swoole4 php-pecl-seaslog php-pecl-libsodium2 php-pecl-nsq php-gd php-mbstring php-imap php-mcrypt php-xml php-devel


sed -i 's/;phar.readonly=.*/phar.readonly = Off/g' /etc/php.ini
sed -i 's/expose_php =.*/expose_php = Off/g' /etc/php.ini
sed -i 's/post_max_size =.*/post_max_size = 50M/g' /etc/php.ini
sed -i 's/upload_max_filesize =.*/upload_max_filesize = 50M/g' /etc/php.ini
sed -i 's/memory_limit =.*/memory_limit = 128M/g' /etc/php.ini
sed -i 's/max_input_time =.*/max_input_time = 300/g' /etc/php.ini
sed -i 's/;date.timezone =.*/date.timezone = PRC/g' /etc/php.ini
sed -i 's/short_open_tag =.*/short_open_tag = On/g' /etc/php.ini
#sed -i 's/;cgi.fix_pathinfo=.*/cgi.fix_pathinfo=0/g' /etc/php.ini
sed -i 's/max_execution_time =.*/max_execution_time = 300/g' /etc/php.ini

#set composer
curl -sS https://getcomposer.org/installer | php 
mv /usr/local/src/composer.phar /usr/bin/composer
chmod +x /usr/bin/composer

composer --version


php --ri swoole

ulimit -n 100000