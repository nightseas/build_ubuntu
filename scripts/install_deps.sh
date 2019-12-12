#!/bin/bash

######################################################
#                                                    #
#           Package Installing Scripts               #
#                                                    #
#   File   : install_packages.sh                     #
#   Author : Xiaohai Li (haixiaolee@gmail.com)       #
#   Rev    : v0.1 2019-12-11                         #
#                                                    #
######################################################

# Workspace of Auto-build environment
HOST_DEPS="binfmt-support qemu-user-static u-boot-tools cpio"

# Check root
if [ "$EUID" -ne 0 ]
  then echo "Must run as root!"
  exit
fi

apt -q update
apt -y upgrade
apt -q -y --no-install-recommends install $HOST_DEPS
