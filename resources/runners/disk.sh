# NodeOS
#
# Copyright (c) 2013-2017 Jacob Groundwater, Jesús Leganés-Combarro 'piranna'
# and other contributors
#
# MIT License

while [ ! $# -eq 0 ]
do
    case "$1" in
        --terminal | -t)
            QEMU="$QEMU -nographic"
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
  -hda disk.img
