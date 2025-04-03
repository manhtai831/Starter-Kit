adb uninstall <package.name>
apks=$(ls signed_*.apk)
echo $apks
adb install-multiple -t --user 0 $apks
