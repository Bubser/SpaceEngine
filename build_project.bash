#!/usr/bin/env bash


# Launch the script in SpaceEngine directory  
PROJECT_DIR=`pwd`; 
echo "Build from $PROJECT_DIR"

# define build dir 
BUILD_DIR="$PROJECT_DIR/build"
# create if it  doesn't exist
if [ ! -d "$BUILD_DIR" ]
then 
    mkdir $BUILD_DIR
fi 

# Go to build directory 
cd "$BUILD_DIR"

# create build files 
cmake ..


# on Linux build with Cmake , for windows open the vcxproj file 
make 

# Go back to project dir 
cd "$PROJECT_DIR"