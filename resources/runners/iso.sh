#!/usr/bin/env sh

qemu-system-$CPU_FAMILY \\
  -enable-kvm           \\
  -hda rootfs           \\
  -hdb usersfs
