USE vk;

-- Таблица для хранения видео на странице
DROP TABLE IF EXISTS video;
CREATE TABLE video(
    id SERIAL PRIMARY KEY,              -- id видео
    user_id BIGINT UNSIGNED NOT NULL,   -- id владельца видео
    filename VARCHAR(225) NOT NULL,     -- имя видео
    file_description VARCHAR(1000),     -- описание видео
    video_file MEDIUMBLOB NOT NULL,     -- файл с видео. Не совсем уверен, что надо использовать этот тип данных
    created_at DATETIME DEFAULT NOW(),  -- время создания файла

    INDEX idx_filename(filename),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

/* Таблица для хранения информации, кто из пользователей добавил себе на страницу
   видео, выложенное другим пользователем
 */
DROP TABLE IF EXISTS video_add;
CREATE TABLE video_add(
    video_id BIGINT UNSIGNED NOT NULL,  -- id видео
    user_id BIGINT UNSIGNED NOT NULL,   -- id владельца видео
    added_at DATETIME DEFAULT NOW(),    -- время добавления файла

    FOREIGN KEY (video_id) REFERENCES video(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Таблица для хранения музыки
DROP TABLE IF EXISTS music;
CREATE TABLE music(
    id SERIAL PRIMARY KEY,              -- id трека
    user_id BIGINT UNSIGNED NOT NULL,   -- id пользователя, выложившего трек
    title VARCHAR(120) NOT NULL,        -- название трека
    singer VARCHAR(120) NOT NULL,       -- имя исполнителя
    album VARCHAR(120),                 -- название альбома
    year INT(4) UNSIGNED,               -- год релиза
    genre VARCHAR(120),                 -- жанр
    music_file BLOB NOT NULL,           -- файл с треком. Не совсем уверен, что надо использовать этот тип данных

    INDEX idx_title(title),
    INDEX idx_signer(singer),
    INDEX idx_album(album),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
