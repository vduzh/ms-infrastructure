-- Принудительно отключаем все активные соединения к БД profile
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'keycloak'
  AND pid <> pg_backend_pid();

-- Удаляем базу данных
DROP DATABASE IF EXISTS keycloak;

-- Удаляем роли
DROP ROLE IF EXISTS keycloak;
