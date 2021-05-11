#!/bin/bash

while [ ! -f /root/stoprun ]
do
  echo 🌱 CLEANING... /tmp
  rm -v /tmp/*.tmp
  echo 🌱 CREATE K32 PLOTS - 4/1/PARA
  chia plots create -r 2 -t /tmp -2 /tmp2 -d /dst
done
rm -f /root/stoprun
echo 🌱 STOPFILE FOUND, GRACEFULL EXIT AFTER PLOTTING
