#!/bin/bash

echo 🌱 BUILD IMAGES

docker build -t clx/chia-farmer farmer/ --no-cache
docker build -t clx/chia-plotter plotter/ --no-cache
