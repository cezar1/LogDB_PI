#!/bin/bash
# declare STRING variable
mySTRING="Init script-CREATE USER that will interact with database"
myUSER="cezar"
myDATABASE="mytestdb"
#print variable on a screen
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
#--------------------------------------------------------------
mySTRING="CREATE TABLE testDB();"
echo "Running on user $myUSER and on database $myDATABASE command [[" $mySTRING "]]"
psql $myDATABASE -U $myUSER -c "$mySTRING"
#--------------------------------------------------------------
mySTRING="DROP TABLE testDB;"
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

