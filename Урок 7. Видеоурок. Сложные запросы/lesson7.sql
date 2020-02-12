USE shop;

SELECT * FROM catalogs
UNION ALL
SELECT * FROM rubrics
UNION ALL
SELECT id, name FROM products
ORDER BY name;


SELECT
       id,
       products.name,
       (SELECT catalogs.name FROM catalogs where catalogs.id = products.catalog_id ) as catalog
FROM products;


SELECT id,
       name,
       catalog_id
FROM products
WHERE catalog_id IN (SELECT id FROM catalogs);

SELECT MIN(price)
FROM products
WHERE catalog_id = (SELECT id from catalogs WHERE catalogs.name = 'материнские платы');

SELECT *
FROM products
WHERE catalog_id = (SELECT id from catalogs WHERE catalogs.name = 'процессоры') and
      price > ANY (SELECT MIN(price)
                FROM products
                WHERE catalog_id = (SELECT id from catalogs WHERE catalogs.name = 'материнские платы'));


SELECT *
FROM catalogs
WHERE EXISTS (SELECT * FROM products WHERE catalog_id = catalogs.id);

SELECT id, name, price, catalog_id FROM products
WHERE ROW(catalog_id, 5060.00) IN (SELECT id, price FROM catalogs);


SELECT
       products.name,
       products.price,
       catalogs.name
FROM catalogs
JOIN products
ON catalogs.id = products.catalog_id;


SELECT *
FROM catalogs
JOIN products
ON catalogs.id = products.catalog_id;

UPDATE catalogs
JOIN products
ON catalogs.id = products.catalog_id
SET price = price * 0.9
WHERE catalogs.name = 'Материнские платы';
