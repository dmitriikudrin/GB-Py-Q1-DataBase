/* Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека,
   который больше всех общался с нашим пользователем. */

USE vk;

SELECT
       COUNT(*) + (SELECT COUNT(*) FROM messages
                        WHERE to_user_id = 870 and from_user_id = to_user_id) as 'Number of messages',
       (SELECT CONCAT(firstname, ' ', lastname) FROM users where id = to_user_id) as 'Name of Friend'
FROM messages
WHERE from_user_id = 870
GROUP BY to_user_id
ORDER BY COUNT(id) DESC
LIMIT 1;


/* Подсчитать общее количество лайков, которые получили пользователи младше 10 лет */

USE vk;

SELECT COUNT(id)
FROM likes
WHERE user_id IN (SELECT user_id FROM profiles WHERE (birthday + INTERVAL 20 YEAR) > NOW());


/* Определить кто больше поставил лайков (всего) - мужчины или женщины? */

USE vk;

SELECT
       (SELECT gender FROM profiles WHERE profiles.user_id = likes.user_id ) as gender
FROM likes
GROUP BY gender
ORDER BY gender DESC
LIMIT 1;
