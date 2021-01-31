FROM node:11-alpine as build
LABEL maintainer='Martijn Pepping <martijn.pepping@automiq.nl>'

RUN apk add --no-cache git
RUN npm install -g grunt-cli
WORKDIR /srv

RUN git clone -b master --depth=1 https://github.com/gchq/CyberChef.git .
RUN npm install

ENV NODE_OPTIONS="--max-old-space-size=2048"
RUN grunt prod


FROM nginxinc/nginx-unprivileged:alpine as app
# old http-server was running on port 8000, avoid breaking change
RUN sed -i 's|listen       8080;|listen       8000;|g' /etc/nginx/conf.d/default.conf

COPY --from=build /srv/build/prod /usr/share/nginx/html

EXPOSE 8000
