#!/usr/bin/env bash

RED="\e[31m"
GRN="\e[32m"
WHT="\e[37m"
CLR="\e[0m"

# Platform aliases
case $PLATFORM in
  ""|pc|qemu)
    PLATFORM=pc_qemu
  ;;
  iso)
    PLATFORM=pc_iso
  ;;

  docker)
    PLATFORM=docker_64
  ;;

  qemu_32)
    PLATFORM=pc_qemu_32
  ;;
  iso_32)
    PLATFORM=pc_iso_32
  ;;

  qemu_64)
    PLATFORM=pc_qemu_64
  ;;
  iso_64)
    PLATFORM=pc_iso_64
  ;;

  raspberry)
    PLATFORM=raspberry_qemu
  ;;
esac

# default CPU for each platform
if [[ -z "$CPU" ]]; then
  case $PLATFORM in
    *_32)
      CPU=i686
    ;;
    *_64)
      CPU=x86_64
    ;;

    raspberry_*)
      CPU=armv6
    ;;

    *)
#      CPU=native  # https://gcc.gnu.org/onlinedocs/gcc-4.9.2/gcc/i386-and-x86-64-Options.html#i386-and-x86-64-Options
      CPU=`uname -m`
    ;;
  esac
fi

# [Hack] Can't be able to use x86_64 as generic x86 64 bits CPU
case $CPU in
  x86_64)
    CPU=nocona
  ;;
esac

# Normalice platforms
case $PLATFORM in
  docker_*)
    PLATFORM=docker
  ;;

  pc_qemu_*)
    PLATFORM=pc_qemu
  ;;
  pc_iso_*)
    PLATFORM=pc_iso
  ;;

#  raspberry_*)
#    PLATFORM=raspberry
#  ;;

  vagga_*)
    PLATFORM=vagga
  ;;
esac

# Set target and architecture for the selected CPU
case $CPU in
  armv6)
    ARCH="arm"
    CPU_FAMILY=arm
    NODE_ARCH=arm
    TARGET=$CPU-nodeos-linux-musleabihf
  ;;
  i[34567]86)
    ARCH="x86"
    CPU_FAMILY=i386
    NODE_ARCH=ia32
    TARGET=$CPU-nodeos-linux-musl
  ;;
  x86_64|nocona)
    ARCH="x86"
    CPU_FAMILY=x86_64
    NODE_ARCH=x64
#    TARGET=$CPU-nodeos-linux-musl
    TARGET=x86_64-nodeos-linux-musl
  ;;
  *)
    echo "Unknown CPU '$CPU'"
    exit 1
  ;;
esac


# Set host triplet and number of concurrent jobs
HOST=$(echo ${MACHTYPE} | sed "s/-[^-]*/-cross/")

if [[ -z $JOBS ]]; then
  JOBS=$((`getconf _NPROCESSORS_ONLN` + 1))
fi


# Auxiliar variables
OBJECTS=`pwd`/obj/$CPU
OUT_DIR=`pwd`/out/$CPU

if [[ $TOOLS ]]; then
  TOOLS=`realpath -s $TOOLS`
fi
PATH=$TOOLS/bin:/bin:/usr/bin

SILENT="--silent LIBTOOLFLAGS=--silent V="
MAKE1="make $SILENT"
MAKE="$MAKE1 --jobs=$JOBS"


# Clean object dir and return the input error
function err(){
  echo -e "${RED}Error compiling '${OBJ_DIR}'${CLR}"
  rm -rf $OBJ_DIR
  rmdir -p --ignore-fail-on-non-empty `dirname $OBJ_DIR`
  exit $1
}
