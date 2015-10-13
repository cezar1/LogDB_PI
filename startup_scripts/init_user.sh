#!/bin/bash
# declare STRING variable

#read system variables from config file
myCONFIG_FILE="../config"
echo "LOGDB_PI STARTUP SCRIPT"

if [ -e $myCONFIG_FILE ] ; then
	echo "Config file exists! ../config"
	while read LINE; do
		echo "$LINE"
		stringarray=($LINE)
		case ${stringarray[0]} in
			"USER") 	echo "Found myUSER ${stringarray[1]}"
					myUSER=${stringarray[1]};;
			"PASSWORD")	echo "Found myPASS ${stringarray[1]}"
					myPASS=${stringarray[1]};;
			"DATABASE") 	echo "Found myDATABASE ${stringarray[1]}"
					myDATABASE=${stringarray[1]};;
			"EVENTSTABLE")	echo "Found myEVENTSTABLE ${stringarray[1]}"
					myEVENTSTABLE=${stringarray[1]};;
			"LOGSTABLE")	echo "Found myLOGSTABLE ${stringarray[1]}"
					myLOGSTABLE=${stringarray[1]};;
		esac
	done < $myCONFIG_FILE
else
	echo "No config file found! ../CONFIG"
	exit;
fi
#CHECK ALL VARIABLES ARE HEALTHY------------------------
if [ -z "$myUSER" ] ; then
	echo "myUSER not set,exit!"
	exit;
fi
if [ -z "$myPASS" ] ; then
	echo "myPASS not set, exit!"
	exit;
fi
if [ -z "$myDATABASE" ] ; then
	echo "myDATABASE not set,exit!"
	exit;
fi
if [ -z "$myEVENTSTABLE" ] ; then
	echo "myEVENTSTABLE not set,exit!"
	exit;
fi
if [ -z "$myLOGSTABLE" ] ; then
	echo "myLOGSTABLE not set,exit!"
	exit;
fi

#	myUSER="cezar"
#	myDATABASE="mytestdb"
#	myEVENTSTABLE="myevents"
#	myLOGSTABLE="mylogs"

#------------------------------------------------------------------------------------
if [ $# != 1 ]; then
	echo "One argument is required. Usage -create -delete" 
else
	if [ $1 = "-create" ]; then
		mySTRING="Init script-CREATE USER that will interact with database"
		mySTRING+=":"
		mySTRING+=$myUSER
		echo $mySTRING
		#--------------------------------------------------------------
		mySTRING="CREATE USER cezar CREATEDB;"
		echo "Running [[" $mySTRING "]]"
		sudo -u postgres psql -c "$mySTRING"
		#--------------------------------------------------------------
		mySTRING="CREATE DATABASE $myDATABASE;"
		echo "Running on user $myUSER command [[" $mySTRING "]]"
		psql postgres -U $myUSER -c "$mySTRING"
		#EVENTS TABLE--------------------------------------------------
		mySTRING="CREATE TABLE $myEVENTSTABLE (
				eventID		varchar(40) NOT NULL CONSTRAINT eventskey PRIMARY KEY,
				date		date NOT NULL,
				eventfamily	varchar(40) NOT NULL
				);"
		echo "Running on user $myUSER and on database $myDATABASE command [[" $mySTRING "]]"
		psql $myDATABASE -U $myUSER -c "$mySTRING"
		#LOGS TABLE----------------------------------------------------
		mySTRING="CREATE TABLE $myLOGSTABLE (
				logID 		varchar(40) NOT NULL CONSTRAINT logskey PRIMARY KEY,
				datestart	date NOT NULL,
				dateend		date NOT NULL
				);"
		echo "Running on user $myUSER and on database $myDATABASE command [[" $mySTRING "]]"
		psql $myDATABASE -U $myUSER -c "$mySTRING"
		#--------------------------------------------------------------
	elif [ $1 = "-delete"  ]; then
		#EVENTS TABLE--------------------------------------------------
		mySTRING="DROP TABLE $myEVENTSTABLE ;"
		echo "Running on user $myUSER command [[" $mySTRING "]]"
		psql $myDATABASE -U $myUSER -c "$mySTRING"
		#LOGS TABLE----------------------------------------------------
		mySTRING="DROP TABLE $myLOGSTABLE ;"
		echo "Running on user $myUSER command [[" $mySTRING "]]"
		psql $myDATABASE -U $myUSER -c "$mySTRING"
		#--------------------------------------------------------------
		mySTRING="DROP DATABASE $myDATABASE;"
		echo "Running on user $myUSER and on postgres database command [[" $mySTRING "]]"
		psql postgres -U $myUSER -c "$mySTRING"
		#--------------------------------------------------------------
		mySTRING="DROP USER cezar;"
		echo "Running [[" $mySTRING "]]"
		sudo -u postgres psql -c "$mySTRING"
	else
		echo "Unknown argument" $1
	fi	
fi
