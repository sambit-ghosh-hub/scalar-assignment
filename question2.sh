#!/bin/bash
#script to recursively travel a dir of n levels

traverse() {
for file in "$1"/*
do
 if [ ! -d "${file}" ]; 
 then
  extension=${file##*.}
  extentionslist="$extension"$'\n'"$extentionslist"
 else
  traverse "${file}"
 fi
done

}

main() {
traverse "$1"
counts=$(echo "$extentionslist" | sort -n | sed '/^$/d' | uniq -c | awk '{print "There are " $1 " files of type " $2}')
echo "$counts"
}

main "$1"
