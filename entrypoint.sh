#!/bin/bash
if [ ! -e '/usr/local/share/v2ray/LoyalsoldierSite.dat' ]; then
    cp /tmp/v2ray/LoyalsoldierSite.dat /usr/local/share/v2ray/LoyalsoldierSite.dat
    cp /tmp/v2ray/geoip.dat /usr/local/share/v2ray/geoip.dat
    cp /tmp/v2ray/geosite.dat /usr/local/share/v2ray/geosite.dat
    echo "拷贝geoip文件"
fi
v2raya --mode=universal --webdir=/etc/v2raya-web
