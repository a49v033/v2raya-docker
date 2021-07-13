FROM alpine
ENV VER=v1.3.3
RUN set -ex \
        && apk update -f && apk upgrade \
        && apk add --no-cache --virtual .build-deps ca-certificates tzdata curl wget iptables ip6tables bash unzip \
        && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone \
        && mkdir /etc/v2raya \
        && mkdir /etc/v2raya-web \
        && wget -P /etc/v2raya-web https://raw.fastgit.org/v2rayA/v2rayA/master/gui/public/favicon.ico \
        && wget -P /etc/v2raya-web https://raw.fastgit.org/v2rayA/v2rayA/master/gui/public/index.html \
        && wget -P /etc/v2raya-web https://raw.fastgit.org/v2rayA/v2rayA/master/gui/public/CNAME \
        && wget -P /etc/v2raya-web https://raw.fastgit.org/v2rayA/v2rayA/master/gui/public/robots.txt \
        && mkdir /usr/share/v2ray \
        && mkdir -p /usr/local/share/v2ray && touch /usr/local/share/v2ray/.copykeep \
        && mkdir /tmp/v2ray \
        && if [ $(arch) == aarch64 ]; then      curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-arm64-v8a.zip; fi \
        && if [ $(arch) == x86_64 ]; then     curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip; fi \
        && unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray \
        && chmod +x /tmp/v2ray/v2ray \
        && mv /tmp/v2ray/v2ray /usr/share/v2ray/v2ray \
        && wget -O /tmp/v2ray/LoyalsoldierSite.dat https://raw.fastgit.org/mzz2017/dist-v2ray-rules-dat/master/geosite.dat \
        && cp /tmp/v2ray/LoyalsoldierSite.dat /usr/local/share/v2ray/LoyalsoldierSite.dat \
        && cp /tmp/v2ray/geoip.dat /usr/local/share/v2ray/geoip.dat \
        && cp /tmp/v2ray/geosite.dat /usr/local/share/v2ray/geosite.dat \
        && rm -rf /var/cache/apk/*
ENV PATH=$PATH:/usr/share/v2ray
RUN if [ $(arch) == aarch64 ]; then     linux=linux_arm64_$VER;     wget https://github.com/v2rayA/v2rayA/releases/download/$VER/v2raya_$linux;     chmod +x /v2raya_$linux;     mv /v2raya_$linux /usr/bin/v2raya; fi
RUN if [ $(arch) == x86_64 ]; then     linux=linux_amd64_$VER;     wget https://github.com/v2rayA/v2rayA/releases/download/$VER/v2raya_$linux;     chmod +x /v2raya_$linux;     mv /v2raya_$linux /usr/bin/v2raya; fi
RUN if [ $(arch) == aarch64 ]; then     down=smartdns-aarch64;     wget https://github.com/pymumu/smartdns/releases/download/Release33/$down;     chmod +x /$down;     mv /$down /usr/bin/smartdns; fi 
RUN if [ $(arch) == x86_64 ]; then     down=smartdns-x86_64;     wget https://github.com/pymumu/smartdns/releases/download/Release33/$down;     chmod +x /$down;     mv /$down /usr/bin/smartdns; fi
VOLUME /etc/v2raya
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
EXPOSE 53 2017 8080 20170 20171 20172
