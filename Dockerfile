FROM alpine:3.23.3

LABEL org.opencontainers.image.title="Azure DNS Forwarder" \
      org.opencontainers.image.description="A lightweight containerized DNS forwarder for Azure Virtual Networks and Private Link resources." \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.authors="Team Orbit <hello@orbit.is>" \
      org.opencontainers.image.vendor="Orbit Cloud ehf." \
      org.opencontainers.image.url="https://github.com/OrbitCloud/azure-dns-forwarder" \
      org.opencontainers.image.documentation="https://github.com/OrbitCloud/azure-dns-forwarder/blob/main/README.md" \
      org.opencontainers.image.source="https://github.com/OrbitCloud/azure-dns-forwarder"

RUN apk upgrade --no-cache \
    && apk add --no-cache dnsmasq

EXPOSE 53/udp 53/tcp
ENTRYPOINT ["dnsmasq", "--no-daemon", "--no-hosts", "--no-resolv", "--server"]
CMD ["168.63.129.16"]
