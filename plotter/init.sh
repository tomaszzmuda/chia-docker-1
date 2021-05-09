#!/bin/bash

if [[ -f /root/.config/plotman/ ]]; then
  echo 🌱 START PLOTTING VIA PLOTMAN
  plotman plot
else
  while [ ! -f /root/stoprun ]
  do
    echo 🌱 CLEANING... /tmp
    rm /tmp/*.tmp
    echo 🌱 CREATE K32 PLOTS - 4/1/PARA
    chia plots create -r 2 -t /tmp -d /plots
  done
  rm -f /root/stoprun
  echo 🌱 STOPFILE FOUND, GRACEFULL EXIT AFTER PLOTTING
