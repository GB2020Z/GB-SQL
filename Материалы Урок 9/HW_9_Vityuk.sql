/* 1.В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.*/

START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
COMMIT;

/* 2. Создайте представление, которое выводит название name товарной позиции из таблицы products и 
соответствующее название каталога name из таблицы catalogs.*/

CREATE VIEW prod AS
SELECT p.id
FROM products
UNION
SELECT cat.id
FROM catalogs;
