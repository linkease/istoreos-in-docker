FROM scratch
ADD rootfs.tar.gz /
COPY quickstart /usr/sbin/quickstart
RUN mkdir -p /var/lock
RUN opkg remove --force-depends \
      iw* && \
    opkg update && \
    opkg install kmod-mac80211 \
      iptables-mod-checksum

RUN echo "iptables -A POSTROUTING -t mangle -p udp --dport 68 -j CHECKSUM --checksum-fill" >> /etc/firewall.user
RUN sed -i '/^exit 0/i cat \/tmp\/resolv.conf > \/etc\/resolv.conf' /etc/rc.local

RUN sed -i "/ttyS0/d" /etc/inittab
RUN sed -i "/tty1/d" /etc/inittab

ARG ts
LABEL org.opencontainers.image.created=$ts
LABEL org.opencontainers.image.version=21.02.2
LABEL org.opencontainers.image.source=https://github.com/linkease/istoreos-in-docker

CMD [ "/sbin/init" ]
