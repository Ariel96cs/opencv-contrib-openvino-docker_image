# OpenCV 4.3.0 docker image with openCV-contrib and openVINO 2020.3.194

## Build image
1-) For downloading some usefull packages, create the following enviroment variables:
` NEXUS_USER="<user-name>"`,
` NEXUS_USER_PASSWORD="<user-password>"`.
#### IMPORTANT: The use of ARG is not save for credentials after the build phase, so, don't share the image built.

2-) Build the image:
` docker build --build-arg NEXUS_USER --build-arg NEXUS_USER_PASSWORD --tag opencv-openvino-dev .`

## Run container

`docker run -it -p 8080:8080 opencv-openvino-dev /bin/bash`

do not close the terminal or stop the process if you want to install opencv.

## Install dlib 

In the just running container prompt , run:

`sh /home/cvlib_dependencies.sh `

## Install additional dependencies for cvlib

In the just running container prompt , run:

`sh /home/cvlib_dependencies.sh `

## Download opencv_contrib

In the just running container prompt , run:

` sh /home/opencv_contrib.sh `

## Install OpenCV 4.3

In the just running container prompt , run:

`sh /home/opencv_install.sh `


## Commit changes to Docker image 

`docker commit -m "Installed openCV4.3" -p CONTAINER_ID opencv-openvino-dev`

Using another terminal, change the CONTAINER_ID for its real value in docker ps.



## Save image to tar 

` docker save opencv-openvino-dev:latest | gzip > myimage_latest.tar.gz` 



## For image loading

` docker load < myimage_latest.tar.gz` 



## For erase images

First, you have to remove all containers related with the image you want to delete.

Try:

 `docker ps`,

then try

` docker stop CONTAINER_ID` ,

or 

`docker rm CONTAINER_ID`

and finally:

`docker rmi IMAGE_NAME` 

or add -f flag to force image erase.