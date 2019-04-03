#!/bin/sh

export BROKER_ID=${HOSTNAME##*-}
perl config.pl

exec bin/kafka-server-start.sh server.properties
