#!/bin/bash

cd /usr/local/src/

git clone -b aivoip https://github.com/ops-spanbrain/freeswitch.git freeswitch

chmod -R 777 /usr/local/src/freeswitch

cd /usr/local/src/freeswitch

./bootstrap.sh 

./configure

make 
make install
make cd-sounds-install
make cd-moh-install
ln -sf /usr/local/freeswitch/bin/freeswitch /usr/bin/ 
ln -sf /usr/local/freeswitch/bin/fs_cli /usr/bin/

echo "load server"

touch /usr/lib/systemd/system/freeswitch.service

tee /usr/lib/systemd/system/freeswitch.service <<-'EOF'

[Unit]
Description=FreeSWITCH
After=syslog.target network.target
After=mysqld.service

[Service]
User=root
EnvironmentFile=-/etc/sysconfig/freeswitch
WorkingDirectory=/usr/local/freeswitch
ExecStart=/usr/local/freeswitch/bin/freeswitch -nc -nf $FREESWITCH_PARAMS
ExecReload=/usr/bin/kill -HUP $MAINPID
Restart=always

[Install]
WantedBy=multi-user.target graphical.target

EOF

echo "load system service"

systemctl --system daemon-reload


cd /usr/local/src/freeswitch


#install xml curl
sed -i 's/#applications\/mod_curl/applications\/mod_curl/g' /usr/local/src/freeswitch/modules.conf
sed -i 's/#xml_int\/mod_xml_curl/xml_int\/mod_xml_curl/g' /usr/local/src/freeswitch/modules.conf

./configure

make mod_xml_curl-install

sed -i 's/#event_handlers\/mod_format_cdr/event_handlers\/mod_format_cdr/g' /usr/local/src/freeswitch/modules.conf
./configure
make mod_format_cdr-install


cd /usr/local/src

git clone https://github.com/ops-spanbrain/mod_g729.git

cd mod_g729

make && make install

echo "install done"

serverId=$(sed -n 1p /var/log/voip.log)
serverAddr=$(sed -n 1p /var/log/voipAddr.log)
hostIp=$(sed -n 1p /var/log/voipIp.log)

echo $serverId
echo $serverAddr
echo $hostIp

FSCONFDIR="/usr/local/freeswitch/conf"

rm -rf $FSCONFDIR/vars.xml
curl -o $FSCONFDIR/vars.xml "$serverAddr/init/$serverId/vars"

rm -rf $FSCONFDIR/autoload_configs/modules.conf.xml
curl -o $FSCONFDIR/autoload_configs/modules.conf.xml "$serverAddr/init/$serverId/modules"

rm -rf $FSCONFDIR/autoload_configs/format_cdr.conf.xml
curl -o $FSCONFDIR/autoload_configs/format_cdr.conf.xml "$serverAddr/init/$serverId/cdr"

rm -rf $FSCONFDIR/autoload_configs/xml_curl.conf.xml
curl -o $FSCONFDIR/autoload_configs/xml_curl.conf.xml "$serverAddr/init/$serverId/curl"

rm -rf $FSCONFDIR/autoload_configs/event_socket.conf.xml
curl -o $FSCONFDIR/autoload_configs/event_socket.conf.xml "$serverAddr/init/$serverId/es"

rm -rf $FSCONFDIR/autoload_configs/acl.conf.xml
curl -o $FSCONFDIR/autoload_configs/acl.conf.xml "$serverAddr/init/$serverId/acl"

rm -rf $FSCONFDIR/autoload_configs/switch.conf.xml
curl -o $FSCONFDIR/autoload_configs/switch.conf.xml "$serverAddr/init/$serverId/switch"

rm -rf $FSCONFDIR/directory/default.xml
curl -o $FSCONFDIR/directory/default.xml "$serverAddr/init/$serverId/directoryDefault"

rm -rf $FSCONFDIR/sip_profiles/external.xml
curl -o $FSCONFDIR/sip_profiles/external.xml "$serverAddr/init/$serverId/sipExternal"

echo "mkdir recordings"

mkdir -p /usr/local/freeswitch/recordings/$serverId

