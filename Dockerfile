FROM mpepping/node6-alpine
LABEL maintainer='Martijn Pepping <martijn.pepping@automiq.nl>'

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
    apk del git && \
    npm install && \
    chown -R cyberchef:cyberchef /srv/CyberChef

USER cyberchef

ENV NODE_OPTIONS="--max-old-space-size=2048"
RUN cd /srv/CyberChef && \
    grunt prod

EXPOSE 8000

WORKDIR /srv/CyberChef/build/prod
ENTRYPOINT ["http-server", "-p", "8000"]
