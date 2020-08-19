
#!/bin/bash

cd /home/opencv/build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D INSTALL_C_EXAMPLES=OFF \
        -D INSTALL_PYTHON_EXAMPLES=OFF \
        -D OPENCV_EXTRA_MODULES_PATH=/home/opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON \
        -D OPENCV_ENABLE_NONFREE=ON \
        -D WITH_INF_ENGINE=ON \
        -D ENABLE_CXX11=ON \
        -D CMAKE_FIND_ROOT_PATH="/opt/intel/openvino_2020.3.194/deployment_tools" \
        -D -DINF_ENGINE_INCLUDE_DIRS="/opt/intel/openvino_2020.3.194/deployment_tools/inference_engine/include" -D INF_ENGINE_LIB_DIRS="/opt/intel/openvino_2020.3.194/deployment_tools/inference_engine/lib/intel64" \
        -D WITH_TBB=ON \
        -D WITH_OPENGL=ON \
        -D INF_ENGINE_RELEASE=2020030000 ..

make -j4
make install
ldconfig
