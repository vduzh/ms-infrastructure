# Kafka

- `docker exec -it kafka bash`
- `docker exec kafka kafka-topics --list --bootstrap-server localhost:9092`
- `docker exec kafka kafka-console-consumer --bootstrap-server localhost:9092 --topic outbox.event.profile --from-beginning`

# Kafka Connect

- `docker exec -it connect bash`
- http://localhost:8083/connectors