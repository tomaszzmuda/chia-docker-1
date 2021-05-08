#!/bin/bash

echo 🌱 REMOVE CONTAINER
for (( c=1; c<=${PA}; c++ ))
do
    docker rm plotter$c
done
docker rm farmer