# docker-cyberchef

[![Docker Pulls](https://badgen.net/docker/pulls/mpepping/cyberchef?icon=docker&label=pulls)](https://hub.docker.com/r/mpepping/cyberchef/)
[![Docker Stars](https://badgen.net/docker/stars/mpepping/cyberchef?icon=docker&label=stars)](https://hub.docker.com/r/mpepping/cyberchef/)
[![Docker Image Size](https://badgen.net/docker/size/mpepping/cyberchef?icon=docker&label=image%20size)](https://hub.docker.com/r/mpepping/cyberchef/)
![Github stars](https://badgen.net/github/stars/mpepping/docker-cyberchef?icon=github&label=stars)
![Github forks](https://badgen.net/github/forks/mpepping/docker-cyberchef?icon=github&label=forks)
![Github issues](https://img.shields.io/github/issues/mpepping/docker-cyberchef)
![Github last-commit](https://img.shields.io/github/last-commit/mpepping/docker-cyberchef)


GCHQ [CyberChef](https://github.com/gchq/CyberChef/) in a container. CyberChef is *the* **Cyber Swiss Army Knife** web app for encryption, encoding, compression and data analysis.

New container-images for both the [CyberChef master branch](https://github.com/gchq/CyberChef) as well as new [CyberChef releases](https://github.com/gchq/CyberChef/releases) are build on a daily base. See [https://hub.docker.com/r/mpepping/cyberchef/](https://hub.docker.com/r/mpepping/cyberchef/).

## Run

### Run with Docker Run

```bash
docker run -d -p 8000:8000 mpepping/cyberchef
```

A listing of all available version tags can be found on the [Docker Hub](https://hub.docker.com/r/mpepping/cyberchef/tags) page.

### Run with Docker Compose

To run CyberChef using the docker-compose, you can use the following docker-compose.yaml file

```yaml
version: "3"

services:
  cyber-chef:
    image: mpepping/cyberchef:latest
    restart: unless-stopped
    ports:
      - "8000:8000"
```

## Refs

* [https://github.com/mpepping/docker-cyberchef/](https://github.com/mpepping/docker-cyberchef/)
* [https://hub.docker.com/r/mpepping/cyberchef/](https://hub.docker.com/r/mpepping/cyberchef/)
* [https://github.com/gchq/CyberChef/](https://github.com/gchq/CyberChef/)
