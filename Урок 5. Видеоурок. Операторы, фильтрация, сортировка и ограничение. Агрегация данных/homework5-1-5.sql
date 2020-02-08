/* (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2);
   Отсортируйте записи в порядке, заданном в списке IN. */

-- Задание сделал относительно таблицы users из БД vk

USE vk;

SELECT * FROM users WHERE id IN (337, 51, 140, 745) ORDER BY FIELD(id, 337, 51, 140, 745);