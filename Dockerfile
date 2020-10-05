FROM arm64v8/alpine
RUN apk update
RUN apk add --no-cache --virtual .build-deps ca-certificates curl iptables bash-completion bash unzip

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

RUN wget https://github.com/v2rayA/v2rayA/releases/download/v1.0.1/v2raya_linux_arm64_v1.0.1
RUN chmod +x /v2raya_linux_arm64_v1.0.1
RUN mv /v2raya_linux_arm64_v1.0.1 /usr/bin/v2raya

RUN sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
RUN sysctl -p

ADD resolv.conf /etc/resolv.conf

VOLUME /etc/v2raya

EXPOSE 53 2017 20170 20171 20172
ENTRYPOINT ["v2raya","--mode=universal", "--webdir=/etc/v2raya-web"]
