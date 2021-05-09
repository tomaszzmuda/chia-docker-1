#!/bin/bash

echo 🌱 BUILD IMAGES

docker build -t clx/chia-farmer farmer/
docker build -t clx/chia-plotter plotter/
