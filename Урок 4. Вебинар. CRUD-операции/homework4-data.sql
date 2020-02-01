USE vk;

-- ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке

SELECT DISTINCT firstname
FROM users
ORDER BY firstname;


/* iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false).
Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1) */

ALTER TABLE profiles
ADD COLUMN is_active BOOL DEFAULT TRUE;

UPDATE profiles
SET
    is_active = FALSE
WHERE
    (((YEAR(NOW()) - YEAR(birthday)) * 12 + MONTH(NOW()) - MONTH(birthday)
    - IF(DAYOFMONTH(NOW()) > DAYOFMONTH(birthday), 0, 1)) / 12) < 18;

SELECT *
FROM profiles
WHERE is_active = FALSE;


-- iv. Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)

DELETE FROM messages
WHERE created_at > NOW();

SELECT *
FROM messages
WHERE created_at > NOW();