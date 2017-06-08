#!/usr/bin/env sh

# NodeOS
#
# Copyright (c) 2013-2017 Jacob Groundwater, Jesús Leganés-Combarro 'piranna'
# and other contributors
#
# MIT License

docker import barebones.tar.gz nodeos/barebones
docker build -t nodeos/initramfs .

docker run -it                         \
    --cap-add SYS_ADMIN                \
    --security-opt=apparmor:unconfined \
    --device /dev/fuse                 \
    nodeos/initramfs
