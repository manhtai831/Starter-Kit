#!/bin/bash -eu
: "${1?"Usage: $0 package name"}"

apk_path_list=$(adb shell pm path "$1")
OIFS=$IFS
IFS=$'\n'
apk_number=1
for apk_line in $apk_path_list
do
    (( ++apk_number ))
    apk_path=${apk_line:8:1000}
    apk_name="app${apk_number}.apk"
    adb pull "$apk_path" $apk_name
done

echo "Done"
