# Install directly onto the SD card (see: https://www.raspberrypi.org/documentation/linux/kernel/building.md)
# Having built the kernel, you need to copy it onto your Raspberry Pi and install the modules; this is best done directly using an SD card reader.

# First, use lsblk before and after plugging in your SD card to identify it. You should end up with something like this:

# sdb
#    sdb1
#    sdb2
# with sdb1 being the FAT (boot) partition, and sdb2 being the ext4 filesystem (root) partition.

# If it's a NOOBS card, you should see something like this:

# sdb
#   sdb1
#   sdb2
#   sdb5
#   sdb6
#   sdb7
# with sdb6 being the FAT (boot) partition, and sdb7 being the ext4 filesystem (root) partition.

# Mount these first, adjusting the partition numbers for NOOBS cards (as necessary):

# mkdir mnt
# mkdir mnt/fat32
# mkdir mnt/ext4
# sudo mount /dev/sdb6 mnt/fat32
# sudo mount /dev/sdb7 mnt/ext4

# Next, install the modules:

# sudo env PATH=$PATH make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=mnt/ext4 modules_install
# Finally, copy the kernel and Device Tree blobs onto the SD card, making sure to back up your old kernel:

# sudo cp mnt/fat32/$KERNEL.img mnt/fat32/$KERNEL-backup.img
# sudo cp arch/arm/boot/zImage mnt/fat32/$KERNEL.img
# sudo cp arch/arm/boot/dts/*.dtb mnt/fat32/
# sudo cp arch/arm/boot/dts/overlays/*.dtb* mnt/fat32/overlays/
# sudo cp arch/arm/boot/dts/overlays/README mnt/fat32/overlays/
# sudo umount mnt/fat32
# sudo umount mnt/ext4
# Another option is to copy the kernel into the same place, but with a different filename - for instance, kernel-myconfig.img - rather than overwriting the kernel.img file. You can then edit the config.txt file to select the kernel that the Pi will boot into:

# kernel=kernel-myconfig.img
# This has the advantage of keeping your kernel separate from the kernel image managed by the system and any automatic update tools, and allowing you to easily revert to a stock kernel in the event that your kernel cannot boot.

# Finally, plug the card into the Pi and boot it!