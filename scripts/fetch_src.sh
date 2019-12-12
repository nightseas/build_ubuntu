#!/bin/bash

######################################################
#                                                    #
#           Source Fetching Scripts                  #
#                                                    #
#   File   : fetch_src.sh                            #
#   Author : Xiaohai Li (haixiaolee@gmail.com)       #
#   Rev    : v0.1 2019-12-11                         #
#                                                    #
######################################################

# Workspace of Auto-build environment
SCRIPT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
ROOT_DIR=$SCRIPT_DIR/..

# Fetch Ubuntu base root file system
cd $ROOT_DIR/src && wget -c http://cdimage.ubuntu.com/ubuntu-base/releases/18.04/release/ubuntu-base-18.04.3-base-armhf.tar.gz

