#!/bin/bash

cd /usr/local/src

curl -sS https://getcomposer.org/installer | php -- --help

mv /usr/local/src/composer.phar /usr/bin/composer && chmod +x /usr/bin/composer

composer config -g repos.packagist composer https://php.cnpkg.org
