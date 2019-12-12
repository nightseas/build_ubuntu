#!/bin/bash

######################################################
#                                                    #
#          Second Stage Building Scripts             #
#                                                    #
#   File   : chroot_build_stage2.sh                  #
#   Author : Xiaohai Li (haixiaolee@gmail.com)       #
#   Rev    : v0.1 2019-12-11                         #
#                                                    #
######################################################

# User name and hostname
USER=ubuntu
HOST=Ubuntu

# Hostname and network settings
echo $HOST > /etc/hostname
echo "127.0.0.1    localhost.localdomain localhost" > /etc/hosts
echo "127.0.0.1    $HOST" >> /etc/hosts

# Enable serial console login for Zynq
echo "ttyPS0" >> /etc/securetty
echo "ttyPS1" >> /etc/securetty

# Install packages
export DEBIAN_FRONTEND=noninteractive
apt update
apt upgrade -q -y --allow-change-held-packages --allow-downgrades --allow-remove-essential
apt install -q -y --allow-change-held-packages --allow-downgrades --allow-remove-essential \
            man tzdata iproute2 udev dialog sudo ifupdown bash-completion bsdmainutils
apt install -q -y --allow-change-held-packages --allow-downgrades --allow-remove-essential \
            htop ethtool net-tools network-manager pciutils usbutils iputils-ping openssh-server \
            nano apt-utils dosfstools i2c-tools initramfs-tools hdparm nethogs iperf3 fio sysstat \
            memtester openocd

# Config timezone and local
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

# Clean up downloaded packages
rm -rf /var/lib/apt/list/
apt autoclean

# Create user
adduser $USER
usermod -aG sudo  $USER
# enter user password
