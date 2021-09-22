## ops 仅限cenots7+
> init
```text
yum -y install epel-release && yum -y update
yum -y install wget jwhois bind-utils tmux screen mtr traceroute tcpdump tshark
```

### 选择安装

>> wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/i.sh | bash
***

> 工具类
>> dl iptables端口流量转发
>>> wget --no-check-certificate https://raw.githubusercontent.com/ghosts1995/ops/master/install/iptablesForward.sh && chmod +x iptablesForward.sh && ./iptablesForward.sh

>> yum install nginx
>>> wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/inginx.sh | bash

>> install SS
>>> wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/ssInstall.sh | bash

>> install git2.21.1
>>> wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/igit.sh | bash && source /etc/bashrc && git --version

>> install nvm and node to npm
>>> wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/invm.sh | bash && source ~/.bash_profile


>> install docker and docker-compose
>>> wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/idocker | bash

> server init
>>> yum -y install wget && wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/init.sh | bash


> install fs1.6
>> curl -o ifs1.6.sh https://raw.githubusercontent.com/ghosts1995/ops/master/install/ifs1.6.sh && chmod +x ifs1.6.sh && ./ifs1.6.sh

<!-- >>> wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/ifs1.6.sh | bash -->

***

> 开发类
>> 编译安装 php7.2.11
>>> wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/DevtoinInstallPhp.sh | bash && source /etc/bashrc

>> 编译安装swoole -v 1.10.5
>>> wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/installSwoole.sh | bash

>> yum 安装php7.2 包含swoole
>>> wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/iphp7.2.sh | bash

>> yum 安装php7.3 包含swoole
>>> wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/iphp7.3.sh | bash

>> centos7.x 安装python3.7.9
>>> wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/ipy.sh | bash && source /etc/profile

>> golang install in version 1.13.8
>>> wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/igo.sh | bash && source /etc/profile && go env


### fs 

```text
curl -s https://raw.githubusercontent.com/ghosts1995/ops/master/iremFs.sh | bash
```


### 建议安装screen,避免网络抖动

````text
yum -y install screen

> 创建一个screen
screen -S logInstall
> 恢复会话
screen -r logInstall
> 当前进行的会话
screen -ls

> mac & osx out 快捷健
control +a +d
```` 


