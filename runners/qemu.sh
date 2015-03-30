#!/usr/bin/env sh

qemu-system-$CPU_FAMILY      \\
  -enable-kvm                \\
  --kernel bzImage           \\
  --initrd initramfs.cpio.gz \\
  -hda     usersfs.img       \\
  -append  \"root=/dev/sda vga=0x318\"
