---
title: Work With Pihole
weight: 1
pre: "<b></b>"
---
# Run Clash with Pi-Hole as Dns Server 

## Prerequisites

- Try [Run Clash Standalone]({{% ref "basic/_index.md" %}}) before current guide.

## What is Pi-Hole?

{{% notice style="tip" %}}
Pi-Hole is a good open source Dns Server that you can self hosted anywhere. Please get more details from [https://pi-hole.net/](https://pi-hole.net/).
{{% /notice %}}

### Run Clash and Pi-Hole both

1. Download yamls

    ```sh
    wget https://raw.githubusercontent.com/easy-programming-guide/clash/main/config.sample.yaml
    wget https://raw.githubusercontent.com/easy-programming-guide/clash/main/sample/clash-pihole/docker-compose.yml
    ```

2. Rename `config.sample.yaml` to `config.yaml`, MUST follow steps from [Update config]({{% ref "basic/#update-config" %}}).
    
    {{% notice style="note" %}}
    > Please follow the steps from [Update config]({{% ref "basic/#update-config" %}}).
    {{% /notice %}}

   and you should disable dns service from Clash, edit `config.yaml`, the 

   ```yaml
    dns:
    enable: false # set it to false, should disable it when you are using pi-hole now.
    listen: 0.0.0.0:53
    ipv6: true
   ```


3. Stop local dns service 

    ```sh
    sudo systemctl stop systemd-resolved
    sudo systemctl disable systemd-resolved
    ```

4. Burn them up

    ```sh
    docker compose up -d
    ```