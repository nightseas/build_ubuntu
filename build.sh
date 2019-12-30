#!/bin/bash

######################################################
#                                                    #
#        Atom Linux Image Auto-build Scripts         #
#                                                    #
#   File   : build.sh                                #
#   Author : Xiaohai Li (haixiaolee@gmail.com)       #
#   Rev    : v0.2 2019-12-30                         #
#                                                    #
######################################################

# Workspace of Auto-build environment
ROOT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
DIRS="src output temp deploy deploy/lib"

# Step 0: create folder structures if not exist
for FOLDER in $DIRS
do
    if [ ! -d "$ROOT_DIR/$FOLDER" ]; then
        echo "Folder '$ROOT_DIR/$FOLDER' does not exist, creating one..."
        mkdir $ROOT_DIR/$FOLDER
    fi
done

# Step 1: install denpendencies, only works on Debian/Ubuntu
sudo $ROOT_DIR/scripts/install_deps.sh

# Step 2: fetch sources, e.g. Ubuntu base RootFS
$ROOT_DIR/scripts/fetch_src.sh

# Step 3: excute building scripts
sudo $ROOT_DIR/scripts/build_rootfs_amd64.sh
