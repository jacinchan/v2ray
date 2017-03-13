FROM alpine:3.5

RUN \
    apk add --no-cache --virtual .build-deps ca-certificates curl \
    && mkdir -p /opt/v2ray \
    && cd /opt/v2ray \
    && curl -L https://github.com/v2ray/v2ray-core/releases/download/v2.20.2/v2ray-linux-64.zip | tar -C /opt/v2ray -xf \
    && unzip v2ray-linux-64.zip v2ray\
    && apk del .build-deps 
 
ENV CONFIG_JSON=none V2RAY_CRT=none V2RAY_KEY=none

ADD entrypoint.sh /entrypoint.sh

RUN chgrp -R 0 /opt/v2ray \
    && chmod -R g+rwX /opt/v2ray \
    && chmod +x /entrypoint.sh

ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
