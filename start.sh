#!/bin/sh

perl config.pl

exec bin/kafka-server-start.sh server.properties
