# Build Clash as an Image, then run it anywhere.

[![Docker Pulls](https://img.shields.io/docker/pulls/wujun4code/clash)](https://hub.docker.com/r/wujun4code/clash)
[![GitHub Issues](https://img.shields.io/github/issues/easy-programming-guide/clash)](https://github.com/easy-programming-guide/clash/issues)
[![License](https://img.shields.io/github/license/easy-programming-guide/clash)](LICENSE)

## Quick start

edit the `config.sample.yaml` with your proxies, and rename it to `config.yaml`

the run 

```bash
docker compose up -d --build 
```
in case of connection with  `https://cdn.jsdelivr.net` you can comment in the `args` and replace with your proxy

```yaml
      # args:
      #   HTTP_PROXY: http://192.168.137.1:7890
      #   HTTPS_PROXY: http://192.168.137.1:7890
      #   NO_PROXY: localhost,127.0.0.1
```


## Customize build

```bash
docker build -t clash .
```

or if you are using a proxy to build your can pass the args with this way

```bash
docker build \
    --build-arg HTTP_PROXY=http://192.168.137.1:7890 \
    --build-arg HTTPS_PROXY=http://192.168.137.1:7890 \
    --build-arg NO_PROXY=localhost,127.0.0.1 \
    -t clash .
```

## Build with Github Action

please check `./.github/workflows`