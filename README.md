# OpenCV 4.3.0 docker image with openCV-contrib and openVINO 2020.3.194

## Build image

` docker build --tag opencv-openvino-dev .`

## Run container

`docker run -it -p 8080:8080 opencv-openvino-dev /bin/bash`

do not close the terminal or stop the process if you want to install opencv.

## Install OpenCV 4.3

In the just running container prompt , run:

` ./home/opencv_install.sh `

## Commit changes to Docker image 

`docker commit -m "Installed openCV4.3" -p CONTAINER_ID opencv-openvino-dev`

Change the CONTAINER_ID for its real value in docker ps.



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