FROM initramfs

MAINTAINER Jacob Groundwater <groundwater@gmail.com>

ADD ROOT/ /root/
RUN chown -R root:root /

ENTRYPOINT ["/init"]
CMD        ["/bin/nodeos-rootfs"]
