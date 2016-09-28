#!/bin/bash

#usage() { echo "Usage: $0 [-d <database path]" 1>&2; exit 1; }

#while getopts ":d:" o; do
 #   case "${o}" in
  #      d)
   #         db=${OPTARG}
    #        ;;
     #   *)
      #      usage
       #     ;;
#    esac
#done
#shift $((OPTIND-1))

#if [ -z "${db}" ] ; then
#    usage
#fi

tmpdir=`cat ~/exareme/etc/exareme/art.properties | awk  'BEGIN { FS = "=" } ;/art.container.diskRoot=/ {print $2}'`
if [ -z "${tmpdir}" ] ; then
    errmsg="exareme was not found, monitoring /"
    tmpdir="/"
fi

np=`nproc`
cpu=`top -bn 1 | awk '{print $9}' | tail -n +8 | awk '{s+=$1;} END {print s}' | cut -f1 -d"." | cut -f1 -d","`
avgcpu=$(( cpu / np ))
avgcpu=`echo $avgcpu | cut -f1 -d"." | cut -f1 -d","`

#mem=`free -m | awk 'NR==2{printf "%.2f%% (%s/%sMB) \n", $3*100/$2,$3,$2 }'`
#memPer=`free -m | awk 'NR==2{printf "%.2f" ,$3*100/$2  }'`
totalM=`cat /proc/meminfo | awk '  /MemTotal:/ {print $2}'`
availM=`cat /proc/meminfo | awk '  /MemAvailable:/ {print $2}'` 
memperUsed=$(( (100*(totalM-availM)) / totalM ))


#diskAbs=`du -hs $db | awk '{print $1}'`
#diskPer=`df -h | awk '$NF=="/"{printf "%s", $5}' | cut -f1 -d"." | cut -f1 -d","`
#diskPer=`echo $diskPer | sed  's/%//g' ` 

diskPer=`df -h $tmpdir | awk 'FNR==2 {print $5}' | cut -f1 -d"%"`

#memPer=`echo $memPer | sed  's/\./,/g' | cut -f1 -d"." | cut -f1 -d","` 

printf "%10d %10d %10d |" "$avgcpu" "$memperUsed" "$diskPer"
echo -n "cpu($np)=$avgcpu"
echo -n " // disk=${diskAbs} ${diskPer}"
echo -n " // mem=$mem"
echo "^ $errmsg"

#df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
# top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}' 

