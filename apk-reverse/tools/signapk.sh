#!/bin/bash
# Sample usage is as follows;
# ./signapk myapp.apk debug.keystore android androiddebugkey
# 
# param1, APK file: Calculator_debug.apk
# param2, keystore location: ~/.android/debug.keystore
# param3, key storepass: android
# param4, key alias: androiddebugkey

# use my debug key default
APK=$1
KEYSTORE="${2:-$HOME/.android/debug.keystore}"
STOREPASS="${3:-android}"
ALIAS="${4:-androiddebugkey}"
OUTPUT_DIR="${5:-./}"

echo $KEYSTORE


# get the filename
APK_BASENAME=$(basename $APK)
SIGNED_APK="signed_"$APK_BASENAME

#debug
echo APK: $APK
echo Key store: $KEYSTORE
echo Store Password:  $STOREPASS
# echo param4 $ALIAS

# delete META-INF folder
zip -d $APK META-INF/\*

echo "zipalign -p -f -v 4 $APK $SIGNED_APK"
zipalign -p -f -v 4 $APK $SIGNED_APK

# sign APK
echo "apksigner sign --ks $KEYSTORE $SIGNED_APK"
apksigner sign --ks $KEYSTORE --ks-pass pass:$STOREPASS $SIGNED_APK
# jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $KEYSTORE -storepass $STOREPASS $APK $ALIAS
#verify
apksigner verify $SIGNED_APK

echo "Out: ---> ${PWD}/$SIGNED_APK"

# jarsigner -verify $APK

#zipalign
# zipalign -v 4 $APK $SIGNED_APK 