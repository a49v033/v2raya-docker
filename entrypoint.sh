#!/bin/bash
#sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
#sysctl -p
sdns -config=/etc/v2raya/sdns.conf >/dev/null 2>&1 &
v2raya --mode=universal --webdir=/etc/v2raya-web
