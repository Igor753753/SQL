/*����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.*/
CREATE DATABASE IF NOT EXISTS shop;
USE shop;

CREATE TABLE users (
  id SERIAL,
  name VARCHAR(255),
  birthday_at DATE,
  created_at DATETIME,
  updated_at DATETIME
);
INSERT INTO users (name, birthday_at) VALUES
  ('��������', '1990-10-05'),
  ('�������', '1984-11-12'),
  ('���������', '1985-05-20'),
  ('������', '1988-02-14'),
  ('����', '1998-01-12'),
  ('�����', '1992-08-29');
  UPDATE users
	SET created_at = NOW() AND updated_at = NOW();
/*������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10". ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
� ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. ������, ������� ������ ������ ���������� � �����, ����� ���� �������.*/
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL,
  name VARCHAR(255),
  birthday_at DATE,
  created_at VARCHAR(255) ,
  updated_at VARCHAR(255)
);
INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('��������', '1990-10-05', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('�������', '1984-11-12', '20.10.2017 9:10', '20.10.2017 9:10'),
  ('���������', '1985-05-20', '20.10.2017 10:10', '20.10.2017 10:10'),
  ('������', '1988-02-14', '20.10.2017 11:10', '20.10.2017 11:10'),
  ('����', '1998-01-12', '20.10.2017 12:10', '20.10.2017 8:10'),
  ('�����', '1992-08-29', '20.10.2017 13:10', '20.10.2017 13:10');
 UPDATE users
SET
created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');
ALTER TABLE users
CHANGE
created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users
CHANGE
updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
/*� ������� ��������� ������� storehouses_products � ���� value ����� �����������
 ����� ������ �����: 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������.
 ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value.
 ������, ������� ������ ������ ���������� � �����, ����� ���� �������*/
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
INSERT INTO storehouses_products (storehouse_id, product_id, value) VALUES
  (1, 1, 0),
  (2, 2, 120),
  (3, 3, 76),
  (4, 4, 199),
  (5, 5, 0),
  (6, 6, 73),
  (7, 7, 0),
  (8, 8, 78),
  (9, 9, 45),
  (10, 10, 0);
SELECT 
    value
FROM
    storehouses_products ORDER BY CASE WHEN value = 0 then 1 else 0 end, value;
   /*�� ������� users ���������� ������� �������������, ���������� � ������� � ���. ������ ������ � ���� ������ ���������� �������� ('may', 'august')*/
    SELECT * FROM users WHERE DATE_FORMAT(birthday_at,'%M') in ('may', 'august');
   --���--
   SELECT * FROM users WHERE birthday_at RLIKE '^[0-9]{4}-(05|08)-[0-9]{2}';
   /*�� ������� catalogs ����������� ������ ��� ������ �������. SELECT * FROM catalogs WHERE id IN (5, 1, 2); ������������ ������ � �������, �������� � ������ IN.*/
  CREATE TABLE catalogs (
  id SERIAL,
  name VARCHAR(255),
  UNIQUE unique_name(name(10))
);
INSERT INTO catalogs (id, name) VALUES
  (1, '����������'),
  (2, '����������� �����'),
  (5, '����������');  
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);
/*����������� ������� ������� ������������� � ������� users*/
SELECT AVG(age) FROM (SELECT Year(current_timestamp) - Year(birthday_at) as age FROM users) as result;
/*����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.*/
SELECT
    DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10))) AS week_day_of_birthday_in_this_Year,
    COUNT(*) AS amount_of_birthday
FROM
    users
GROUP BY 
    week_day_of_birthday_in_this_Year
ORDER BY
	amount_of_birthday DESC;
_--����������� ������������ ����� � ������� �������--
SELECT round(exp(sum(log(id))), 10) from users;
