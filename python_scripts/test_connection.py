#!/usr/bin/python
# -*- coding: utf-8 -*-
import psycopg2
import test_config as myConfigScript

myConfigScript.init()
myConfigOk    = myConfigScript.myConfigOk
myUSER        = myConfigScript.myUSER
myPASSWORD    = myConfigScript.myPASSWORD
myDATABASE    = myConfigScript.myDATABASE
myEVENTSTABLE = myConfigScript.myEVENTSTABLE
myLOGSTABLE   = myConfigScript.myLOGSTABLE 
    
if not myConfigOk:
    print 'Config file incomplete!'
    sys.exit()

#OPEN DATABASE

con = None
try:
    print '=======LOGDB_PI==================='
    print '=Database connection check script='
    print '=================================='
    con = psycopg2.connect(database='mytestdb', user='cezar') 
    cur = con.cursor()
    cur.execute('SELECT version()')          
    ver = cur.fetchone()
    print ver    
    
except psycopg2.DatabaseError, e:
    print 'Error %s' % e    
    sys.exit(1)
    
finally:
    if con:
        con.close()
