#!/bin/bash

while [ ! -f /root/stoprun ]
do
  echo 🌱 CLEANING... /tmp
  rm /tmp/*.tmp
  echo 🌱 CREATE K32 PLOTS - 4/1/PARA
  chia plots create -r 4 -t /tmp -d /plots
done
rm -f /root/stoprun
echo 🌱 STOPFILE FOUND, GRACEFULL EXIT AFTER PLOTTING
