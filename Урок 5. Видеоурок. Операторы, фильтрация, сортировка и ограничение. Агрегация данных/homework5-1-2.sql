/* Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое
   время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME,
   сохранив введеные ранее значения. */

use vk;

ALTER TABLE users
MODIFY COLUMN created_at DATETIME,
MODIFY COLUMN updated_at DATETIME;

DESCRIBE users;


