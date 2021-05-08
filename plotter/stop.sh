#!/bin/bash

for (( c=1; c<=${PA}; c++ ))
do
    docker exec plotter${PA} touch /root/stoprun
done
