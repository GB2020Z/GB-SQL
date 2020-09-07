/*���� �������� ��������
 * 1. ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.
 */
USE vk;

DROP TABLE IF EXISTS t_users;
CREATE TABLE t_users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) ) COMMENT = '������ ��� �������������';
 
DROP TABLE IF EXISTS t_orders;
CREATE TABLE t_orders(
id SERIAL PRIMARY KEY,
t_status VARCHAR(2) ) COMMENT = '0 - �� �������, 1 - �������';

SELECT
  id, name
FROM
  t_users
WHERE
  id = (SELECT id FROM t_orders WHERE t_status = 1);

/*2. �������� ������ ������� products � �������� catalogs, ������� ������������� ������.*/
 SELECT
  products.id, 
  products.name,
  (select catalogs.name 
	FROM
  		catalogs
	WHERE
  		catalog_id = products.catalog_id) as 'product_list'
  FROM products;
  