USE vk;

INSERT IGNORE INTO users (firstname, lastname, email, phone)
VALUES ('Ivan', 'Pupkin', 'pupkin1@example.ru', '9231234567'),
       ('Ivan', 'Pupkin', 'pupkin2@example.ru', '9231234567'),
       ('Ivan', 'Pupkin', 'pupkin3@example.ru', '9231234567'),
       ('Ivan', 'Pupkin', 'pupkin4@example.ru', '9231234567'),
       ('Ivan', 'Pupkin', 'pupkin5@example.ru', '9231234567'),
       ('Ivan', 'Pupkin', 'pupkin6@example.ru', '9231234567');


INSERT IGNORE INTO users (id, firstname, lastname, email, password_hash, phone, is_deleted)
SELECT *
FROM users;


SELECT DISTINCT *
from users;

INSERT INTO friend_requests (initiator_user_id, target_user_id, status)
VALUES (489, 621, 'requested');

INSERT INTO friend_requests (initiator_user_id, target_user_id, status)
VALUES (489, 225, 'requested');

INSERT INTO friend_requests (initiator_user_id, target_user_id, status)
VALUES (489, 226, 'requested');

INSERT INTO friend_requests (initiator_user_id, target_user_id, status)
VALUES (489, 227, 'requested');

UPDATE friend_requests
SET
    status = 'approved',
    confirmed_at = NOW()
WHERE
    initiator_user_id = 489 and target_user_id = 621 and status = 'requested';

DELETE IGNORE FROM friend_requests
WHERE
    initiator_user_id = 489 and target_user_id = 227 and status = 'requested';

UPDATE users
SET password_hash = NULL;