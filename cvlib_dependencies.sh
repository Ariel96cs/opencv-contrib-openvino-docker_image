#!/usr/bin/env bash
apt-get -y install nano
apt-get -y install libopencv-dev=2.4.9.1+dfsg-1.5ubuntu1.1
apt-get -y install libopencv-nonfree-dev=2.4.9.1+dfsg-1.5ubuntu1.1
apt-get -y install libopenblas-dev=0.2.18-1ubuntu1
apt-get -y install autoconf
apt-get -y install autoconf-archive
apt-get -y install libtool
apt-get -y install autogen
apt-get -y install pkg-config
apt-get -y install libboost-all-dev
apt-get -y install libtbb-dev
apt-get -y install dlib=19.20.99
apt-get -y install leptonica=1.74.4
apt-get -y install tesseract=4.0.0-beta.1

apt-get -y install libpng=1.5.12
apt-get -y install openface=2.0.4

# Para usar modelos entrenados en Keras
apt-get -y install eigen3=3.3.30
apt-get -y install frugally-deep=0.8.0
apt-get -y install functionalplus=0.2.3
apt-get -y install nlohmann_json=3.1.2

# Para instalar dlib

apt-get -y update
apt-get -y install build-essential cmake
apt-get -y install libopenblas-dev liblapack-dev 
apt-get -y install libx11-dev libgtk-3-dev
apt-get -y install python python-dev python-pip
apt-get -y install python3 python3-dev python3-pip

wget http://dlib.net/files/dlib-19.20.tar.bz2
tar xvf dlib-19.20.tar.bz2
cd dlib-19.20/
mkdir build
cd build
cmake ..
cmake --build . --config Release
make install
ldconfig
cd ..