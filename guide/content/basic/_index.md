---
title: Intsall
weight: 1
chapter: true
pre: "<b></b>"
---

# Install with `docker compose`

download the `config.sample.yaml`

```sh
wget https://raw.githubusercontent.com/easy-programming-guide/clash/main/config.sample.yaml
```

then download the `docker-compose.yml`

```sh
wget https://raw.githubusercontent.com/easy-programming-guide/clash/main/sample/clash-standalone/docker-compose.yml
```

it should follow the content

```yml
services:
  clash:
    image: ghcr.io/easy-programming-guide/clash:latest
    volumes:
      - ./config.yaml:/opt/clash/config.yaml
    ports:
      # - "53:53"
      - "7890:7890"
      - "7891:7891"
```