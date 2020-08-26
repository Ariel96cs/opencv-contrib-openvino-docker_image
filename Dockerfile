ARG NEXUS_USER
ARG NEXUS_USER_PASSWORD

FROM openvino/ubuntu18_dev:2020.3


ENV nexus_user=$NEXUS_USER
ENV nexus_user_password=$NEXUS_USER_PASSWORD

USER root
RUN apt-get install apt-transport-https
RUN apt-get update && apt-get install -y --no-install-recommends git
# RUN apt-get -y install apt-utils
RUN apt-get -y install wget

# configure for libs downloading
RUN mkdir /home/.m2
ADD settings.xml /home/.m2/settings.xml
ADD nexus.sh /home/nexus.sh
RUN bash /home/nexus.sh


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

RUN bash mkdir /home/workspace

CMD ["/bin/bash"]
