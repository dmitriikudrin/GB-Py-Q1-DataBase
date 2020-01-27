DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
    id SERIAL PRIMARY KEY, -- BIGINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT
    firstname VARCHAR(50) COMMENT 'Имя' ,
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE,
    `password_hash` VARCHAR(100),
    phone VARCHAR(12),


    INDEX idx_users_phone(phone),
    INDEX idx_users_name_idx(firstname, lastname)
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
    user_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
    photo_id BIGINT UNSIGNED NULL,
    hometown VARCHAR(100),
    created_at DATETIME DEFAULT NOW()
);

ALTER TABLE profiles
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id) REFERENCES users(id)
ON UPDATE CASCADE
ON DELETE RESTRICT;

DROP TABLE IF EXISTS messages;
CREATE TABLE messages(
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	created_at DATETIME DEFAULT NOW(),

	INDEX idx_from_user_id(from_user_id),
	INDEX idx_to_user_id(to_user_id),
	CONSTRAINT fk_from_user_id FOREIGN KEY (from_user_id) REFERENCES users(id),
	CONSTRAINT fk_to_user_id FOREIGN KEY (to_user_id) REFERENCES users(id)
);
