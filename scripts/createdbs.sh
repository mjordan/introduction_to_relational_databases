#!/bin/bash

# Script to create a set of MySQL databases and corresponding user accounts.
# User account names are in the form stringNUM.
# Usage: ./createdbs.sh
# You will be asked to confirm that you want to proceed, and if you answer 'y',
# prompted for your MySQL root user's password.

# Leave COUNTER as is.
COUNTER=1
# NUMDBs is the number of database/account sets you want.
NUMDBS=10
# Adjust PASSWORDLENGTH to suit your password length preference.
PASSWORDLENGTH=6
# USERNAMESTUB is a string that will be prepended to all usernames.
USERNAMESTUB=humanists

GLOBIGNORE="*"
MYSQL=`which mysql`

echo "Running this script will create $NUMDBS databases and corresponding users. Do you want to continue (y/n)?"
read CONFIRM
if [ $CONFIRM = 'y' ]; then
  while [  $COUNTER -le $NUMDBS ]; do
    ID=$( printf '%02d' $COUNTER )
    USERNAME=${USERNAMESTUB}${ID}
    # We use USERNAME as the database name.
    DBNAME=$USERNAME
    PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $PASSWORDLENGTH | head -n 1)
    echo ${USERNAME}/$PASSWORD

    CREATESQL="CREATE DATABASE IF NOT EXISTS $DBNAME;"
    USAGESQL="GRANT USAGE ON *.* TO $USERNAME@localhost IDENTIFIED BY '$PASSWORD';"
    PRIVILEGESSQL="GRANT ALL PRIVILEGES ON $DBNAME.* TO $USERNAME@localhost;"
    FLUSHSQL="FLUSH PRIVILEGES;"
    SQL="${CREATESQL} ${USAGESQL} ${PRIVILEGESSQL} ${FLUSHSQL}"
    echo $SQL

    let COUNTER=COUNTER+1 
  done
else
  echo "OK, quiting."
fi
