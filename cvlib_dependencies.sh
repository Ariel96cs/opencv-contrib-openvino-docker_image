#!/usr/bin/env bash
apt install nano
apt install libopencv-dev=2.4.9.1+dfsg-1.5ubuntu1.1
apt install libopencv-nonfree-dev=2.4.9.1+dfsg-1.5ubuntu1.1
apt install libopenblas-dev=0.2.18-1ubuntu1
apt install autoconf
apt install autoconf-archive
apt install libtool
apt install autogen
apt install pkg-config
apt install libboost-all-dev
apt install libtbb-dev
apt install dlib=19.20.99
apt install leptonica=1.74.4
apt install tesseract=4.0.0-beta.1

apt install libpng=1.5.12
apt install openface=2.0.4

# Para usar modelos entrenados en Keras
apt install eigen3=3.3.30
apt install frugally-deep=0.8.0
apt install functionalplus=0.2.3
apt install nlohmann_json=3.1.2

# Para instalar dlib

apt-get update
apt-get install build-essential cmake
apt-get install libopenblas-dev liblapack-dev 
apt-get install libx11-dev libgtk-3-dev
apt-get install python python-dev python-pip
apt-get install python3 python3-dev python3-pip

wget http://dlib.net/files/dlib-19.20.tar.bz2
tar xvf dlib-19.20.tar.bz2
cd dlib-19.20/
mkdir build
cd build
cmake ..
cmake --build . --config Release
sudo make install
sudo ldconfig
cd ..