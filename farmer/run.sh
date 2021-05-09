#!/bin/bash

docker run -it -p 8444:8444 --name farmer --dns=1.1.1.1 -v chia-db:/root/.chia -v /mnt/storage:/plots:ro clx/chia-farmer