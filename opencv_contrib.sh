#!/bin/bash
cvVersion="master"
cd /home
cwd=$(pwd)

git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout $cvVersion
