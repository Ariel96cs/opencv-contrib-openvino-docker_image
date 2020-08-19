#!/usr/bin/env bash

# Para instalar dlib

apt-get update
apt install wget
apt install build-essential cmake
apt install libopenblas-dev liblapack-dev 
apt install libx11-dev libgtk-3-dev
apt install python python-dev python-pip
apt install python3 python3-dev python3-pip

wget http://dlib.net/files/dlib-19.20.tar.bz2
tar xvf dlib-19.20.tar.bz2
cd dlib-19.20/
mkdir build
cd build
cmake ..
cmake --build . --config Release
make install
ldconfig
python setup.py install
python3 setup.py install
cd ..
rm dlib-19.20.tar.bz2*
