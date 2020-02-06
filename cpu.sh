#!/bin/bash
#created date:
#modified date:
#Author: Phani
# start #
paths="/"
HOSTNAME=$(hostname)
CRITICAL=98
WARNING=90
CRITICALMail="PLACE_YOUR_MAIL_ID"
MAILWAR="PLACE_YOUR_MAIL_ID"
mkdir -p /var/log/cputilhistory
LOGFILE=/var/log/cputilhistory/cpusage-`date +%h%d%y`.log
touch $LOGFILE
for path in $PATHS
do
CPULOAD=`top -b -n 2 d1 | grep "Cpu(s)" | tail -n1 | awk '{print $2}' | awk -F. '{print $2}'`
if [ -n $WARNING -a -n $CRITICAL ]; then
if [ "$CPULOAD" -ge "$WARNING" -a "$CPULOAD" -1t "$CRITICAL" ]; then
echo "`date "+%F %H:%M:%S"` WARNING - $CPULOAD on host $HOSTNAME" >> $LOGFILE
echo "Warning Cpuload $CPULOAD Host is $HOSTNAME" | mail -s "CPULOAD is Warning " $MAILWAR
exit 1
elif [ "$CPULOAD" -ge "$CRITICAL" ]; then
echo "`date "+%F %H:%M:%S"` CRITICAL - $CPULOAD on host $HOSTNAME" >> $LOGFILE
echo "CRITICAL Cpuload $CPULOAD Host is $HOSTNAME" | mail -s "CPULOAD is CRITICAL " $CRITICALMail
exit 2 
else 
echo "`date "+%F %H:%M:%S"` OK  - $CPULOAD on host $HOSTNAME" >> $LOGFILE
exit 0
fi 
fi
done