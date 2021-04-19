FROM alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk update && apk upgrade
RUN apk add --no-cache --virtual .build-deps ca-certificates tzdata curl wget iptables bash-completion bash unzip
ENV VER=v1.3.1
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone

RUN mkdir /etc/v2raya
RUN mkdir /etc/v2raya-web
RUN wget -P /etc/v2raya-web https://raw.githubusercontent.com/v2rayA/v2rayA/master/gui/public/favicon.ico
RUN wget -P /etc/v2raya-web https://raw.githubusercontent.com/v2rayA/v2rayA/master/gui/public/index.html
RUN wget -P /etc/v2raya-web https://raw.githubusercontent.com/v2rayA/v2rayA/master/gui/public/CNAME
RUN wget -P /etc/v2raya-web https://raw.githubusercontent.com/v2rayA/v2rayA/master/gui/public/robots.txt
RUN mkdir /usr/share/v2ray
RUN mkdir -p /usr/local/share/v2ray && touch /usr/local/share/v2ray/.copykeep

RUN mkdir /tmp/v2ray
RUN if [ $(arch) == aarch64 ]; then      curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-arm64-v8a.zip; fi
RUN if [ $(arch) == x86_64 ]; then     curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip; fi
RUN unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
RUN chmod +x /tmp/v2ray/v2ray
RUN mv /tmp/v2ray/v2ray /usr/share/v2ray/v2ray
RUN wget -O /tmp/v2ray/LoyalsoldierSite.dat https://raw.githubusercontent.com/mzz2017/dist-v2ray-rules-dat/master/geosite.dat
RUN cp /tmp/v2ray/LoyalsoldierSite.dat /usr/local/share/v2ray/LoyalsoldierSite.dat
RUN cp /tmp/v2ray/geoip.dat /usr/local/share/v2ray/geoip.dat
RUN cp /tmp/v2ray/geosite.dat /usr/local/share/v2ray/geosite.dat
#RUN rm -rf /tmp/v2ray

ENV PATH=$PATH:/usr/share/v2ray

RUN if [ $(arch) == aarch64 ]; then     linux=linux_arm64_$VER;     wget https://github.com/v2rayA/v2rayA/releases/download/$VER/v2raya_$linux;     chmod +x /v2raya_$linux;     mv /v2raya_$linux /usr/bin/v2raya; fi
RUN if [ $(arch) == x86_64 ]; then     linux=linux_amd64_$VER;     wget https://github.com/v2rayA/v2rayA/releases/download/$VER/v2raya_$linux;     chmod +x /v2raya_$linux;     mv /v2raya_$linux /usr/bin/v2raya; fi
VOLUME /etc/v2raya
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
EXPOSE 53 2017 8080 20170 20171 20172
