# Kafka

## Создай три системных топика для Kafka Connect 

- `docker exec -it kafka bash`

### _connect-configs

```shell
kafka-topics --create \
  --bootstrap-server kafka:9092 \
  --replication-factor 1 \
  --partitions 1 \
  --topic _connect-configs \
  --config cleanup.policy=compact
```

### _connect-offsets

```shell
kafka-topics --create \
  --bootstrap-server kafka:9092 \
  --replication-factor 1 \
  --partitions 25 \
  --topic _connect-offsets \
  --config cleanup.policy=compact
```

### _connect-status

```shell
kafka-topics --create \
  --bootstrap-server kafka:9092 \
  --replication-factor 1 \
  --partitions 5 \
  --topic _connect-status \
  --config cleanup.policy=compact
```

