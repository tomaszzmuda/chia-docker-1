echo START SETUP
echo SET PERMISSION
chmod +x *.sh
chmod +x farmer/*.sh
chmod +x plotter/*.sh

echo INSTALL DEPENDENCIES
apt install -y make zip unzip docker.io docker-compose cifs-utils

echo MOVE KEYFILE
cp keyfile farmer/keyfile
mv keyfile plotter/keyfile