# First, you will need a suitable Linux cross-compilation host. 
# We tend to use Ubuntu; since Raspbian is also a Debian distribution, 
# it means many aspects are similar, such as the command lines.

# Install toolchain

# Use the following command to download the toolchain to the home folder:
git clone https://github.com/raspberrypi/tools ~/tools

# Updating the $PATH environment variable makes the system aware of 
# file locations needed for cross-compilation. On a 32-bit host system 
# you can update and reload it using:
# echo PATH=\$PATH:~/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin >> ~/.bashrc
# source ~/.bashrc

# If you are on a 64-bit host system, you should use:
echo PATH=\$PATH:~/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin >> ~/.bashrc
source ~/.bashrc

# Get sources
# To download the minimal source tree for the current branch, run:
git clone --depth=1 https://github.com/raspberrypi/linux

# Build sources
# To build the sources for cross-compilation, make sure you have the dependencies needed on your machine by executing:
sudo apt install git bison flex libssl-dev -y

# Enter the following commands to build the sources and Device Tree files:
#For Pi 1, Pi Zero, Pi Zero W, or Compute Module:
cd linux
KERNEL=kernel
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcmrpi_defconfig

# For Pi 2, Pi 3, Pi 3+, or Compute Module 3:
# cd linux
# KERNEL=kernel7
# make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig

# For Raspberry Pi 4:
# cd linux
# KERNEL=kernel7l
# make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2711_defconfig

# Then, for all:
# Note: To speed up compilation on multiprocessor systems, and get 
# some improvement on single processor ones, use -j n, where n is 
# the number of processors * 1.5. Alternatively, feel free to experiment and see what works!
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs -j 3