#!/bin/bash

for (( c=1; c<=${PA}; c++ ))
do
  docker run -d --name plotter$c --dns=1.1.1.1 -v /mnt/scratch/tmp_$c:/tmp  -v /mnt/scratch/tmp2_$c:/tmp2  -v /mnt/scratch/dst_$c:/dst -v /mnt/storage:/storage clx/chia-plotter:latest
  echo 🌱 PLOTTER STARTED $c of ${PA} ... sleep for 1h
  sleep 1h
done
