FROM openvino/ubuntu18_dev:2020.3

USER root
RUN apt-get update && apt-get install -y --no-install-recommends git

# opencv-contrib
ADD opencv_contrib.sh /home/opencv_contrib.sh
RUN bash /home/opencv_contrib.sh

# opencv
ADD opencv_prepare.sh /home/opencv_prepare.sh
RUN bash /home/opencv_prepare.sh

ADD opencv_install.sh /home/opencv_install.sh

ADD README.md /home/README.md

CMD ["/bin/bash"]