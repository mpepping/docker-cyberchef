FROM alpine:latest
MAINTAINER Martijn Pepping <martijn.pepping@automiq.nl>

RUN addgroup cyberchef -S && \
    adduser cyberchef -G cyberchef -S && \
    apk update && \
    apk add git nodejs && \
    rm -rf /var/cache/apk/* && \
    npm install -g grunt-cli && \
    npm install -g http-server

RUN cd /srv && \
    git clone -b master --depth=1 https://github.com/gchq/CyberChef.git && \
    cd CyberChef && \
    rm -rf .git && \
    npm install && \
    npm cache rm && \
    apk del git && \
    chown -R cyberchef:cyberchef /srv/CyberChef && \
    grunt prod

WORKDIR /srv/CyberChef/build/prod
USER cyberchef
ENTRYPOINT ["http-server", "-p", "8000"]
