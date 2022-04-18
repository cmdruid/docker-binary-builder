#!/bin/sh
## Build script template. See accompanying Dockerfile for more build options.

###############################################################################
# Environment
###############################################################################

PATH_NAME=`dirname $1`
BASE_NAME=`basename $1`
EXT_NAME="${BASE_NAME##*.}"
BUILD_DIR="$(dirname "$(realpath "$0")")"

###############################################################################
# Methods
###############################################################################

usage() {
  printf "
  Compile a binary using the provided docekrfile, and save to /out directory.
  
  Usage: $0 dockerfile.example (or files/dockerfile.example)
  
  The extention of the dockerfile is passed to the build environment as BIN_NAME.
  (e.x. dockerfile.sample will be passed as BIN_NAME='sample')
  \n"
}

###############################################################################
# Script
###############################################################################

set -e

## Check input argument.
if [ -z "$1" ] ; then
  echo "Error: You must specify a Dockerfile to use!" && usage && exit 1
elif [ "$1" = "--help" ]; then
  usage && exit 0
elif [ ! -e "$1" ]; then
  echo "Error: $1 does not exist! Are you providing the right path?" && usage && exit 1
else
  echo "Starting builder using $BASE_NAME ... "
fi

## If out/ path does not exist, create it.
if [ ! -d "$BUILD_DIR/out" ]; then
  mkdir "$BUILD_DIR/out"
fi

## If previous docker image exists, remove it.
if [ ! -z "$(docker image ls | grep $BASE_NAME)" ]; then
  docker image rm $BASE_NAME
fi

## Begin building image.
DOCKER_BUILDKIT=1 docker build \
  --tag $BASE_NAME \
  --build-arg BIN_NAME=$EXT_NAME \
  --output type=local,dest=$BUILD_DIR/out \
  --file $PATH_NAME/$BASE_NAME \
$2 $BUILD_DIR
