# The Linux kernel is highly configurable; advanced users may wish 
# to modify the default configuration to customise it to their needs, 
# such as enabling a new or experimental network protocol, or enabling 
# support for new hardware.

# Configuration is most commonly done through the make menuconfig interface. 
# Alternatively, you can modify your .config file manually, but this can be 
# more difficult for new users.

# Preparing to configure the kernel
# The menuconfig tool requires the ncurses development headers to compile properly. 
# These can be installed with the following command:
sudo apt install libncurses5-dev

# For all models of Raspberry Pi 1 (includes Compute Module and Pi Zero):
KERNEL=kernel
# make bcmrpi_defconfig

# If you're cross-compiling, the second line should be:
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcmrpi_defconfig

# For all models of Raspberry Pi 2/3 (includes 3B+, 3A+ and Compute Module 3):
# $ KERNEL=kernel7
# $ make bcm2709_defconfig

# If you're cross-compiling, the second line should be:
# make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig

# Using menuconfig
# Once you've got everything set up and ready to go, you can compile and run the 
# menuconfig utility as follows:
# make menuconfig

# If you're cross-compiling,:
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- menuconfig