#!/usr/bin/python
# -*- coding: utf-8 -*-
import sys

#OPEN CONFIG
myConfigOk = False
myUSER = None
myPASSWORD = None
myDATABASE = None
myEVENTSTABLE = None
myLOGSTABLE = None

def init():
    try:
        print '======LOGDB_PI=================='
        print '=Configuration file load script='
        print '================================'
        global myConfigOk
        global myUSER
        global myPASSWORD
        global myDATABASE
        global myEVENTSTABLE
        global myLOGSTABLE

        myCONFIG_FILE  = "../config"
        print 'Config file ok!'
        myCF_TARGET = open(myCONFIG_FILE,"r")
        myCF_DATA = myCF_TARGET.read()
        myCF_LIST = myCF_DATA.splitlines()
        for line in myCF_LIST:
            print line
            myCF_descriptor , myCF_data =line.split()
            if  myCF_descriptor == 'USER':
                print 'Found myUSER %s' % myCF_data
                myUSER = myCF_data
            elif  myCF_descriptor == 'PASSWORD':
                print 'Found myPASSWORD %s' % myCF_data
                myPASSWORD = myCF_data
            elif  myCF_descriptor == 'DATABASE':
                print 'Found myDATABASE %s' % myCF_data
                myDATABASE = myCF_data
            elif  myCF_descriptor == 'EVENTSTABLE':
                print 'Found myEVENTSTABLE %s' % myCF_data
                myEVENTSTABLE = myCF_data
            elif  myCF_descriptor == 'LOGSTABLE':
                print 'Found myLOGSTABLE %s' % myCF_data
                myLOGSTABLE = myCF_data
        myConfigOk = myUSER is not None and myPASSWORD is not None and myDATABASE is not None and myEVENTSTABLE is not None and myLOGSTABLE is not None
        myCF_TARGET.close()
    except (OSError,IOError) as e:
        print 'File error : %s' % e

    
