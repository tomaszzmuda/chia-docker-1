#!/bin/bash

echo 🌱 START FARMER
docker start farmer

echo 🌱 SLEEP 30s
sleep 30s

echo 🌱 START PLOTTER
for (( c=1; c<=${PA}; c++ ))
do
    docker start plotter$c
done