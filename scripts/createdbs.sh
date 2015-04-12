#!/bin/bash

# Script to create a set of MySQL databases and corresponding user accounts.
# User account names are in the form stringNUM. This script is in the public domain.
# Usage: ./createdbs.sh
# You will be asked to confirm that you want to proceed, and if you answer 'y',
# prompted for your MySQL root user's password.

# Leave COUNTER as is.
COUNTER=1
# Your MySQL server's root password. Set it to empty if you want to be prompted for each database.
MYSQLROOTPASSWORD=
# NUMDBs is the number of database/account sets you want.
NUMDBS=2
# Adjust PASSWORDLENGTH to suit your password length preference.
PASSWORDLENGTH=6
# USERNAMESTUB is a string that will be prepended to all usernames.
USERNAMESTUB=footest
# PATHTODBTOLOAD is the path to an SQL file to load into the newly created database.
PATHTODBTOLOAD=sampledb.sql

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

    # Assemble the SQL statements required to create the db and user.
    CREATESQL="CREATE DATABASE IF NOT EXISTS $DBNAME;"
    USAGESQL="GRANT USAGE ON *.* TO $USERNAME@localhost IDENTIFIED BY '$PASSWORD';"
    PRIVILEGESSQL="GRANT ALL PRIVILEGES ON $DBNAME.* TO $USERNAME@localhost;"
    FLUSHSQL="FLUSH PRIVILEGES;"
    SQL="${CREATESQL} ${USAGESQL} ${PRIVILEGESSQL} ${FLUSHSQL}"

    let COUNTER=COUNTER+1 

    # Execute the SQL to create the db and user.
    $MYSQL -uroot -p${MYSQLROOTPASSWORD} -e "$SQL"
    # Load an SQL file into the db.
    $MYSQL -u${USERNAME} -p${PASSWORD} $DBNAME < $PATHTODBTOLOAD
  done
else
  echo "OK, quiting without creating any databases or users."
fi
