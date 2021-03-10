#!/bin/sh

if [ "$BROKER_ID" != "" ]
then 
    sed -i "s/^\(broker\.id\s*=\s*\).*\$/\1$BROKER_ID/" "$CONFIG_FILE";
fi;

if [ "$ZOOKEEPER_HOST" != "" ]
then 
    sed -i "s/^\(zookeeper\.connect\s*=\s*\).*\$/\1$ZOOKEEPER_HOST/" "$CONFIG_FILE";
fi;


echo "KafkaServer {" >> /opt/kafka/config/kafka.jaas;
echo "    org.apache.kafka.common.security.plain.PlainLoginModule required" >> /opt/kafka/config/kafka.jaas;
echo "    username=\"$USERNAME\"" >> /opt/kafka/config/kafka.jaas;
echo "    password=\"$PASSWORD\"" >> /opt/kafka/config/kafka.jaas;
echo "    user_$USERNAME=\"$PASSWORD\";" >> /opt/kafka/config/kafka.jaas;
echo "};" >> /opt/kafka/config/kafka.jaas;
cat /opt/kafka/config/kafka.jaas

export KAFKA_OPTS="-Djava.security.auth.login.config=/opt/kafka/config/kafka.jaas"

echo "listeners=SASL_PLAINTEXT://:9092" >> "$CONFIG_FILE";
echo "advertised.listeners=SASL_PLAINTEXT://$HOST:9092" >> "$CONFIG_FILE";
echo "security.inter.broker.protocol=SASL_PLAINTEXT" >> "$CONFIG_FILE";
echo "sasl.mechanism.inter.broker.protocol=PLAIN" >> "$CONFIG_FILE";
echo "sasl.enabled.mechanisms=PLAIN" >> "$CONFIG_FILE";
echo "zookeeper.sasl.client=false" >> "$CONFIG_FILE";

exec ./kafka-server-start.sh "$CONFIG_FILE"