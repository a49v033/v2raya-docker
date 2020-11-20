#!/bin/bash
#sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
#sysctl -p
echo -e "nameserver 180.76.76.76" > /etc/resolv.conf 
v2raya --mode=universal --webdir=/etc/v2raya-web
