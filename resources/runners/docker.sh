#!/usr/bin/env sh

docker import barebones.tar.gz nodeos/barebones
docker build -t nodeos/initramfs .

docker run -it                         \
    --cap-add SYS_ADMIN                \
    --security-opt=apparmor:unconfined \
    --device /dev/fuse                 \
    nodeos/initramfs
