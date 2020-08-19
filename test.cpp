#include <opencv2/opencv.hpp>
#include <iostream>

using namespace cv;
using namespace std;

int main(int argc, char** argv){
    Mat image = imread("/home/ariel/uh/opencv_tutorial/pca.png");

    if(image.empty()){
        cout << "Could not open or find the image"<< endl;
        cin.get();//wait for any key press
        return -1;
    }

    String windowName = "The image";
    namedWindow(windowName); // create a window
    imshow(windowName,image); // show image inside the create window
    waitKey(0);
    destroyWindow(windowName);
    return 0;
}
