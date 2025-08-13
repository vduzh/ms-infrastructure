-- Создаём роль profile с правом входа
CREATE ROLE keycloak WITH LOGIN PASSWORD 'keycloak';

-- Создаём базу данных
CREATE DATABASE keycloak WITH OWNER=keycloak ENCODING='UTF8' LC_COLLATE='en_US.UTF-8' LC_CTYPE='en_US.UTF-8' TEMPLATE=template0;

-- Подключаемся к новой БД
\c keycloak

-- Создаём схему
CREATE SCHEMA IF NOT EXISTS keycloak AUTHORIZATION keycloak;