#!/usr/bin/env bash


TOOLS=$CLFS/cross-tools

#
# Linux kernel headers
#

SRC_DIR=$SOURCES/linux

if [[ ! -d $TOOLS/$TARGET/include/linux ]]; then
  (
    cd $SRC_DIR

    # Extract headers
    make mrproper                                             &&
    make ARCH=$ARCH headers_check                             &&
    make ARCH=$ARCH INSTALL_HDR_PATH=$TOOLS/$TARGET headers_install
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

    $SRC_DIR/configure                \
        --prefix=$TOOLS               \
        --target=$TARGET              \
        --with-sysroot=$TOOLS/$TARGET \
        --disable-werror              \
        --disable-nls                 \
        --disable-multilib            || exit 111

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

    $SRC_DIR/configure                        \
        --prefix=$TOOLS                       \
        --build=$HOST                         \
        --host=$HOST                          \
        --target=$TARGET                      \
        --with-sysroot=$TOOLS/$TARGET         \
        --disable-nls                         \
        --disable-shared                      \
        --without-headers                     \
        --with-newlib                         \
        --disable-decimal-float               \
        --disable-libgomp                     \
        --disable-libmudflap                  \
        --disable-libssp                      \
        --disable-libatomic                   \
        --disable-libquadmath                 \
        --disable-threads                     \
        --disable-multilib                    \
        --with-mpfr-include=$SRC_DIR/mpfr/src \
        --with-mpfr-lib=`pwd`/mpfr/src/.libs  \
        --with-arch=$CPU                      \
        --enable-languages=c,c++              || exit 121

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

    CC=$TARGET-gcc $SRC_DIR/configure \
        --prefix=/                    \
        --disable-static              \
        --target=$TARGET              || exit 131

    CC=$TARGET-gcc $MAKE || exit 132
  )
fi

# Install
#( cd $OBJ_DIR && DESTDIR=$TOOLS/$TARGET make install ) || exit 133
( cd $SRC_DIR && DESTDIR=$TOOLS/$TARGET make install ) || exit 133


#
# gcc final
#

SRC_DIR=$SOURCES/gcc
OBJ_DIR=$OBJECTS/gcc-final

# Configure & compile
if [[ ! -d $OBJ_DIR ]]; then
  mkdir -p $OBJ_DIR &&
  (
    cd $OBJ_DIR                               &&
    $SRC_DIR/configure                        \
        --prefix=$TOOLS                       \
        --build=$HOST                         \
        --host=$HOST                          \
        --target=$TARGET                      \
        --with-sysroot=$TOOLS/$TARGET         \
        --disable-nls                         \
        --enable-c99                          \
        --enable-long-long                    \
        --disable-libmudflap                  \
        --disable-multilib                    \
        --with-mpfr-include=$SRC_DIR/mpfr/src \
        --with-mpfr-lib=`pwd`/mpfr/src/.libs  \
        --with-arch=$CPU                      \
        --enable-languages=c,c++              &&
    $MAKE
  ) || exit 120
fi

# Install
( cd $OBJ_DIR && $MAKE install ) || exit 121


#
# Check basic functions (compiling and linking) works as expected
#

scripts/test || exit $?


echo -e "${GRN}Successfully built cross-toolchain pass 1${CLR}"
