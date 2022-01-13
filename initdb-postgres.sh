#!/bin/bash

FILE=/dump/database-dump.sql

if test -f "$FILE"; then
	echo "Importing now database dump..."
	/usr/bin/psql -U $POSTGRES_USER $POSTGRES_DB < $FILE
	echo "Done with importing of database dump!"
fi
