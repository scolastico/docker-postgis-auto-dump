FROM postgis/postgis:13-master
MAINTAINER scolastico support@scolasti.co

# Copy the initdb script for loading the database dump.
COPY ./initdb-postgres.sh /docker-entrypoint-initdb.d/99_dumploader.sh
RUN chmod +x /docker-entrypoint-initdb.d/99_dumploader.sh

# Copy the sigterm trap to dump the database before shuting down.
COPY ./sigterm-trap.sh /usr/local/bin/sigterm-trap.sh
RUN chmod +x /usr/local/bin/sigterm-trap.sh

# Overwrite the entrypoint to get our sigterm trap running.
ENTRYPOINT ["/usr/local/bin/sigterm-trap.sh"]
STOPSIGNAL SIGINT
CMD ["postgres"]
