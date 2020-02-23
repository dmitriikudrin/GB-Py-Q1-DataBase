/* Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
   С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу
   "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
 */


DROP FUNCTION IF EXISTS hello;
CREATE FUNCTION hello()
RETURNS VARCHAR(14) NOT DETERMINISTIC
BEGIN
    IF (CURRENT_TIME() BETWEEN TIME('6:00:00') and TIME('12:00:00')) THEN
        RETURN 'Good morning';
    ELSEIF (CURRENT_TIME() BETWEEN TIME('12:00:00') and TIME('18:00:00')) THEN
        RETURN 'Good afternoon';
    ELSEIF (CURRENT_TIME() BETWEEN TIME('18:00:00') and TIME('0:00:00')) THEN
        RETURN 'Good evening';
    ELSE
        RETURN 'Good night';
    END IF;
END;

SELECT hello();


/* В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо
   присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
   Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям
   NULL-значение необходимо отменить операцию.
 */

USE shop;

CREATE TRIGGER products_null BEFORE INSERT ON products
    FOR EACH ROW
    BEGIN
        IF (NEW.name IS NULL AND NEW.description IS NULL) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Operation canceled';
        END IF;
    END;

INSERT INTO products (id, price)
VALUES (100, 100);

