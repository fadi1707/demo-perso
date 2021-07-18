#!/bin/sh

IMG_NAME=$1
echo $IMG_NAME
CURRENT_DIR=`pwd`
NEW_DIR="${CURRENT_DIR}@2"

cp $IMG_NAME $NEW_DIR/deployment
