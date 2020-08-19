FROM openvino/ubuntu18_dev:2020.3

USER root
RUN apt-get update && apt-get install -y --no-install-recommends git
RUN apt-get -y install wget

# opencv-contrib
ADD opencv_contrib.sh /home/opencv_contrib.sh
RUN bash /home/opencv_contrib.sh

# opencv
ADD opencv_prepare.sh /home/opencv_prepare.sh
RUN bash /home/opencv_prepare.sh
ADD opencv_install.sh /home/opencv_install.sh

#cvlib dependencies
ADD cvlib_dependencies.sh /home/cvlib_dependencies.sh
RUN bash /home/cvlib_dependencies.sh

ADD README.md /home/README.md

CMD ["/bin/bash"]