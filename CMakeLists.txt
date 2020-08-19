cmake_minimum_required (VERSION 3.5)
project(cvlib LANGUAGES CXX)

set (cvlib_VERSION_MAJOR 1)
set (cvlib_VERSION_MINOR 1)
set (cvlib_VERSION_REVISION 30)


# Cmake

    get_filename_component(MODULES_DIR "cmake" ABSOLUTE)
    set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${MODULES_DIR})

# Configuration

    # configure a header file to pass some of the CMake settings to the source code
    configure_file (
            "${PROJECT_SOURCE_DIR}/include/cvlib_version.h.in"
            "${PROJECT_SOURCE_DIR}/include/cvlib_version.hpp"
    )


#La siguiente instruccion es una buena optimizacion, pero no se puede utilizar con la libreria openface.
#Si en un futuro, dejamos de utilizar openface, recomiendo activar este flag, pq algunos algoritmos ganan en velocidad
#set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -mavx")

set (DEV False)
    set (SUFFIX_PACKAGE_NAME "")
    set (COMPONENT_TYPE "runtime")

    IF( ${DEV} )
        MESSAGE( "DEV true" )
        set (SUFFIX_PACKAGE_NAME "-dev")
        set (COMPONENT_TYPE "development")
    ELSE (${DEV} )
        MESSAGE( "DEV false" )
    ENDIF(${DEV} )



    # Dependencies

    include_directories("/usr/include/fdeep")
    include_directories("/usr/include/fplus")
    include_directories("/usr/include/eigen3")

    find_package(InferenceEngine REQUIRED)
    include_directories(${InferenceEngine_INCLUDE_DIRS})
            
    find_package(OpenCV 4.3.0 REQUIRED)
    include_directories(${OpenCV_INCLUDE_DIRS})
    if(OPENCV_XFEATURES2D_FOUND)
        message("xfeatures2d found")
    endif()
    set(DEPENDENCIES ${DEPENDENCIES} ${InferenceEngine_LIBRARIES} ${OpenCV_LIBS})
    #message("OPENCV DIRS:  ${OpenCV_INCLUDE_DIRS}")
    #message("OPENCV LIBS:  ${OpenCV_LIBS}")
    

    #find_package(OpenCV 2.4.9 REQUIRED)
    #include_directories(${OpenCV_INCLUDE_DIRS})
    #set(DEPENDENCIES ${DEPENDENCIES} ${OpenCV_LIBS})

    #find_package(OpenCVNonFree 2.4.9 REQUIRED)
    #include_directories(${OpenCVNonFree_INCLUDE_DIRS})
    #set(DEPENDENCIES ${DEPENDENCIES} ${OpenCVNonFree_LIBRARIES})

    find_package(DLib 19.20.99 REQUIRED)
    include_directories(${DLib_INCLUDE_DIR})
    MESSAGE("DLib INCLUDES: ${DLib_INCLUDE_DIR}")
    MESSAGE("DLib LIB: ${DLib_LIBRARY}")
    set(DEPENDENCIES ${DEPENDENCIES} ${DLib_LIBRARY})

    find_package(OpenBLAS REQUIRED)
    set(DEPENDENCIES ${DEPENDENCIES} ${OpenBLAS_LIBRARIES})
    
    find_package( Tesseract 4.0.0 REQUIRED )
    include_directories(${Tesseract_INCLUDE_DIRS})
    set(DEPENDENCIES ${DEPENDENCIES} ${Tesseract_LIBRARIES})

    #find_package(OpenFace 2.0.4 REQUIRED)
    #include_directories(${OpenFace_INCLUDE_DIRS})
    #MESSAGE("OpenFace_LIBRARIES=${OpenFace_LIBRARIES}")
    #set(DEPENDENCIES ${DEPENDENCIES} ${OpenFace_LIBRARIES})

    find_package( Boost 1.58 REQUIRED COMPONENTS filesystem system)

    include_directories(${Boost_INCLUDE_DIRS})
    include_directories(${Boost_INCLUDE_DIRS}/boost)
    MESSAGE("Boost_LIBRARIES: ${Boost_LIBRARIES}")
    set(DEPENDENCIES ${DEPENDENCIES} ${Boost_LIBRARIES})

    find_package(TBB 4.4 REQUIRED)
    set(DEPENDENCIES ${DEPENDENCIES} /opt/intel/openvino_2020.3.194/deployment_tools/inference_engine/external/tbb/lib/libtbb.so.2)
    message("TBB DIRS:  ${TBB_INCLUDE_DIRS}")
    message("TBB LIBS:  ${TBB_LIBS}")
    message("DEPENDENCIES:  ${DEPENDENCIES}")
#GPU support
    #set(DEPENDENCIES ${DEPENDENCIES} /usr/local/cuda-8.0/lib64/libcudnn.so)

# Build

    set(CMAKE_CXX_STANDARD 14)
    #set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++17")

    file(GLOB SOURCE_FILES
            src/*.cpp
            src/face/*.cpp
            src/ocr/*.cpp
            src/signature_detector/*.cpp
            src/bw_detector/*.cpp
            src/hologram/*.cpp)
    file(GLOB HEADER_FILES include/*.h include/*.hpp
            include/face/*.hpp
            include/ocr/*.hpp
            include/signature_detector/*.hpp
            include/bw_detector/*.hpp
            include/hologram/*.hpp
            cvlib_version.h.in)
    add_library(${PROJECT_NAME} SHARED ${SOURCE_FILES} ${HEADER_FILES} samples/common/util.cpp samples/common/util.hpp)

#Shared and Static Libs
    ADD_DEFINITIONS(-fPIC)
    SET_TARGET_PROPERTIES(${PROJECT_NAME} PROPERTIES COMPILE_FLAGS "-fPIC")

    #add_executable(${PROJECT_NAME} demo/main.cpp ${SOURCE_FILES} ${HEADERS_FILES})

    target_link_libraries(${PROJECT_NAME} ${DEPENDENCIES})
    target_include_directories(${PROJECT_NAME} PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
        PRIVATE src)

# Install

    include(GNUInstallDirs)
    set(PROJECT_CONFIG "${PROJECT_NAME}Config")

    # 'make install' to the correct locations (provided by GNUInstallDirs).
    install(TARGETS ${PROJECT_NAME} EXPORT ${PROJECT_CONFIG}
        ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR} # This is for Windows
        COMPONENT ${COMPONENT_TYPE})


    install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})
    install(EXPORT ${PROJECT_CONFIG} DESTINATION lib/cmake/cvlib/)
    export(TARGETS ${PROJECT_NAME} FILE "${PROJECT_CONFIG}.cmake")

# Package

    include (InstallRequiredSystemLibraries)
    set (CPACK_GENERATOR DEB)
    set (CPACK_PACKAGE_VERSION ${cvlib_VERSION_MAJOR}.${cvlib_VERSION_MINOR}.${cvlib_VERSION_REVISION}${SUFFIX_PACKAGE_NAME})
    set (CPACK_DEBIAN_PACKAGE_MAINTAINER "eID <support@electronicid.eu>")

#Dependencias
    set(CPACK_DEBIAN_PACKAGE_DEPENDS
             "libopencv-dev,
            libopenblas-dev (= 0.2.18-1ubuntu1),
		    libboost-all-dev (>> 1.58),
		    libtbb-dev (>> 4.3), libtbb-dev (<< 4.5),
            libpng (>= 1.5.12),
            dlib (= 19.20.99),
            leptonica (>= 1.74.4),
            tesseract (= 4.0.0-beta.1)")

    include (CPack)

# Temporal patch // TODO: Convert to CTests and http://gamesfromwithin.com/exploring-the-c-unit-testing-framework-jungle
    add_subdirectory(test)
    add_subdirectory(samples)