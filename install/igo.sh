#!/bin/bash

cd /usr/local/src

wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz

tar zxvf go1.15.6.linux-amd64.tar.gz -C /usr/local

mkdir -p /usr/local/gocode
mkdir -p /usr/local/gocode/src
mkdir -p /usr/local/gogocodepro/bin
mkdir -p /usr/local/gocode/pkg

export GOPATH=/usr/local/gocode
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
