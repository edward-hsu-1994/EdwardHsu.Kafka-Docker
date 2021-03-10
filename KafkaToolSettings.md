# Kafka Tool Settings

## Properties

Zookeeper Host: localhost
Zookeeper Port: 2181

## Security

Type: SASL Plaintext

## Advanced

SASL Mechanism: PLAIN

## JAAS

```
org.apache.kafka.common.security.plain.PlainLoginModule required username="user" password="pwd";
```