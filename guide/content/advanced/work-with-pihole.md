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

3. Run them both

    ```sh
    docker compose up -d
    ```