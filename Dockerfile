FROM docker.io/node:17 as build

LABEL maintainer="Martijn Pepping <martijn.pepping@automiq.nl>"

ARG VERSION

RUN chown -R node:node /srv

USER node
WORKDIR /srv

RUN git clone -b "$VERSION" --depth=1 https://github.com/gchq/CyberChef.git .
RUN npm install

ENV NODE_OPTIONS="--max-old-space-size=2048"
RUN npx grunt prod


FROM docker.io/nginxinc/nginx-unprivileged:alpine as app

LABEL maintainer="Martijn Pepping <martijn.pepping@automiq.nl>" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vcs-ref="github.com/mpepping/docker-cyberchef" \
    org.label-schema.name="mpepping/cyberchef" \
    org.label-schema.description="CyberChef" \
    org.label-schema.url="https://github.com/mpepping/docker-cyberchef" \
    org.label-schema.vcs-url="https://github.com/mpepping/docker-cyberchef" \
    org.label-schema.vendor="Martijn Pepping" \
    org.label-schema.docker.cmd="docker run -it mpepping/cyberchef:latest"

# old http-server was running on port 8000, avoid breaking change; also, add IPv6 listener
RUN sed -i \
    -e 's/listen       8080;/listen       8000;/g' \
    -e '/listen       8000;/a\' \
    -e '    listen       [::]:8000;' /etc/nginx/conf.d/default.conf
    
COPY --from=build /srv/build/prod /usr/share/nginx/html

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
	CMD [ $(curl -I -s http://127.0.0.1:8000 | head -n 1 | cut -d' ' -f2 | head -n 1) -eq 200 ] || [ $(curl -I -s -6 http://[::1]:8000 | head -n 1 | cut -d' ' -f2 | head -n 1) -eq 200 ] || exit 1

EXPOSE 8000
