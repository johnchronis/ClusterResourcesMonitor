# ClusterResourcesMonitor
A service that monitors cpu, memory and disk usage of a cluster. Detailed logs are stored and a live status is served at <serverip>:8484 

## Prerequisites
* nodejs
* passwordless ssh to every node

## Usage
* with Exareme installed run : startExaremeMonitoring.sh
* without Exareme run : startMonitoring.sh
* to stop run : stopMonitoring.sh

## Configuration 
* When it is used without Exareme create a file called workers containing the ips of the nodes that you want to be monitored (one per line)

## View Live Usage 
Usage can be monitored at <ip of server>:8484.

![Alt text](/screenshots/live.png?raw=true "Live Status")

## Log
The detailed logs are store at the directory statsLogs

![Alt text](/screenshots/log.png?raw=true "Log")
