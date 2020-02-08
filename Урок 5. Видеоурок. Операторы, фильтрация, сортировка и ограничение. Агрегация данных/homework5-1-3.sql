/* В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
   0, если товар закончился и выше нуля, если на складе имеются запасы.
   Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
   Однако, нулевые запасы должны выводиться в конце, после всех записей. */

/* Задание сделал относительно таблицы communities из БД vk.
   Для этого добавил столбец number_users c количеством участников сообщества */


USE vk;

ALTER TABLE communities
ADD number_users INT NOT NULL;

UPDATE communities
SET communities.number_users = ROUND(RAND()*(10));

SELECT * FROM communities
ORDER BY CASE WHEN number_users = 0 THEN 100000000000 ELSE number_users END;