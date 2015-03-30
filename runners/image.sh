#!/usr/bin/env sh

qemu-system-$CPU_FAMILY \\
  -enable-kvm           \\
  -hda rootfs.img       \\
  -hdb usersfs.img
