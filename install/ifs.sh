#!/bin/bash


#install libav
yum install -y http://repo.okay.com.mx/centos/7/x86_64/release/okay-release-1-1.noarch.rpm
yum install -y libav-tools
yum remove -y libav*


#libyuv libvpx yasm

yum install -y  zlib-devel libjpeg-devel  libpng-devel freetype-devel  sqlite-devel  libcurl-devel pcre-devel  speex-devel  ldns-devel libedit-devel openssl-devel


yum install -y gcc-c++ wget zeromq-devel libtiff-devel patch alsa-lib-devel autoconf automake bison broadvoice-devel bzip2 curl-devel db-devel e2fsprogs-devel flite-devel g722_1-devel gdbm-devel gnutls-devel ilbc2-devel ldns-devel libcodec2-devel libcurl-devel libedit-devel libidn-devel libjpeg-devel libmemcached-devel libogg-devel libsilk-devel libsndfile-devel libtheora-devel libtool libvorbis-devel libxml2-devel lua-devel lzo-devel mongo-c-driver-devel ncurses-devel net-snmp-devel openssl-devel opus-devel pcre-devel perl perl-ExtUtils-Embed pkgconfig portaudio-devel postgresql-devel python26-devel python-devel soundtouch-devel speex-devel sqlite-devel unbound-devel unixODBC-devel libuuid-devel which yasm zlib-devel


yum install -y libtool-ltdl-devel uuid-devel zlib-devel libjpeg-turbo-devel ncurses-devel  pcre2-devel ldns-devel speexdsp-devel sqlite-devel perl-devel gdbm-devel bison-devel libsndfile-devel lua



yum provides '*/applydeltarpm'
yum install deltarpm

yum install -y https://files.freeswitch.org/repo/yum/centos-release/freeswitch-release-repo-0-1.noarch.rpm epel-release yum-utils
yum-builddep -y freeswitch
yum install -y yum-plugin-ovl centos-release-scl rpmdevtools 
yum install -y devtoolset-4-gcc*

scl enable devtoolset-4 'bash'



#### install ffmpeg
rpm --import  http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
rpm -Uvh  http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm

yum install -y ffmpeg
yum remove -y ffmpeg*
# show version 
ffmpeg -version


###
#nasm
wget https://www.nasm.us/pub/nasm/releasebuilds/2.14/nasm-2.14.tar.bz2
tar -jxvf nasm-2.14.tar.bz2
cd nasm-2.14
./configure
make & make install

#x264
git clone http://git.videolan.org/git/x264.git
./configure --enable-shared --enable-static --enable-debug --disable-asm

make & make install


#libk
#signalwire-c

###
git clone https://freeswitch.org/stash/scm/sd/libav.git
cd libav
#./configure --enable-pic --enable-shared  --enable-libx264 --enable-gpl --extra-libs="-ldl"
./configure --disable-static --enable-shared --enable-pic
make CXXFLAGS="-fPIC"
make install


ln -s /usr/local/lib/pkgconfig/libavcodec.pc /usr/lib64/pkgconfig
ln -s /usr/local/lib/pkgconfig/libavdevice.pc /usr/lib64/pkgconfig
ln -s /usr/local/lib/pkgconfig/libavfilter.pc /usr/lib64/pkgconfig
ln -s /usr/local/lib/pkgconfig/libavformat.pc /usr/lib64/pkgconfig
ln -s /usr/local/lib/pkgconfig/libavresample.pc /usr/lib64/pkgconfig
ln -s /usr/local/lib/pkgconfig/libavutil.pc /usr/lib64/pkgconfig
ln -s /usr/local/lib/pkgconfig/libswscale.pc /usr/lib64/pkgconfig
ln -s /usr/local/lib/pkgconfig/x264.pc /usr/lib64/pkgconfig
ldconfig                                              



###
vi /etc/yum.repos.d/rabbitmq-erlang.repo

[rabbitmq-erlang]
name=rabbitmq-erlang
baseurl=https://dl.bintray.com/rabbitmq/rpm/erlang/20/el/7
gpgcheck=1
gpgkey=https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc
repo_gpgcheck=0
enabled=1

yum install -y erlang

##git clone and install

cd /usr/local/src
git clone -b v1.10 https://github.com/signalwire/freeswitch.git freeswitch && cd /usr/local/src/freeswitch
./bootstrap.sh -j

./configure --enable-portable-binary \
            --prefix=/usr --localstatedir=/var --sysconfdir=/etc \
            --with-gnu-ld --with-python --with-erlang --with-openssl \
            --enable-core-odbc-support --enable-zrtp


make
make -j install
make -j cd-sounds-install
make -j cd-moh-install
