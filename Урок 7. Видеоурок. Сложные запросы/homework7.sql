/* Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине. */

USE shop;

SELECT users.name
FROM users
WHERE users.id IN (SELECT orders.user_id FROM orders);


/* Выведите список товаров products и разделов catalogs, который соответствует товару. */

USE shop;

SELECT products.id as id,
       products.name as name,
       products.description as description,
       products.price as price,
       catalogs.name as catalog
FROM products
JOIN catalogs
WHERE products.catalog_id = catalogs.id;


/* (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
   Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights
   с русскими названиями городов. */

CREATE SCHEMA IF NOT EXISTS test DEFAULT CHARSET = utf8;;
USE test;

DROP TABLE IF EXISTS cities;
CREATE TABLE cities(
    label VARCHAR(50) NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS flights;
CREATE TABLE flights(
    id SERIAL PRIMARY KEY,
    `from` VARCHAR(50) NOT NULL,
    `to` VARCHAR(50) NOT NULL
);

ALTER TABLE flights
ADD FOREIGN KEY (`from`) REFERENCES cities(label),
ADD FOREIGN KEY (`to`) REFERENCES cities(label);


INSERT INTO cities
VALUES
       ('moscow', 'Москва'),
       ('irkutsk', 'Иркутск'),
       ('novgorod', 'Новогород'),
       ('kazan', 'Кзань'),
       ('omsk', 'Омск');

INSERT INTO flights (`from`, `to`)
VALUES
       ('moscow', 'omsk'),
       ('novgorod', 'kazan'),
       ('irkutsk', 'moscow'),
       ('omsk', 'irkutsk'),
       ('moscow', 'kazan');

SELECT dep.name as Departure,
       arr.name as Arrival
FROM flights
LEFT JOIN cities as dep ON dep.label = flights.`from`
LEFT JOIN cities as arr ON arr.label = flights.`to`;

