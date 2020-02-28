USE shop;

/* Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products
   в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и
   содержимое поля name.
 */

DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs`(
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME DEFAULT NOW(),
    table_name VARCHAR(20),
    id_original BIGINT UNSIGNED,
    name_original VARCHAR(255)
) ENGINE=ARCHIVE;

DELIMITER //
DROP TRIGGER IF EXISTS logs_users_insert//
CREATE TRIGGER logs_users_insert AFTER INSERT ON users
    FOR EACH ROW
    BEGIN
        INSERT INTO `logs` (table_name, id_original, name_original)
        VALUES
               ('users', NEW.id, NEW.name);
    END//

DROP TRIGGER IF EXISTS logs_users_update//
CREATE TRIGGER logs_users_update AFTER UPDATE ON users
    FOR EACH ROW
    BEGIN
        INSERT INTO `logs` (table_name, id_original, name_original)
        VALUES
               ('users', NEW.id, NEW.name);
    END//

DROP TRIGGER IF EXISTS logs_catalogs_insert//
CREATE TRIGGER logs_catalogs_insert AFTER INSERT ON catalogs
    FOR EACH ROW
    BEGIN
        INSERT INTO `logs` (table_name, id_original, name_original)
        VALUES
               ('catalogs', NEW.id, NEW.name);
    END//

DROP TRIGGER IF EXISTS logs_catalogs_update//
CREATE TRIGGER logs_catalogs_update AFTER UPDATE ON catalogs
    FOR EACH ROW
    BEGIN
        INSERT INTO `logs` (table_name, id_original, name_original)
        VALUES
               ('catalogs', NEW.id, NEW.name);
    END//

DROP TRIGGER IF EXISTS logs_products_insert//
CREATE TRIGGER logs_products_insert AFTER INSERT ON products
    FOR EACH ROW
    BEGIN
        INSERT INTO `logs` (table_name, id_original, name_original)
        VALUES
               ('products', NEW.id, NEW.name);
    END//

DROP TRIGGER IF EXISTS logs_products_update//
CREATE TRIGGER logs_products_update AFTER UPDATE ON products
    FOR EACH ROW
    BEGIN
        INSERT INTO `logs` (table_name, id_original, name_original)
        VALUES
               ('products', NEW.id, NEW.name);
    END//
DELIMITER ;

INSERT INTO catalogs (name) VALUES ('new catalog');
