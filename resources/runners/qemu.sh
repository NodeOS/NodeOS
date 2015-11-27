APPEND="root=/dev/sda ip=dhcp vga=0x344"
while [ ! $# -eq 0 ]
do
    case "$1" in
        --terminal | -t)
            APPEND="$APPEND console=ttyAMA0,115200 console=ttyS0"
            QEMU="$QEMU -nographic"
            echo "$APPEND $QEMU"
            ;;
    esac
    shift
done

grep -q -e "vmx" -e "svm" /proc/cpuinfo
if [ $? -eq 0 ]; then
  QEMU="$QEMU -enable-kvm"
fi

$QEMU                   \
  -vga std              \
  -m 256M               \
  -redir tcp:50080::80  \
  -redir tcp:50443::443 \
  --kernel barebones    \
  --initrd initramfs    \
  -hda     usersfs      \
  -append  "$APPEND"
