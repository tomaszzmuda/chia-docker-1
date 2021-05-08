#!/bin/bash

for (( c=1; c<=${PA}; c++ ))
do
  docker run -d --name plotter$c --dns=1.1.1.1 -v /mnt/scratch/plotter$c:/tmp -v /mnt/storage:/plots clx/chia-plotter:latest
  echo 🌱 STARTED PLOTTER $c of ${PA} ... sleep for 1h
  sleep 1h
done
