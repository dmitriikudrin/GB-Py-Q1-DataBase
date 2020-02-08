/* (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
   Месяцы заданы в виде списка английских названий ('may', 'august') */

-- Задание сделал относительно таблицы profiles из БД vk

USE vk;

SELECT * FROM profiles
WHERE  MONTHNAME(birthday) IN ('may', 'august');