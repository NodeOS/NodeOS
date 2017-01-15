FROM nodeos/barebones

MAINTAINER Jesús Leganés Combarro 'piranna' <piranna@gmail.com>

ADD initramfs.tar.gz /

VOLUME /tmp
ADD usersfs.tar.gz /tmp

ENV root container

ENTRYPOINT ["/init"]
