#/bin/bash

echo **********************************************
echo 🌱 STOP FARMER
echo **********************************************

docker stop farmer

echo **********************************************
echo 🌱 STOP PLOTTER
echo **********************************************

for (( c=1; c<=${PA}; c++ ))
do
    docker stop plotter$c
done