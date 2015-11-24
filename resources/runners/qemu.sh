#!/usr/bin/env sh

qemu-system-$CPU_FAMILY \\
  -enable-kvm           \\
  -vga std              \\
  -m 256M               \\
  --kernel barebones    \\
  --initrd initramfs    \\
  -hda     usersfs      \\
  -append  \"root=/dev/sda ip=dhcp vga=0x344\"
