USE vk;

INSERT IGNORE INTO users (firstname, lastname, email, phone)
VALUES ('Ivan', 'Pupkin', 'pupkin1@example.ru', '9231234567'),
       ('Ivan', 'Pupkin', 'pupkin2@example.ru', '9231234567'),
       ('Ivan', 'Pupkin', 'pupkin3@example.ru', '9231234567'),
       ('Ivan', 'Pupkin', 'pupkin4@example.ru', '9231234567'),
       ('Ivan', 'Pupkin', 'pupkin5@example.ru', '9231234567'),
       ('Ivan', 'Pupkin', 'pupkin6@example.ru', '9231234567');


INSERT IGNORE INTO users (id, firstname, lastname, email, password_hash, phone)
SELECT *
FROM users;


SELECT DISTINCT *
from users;

