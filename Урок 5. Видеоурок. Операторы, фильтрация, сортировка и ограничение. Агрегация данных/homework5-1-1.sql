-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

use vk;

ALTER TABLE users
ADD 'created_at' VARCHAR(19),
ADD 'updated_at' VARCHAR(19);

UPDATE users
SET created_at = NOW(),
    updated_at = NOW();

SELECT created_at, updated_at FROM users;
