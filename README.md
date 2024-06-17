# Build Clash as an Image, then run it anywhere.

[![Docker Pulls](https://img.shields.io/docker/pulls/wujun4code/clash)](https://hub.docker.com/r/wujun4code/clash)
[![GitHub Issues](https://img.shields.io/github/issues/easy-programming-guide/clash)](https://github.com/easy-programming-guide/clash/issues)
[![License](https://img.shields.io/github/license/easy-programming-guide/clash)](LICENSE)

## Quick start

Use case docs can be found -> [Install CLASH](https://easy-programming-guide.github.io/clash/)

## Build image

edit the `config.sample.yaml` with your proxies, and rename it to `config.yaml`

the run 

```bash
docker compose up -d --build 
```
in case of connection issue with  `https://cdn.jsdelivr.net` you can comment in the `args` and replace with your proxy

```yaml
      # args:
      #   HTTP_PROXY: http://192.168.137.200:7890
      #   HTTPS_PROXY: http://192.168.137.200:7890
      #   NO_PROXY: localhost,127.0.0.1
```

## Quick Run

```sh
docker build -t clash
docker run -d \
  --name clash \
  -v ./config.yaml:/opt/clash/config.yaml \
  clash
```

## Customize build

```bash
docker build -t clash .
```

or if you are using a proxy to build your can pass the args with this way, `192.168.137.200` is the ip of your docker host, please do not use `127.0.0.1`.

```bash
docker build \
    --build-arg HTTP_PROXY=http://192.168.137.200:7890 \
    --build-arg HTTPS_PROXY=http://192.168.137.200:7890 \
    --build-arg NO_PROXY=localhost,127.0.0.1 \
    -t clash .
```

## Build with Github Action

please check `./.github/workflows`

## Run docs locally

```bash
git submodule update --init --recursive
cd ./guide
hugo serve --bind 0.0.0.0 --baseURL http://0.0.0.0:1313  --port 1313
```