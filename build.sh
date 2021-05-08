#!/bin/bash

docker build -t clx/chia-farmer farmer/ --no-cache
docker build -t clx/chia-plotter plotter/ --no-cache
docker build -t clx/chia-full_node full-node/ --no-cache