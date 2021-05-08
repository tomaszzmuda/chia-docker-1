#!/bin/bash

docker run -it -p 8444:8444 --name farmer${FID} -v chia-db:/root/.chia -v /mnt/storage:/plots:ro clx/chia-farmer