#!/bin/sh
if [ ! -f /data/server.properties ]; then
  perl config.pl
fi

exec bin/kafka-server-start.sh /data/server.properties
