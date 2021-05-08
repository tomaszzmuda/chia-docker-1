#!/bin/bash

# docker run -it -p 8444:8444 --name full_node -v chia-db:/root/.chia -v /mnt/storage:/plots:ro -e keys="./keyfile" clx/chia-full_node
docker run --name full_node -d --dns=1.1.1.1 -v /mnt/scratch/full-node:/tmp -v /mnt/storage:/plots:ro ghcr.io/chia-network/chia:latest

