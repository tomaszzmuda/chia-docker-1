#!/bin/bash

for (( c=1; c<=${PA}; c++ ))
do
    docker exec plotter$c touch /root/stoprun
done
