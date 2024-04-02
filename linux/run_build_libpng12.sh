#!/bin/bash
set -eux

BASEDIR=$1
TMPDIR=$BASEDIR/tmp

mkdir -p $TMPDIR
cd $TMPDIR

# get source
wget --content-disposition -c https://sourceforge.net/projects/libpng/files/libpng12/1.2.59/libpng-1.2.59.tar.xz

tar Jxf libpng-1.2.59.tar.xz
cd libpng-1.2.59

##########

./configure \
    --prefix=$BASEDIR/povray_bundle/libpng12 \
    --disable-shared

##########

make -j 8
make install
cd ..
# rm -rf libpng-1.2.59
