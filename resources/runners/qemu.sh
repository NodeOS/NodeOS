#!/usr/bin/env sh

QEMU=qemu-system-$CPU_FAMILY

grep -q -e "vmx" -e "svm" /proc/cpuinfo
if [ $? -eq 0 ]; then
  QEMU=\"\$QEMU -enable-kvm\"
fi

\$QEMU                  \\
  -vga std              \\
  -m 256M               \\
  --kernel barebones    \\
  --initrd initramfs    \\
  -hda     usersfs      \\
  -append  \"root=/dev/sda ip=dhcp vga=0x344\"
