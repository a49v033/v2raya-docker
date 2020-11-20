#!/bin/bash
#sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
#sysctl -p
#由于国内dns会解析github到无法访问ip  添加hosts
echo '192.30.255.113 github.com' >> /etc/hosts 
v2raya --mode=universal --webdir=/etc/v2raya-web
