#!/bin/bash
myCONFIG_FILE="../config"
if [ -e $myCONFIG_FILE ] ; then
    while read LINE; do
	echo "$LINE"
	stringarray=($LINE)
	case ${stringarray[0]} in
	    "LOG_DROP_PATH")  echo "Found myLOG_DROP_PATH ${stringarray[1]}"
		              myLOG_DROP_PATH=${stringarray[1]};;
	    "LOG_PROC_PATH")  echo "Found myLOG_PROC_PATH ${stringarray[1]}"
		              myLOG_PROC_PATH=${stringarray[1]};;
	esac	
    done < $myCONFIG_FILE
    if [ -z "$myLOG_DROP_PATH" ] ; then
	echo "myLOG_DROP_PATH not set, exit!"
	exit;
    else
	if [ -e $myLOG_DROP_PATH ] ; then
	    echo "Log drop path is ok!"
	else
	    mkdir $myLOG_DROP_PATH
	fi
    fi
    if [ -z "$myLOG_PROC_PATH" ] ; then
	echo "myLOG_PROC_PATH not set, exit!"
	exit;
    else
	if [ -e $myLOG_PROC_PATH ] ; then
	    echo "Log proc path is ok!"
	else
	    mkdir $myLOG_PROC_PATH
	fi
    fi
    
else
    echo "No config file found! ../config"
    exit;
fi

