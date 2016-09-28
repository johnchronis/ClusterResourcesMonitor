#!/bin/bash

usage() { echo "Usage: $0 [-w <worker file path>]" 1>&2; exit 1; }



while getopts ":w:" o; do
    case "${o}" in
        w)
            w=${OPTARG}
            ;;
      #  d) 
	  # db=${OPTARG}
	  # ;;
	*)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${w}" ]; then
    usage
fi
echo 1
rm monitor.html 2> /dev/null
touch monitor.html
echo "<html><head><meta http-equiv=\"refresh\" content=\"3\"></head><body><h1>The monitoring service is starting up!</h1></body></html>"> monitor.html
rm tmpmonitor.html 2> /dev/null
mkdir statslogs 2> /dev/null
echo 1.5
while read p; do
 scp ./stats.sh `echo $p`:/tmp/ 
done <`echo $w`
	#echo 2
while read p; do
 touch statslogs/$p.stat
 echo "cpu(avg)  mem(%)  disk(%)" >statslogs/$p.stat 
done <`echo $w`
echo 3
while [ 1 ]
do
	rm tmpmonitor.html 2> /dev/null
	touch tmpmonitor.html
	echo "<!DOCTYPE html><html><head><meta http-equiv=\"refresh\" content=\"3\"></ head><body><table style=\"width:80%\"><tr><th>Node</th><th align=\"left\">Cpu (% avg of cores)</th><th align=\"left\">Memory (%)</th><th align=\"left\">Disk (%)</th><th>Message</th></tr>"  > tmpmonitor.html
echo 4
	while read p; do
   		#echo $p
  		if [ "127.0.0.1" == "$p" ] || [ "localhost" == "$p" ] ; then
			res=`./stats.sh` 
		else
		        res=`rsh -n $p /tmp/stats.sh `
		
		fi
		rec=`echo $res | awk -F "|" 'NR==1{print $1}'`
		errmsg=`echo $res | awk -F "^" 'NR==1{print $2}'`
			
		echo $rec >> statslogs/$p.stat # write to detailed monitor files 
		
		cpu=`echo $rec | awk '{print $1}'` #live monitoring
		disk=`echo $rec | awk '{print $3}'`
		mem=`echo $rec | awk '{print $2}' | cut -f1 -d"." | cut -f1 -d","`

		echo "<tr> <td align=\"center\">${p}</td>  <td><meter min=\"0\" max=\"100\" value=\"${cpu}\"></meter>&nbsp;&nbsp;${cpu}</td> <td><meter min=\"0\" max=\"100\" value=\"${mem}\"></meter>&nbsp;&nbsp;${mem}</td> <td><meter min=\"0\" max=\"100\" value=\"${disk}\"></meter>&nbsp;&nbsp;${disk}</td> <td>${errmsg}</td></tr> " >> tmpmonitor.html			
#echo 5
	done <`echo $w`

	echo  "</table></body></html>" >> tmpmonitor.html
	#echo 6
	touch block
	#sync
	until [ ! -f "./nlock" ]
	do
	  rm block
	  #echo "nlock exists"
     	  sleep 0.2
	  touch block
	done
	#echo "nlock not"
	rm monitor.html 2> /dev/null
	mv tmpmonitor.html monitor.html
	rm block	
#echo 7
	sleep 4;
#echo 8
done

