#!/bin/bash

docker exec plotter1 touch /root/stoprun
docker exec plotter2 touch /root/stoprun
docker exec plotter3 touch /root/stoprun
docker exec plotter4 touch /root/stoprun