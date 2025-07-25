# Docker Compose 

- `docker compose up` - create infrastructure 
- `docker compose down` - пересоздать контейнеры
  - `docker compose down -v` - delete all with volumes

# Kafka

- `docker exec -it kafka bash`
- `docker exec kafka kafka-topics --list --bootstrap-server localhost:9092`
- `docker exec kafka kafka-console-consumer --bootstrap-server localhost:9092 --topic outbox.event.profile --from-beginning`
- `docker exec kafka kafka-broker-api-versions --bootstrap-server localhost:9092` - проверим, что Kafka правильно рекламирует адреса

# Kafka Connect

- `docker exec -it connect bash`
- http://localhost:8083/connectors