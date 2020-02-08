/* (по желанию) Подсчитайте произведение чисел в столбце таблицы */

use vk;

SELECT EXP(SUM(LN(id))) FROM users;