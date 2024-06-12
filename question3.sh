#!/bin/bash
service=$1

# If systemctl exists use it.
systemctl status > /dev/null 2> /dev/null
if [ $? -eq 0 ] 
then 
 STATUS="$(systemctl is-active $service)"
 RUNNING="$(systemctl show -p SubState $service | cut -d'=' -f2)"
 if [ "${STATUS}" = "active" ]; then
 echo "$service Service is Active"
 if [ "${RUNNING}" = "running" ]; then
 echo "$service Service is Running"
 else
 echo "$service Service Not Running"
 fi
 else
 echo "$service Service Not Active "
 exit 1
 fi
# If systemctl does not exist use ps instead.
else
 i=$(ps -eaf | grep -i $service |sed '/^$/d'| wc -l)
 if [ $i > 0 ]
 then
   echo "$service Service is Running"
 else
   echo "$service Service Not Running"
 fi
fi