FROM debian:trixie-slim

RUN apt-get update && \
    apt-get install -y curl jq cron && \
    apt-get clean

WORKDIR /app

COPY cloudflare-ddns.sh ./cloudflare-ddns.sh

RUN echo "*/5 * * * * root /app/cloudflare-ddns.sh >> /proc/1/fd/1 2>&1" > /etc/cron.d/ddns && \
    chmod 0644 /etc/cron.d/ddns

CMD ["cron", "-f"]
