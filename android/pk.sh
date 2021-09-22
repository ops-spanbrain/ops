#!/bin/bash

dir=$(pwd)


read APP_NAME

APP_PATH="$dir/$APP_NAME"
APK_APK="$dir/$APP_NAME.apk"
APP_DIST="$APP_PATH/dist/$APP_NAME.apk"
DEX="you path ../dex-tools"

if [ ! -f "$APK_APK" ];then
	echo "not file:$APK_APK"
else	
	echo "start analysis: $APK_NAME"
	apktool d $APK_APK
	echo "dir path:$APP_PATH"
	apktool b $APP_PATH
	cd $DEX

	source d2j-dex2jar.sh "$APP_DIST"
	mv "$APP_NAME-dex2jar.jar" $APP_PATH
fi

echo "done"