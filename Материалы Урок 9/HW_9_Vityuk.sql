/* 1.� ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. 
����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.*/

START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
COMMIT;

/* 2. �������� �������������, ������� ������� �������� name �������� ������� �� ������� products � 
��������������� �������� �������� name �� ������� catalogs.*/

CREATE VIEW prod AS
SELECT p.id
FROM products
UNION
SELECT cat.id
FROM catalogs;
