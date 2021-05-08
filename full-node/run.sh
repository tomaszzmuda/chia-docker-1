#!/bin/bash

docker run -it -p 8444:8444 --name full_node -v chia-db:/root/.chia -v /mnt/storage:/plots:ro -e keys="./keyfile"
clx/chia-full_node