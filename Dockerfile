FROM ubuntu:latest

WORKDIR /opt/clash

RUN apt update && \
    apt install -y gzip curl net-tools dnsutils traceroute telnet nmap wget

COPY clash-linux-amd64-n2023-09-05-gdcc8d87.gz /opt/clash/
RUN gunzip /opt/clash/clash-linux-amd64-n2023-09-05-gdcc8d87.gz && \
    mv /opt/clash/clash-linux-amd64-n2023-09-05-gdcc8d87 /opt/clash/clash && \
    chmod +x /opt/clash/clash 

COPY Country.mmdb /opt/clash/

RUN mkdir -p /opt/clash/ruleset

VOLUME /opt/clash/config.yaml

EXPOSE 53 7890 7891 9090

CMD ["/opt/clash/clash", "-d", "/opt/clash/"]