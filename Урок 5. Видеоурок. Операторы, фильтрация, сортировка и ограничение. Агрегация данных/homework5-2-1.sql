/* Подсчитайте средний возраст пользователей в таблице users */

USE vk;

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday, NOW()))) FROM profiles;