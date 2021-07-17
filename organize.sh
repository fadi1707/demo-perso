#!/bin/sh

IMG_NAME=$1

CURRENT_DIR=`pwd`
NEW_DIR="${CURRENT_DIR}@2"

cp $IMG_NAME $NEW_DIR/deployment
