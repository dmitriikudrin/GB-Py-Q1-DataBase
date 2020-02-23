/* В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
   Переместите запись id = 1 изтаблицы shop.users в таблицу sample.users. Используйте транзакции.
 */

CREATE DATABASE shop1 DEFAULT CHARSET = utf8;
create table shop1.users(
    id          SERIAL PRIMARY KEY,
    name        varchar(255)                       null comment 'Имя покупателя',
    birthday_at date                               null comment 'Дата рождения',
    created_at  datetime default CURRENT_TIMESTAMP null,
    updated_at  datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP
) comment 'Покупатели';
INSERT INTO shop1.users (id, name, birthday_at, created_at, updated_at)
VALUES
       (1, 'Геннадий', '1990-10-05', '2020-02-12 11:10:48', '2020-02-12 11:10:48'),
       (2, 'Наталья', '1984-11-12', '2020-02-12 11:10:48', '2020-02-12 11:10:48'),
       (3, 'Александр', '1985-05-20', '2020-02-12 11:10:48', '2020-02-12 11:10:48'),
       (4, 'Сергей', '1988-02-14', '2020-02-12 11:10:48', '2020-02-12 11:10:48'),
       (5, 'Иван', '1998-01-12', '2020-02-12 11:10:48', '2020-02-12 11:10:48'),
       (6, 'Мария', '1992-08-29', '2020-02-12 11:10:48', '2020-02-12 11:10:48');


CREATE DATABASE sample;
USE sample;
CREATE TABLE users LIKE shop1.users;


START TRANSACTION;
INSERT INTO users
SELECT * FROM shop1.users;
DELETE FROM shop1.users;
COMMIT;



/* Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее
   название каталога name из таблицы catalogs.
 */

USE shop;

CREATE OR REPLACE VIEW view1 AS
    SELECT products.name AS product,
           catalogs.name AS catalog
    FROM products
    JOIN catalogs
    WHERE products.catalog_id = catalogs.id;

SELECT * FROM view1;



/* (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи
   за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит
   полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0,
   если она отсутствует.
 */

USE sample;

DROP TABLE IF EXISTS temp;
CREATE TABLE temp(
    created_at DATE
);

INSERT INTO temp
VALUES
       ('2018-08-01'),
       ('2018-08-04'),
       ('2018-08-16'),
       ('2018-08-17');

DROP TABLE IF EXISTS august;
CREATE TABLE august(
    day DATE
);

INSERT INTO august
VALUES
       	('2018-08-01'),
		('2018-08-02'),
		('2018-08-03'),
		('2018-08-04'),
		('2018-08-05'),
		('2018-08-06'),
		('2018-08-07'),
		('2018-08-08'),
		('2018-08-09'),
		('2018-08-10'),
		('2018-08-11'),
		('2018-08-12'),
		('2018-08-13'),
		('2018-08-14'),
		('2018-08-15'),
		('2018-08-16'),
		('2018-08-17'),
		('2018-08-18'),
		('2018-08-19'),
		('2018-08-20'),
		('2018-08-21'),
		('2018-08-22'),
		('2018-08-23'),
		('2018-08-24'),
		('2018-08-25'),
		('2018-08-26'),
		('2018-08-27'),
		('2018-08-28'),
		('2018-08-29'),
		('2018-08-30'),
		('2018-08-31');

SELECT day,
       EXISTS(SELECT created_at FROM temp WHERE created_at = day) as exist
FROM august
LEFT JOIN temp
ON day = created_at
ORDER BY day;



/* (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие
   записи из таблицы, оставляя только 5 самых свежих записей.
 */

USE sample;

DROP TABLE IF EXISTS temp;
CREATE TABLE temp(
    created_at DATE
);

INSERT INTO temp
VALUES
       ('2018-08-01'),
       ('2018-08-02'),
		('2018-08-03'),
		('2018-08-04'),
		('2018-08-05'),
		('2018-08-06'),
		('2018-08-07'),
		('2018-08-08'),
		('2018-08-09'),
		('2018-08-10'),
		('2018-08-11'),
		('2018-08-12'),
		('2018-08-13'),
		('2018-08-14'),
		('2018-08-15'),
		('2018-08-16'),
		('2018-08-17'),
		('2018-08-18'),
		('2018-08-19'),
		('2018-08-20'),
		('2018-08-21'),
		('2018-08-22'),
		('2018-08-23'),
		('2018-08-24'),
		('2018-08-25'),
		('2018-08-26'),
		('2018-08-27'),
		('2018-08-28'),
		('2018-08-29'),
		('2018-08-30'),
		('2018-08-31');


-- Вариант 1
START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS temp_table;
CREATE TEMPORARY TABLE temp_table LIKE temp;

INSERT INTO temp_table
SELECT *
FROM temp
ORDER BY created_at DESC
LIMIT 5;

DELETE FROM temp;

INSERT INTO temp
SELECT * FROM temp_table;

DROP TEMPORARY TABLE IF EXISTS temp_table;

COMMIT;


-- Вариант 2
SET @tempset = (SELECT *
FROM temp
ORDER BY created_at DESC
LIMIT 4,1);

DELETE FROM sample.temp
WHERE sample.temp.created_at < @tempset;










