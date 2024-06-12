#!/bin/bash
logfile=$1
# exit if file does not exist
if [ ! -f $logfile ]; 
then
 echo "Error: File Not Found, Please check if file path is correct." 
 exit 1
fi
# count total number of lines to find out how many requests were sent
totalcount=$(wc -l $logfile | awk '{print $1}')
echo "Total Requests Count: $totalcount"
# count number of successful requests (Code 200-299) and calculate percentage only if atleast 1 log entry exists
if [ $(($totalcount)) -eq 0 ]; 
then
 echo "Error: No logs to analyse" 
 exit 1
fi
successcount=$(awk '{print $9}' assignment.log | grep 2[0-9][0-9] | wc -l)
perct=$(($successcount*100/$(($totalcount))))
echo "Percentage of Successful Requests: $perct"
# Evaluate how many requests came from same IP address and take the highest to get most active user IP
most_requests=$(awk '{print $1}' assignment.log | sort -n | uniq -c | sort -nr | awk 'NR==1 {print $2}')
echo "Most Active User: $most_requests"