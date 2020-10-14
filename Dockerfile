FROM arm64v8/alpine
RUN apk update
RUN apk upgrade
RUN apk add --no-cache --virtual .build-deps ca-certificates curl wget iptables bash-completion bash unzip
ENV VER=v1.0.1
RUN apk add tzdata
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
RUN apk del tzdata

RUN mkdir /etc/v2raya
RUN mkdir /etc/v2raya-web
RUN wget -P /etc/v2raya-web https://raw.githubusercontent.com/v2rayA/v2rayA/master/gui/public/index.html
RUN mkdir /usr/share/v2ray

RUN mkdir /tmp/v2ray
RUN curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-arm64-v8a.zip
RUN unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
RUN chmod +x /tmp/v2ray/v2ray
RUN chmod +x /tmp/v2ray/v2ctl
RUN mv /tmp/v2ray/v2ray /usr/share/v2ray/v2ray
RUN mv /tmp/v2ray/v2ctl /usr/share/v2ray/v2ctl
RUN mv /tmp/v2ray/geoip.dat /usr/share/v2ray/geoip.dat
RUN mv /tmp/v2ray/geosite.dat /usr/share/v2ray/geosite.dat
RUN rm -rf /tmp/v2ray

ENV PATH=$PATH:/usr/share/v2ray

RUN wget https://github.com/v2rayA/v2rayA/releases/download/$VER/v2raya_linux_arm64_$VER
RUN chmod +x /v2raya_linux_arm64_$VER
RUN mv /v2raya_linux_arm64_$VER /usr/bin/v2raya

RUN wget https://static.adguard.com/adguardhome/beta/AdGuardHome_linux_arm64.tar.gz
RUN tar  -zxvf AdGuardHome_linux_arm64.tar.gz
RUN rm -r AdGuardHome_linux_arm64.tar.gz
RUN mv /AdGuardHome/AdGuardHome /usr/bin/AdGuardHome
RUN chmod +x /usr/bin/AdGuardHome

VOLUME /etc/v2raya
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
EXPOSE 53 2017 20170 20171 20172
#ENTRYPOINT ["v2raya","--mode=universal", "--webdir=/etc/v2raya-web"]
