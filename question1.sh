#!/bin/bash
logfile=$1
if [ ! -f $logfile ]; 
then
 echo "File Not Found, Please check if file path is correct."
 exit 1
fi
totalcount=$(wc -l $logfile | awk '{print $1}')
echo "Total Requests Count: $totalcount"
successcount=$(awk '{print $9}' assignment.log | grep 2[0-9][0-9] | wc -l)
perct=$(($successcount*100/$(($totalcount))))
echo "Percentage of Successful Requests: $perct"
most_requests=$(awk '{print $1}' assignment.log | sort -n | uniq -c | sort -nr | awk 'NR==1 {print $2}')
echo "Most Active User: $most_requests"