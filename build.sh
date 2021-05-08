#!/bin/bash

echo **********************************************
echo 🌱 BUILD IMAGES
echo **********************************************

docker build -t clx/chia-farmer farmer/ --no-cache
docker build -t clx/chia-plotter plotter/ --no-cache
