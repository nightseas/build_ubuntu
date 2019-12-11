#!/bin/bash

######################################################
#                                                    #
#        Zynq Linux Image Auto-build Scripts         #
#                                                    #
#   File   : build.sh                                #
#   Author : Xiaohai Li (haixiaolee@gmail.com)       #
#   Rev    : v0.1 2019-12-09                         #
#                                                    #
######################################################

# Workspace of Auto-build environment
ROOT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

# Step 1: install denpendencies, only works on Debian/Ubuntu
sudo $ROOT_DIR/scripts/install_deps.sh

# Step 2: fetch sources, e.g. Ubuntu base RootFS
$ROOT_DIR/scripts/fetch_src.sh

# Step 3: excute building scripts
sudo $ROOT_DIR/scripts/build_rootfs_armhf.sh
