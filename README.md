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

-

`docker exec kafka kafka-console-consumer --bootstrap-server localhost:9092 --topic profile.events --from-beginning --property print.headers=true`
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

-

`docker exec kafka kafka-console-consumer --bootstrap-server localhost:9092 --topic profile.events --from-beginning`

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

# Redis

## Подключение к Redis

- `docker exec -it redis redis-cli`

## Команды

### Работа со ключами

- `KEYS *` - 1, если ключ есть. иначе 0. ❗ Может сильно тормозить на большом количестве ключей - для
  отладки!
- `EXISTS foo` - 1, если ключ есть. иначе 0.
- `DEL foo` - eдалить ключ, вернет 1, если был и удален. если не было, то 0.
- `TYPE foo` - что хранится в ключе (string в примере)

### Работа со строками (string)

👉 Redis по умолчанию работает со строками.

- `SET foo "Bar"` - сохранить значение по ключу
    - `SET city "Minsk"`
- `GET foo` - получить значение по ключу. если нет, то возвращает (nil)

### Работа со списками (LIST)

👉 Redis-список — это **упорядоченная** коллекция строк (аналог очереди/стека).

#### `LLEN` - Длина списка

- `LLEN tasks` - если списка нет, то 0

#### `LRANGE` - Получить элементы из диапазона

- `LRANGE tasks 0 -1` - выведет весь список

#### Добавление в список

##### `LPUSH` - добавить в **начало** списка

👉 Список растёт влево при `LPUSH`.

- `LPUSH tasks "learn Redis"` - возвращает длину списка после добавления
  - `LPUSH tasks "write code"`
    - `LRANGE tasks 0 1` - выведет 'write code', 'learn Redis'
    
##### `RPUSH` - добавить в **конец** списка

👉 Список растёт влево при `LPUSH`.

- `RPUSH greeting "Hello" "World!"`
- `LRANGE tasks 0 -1` - выведет 'Hello', 'World!' 

##### `LTRIM` - ограничить длину списка.

👉 Позволяет оставить в списке только указанный диапазон элементов, обрезая всё остальное.

- `DEL recent_logs`
- `RPUSH recent_logs "msg1" "msg2" "msg3" "msg4" "msg5"`
- `LRANGE recent_logs 0 -1`
  - `LTRIM recent_logs -3 -1` - оставим только последние 3 (надо каждый раз после добавление делать)
  - `LRANGE recent_logs 0 -1` 

#### Удаление из списка

##### `LPOP` - Удалить и вернуть из **начала**.

👉 Список растёт влево при `LPOP`.

- `RPUSH colors "red"`
  - `RPUSH colors "green"`
  - `RPUSH colors "blue"`
  - `LRANGE colors 0 -1` - возвращает red, green и blue
- `LPOP colors` - возвращает red
  - `LRANGE colors 0 -1` - возвращает green и blue

##### `RPOP` - Удалить и вернуть из **конца**.

👉 Список растёт влево при `LPOP`.

- `RPUSH nambers "one"`
  - `RPUSH nambers "two"`
  - `RPUSH nambers "three"`
  - `LRANGE nambers 0 -1` - возвращает one, two и three
- `RPOP nambers` - возвращает three
  - `LRANGE nambers 0 -1` - возвращает one, two


### Установка TTL (время жизни ключа)

- `SET temp "I will expire"`
- `EXPIRE temp 10` - установить время жизни (в секундах)
    - `EXPIRE city 30`
        - `EXPIRE city 10` - читать значение и сразу вручную продлевать TTL
- `TTL temp` - — сколько времени осталось. -1: ключ существует, но без TTL, -2: елюч не существует
  вообще.
    - `TTL city`

# Keycloak

## Create database

👉 Database is available in Docker

- `docker exec -it postgres bash`
  - `docker exec -it postgres psql -U postgres`

### Scripts

- `docker cp keycloak/. postgres:/tmp` - copy scripts into container
- `docker exec -it postgres psql -U postgres -f /tmp/drop-db.sql` - drop db
- `docker exec -it postgres psql -U postgres -f /tmp/create-db.sql` - create db

## Web access

### First login

- http://localhost:8880
- bootstrap/bootstrap

#### Create a permanent admin

- Войти как bootstrap/bootstrap
- Перейти в Real: master
- Перейти в Users
- Create user: 
  - Username: admin
  - Email, First name, Last name — по желанию
  - Enabled: ✅
- Перейди на вкладку Credentials → установи пароль
  - Temporary: ❌ OFF
- Перейди на вкладку Role Mappings
  - В списке Assign role выбираем Realm roles
    - Назначь роли:
      - или admin если хочешь полный доступ
      - realm-admin (достаточно для администрирования) ???

# Kong

## Web access

- http://localhost:8001/



# Nexus

## Web access

- http://localhost:8081
- admin/admin123
- `docker exec nexus cat /nexus-data/admin.password`

## Commands

- `docker logs nexus`

/nexus-data/admin.password
 