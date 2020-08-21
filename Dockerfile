FROM openjdk:8-jdk-alpine
MAINTAINER leodockeryang<1064894600@qq.com>

COPY mirthconnect3.9.0_zh.tar.gz /usr/local
RUN tar -zxvf /usr/local/mirthconnect3.9.0_zh.tar.gz -C /usr/local && rm -f /usr/local/mirthconnect3.9.0_zh.tar.gz

ENV MYPATH /usr/local/mirthconnect3.9.0_zh
WORKDIR $MYPATH

EXPOSE 8080 8443

CMD echo $MYPATH && java -jar mirth-server-launcher.jar && /bin/bash
