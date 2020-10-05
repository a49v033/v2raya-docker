  #!/bin/bash
# 开启转发
sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
sysctl -p
echo -e "nameserver 114.114.114.114" > /etc/resolv.conf
v2raya --mode=universal --webdir=/etc/v2raya-web
