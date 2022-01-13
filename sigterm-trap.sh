#!/bin/bash

echo "Registering shutdown trap for database dump generation..."

stop() {
    echo "Container stopping, generating dump of database..."
	FILE=/dump/database-dump.sql
	mv $FILE /dump/database-dump.sql.old
	pg_dump -U $POSTGRES_USER $POSTGRES_DB > $FILE
	echo "Done with generating database dump!"
	echo "Stopping now database..."
	kill -s SIGINT -$1
	wait $1
}

setsid docker-entrypoint.sh "$@" &
PID=$!

trap "stop $PID" SIGINT
echo "Shutdown trap registerd!"

wait $PID
echo "Bye!"
