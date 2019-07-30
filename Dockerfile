FROM node:11-alpine
LABEL maintainer='Martijn Pepping <martijn.pepping@automiq.nl>'

RUN addgroup cyberchef -S && \
    adduser cyberchef -G cyberchef -S && \
    apk update && \
    apk add curl git jq nodejs unzip && \
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

WORKDIR /srv/CyberChef/build/prod

RUN REL=$(curl -ksL "https://api.github.com/repos/gchq/CyberChef/releases/latest" | jq -r '.tag_name') && \
    curl -s -L -O "https://github.com/gchq/CyberChef/releases/download/${REL}/CyberChef_${REL}.zip" && \
    unzip -u CyberChef_${REL}.zip

EXPOSE 8000

ENTRYPOINT ["http-server", "-p", "8000"]
