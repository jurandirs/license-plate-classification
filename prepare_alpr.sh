curl -o node-v9.7.1-linux-armv6l.tar.gz https://nodejs.org/dist/v9.7.1/node-v9.7.1-linux-armv6l.tar.gz
tar -xzf node-v9.7.1-linux-armv6l.tar.gz
sudo cp -r node-v9.7.1-linux-armv6l/* /usr/local/
node -v
npm -v
sudo npm install pi-camera
