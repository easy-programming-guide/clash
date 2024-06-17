---
title: Quick Start
weight: 1
pre: "<b></b>"
---

# Run Clash Standalone

## Download the config yaml files
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

## Update config

rename `config.sample.yaml` to `config.yaml` and replace the proxies with your proxy servers.

```yaml
...
proxies:
  # shadowsocks
  # 支持加密方式：
  #   aes-128-gcm aes-192-gcm aes-256-gcm
  #   aes-128-cfb aes-192-cfb aes-256-cfb
  #   aes-128-ctr aes-192-ctr aes-256-ctr
  #   rc4-md5 chacha20 chacha20-ietf xchacha20
  #   chacha20-ietf-poly1305 xchacha20-ietf-poly1305

  - name: "ss1"
    type: ss
    server: server
    port: 443
    cipher: chacha20-ietf-poly1305
    password: "password"
    # udp: true

  - name: "ss2"
    type: ss
    server: server
    port: 443
    cipher: AEAD_CHACHA20_POLY1305
    password: "password"
    plugin: obfs
    plugin-opts:
      mode: tls # 混淆模式，可以选择 http 或 tls
      host: bing.com # 混淆域名，需要和服务器配置保持一致

  - name: "ss3"
    type: ss
    server: server
    port: 443
    cipher: AEAD_CHACHA20_POLY1305
    password: "password"
    plugin: v2ray-plugin
    plugin-opts:
      mode: websocket # 暂时不支持 QUIC 协议
      # tls: true # wss
      # skip-cert-verify: true
      # host: bing.com
      # path: "/"
      # headers:
      #   custom: value

  # vmess
  # 支持加密方式：auto / aes-128-gcm / chacha20-poly1305 / none
  - name: "vmess"
    type: vmess
    server: server
    port: 443
    uuid: uuid
    alterId: 32
    cipher: auto
    # udp: true
    # tls: true
    # skip-cert-verify: true
    # servername: example.com # 优先级高于 wss host
    # network: ws
    # ws-path: /path
    # ws-headers:
    #   Host: v2ray.com

  - name: "vmess-http"
    type: vmess
    server: server
    port: 443
    uuid: uuid
    alterId: 32
    cipher: auto
    # udp: true
    # network: http
    # http-opts:
    #   # method: "GET"
    #   # path:
    #   #   - '/'
    #   #   - '/video'
    #   # headers:
    #   #   Connection:
    #   #     - keep-alive

  # socks5
  - name: "socks"
    type: socks5
    server: server
    port: 443
    # username: username
    # password: password
    # tls: true
    # skip-cert-verify: true
    # udp: true

  # http
  - name: "http"
    type: http
    server: server
    port: 443
    # username: username
    # password: password
    # tls: true # https
    # skip-cert-verify: true

  - name: "snell"
    type: snell
    server: server
    port: 44046
    psk: yourpsk
    # obfs-opts:
    # mode: http # 或 tls
    # host: bing.com

  # Trojan
  - name: "trojan"
    type: trojan
    server: server
    port: 443
    password: yourpsk
  - name: "ssr"
    type: ssr
    server: server
    port: 443
    cipher: chacha20-ietf
    password: "password"
    obfs: tls1.2_ticket_auth
    protocol: auth_sha1_v4
    # obfs-param: domain.tld
    # protocol-param: "#"
    # udp: true

proxy-groups:

  - name: Auto
    type: url-test
    proxies:
      - ss1
      - ss2
      - trojan
      - ssr
    # tolerance: 150
    # lazy: true
    url: 'http://www.gstatic.com/generate_204'
    interval: 300
...
```

{{% notice style="note" %}}
Please add your proxies to `Auto` ->

```yaml
proxy-groups:

  - name: Auto
    type: url-test
    proxies:
      - <your-proxy-1>
      - <your-proxy-2>
      - ...
      - <your-proxy-999>
    # tolerance: 150
    # lazy: true
    url: 'http://www.gstatic.com/generate_204'
    interval: 300
```
{{% /notice %}}

## Start service

```sh
docker compose up -d
```

then you can use it as your proxy.

## Set proxy
{{< tabs >}}
{{% tab title="Linux" %}}
### for console program

```sh
sudo vi .bashrc
```

add the following content

```sh
export http_proxy=http://127.0.0.1:7890/
export https_proxy=http://127.0.0.1.1:7890/
export ftp_proxy=http://127.0.0.1:7890/
```

### for apt 

```sh
sudo vi /etc/apt/apt.conf
```

add these content

```sh
Acquire::http::proxy "http://127.0.0.1:7890/";
Acquire::https::proxy "http://127.0.0.1:7890/";
Acquire::ftp::proxy "http://127.0.0.1:7890/";
```

### for System-wide

```sh
sudo vi /etc/environment
```

```sh
http_proxy=http://127.0.0.1:7890/
https_proxy=http://127.0.0.1:7890/
ftp_proxy=http://127.0.0.1:7890/
```

{{% /tab %}}

{{% tab title="MaxOS" %}}

### Setting Up HTTP Proxy on macOS
1. Open System Preferences:

- Click the Apple menu in the top-left corner of your screen.
- Select "System Preferences".

2. Network Settings:

- Click on "Network".
- Select the network interface you're currently using (e.g., Wi-Fi or Ethernet) from the left sidebar.

3. Advanced Settings:

- Click the "Advanced…" button in the lower-right corner.
- Navigate to the "Proxies" tab.

4. Configure HTTP Proxy:

- Check the box next to "Web Proxy (HTTP)".
- In the "Web Proxy Server" box, enter `127.0.0.1` for the address and `7890` for the port.

5. Apply Settings:

- Click "OK" to close the Advanced settings window.
- Click "Apply" to save the changes.
{{% /tab %}}

{{% tab title="Windows" %}}

### Setting Up HTTP Proxy on macOS
1. Open Settings:

- Press Windows + I to open the Settings app.
- Alternatively, click the Start menu and select "Settings".

2. Network & Internet:

- In the Settings window, click on "Network & Internet".

3. Proxy Settings:

- In the left sidebar, click on "Proxy".

4. Configure HTTP Proxy:

- Under "Manual proxy setup", turn on the "Use a proxy server" switch.
- In the "Address" field, enter 127.0.0.1.
- In the "Port" field, enter 7890.

5. Save Settings:

- Click "Save" to apply the changes.
{{% /tab %}}

{{< /tabs >}}
