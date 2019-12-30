#!/bin/bash

######################################################
#                                                    #
#         Ubuntu Rootfs Packaging Scripts            #
#                                                    #
#   File   : pack_rootfs.sh                          #
#   Author : Xiaohai Li (haixiaolee@gmail.com)       #
#   Rev    : v0.1 2019-12-11                         #
#                                                    #
######################################################

BUILD_STAMP=$(date '+%Y%m%d_%H%M')

# Workspace of Auto-build environment
SCRIPT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
ROOT_DIR=$SCRIPT_DIR/..

# Source base image and workspace destination
WORKSPACE_DIR=$ROOT_DIR/temp/ubuntu18.04.3
DEST_PACK=$ROOT_DIR/output/rootfs_ubuntu_bionic_amd64_$BUILD_STAMP.tar.gz

# Check root
if [ "$EUID" -ne 0 ]
  then echo "Must run as root!"
  exit
fi

cd $WORKSPACE_DIR && tar czpf $DEST_PACK ./
