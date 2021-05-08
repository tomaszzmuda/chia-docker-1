#!/bin/bash

if [[ ! -z $1 ]]; then
    docker run -d --name plotter$1 --network host --dns=1.1.1.1 -v /mnt/scratch/plotter$1:/tmp -v /mnt/storage:/plots clx/chia-plotter:latest
else
    echo 
fi