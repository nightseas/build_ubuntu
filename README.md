# Ubuntu RootFS Auto-build Scripts

This is just a simple implementation of auto-building Ubuntu root file system for 32-bit ARM processors, e.g. Xilinx Zynq7000.

 - Host OS requirement: Ubuntu 16.04 or 18.04
 - RootFS baseline: ubuntu-base-18.04.3-base-armhf

### How-tos

1. If there're any kernel modules compiled, they must be manually copied to the deploy folder.
```sh
make modules_install INSTALL_MOD_PATH=<path_of_deploy_folder>
```

2. Clone this repo and run the build.sh script to build the RootFS package. A gzip archive named rootfs_ubuntu_bionic_armhf_YYYYmmdd_HHMM.tar.gz will be generated in output folder if the building process has been succeeded.
```sh
git clone https://github.com/nightseas/build_ubuntu_armhf
cd build_ubuntu_armhf
./build.sh
```
3. Extract the package to RootFS partition, which is usually the 2nd partition of a SD card, eMMC, or USB disk. Replace sdX with the partition name of your device.
```sh
sudo mount /dev/sdX /mnt
sudo tar xzpf rootfs_ubuntu_bionic_armhf_YYYYmmdd_HHMM.tar.gz -C /mnt
```

### TBD

 - Add scripts to build cpio or ramdisk RootFS.
