FROM scratch
ADD rootfs.tar.gz /
COPY ./setupvmease /etc/init.d/setupvmease
RUN mkdir -p /var/lock
RUN opkg remove --force-depends iw*

RUN /etc/init.d/setupvmease enable
RUN echo "iptables -A POSTROUTING -t mangle -p udp --dport 68 -j CHECKSUM --checksum-fill" >> /etc/firewall.user
RUN sed -i '/^exit 0/i cat \/tmp\/resolv.conf > \/etc\/resolv.conf' /etc/rc.local

RUN sed -i "/ttyS0/d" /etc/inittab
RUN sed -i "/tty1/d" /etc/inittab

ARG ts
LABEL org.opencontainers.image.created=$ts
LABEL org.opencontainers.image.version=22.03
LABEL org.opencontainers.image.source=https://github.com/linkease/istoreos-in-docker

CMD [ "/sbin/init" ]
