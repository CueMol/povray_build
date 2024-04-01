#!/bin/sh
set -eux

BASEDIR=$1
TMPDIR=$BASEDIR/tmp

mkdir -p $TMPDIR
cd $TMPDIR

# get source
wget https://boostorg.jfrog.io/artifactory/main/release/1.76.0/source/boost_1_76_0.tar.bz2
# cp $HOME/src/boost_1_76_0.tar.bz2 .

tar xzf boost_1_76_0.tar.bz2
cd boost_1_76_0
bash bootstrap.sh

#####

instpath=$BASEDIR/povray_bundle/boost_1_76_static

./b2 \
 --prefix=$instpath \
 --with-date_time \
 --with-filesystem \
 --with-iostreams \
 --with-system \
 --with-thread \
 --with-chrono \
 --with-timer \
 -d0 \
link=static threading=multi install

#####

cd ..
# rm -rf boost_1_76_0
