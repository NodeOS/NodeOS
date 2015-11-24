#!/usr/bin/env sh

qemu-system-$CPU_FAMILY \\
  -enable-kvm           \\
  -vga std              \\
  -m 256M               \\
  -hda rootfs           \\
  -hdb usersfs
