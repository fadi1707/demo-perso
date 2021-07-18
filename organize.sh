#!/bin/bash

IMG_NAME=$1
WRKSPC="1"
CURRENT_DIR=`pwd`

echo $CURRENT_DIR | grep -o "@" 

if [ $? -eq 0 ]
then 
    WRKSPC=`echo $CURRENT_DIR | cut -d'@' -f2`
    CURRENT_DIR=`echo $CURRENT_DIR | cut -d'@' -f1`
    echo $CURRENT_DIR
fi

WRKSPC=$((WRKSPC+1))

NEW_DIR="${CURRENT_DIR}@${WRKSPC}"
echo $NEW_DIR
echo "cp $CURRENT_DIR/$IMG_NAME $NEW_DIR/deployment"
