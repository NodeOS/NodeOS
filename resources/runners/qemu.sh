# NodeOS
#
# Copyright (c) 2013-2017 Jacob Groundwater, Jesús Leganés-Combarro 'piranna'
# and other contributors
#
# MIT License

APPEND="root=/dev/sda ip=dhcp vga=0x344"
while [ ! $# -eq 0 ]
do
    case "$1" in
        --terminal | -t)
            APPEND="$APPEND console=ttyAMA0,115200 console=ttyS0"
            QEMU="$QEMU -nographic"
            ;;
    esac
    shift
done

grep -q -e "vmx" -e "svm" /proc/cpuinfo
if [ $? -eq 0 ]; then
  QEMU="$QEMU -enable-kvm"
fi

$QEMU                        \
  -vga std                   \
  -m 256M                    \
  -redir tcp:50080::80       \
  -redir tcp:50443::443      \
  --kernel kernel            \
  --initrd initramfs.cpio.gz \
  -hda     usersfs.img       \
  -append  "$APPEND"
