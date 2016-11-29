FROM alpine:3.4
MAINTAINER Martijn Pepping <martijn.pepping@automiq.nl>

RUN \
  addgroup cyberchef -S && \
  adduser cyberchef -G cyberchef -S && \
  apk update && \
  apk add git nodejs && \
  npm install -g grunt-cli && \
  npm install -g http-server

RUN \
  cd /srv && \
  git clone https://github.com/gchq/CyberChef.git && \
  cd CyberChef && \
  npm install && \
  chown -r cyberchef:cyberchef /srv/CyberChef && \
  grunt prod

WORKDIR /srv/CyberChef/build/prod
USER cyberchef
ENTRYPOINT ["http-server", "-p", "8000"]
