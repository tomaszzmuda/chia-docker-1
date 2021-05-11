#!/bin/bash

chia init
chia keys add -f /root/keyfile
rm /root/keyfile
sed -i 's/localhost/127.0.0.1/g' ~/.chia/mainnet/config/config.yaml
chia plots add -d /dst
chia start farmer
chia plots status
while [ 1 ]
do
  chia show -s
  chia wallet show
  sleep 1h
done
