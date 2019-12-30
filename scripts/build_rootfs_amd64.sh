#!/bin/bash

######################################################
#                                                    #
#         Ubuntu Rootfs Building Scripts             #
#                                                    #
#   File   : build_rootfs_amd64.sh                   #
#   Author : Xiaohai Li (haixiaolee@gmail.com)       #
#   Rev    : v0.1 2019-12-30                         #
#                                                    #
######################################################

BUILD_STAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Workspace of Auto-build environment
SCRIPT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
ROOT_DIR=$SCRIPT_DIR/..

# Source base image and workspace destination
SRC_IMG=$ROOT_DIR/src/ubuntu-base-18.04.3-base-amd64.tar.gz
SRC_KMOD=$ROOT_DIR/deploy/lib
SRC_OVL=$ROOT_DIR/overlay
DEST_DIR=$ROOT_DIR/temp/ubuntu18.04.3

# Check root
if [ "$EUID" -ne 0 ]
  then echo "Must run as root!"
  exit
fi

# Umount host folders incase the script was not finished last time
umount $DEST_DIR/dev $DEST_DIR/proc

# Clear and create new workspace
rm -rf $DEST_DIR
mkdir $DEST_DIR

# Extract base image
tar -xzpf $SRC_IMG -C $DEST_DIR
cp -a /usr/bin/qemu-x86_64-static $DEST_DIR/usr/bin/
cp -a $SCRIPT_DIR/chroot_build_stage2.sh $DEST_DIR/

# Add overlay for DNS and apt source
cp -aL /etc/resolv.conf $DEST_DIR/etc/
#cp -a $SRC_OVL/sources.list $DEST_DIR/etc/apt/

# Bind host dev and proc folder to workspace
mount -o bind /dev $DEST_DIR/dev
mount -o bind /proc $DEST_DIR/proc

# Change root to workspace directory and start the 2nd stage scripts
chroot $DEST_DIR ./chroot_build_stage2.sh

# Unbind dev and proc
umount $DEST_DIR/dev $DEST_DIR/proc

# Remove qemu and 2nd stage scripts
rm $DEST_DIR/usr/bin/qemu-x86_64-static
rm $DEST_DIR/chroot_build_stage2.sh

# Copy kernel modules to rootfs
cp -Rp $SRC_KMOD/* $DEST_DIR/lib/

# Add overlay to rootfs
cp $SRC_OVL/timesyncd.conf $DEST_DIR/etc/systemd/
cp $SRC_OVL/10-help-text-snr $DEST_DIR/etc/update-motd.d/10-help-text
#cp $SRC_OVL/LAN $DEST_DIR/etc/NetworkManager/system-connections/
touch $DEST_DIR/etc/NetworkManager/conf.d/10-globally-managed-devices.conf

echo "printf \" * Build Stamp:  $BUILD_STAMP\\n\"" >> $DEST_DIR/etc/update-motd.d/10-help-text

# Create rootfs archive
$SCRIPT_DIR/pack_rootfs.sh
