#!/usr/bin/env bash

#NUM_JOBS=$((`nproc` + 1))
#
#CPU=ia32
#TARGET=i686-nodeos-linux
#
#SOURCES=`pwd`/sources
#OBJECTS=`pwd`/obj/$CPU
##TOOLS=`pwd`/tools
#TOOLS=/tools
#
#MAKE="make --jobs=$NUM_JOBS"

#
# libstdc++
#

SRC_DIR=$SOURCES/gcc
OBJ_DIR=$OBJECTS/libstdc++

# Configure & compile
if [[ ! -d $OBJ_DIR ]]; then
  mkdir -p $OBJ_DIR &&
  (
    cd $OBJ_DIR                                                 &&
    $SRC_DIR/libstdc++-v3/configure                             \
        --host=$TARGET                                          \
        --prefix=$TOOLS                                         \
        --disable-multilib                                      \
        --disable-shared                                        \
        --disable-nls                                           \
        --disable-libstdcxx-threads                             \
        --disable-libstdcxx-pch                                 \
        --with-gxx-include-dir=/tools/$TARGET/include/c++/4.9.1 &&
    $MAKE
  ) || exit 200
fi

# Install
( cd $OBJ_DIR && $MAKE install ) || exit 201


#
# binutils
#

SRC_DIR=$SOURCES/binutils
OBJ_DIR=$OBJECTS/binutils-pass2

# Configure & compile
if [[ ! -d $OBJ_DIR ]]; then
  mkdir -p $OBJ_DIR &&
  (
    cd $OBJ_DIR                    &&
    CC=$TARGET-gcc                 \
    AR=$TARGET-ar                  \
    RANLIB=$TARGET-ranlib          \
    $SRC_DIR/configure             \
        --host=$TARGET             \
        --prefix=$TOOLS            \
        --disable-nls              \
        --disable-werror           \
        --with-lib-path=$TOOLS/lib \
        --with-sysroot             &&
    $MAKE
  ) || exit 210
fi

# Install
( cd $OBJ_DIR && $MAKE install ) || exit 211

(
  cd $OBJ_DIR                        &&
  $MAKE -C ld clean                  &&
  $MAKE -C ld LIB_PATH=/usr/lib:/lib &&
  cp -v ld/ld-new $TOOLS/bin
) || exit 212


#
# gcc
#

SRC_DIR=$SOURCES/gcc
OBJ_DIR=$OBJECTS/gcc-pass2

# Configure & compile
if [[ ! -d $OBJ_DIR ]]; then
  (
    cd $SRC_DIR
    cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
      `dirname $($TARGET-gcc -print-libgcc-file-name)`/include-fixed/limits.h
  ) || exit 220

  mkdir -p $OBJ_DIR &&
  (
    cd $OBJ_DIR                                        &&
    CC=$TARGET-gcc                                     \
    CXX=$TARGET-g++                                    \
    AR=$TARGET-ar                                      \
    RANLIB=$TARGET-ranlib                              \
    $SRC_DIR/configure                                 \
        --prefix=$TOOLS                                \
        --with-local-prefix=$TOOLS                     \
        --with-native-system-header-dir=$TOOLS/include \
        --enable-languages=c,c++                       \
        --disable-libstdcxx-pch                        \
        --disable-multilib                             \
        --disable-bootstrap                            \
        --disable-libgomp                              &&
    $MAKE
  ) || exit 221
fi

# Install
( cd $OBJ_DIR && $MAKE install ) &&
ln -sv gcc $TOOLS/bin/cc         || exit 222


#
# Check basic functions (compiling and linking) works as expected
#

echo 'main(){}' > dummy.c          || exit 230
cc dummy.c                         || exit 231
readelf -l a.out | grep ': '$TOOLS || exit 232
rm -v dummy.c a.out                || exit 233


echo -e "${GRN}Successfully built cross-toolchain pass 2${CLR}"
