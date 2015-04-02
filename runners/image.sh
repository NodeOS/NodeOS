#!/usr/bin/env sh

qemu-system-$CPU_FAMILY -enable-kvm rootfs.img
