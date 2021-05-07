# Setup

    apt install git make zip unzip docker.io docker-compose cifs-utils

## Generating a wallet and store mnemonic phrase in keyfile

    # docker build -t clx/chia-genkey farmer/
    docker build -t clx/chia-farmer farmer/
    # docker run --rm clx/chia-farmer bash -c 'chia init && chia keys generate_and_print' | sed -n '7p' > keyfile
    docker run --rm clx/chia-farmer bash -c 'chia init && chia keys generate_and_print' | sed -n '7p' > keyfile



    cp keyfile farmer/keyfile q
    mv keyfile plotter/keyfile

    # docker image rm clx/chia-genkey:latest

### Starting the farmer

    docker volume create chia-db
    # docker build -t clx/chia-farmer farmer/
    docker run -it -p 8444:8444 --name farmer -v chia-db:/root/.chia -v /mnt/storage/plots:/plots:ro clx/chia-farmer

Port forward 8444

### Starting a plotter

    docker build -t clx/chia-plotter plotter/
    # docker run -d --name plotter1 -v /mnt/scratch/plotter1:/tmp -v /mnt/storage/plots:/plots clx/chia-plotter

    # docker logs -tf plotter1
    # docker exec -it farmer bash
    # chia show -sc

## IMPORTANT

    nohup bash start-plotters.sh 4 &

## Stop Container

    docker exec plotter1 touch /root/stoprun

## Mounten

    sudo apt install cifs-utils

VOLUME FORMATIEREN

    sudo mkfs.ext4 -F /dev/disk/by-id/scsi-0HC_Volume_11049661

VERZEICHNIS ANLEGEN

    mkdir /mnt/scratch

VOLUME VERKNÜPFEN

    mount -o discard,defaults /dev/disk/by-id/scsi-0HC_Volume_11049661 /mnt/scratch

    mount -t cifs //u264756.your-storagebox.de/backup /mnt/storage -o sec=ntlmv2,username=u264756,password=8xdgBFtd02w2ETcr

OPTIONAL: VOLUME ZU FSTAB HINZUFÜGEN

    echo "/dev/disk/by-id/scsi-0HC_Volume_11049661 /mnt/scratch ext4 discard,nofail,defaults 0 0" >> /etc/fstab

./setup.sh
