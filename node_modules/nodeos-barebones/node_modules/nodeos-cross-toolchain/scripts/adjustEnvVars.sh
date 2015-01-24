#!/usr/bin/env bash

# Platform aliases
case $PLATFORM in
  ""|pc|qemu)
    PLATFORM=pc_qemu
  ;;
  image)
    PLATFORM=pc_image
  ;;

  docker)
    PLATFORM=docker_64
  ;;

  qemu_32)
    PLATFORM=pc_qemu_32
  ;;
  image_32)
    PLATFORM=pc_image_32
  ;;

  qemu_64)
    PLATFORM=pc_qemu_64
  ;;
  image_64)
    PLATFORM=pc_image_64
  ;;

  raspberry)
    PLATFORM=raspberry_qemu
  ;;
esac

# default CPU for each platform
if [[ -z "$CPU" ]]; then
  case $PLATFORM in
    pc_qemu|pc_image)
#      CPU=native  # https://gcc.gnu.org/onlinedocs/gcc-4.9.2/gcc/i386-and-x86-64-Options.html#i386-and-x86-64-Options
      CPU=`uname -m`
    ;;

    docker_32|pc_qemu_32|pc_image_32)
      CPU=i686
    ;;
    docker_64|pc_qemu_64|pc_image_64)
      CPU=x86_64
    ;;

    raspberry_qemu|raspberry_image)
      CPU=armv6
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
  docker_32|docker_64)
    PLATFORM=docker
  ;;

  pc_qemu_32|pc_qemu_64)
    PLATFORM=pc_qemu
  ;;
  pc_image_32|pc_image_64)
    PLATFORM=pc_image
  ;;

#  raspberry_qemu)
#    PLATFORM=raspberry
#  ;;
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

PATH=$TOOLS/bin:/bin:/usr/bin

MAKE1="make --silent"
MAKE="$MAKE1 --jobs=$JOBS"
