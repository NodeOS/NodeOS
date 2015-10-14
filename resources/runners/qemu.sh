#!/usr/bin/env sh

qemu-system-$CPU_FAMILY \\
  -enable-kvm           \\
  --kernel barebones    \\
  --initrd initramfs    \\
  -hda     usersfs      \\
  -append  \"root=/dev/sda vga=0x344\"
