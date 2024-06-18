---
title: Run as Linux Systemd Service
weight: 2
pre: "<b></b>"
---

# Install Clash for Llinux


## Remove conflicts

check if legacy service exits

```sh
systemctl status clash.service
```

if exist, remove it

```sh
sudo rm -rf vi /etc/systemd/system/clash.service
```

## Download clash-linux-amd64

```sh
wget https://github.com/easy-programming-guide/clash/raw/main/clash-linux-amd64-n2023-09-05-gdcc8d87.gz
```

then install it

```sh
sudo gunzip /opt/clash/clash-linux-amd64-n2023-09-05-gdcc8d87.gz && \
    mv /opt/clash/clash-linux-amd64-n2023-09-05-gdcc8d87 /opt/clash/clash && \
    chmod +x /opt/clash/clash 
```

{{% notice style="note" %}}
if `gunzip` is missing, please install gzip `apt-get install -y gzip`.
{{% /notice %}}

## Add Country.db

```sh
wget https://github.com/easy-programming-guide/clash/raw/main/Country.mmdb
```

copy it with clash 

```sh
sudo mv Country.mmdb /opt/clash/
```

## Download popular ruleset

```sh
curl -L -o /opt/clash/ruleset/reject.yaml https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/reject.txt
curl -L -o /opt/clash/ruleset/icloud.yaml https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/icloud.txt
curl -L -o /opt/clash/ruleset/apple.yaml https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/apple.txt
curl -L -o /opt/clash/ruleset/google.yaml https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/google.txt
curl -L -o /opt/clash/ruleset/proxy.yaml https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/proxy.txt
curl -L -o /opt/clash/ruleset/direct.yaml https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/direct.txt
curl -L -o /opt/clash/ruleset/private.yaml https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/private.txt
curl -L -o /opt/clash/ruleset/gfw.yaml https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/gfw.txt
curl -L -o /opt/clash/ruleset/tld-not-cn.yaml https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/tld-not-cn.txt
curl -L -o /opt/clash/ruleset/telegramcidr.yaml https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/telegramcidr.txt
curl -L -o /opt/clash/ruleset/cncidr.yaml https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/cncidr.txt
curl -L -o /opt/clash/ruleset/lancidr.yaml https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/lancidr.txt
curl -L -o /opt/clash/ruleset/applications.yaml https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/applications.txt
```

then you can download some extra rulesets with this way 

```sh
curl -L -o /opt/clash/ruleset/chatGPT.yaml https://raw.githubusercontent.com/easy-programming-guide/clash/main/ruleset/chatGPT.yaml
```

## Update config.yaml

download the `config.sample.yaml`

```sh
wget https://raw.githubusercontent.com/easy-programming-guide/clash/main/config.sample.yaml
```

Rename `config.sample.yaml` to `config.yaml`, MUST follow steps from [Update config]({{% ref "basic/#update-config" %}}).
    
{{% notice style="note" %}}
Please follow the steps from [Update config]({{% ref "basic/#update-config" %}}).
{{% /notice %}}


then copy your config.yaml to clash root directory

```sh
sudo mv config.yaml /opt/clash/
```

## Verify

```sh
cd /opt/clash
sudo ./clash -d .
```

if works well, you will see

```log
Jun 17 02:21:17 ubuntu-dev-server clash[21780]: 02:21:17 INF [Config] initial rule provider name=telegramcidr
Jun 17 02:21:17 ubuntu-dev-server clash[21780]: 02:21:17 INF [Config] initial rule provider name=applications
Jun 17 02:21:17 ubuntu-dev-server clash[21780]: 02:21:17 INF [DNS] server listening addr=[::]:53
Jun 17 02:21:17 ubuntu-dev-server clash[21780]: 02:21:17 INF [API] listening addr=[::]:9090
Jun 17 02:21:17 ubuntu-dev-server clash[21780]: 02:21:17 INF inbound create success inbound=http addr=:7890 network=tcp
Jun 17 02:21:17 ubuntu-dev-server clash[21780]: 02:21:17 INF inbound create success inbound=socks addr=:7891 network=tcp
Jun 17 02:21:17 ubuntu-dev-server clash[21780]: 02:21:17 INF inbound create success inbound=socks addr=:7891 network=udp
```

## Set systemd service

{{% notice style="note" %}}
Please stop `/opt/clash/clash` service before the next steps.
{{% /notice %}}

```sh
wget https://raw.githubusercontent.com/easy-programming-guide/clash/main/sample/clash-linux/clash.service
sudo mv clash.service /etc/systemd/system/
sudo systemctl start clash.service
sudo systemctl enable clash.service
```


## Uninstall

1. stop service

    ```sh
    systemctl status clash.service
    systemctl stop clash.service
    systemctl daemon-reload
    sudo rm -rf /etc/systemd/system/clash.service
    ```

2. remove clash

```sh
sudo rm -rf /opt/clash
```