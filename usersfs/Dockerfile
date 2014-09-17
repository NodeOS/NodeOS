#FROM nodeos/base
FROM rootfs

ADD USERS/ /home/

MAINTAINER Jacob Groundwater <groundwater@gmail.com>

ENTRYPOINT ["/init", "/bin/nodeos-rootfs"]
CMD        ["/home/nodeos/bin/nsh"]
