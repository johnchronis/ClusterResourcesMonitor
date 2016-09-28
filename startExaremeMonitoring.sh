#!/bin/bash
if [ -z `which nodejs` ]
    then
        echo "Install node by: apt-get install nodejs and then start Monitoring again"
        exit
fi
if [ ! -f ~/exareme/etc/exareme/workers ]; then
    echo "Exareme worker file was not found!"
    echo "Add the ips of the nodes to be monitored to a file named workers in this directory and run startMonitoring.sh"
    exit
fi

cp ~/exareme/etc/exareme/workers .
cat ~/exareme/etc/exareme/master >> ./workers
nohup ./masterStats.sh -w workers  >/dev/null 2>&1 &  
nohup nodejs ./monitor.js  >/dev/null 2>&1   &
