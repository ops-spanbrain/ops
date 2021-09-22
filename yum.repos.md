cd /etc/yum.repos.d/

mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bar

```text

[base]
name=CentOS-$releasever - Base - nus.edu.sg
baseurl=http://mirror.nus.edu.sg/centos/7/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates
[updates]
name=CentOS-$releasever - Updates - nus.edu.sg
baseurl=http://mirror.nus.edu.sg/centos/7/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras - nus.edu.sg
baseurl=http://mirror.nus.edu.sg/centos/7/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-$releasever - Plus - nus.edu.sg
baseurl=http://mirror.nus.edu.sg/centos/7/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#contrib - packages by Centos Users
[contrib]
name=CentOS-$releasever - Contrib - nus.edu.sg
baseurl=http://mirror.nus.edu.sg/centos/7/contrib/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

```

yum clean all && yum clean metadata && yum clean dbcache && yum makecache && yum update


### 清除
yum clean all
### 将服务器上的软件包信息缓存到本地,以提高搜索安装软件的速度
yum makecache  
yum -y update   
### 测试域名是否可用
yum install -y vim*    
