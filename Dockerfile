FROM alpine:3.20.3
LABEL maintainer="Dmitry Mozzherin"
RUN apk --no-cache add dnsmasq
EXPOSE 53/udp
ENTRYPOINT ["dnsmasq", "--no-daemon", "--no-hosts", "--no-resolv", "--server"]
CMD ["168.63.129.16"]
