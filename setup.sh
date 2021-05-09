if [[ -z ${ID} || -z ${PA} ]]; then
    echo "Farm Instance ID (ID) and Plotter Amount (PA) are required. \n export FID=1 && export PA=2"
    exit
else
    echo 🌱  🌱  🌱  🌱  START SETUP  🌱  🌱  🌱  🌱 

    echo 🌱 SET PERMISSION
    chmod +x *.sh
    chmod +x farmer/*.sh
    chmod +x plotter/*.sh

    echo 🌱 INSTALL DEPENDENCIES
    apt install -y make zip unzip docker.io docker-compose cifs-utils

    echo 🌱 MOVE KEYFILE
    cp keyfile farmer/keyfile
    mv keyfile plotter/keyfile

    echo 🌱 MOUNT SCRATCH /tmp - /mnt/scratch/plotter#
    mkdir /mnt/scratch
    chmod +x /mnt/scratch
    mount -o discard,defaults /dev/disk/by-id/scsi-0HC_Volume_11049661 /mnt/scratch
    echo "/dev/disk/by-id/scsi-0HC_Volume_11049661 /mnt/scratch ext4 discard,nofail,defaults 0 0" >> /etc/fstab
    mount -a

    echo 🌱 MOUNT STORAGE /plots - /mnt/storage
    mkdir /mnt/storage
    chmod +x /mnt/storage
    mount -t cifs //u264756.your-storagebox.de/backup /mnt/storage -o sec=ntlmv2,credentials=/root/.smbcredentials
    echo "//u264756.your-storagebox.de/backup /mnt/storage cifs auto,users,credentials=/root/.smbcredentials,uid=1000,gid=1000,file_mode=0644,dir_mode=0755  0 0
    " >> /etc/fstab
    mount -a

    echo 🌱 CREATE DOCKER VOLUME FOR DB
    docker volume create chia-db
fi
exit