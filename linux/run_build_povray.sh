#!/bin/bash
set -eux

BASEDIR=$1
TMPDIR=$BASEDIR/tmp

mkdir -p $TMPDIR
cd $TMPDIR

# get source
wget --progress=dot:mega -c --content-disposition \
     https://github.com/POV-Ray/povray/archive/refs/tags/v3.7.0.10.tar.gz

tar xzf povray-3.7.0.10.tar.gz
cd povray-3.7.0.10

cd unix/
./prebuild.sh
cd ../

instpath=$BASEDIR/povray_bundle

./configure \
    NON_REDISTRIBUTABLE_BUILD=yes \
    COMPILED_BY="your name <email@address>" \
    --prefix=$instpath \
    --with-boost=$BASEDIR/povray_bundle/boost_1_76_static \
    --with-libpng=$BASEDIR/povray_bundle/libpng12/lib \
    --without-x \
    --without-openexr \
    --without-libmkl \
    --without-libsdl \
    --without-libjpeg \
    --without-libtiff

make -j 8
make install

# cd ..
# rm -rf povray-3.7.0.10
