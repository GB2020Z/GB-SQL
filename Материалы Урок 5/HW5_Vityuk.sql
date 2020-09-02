/*������������ ������� ���� ���������� �������
1.*/
use users;
INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('��������', '1990-10-05', NOW(), NOW()),
  ('�������', '1984-11-12', NOW(), NOW()),
  ('���������', '1985-05-20', NOW(), NOW()),
  ('������', '1988-02-14', NOW(), NOW()),
  ('����', '1998-01-12', NOW(), NOW()),
  ('�����', '1992-08-29', NOW(), NOW());

 -- 2.
SELECT
  id,
  name,
  birthday_at,
  DATETIME(created_at) created_at,
  DATETIME(updated_at) updated_at
FROM
  users;

 -- 3. � ���������� �� �����
 use storehouses_products;
 select * from storehouses_products order by value
 where value > 0;
 
-- 4. 
use users;
select * from users where month = may or august;


-- 5. �� ����� ������� �������.
SELECT * FROM catalogs WHERE id IN (5,1,2);


/*������������ ������� ���� ���������� �������
 1. */

use users;
select AVG(birthday_at) FROM users;

-- 2.
SELECT count(*),
  dayofweek() (birthday_at) AS birthday_week
FROM
  users
GROUP BY
  birthday_week
ORDER BY
  birthday_week;

 -- 3.
 use table_name;
 SELECT SUM(value) FROM table_name;


