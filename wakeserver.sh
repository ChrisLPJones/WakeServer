#!/bin/bash

clientName="Windows PC"                  # Name of the client computer
clientIP="0.0.0.0"                       # IP address of the client computer
serverIP="0.0.0.0"                       # IP address of the server
routerNetworkInterface="eth0"            # Network interface name of the server
serverMacAddress="00:00:00:00:00:00"     # MAC address of the server

while :
do
  serverStatus=$(ping $serverIP -c 1 | grep -o "0 packets received")

  if [ "$serverStatus" = "0 packets received" ]; then
    echo "Server is Offline"
    clientStatus=$(ping $clientIP -w 1 | grep -o "1 packets received")
    if [ "$clientStatus" = "1 packets received" ]; then
      echo "$(date +%d/%m/%y' - '%r) - Waking server for $clientName" >> /jffs/scripts/server.log
      echo "" >> /jffs/scripts/server.log
      etherwake -i $routerNetworkInterface $serverMacAddress
      sleep 100
    fi
  else
    echo "Server is Online"
  fi
  sleep 10
done
