#!/usr/bin/env bash

#
# Linux kernel headers
#

SRC_DIR=$SOURCES/linux

if [[ ! -d $CLFS/cross-tools/$TARGET/include/linux ]]; then
  (
    cd $SRC_DIR

    # Extract headers
    make mrproper                                             &&
    make ARCH=$ARCH headers_check                             &&
    make ARCH=$ARCH INSTALL_HDR_PATH=${CLFS}/cross-tools/${TARGET} headers_install
  ) || exit 100
fi


#
# binutils
#

SRC_DIR=$SOURCES/binutils
OBJ_DIR=$OBJECTS/binutils

# Configure & compile
if [[ ! -d $OBJ_DIR ]]; then
  mkdir -p $OBJ_DIR || exit 110

  (
    cd $OBJ_DIR

    $SRC_DIR/configure                               \
        --prefix=${CLFS}/cross-tools                 \
        --target=$TARGET                             \
        --with-sysroot=${CLFS}/cross-tools/${TARGET} \
        --disable-werror                             \
        --disable-nls                                \
        --disable-multilib                            || exit 111

    $MAKE configure-host || exit 112
    $MAKE                || exit 113
  )

#  case $(uname -m) in
#    x86_64)
#      mkdir -v $TOOLS/lib && ln -sv lib $TOOLS/lib64
#    ;;
#  esac
fi

# Install
( cd $OBJ_DIR && $MAKE install ) || exit 114


#
# gcc static
#

SRC_DIR=$SOURCES/gcc
OBJ_DIR=$OBJECTS/gcc-static

# Configure & compile
if [[ ! -d $OBJ_DIR ]]; then
  mkdir -p $OBJ_DIR || exit 120

  (
    cd $OBJ_DIR

    $SRC_DIR/configure                               \
        --prefix=${CLFS}/cross-tools                 \
        --build=$HOST                                \
        --host=$HOST                                 \
        --target=$TARGET                             \
        --with-sysroot=${CLFS}/cross-tools/${TARGET} \
        --disable-nls                                \
        --disable-shared                             \
        --without-headers                            \
        --with-newlib                                \
        --disable-decimal-float                      \
        --disable-libgomp                            \
        --disable-libmudflap                         \
        --disable-libssp                             \
        --disable-libatomic                          \
        --disable-libquadmath                        \
        --disable-threads                            \
        --disable-multilib                           \
        --with-mpfr-include=$SRC_DIR/mpfr/src        \
        --with-mpfr-lib=$(pwd)/mpfr/src/.libs        \
        --with-arch=${CPU}                           \
        --enable-languages=c,c++                     || exit 121

    $MAKE all-gcc all-target-libgcc || exit 122
  )
fi

# Install
( cd $OBJ_DIR && $MAKE install-gcc install-target-libgcc ) || exit 123


#
# musl
#

SRC_DIR=$SOURCES/musl
OBJ_DIR=$OBJECTS/musl

# Configure & compile
if [[ ! -d $OBJ_DIR ]]; then
#  mkdir -p $OBJ_DIR || exit 130

  (
#    cd $OBJ_DIR
    cd $SRC_DIR

    CC=${TARGET}-gcc $SRC_DIR/configure \
        --prefix=/                      \
        --target=${TARGET}              || exit 131

    CC=${TARGET}-gcc $MAKE || exit 132
  )
fi

# Install
#( cd $OBJ_DIR && DESTDIR=${CLFS}/cross-tools/${TARGET} $MAKE install ) || exit 133
( cd $SRC_DIR && DESTDIR=${CLFS}/cross-tools/${TARGET} $MAKE install ) || exit 133


#
# gcc final
#

SRC_DIR=$SOURCES/gcc
OBJ_DIR=$OBJECTS/gcc-final

# Configure & compile
if [[ ! -d $OBJ_DIR ]]; then
  mkdir -p $OBJ_DIR &&
  (
    cd $OBJ_DIR                                        &&
    $SRC_DIR/configure \
        --prefix=${CLFS}/cross-tools \
        --build=${HOST} \
        --host=${HOST} \
        --target=${TARGET} \
        --with-sysroot=${CLFS}/cross-tools/${TARGET} \
        --disable-nls \
        --enable-c99 \
        --enable-long-long \
        --disable-libmudflap \
        --disable-multilib \
        --with-mpfr-include=$SRC_DIR/mpfr/src \
        --with-mpfr-lib=$(pwd)/mpfr/src/.libs \
        --with-arch=${CPU} \
        --enable-languages=c,c++                       &&
    $MAKE
  ) || exit 120
fi

# Install
( cd $OBJ_DIR && $MAKE install ) || exit 121


# #
# # glibc
# #
#
# SRC_DIR=$SOURCES/libc
# OBJ_DIR=$OBJECTS/libc
#
# LINUX_VERSION=$(cd $SOURCES/linux; make kernelversion)
#
# # Configure & compile
# if [[ ! -d $OBJ_DIR ]]; then
#   mkdir -p $OBJ_DIR &&
#   (
#     cd $OBJ_DIR                                &&
#     $SRC_DIR/configure                         \
#       --prefix=$TOOLS                          \
#       --host=$TARGET                           \
#       --build=$($SRC_DIR/scripts/config.guess) \
#       --disable-profile                        \
#       --disable-sanity-checks                  \
#       --enable-kernel=$LINUX_VERSION           \
#       --with-headers=$TOOLS/include            \
#       libc_cv_forced_unwind=yes                \
#       libc_cv_ctors_header=yes                 \
#       libc_cv_c_cleanup=yes                    &&
#     $MAKE
#   ) || exit 130
# fi
#
# # Install
# ( cd $OBJ_DIR && $MAKE install ) || exit 131


#
# Check basic functions (compiling and linking) works as expected
#

echo 'main(){}' > dummy.c          || exit 140
$TARGET-gcc dummy.c                || exit 141
readelf -l a.out | grep ': '$TOOLS || exit 142
rm -v dummy.c a.out                || exit 143


echo -e "${GRN}Successfully built cross-toolchain pass 1${CLR}"
