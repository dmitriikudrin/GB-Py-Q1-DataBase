DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
    id SERIAL PRIMARY KEY, -- BIGINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT
    firstname VARCHAR(50),
    lastname VARCHAR(50),
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

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests(
    initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'unfriended', 'declined'),
    requested_at DATETIME DEFAULT NOW(),
    confirmed_at DATETIME,

    PRIMARY KEY (initiator_user_id, target_user_id),
    INDEX idx_initiator_user_id(initiator_user_id),
    INDEX idx_target_user_id(target_user_id),
    CONSTRAINT fk_initiator_user_id FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    CONSTRAINT fk_target_user_id FOREIGN KEY (target_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS communites;
CREATE TABLE communities(
    id SERIAL PRIMARY KEY,
    name VARCHAR(150),

    INDEX idx_communities_name(name)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
    user_id BIGINT UNSIGNED NOT NULL,
    community_id BIGINT UNSIGNED NOT NULL,

    PRIMARY KEY (user_id, community_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
    id SERIAL PRIMARY KEY,
    name VARCHAR(150)
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
    id SERIAL PRIMARY KEY,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    filename VARCHAR(225),
    `size` INT,
    metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX (user_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
    id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS photo_albums;
CREATE TABLE photo_albums(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) DEFAULT NULL,
    user_id BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS photos;
CREATE TABLE photos(
    id SERIAL PRIMARY KEY,
    album_id BIGINT UNSIGNED,
    media_id BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);
