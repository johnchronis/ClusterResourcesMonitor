#!/bin/bash
if [ -z `which nodejs` ]
    then
        echo "Install node by: apt-get install nodejs and then start Monitoring again"
        exit
fi
if [ ! -f ./workers ]; then
    echo "Workers File not found, create a file named workers in this directory containing all the nodes you want to monitor!"
    exit
fi

nohup ./masterStats.sh -w workers  >/dev/null 2>&1 &  
nohup nodejs ./monitor.js  >/dev/null 2>&1   &
