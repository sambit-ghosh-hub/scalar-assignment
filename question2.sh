#!/bin/bash

# traverse directory recursively and note down every file extention encountered.
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
# run traversal and format the output correctly
main() {
traverse "$1"
echo -e "Extention \t Count"
counts=$(echo -e "$extentionslist" | sort -n | sed '/^$/d' | uniq -c | awk '{print  $2 " \t \t " $1}')
echo "$counts"
}

main "$1"
