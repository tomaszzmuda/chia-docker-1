#!/bin/bash

docker build -t --no-cache clx/chia-farmer farmer/
docker build -t --no-cache clx/chia-plotter plotter/