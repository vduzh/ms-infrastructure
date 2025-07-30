# Docker Compose

- `docker compose up` - create infrastructure
- `docker compose down` - пересоздать контейнеры
    - `docker compose down -v` - delete all with volumes


# Kafka

## Kafka UI
- `http://localhost:9080/` - админ консоль


# Kafka CLI

- `docker exec -it kafka bash`

## Проверка доступных топиков

Так можно проверить, что Kafka работает. Если всё ок — вывод либо пустой, либо покажет список
топиков.

- `docker exec kafka kafka-topics --bootstrap-server localhost:9092 --list`
    - `docker exec kafka kafka-topics --bootstrap-server kafka:9092 --list` - указывать имя брокера
      в сети docker-compose

- `docker exec kafka kafka-console-consumer --bootstrap-server localhost:9092 --topic profile.events --from-beginning --property print.headers=true`
- 
- `docker exec kafka kafkacat -b localhost:9092 -t profile.events -C -J`

## Создать топик

-
`docker exec kafka kafka-topics --bootstrap-server kafka:9092 --create --topic my-topic --partitions 3 --replication-factor 1`

## Описать топик

- `docker exec kafka kafka-topics --bootstrap-server kafka:9092 --describe --topic profile.events`

## Отправить сообщение (producer)

- `docker exec -i kafka kafka-console-producer --broker-list kafka:9092 --topic my-topic` - можно
  вводить строки — они пойдут в топик

- Прочитать сообщения (consumer)

- `docker exec kafka kafka-console-consumer --bootstrap-server localhost:9092 --topic profile.events --from-beginning`

## Прочее

- `docker exec kafka kafka-broker-api-versions --bootstrap-server localhost:9092` - проверим, что
  Kafka правильно рекламирует адреса

## Очистка топика

### Удалить и пересоздать топик (простой и надёжный способ)

- `docker exec kafka kafka-topics --bootstrap-server kafka:9092 --delete --topic my-topic`
-
`docker exec kafka kafka-topics --bootstrap-server kafka:9092 --create --topic my-topic --partitions 3 --replication-factor 1`

# Kafka Connect

- `docker exec -it connect bash`
- http://localhost:8083/connectors

# Nexus

## Web access

- http://localhost:8081
- admin/admin123 
- `docker exec nexus cat /nexus-data/admin.password` 

## Commands

- `docker logs nexus`

/nexus-data/admin.password
 