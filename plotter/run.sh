#!/bin/bash

for (( c=1; c<=$1; c++ ))
do
  docker run -d --name plotter$c --network none -v /mnt/scratch/plotter$c:/tmp -v /mnt/storage/plots:/plots clx/chia-plotter:latest
  sleep 1m
done
