#/bin/bash

echo 🌱 STOP PLOTTER
for (( c=1; c<=${PA}; c++ ))
do
    docker stop plotter$c
done