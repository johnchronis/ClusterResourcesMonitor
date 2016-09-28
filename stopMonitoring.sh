kill -kill `ps aux | grep monitor.js | awk '!/grep/ {print $2}'`>/dev/null 2>&1
kill -kill `ps aux | grep masterStats.sh | awk '!/grep/ {print $2}'`>/dev/null 2>&1
rm nohup.out >/dev/null 2>&1
