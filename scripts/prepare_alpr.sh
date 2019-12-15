curl -o node-v9.7.1-linux-armv6l.tar.gz https://nodejs.org/dist/v9.7.1/node-v9.7.1-linux-armv6l.tar.gz
tar -xzf node-v9.7.1-linux-armv6l.tar.gz
sudo cp -r node-v9.7.1-linux-armv6l/* /usr/local/
node -v
npm -v
npm init
sudo npm install pi-camera

# https://raspberrypi.stackexchange.com/questions/13764/what-causes-enospc-error-when-using-the-raspberry-pi-camera-module
cp /boot/cmdline.txt /boot/cmdline.txt~
echo "dwc_otg.lpm_enable=0 console=ttyAMA0,115200 kgdboc=ttyAMA0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline rootwait bcm2708.w1_gpio_pin=18" > /boot/cmdline.txt

