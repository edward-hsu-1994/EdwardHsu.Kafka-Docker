#!/bin/sh
if [ "$BROKER_ID" != "" ]
then 
    sed -i "s/^\(broker\.id\s*=\s*\).*\$/\1$BROKER_ID/" "$CONFIG_FILE";
fi;

if [ "$ZOOKEEPER_HOST" != "" ]
then 
    sed -i "s/^\(zookeeper\.connect\s*=\s*\).*\$/\1$ZOOKEEPER_HOST/" "$CONFIG_FILE";
fi;

if [ "$LISTENERS" != "" ]
then 
    echo "listeners=$LISTENERS" >> "$CONFIG_FILE";
fi;

if [ "$ADV_LISTENERS" != "" ]
then 
    echo "advertised.listeners=$ADV_LISTENERS" >> "$CONFIG_FILE";
fi;

exec ./kafka-server-start.sh "$CONFIG_FILE"