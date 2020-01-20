/*
 Создайте базу данных example, разместите в ней таблицу users,
 состоящую из двух столбцов, числового id и строкового name.
*/

CREATE DATABASE IF NOT EXISTS exampledb;
USE exampledb;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(100) UNIQUE
)
