# ClusterResourcesMonitor
## Prerequisites
* nodejs : install from apt-get 
* passwordless ssh to every nodes

## Usage
* with Exareme installed run : startExaremeMonitoring.sh
* without Exareme run : startMonitoring.sh
* to stop run : stopMonitoring.sh

## Configuration 
* When it is used without Exareme create a file called workers containing the ip of the nodes that you want to be monitored (one per line)

## View Usage
The statistics can be accessed through <ip of server>:8484.
