use shop;
-- 1. � ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. 
-- ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.
use sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��� ����������',
  birthday_at DATE COMMENT '���� ��������',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '����������';
INSERT INTO users VALUES
  (DEFAULT, 'sample user', '2001-11-01', DEFAULT, DEFAULT);
 DELETE FROM shop.users WHERE id = 1;
 START TRANSACTION;
INSERT INTO sample.users (SELECT * FROM shop.users WHERE shop.users.id = 1);
COMMIT;
---2 ������
START TRANSACTION;
INSERT INTO sample.users (name, birthday_at) 
SELECT shop.users.name, shop.users.birthday_at 
FROM shop.users 
WHERE (id = 1);
COMMIT;
SELECT * FROM shop.users;
SELECT * FROM sample.users;
-----�������� �������������, ������� ������� �������� name �������� ������� �� ������� products � ��������������� �������� �������� name �� ������� catalogs.
use shop;
SELECT * FROM products ;
SELECT * from catalogs;
CREATE OR REPLACE VIEW v AS 
  SELECT products.name AS p_name, catalogs.name AS c_name 
    FROM products,catalogs 
      WHERE products.catalog_id = catalogs.id;
--------  (�� �������) ����� ������� ������� � ����������� ����� created_at. 
-- � ��� ��������� ���������� ����������� ������ �� ������ 2018 ���� '2018-08-01', '2016-08-04', '2018-08-16' � 2018-08-17. 
-- ��������� ������, ������� ������� ������ ������ ��� �� ������, ��������� � �������� ���� �������� 1, 
-- ���� ���� ������������ � �������� ������� � 0, ���� ��� �����������.
use shop;
CREATE TABLE task (
  id SERIAL PRIMARY KEY,
  created_at date);
INSERT INTO task
values (NULL, '2018-08-01'), (NULL, '2018-08-04'), (NULL, '2018-08-16'), (NULL, '2018-08-17'); 
CREATE TEMPORARY TABLE days_aug (days int);
INSERT INTO days_aug VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), 
							(11), (12),(13),(14), (15), (16), (17), (18), (19), (20),
                            (21), (22), (23), (24), (25), (26), (27), (28), (29), (30), (31);
SET @start_aug = '2018-07-31';

SELECT @start_aug + interval days day AS date_aug,
	   CASE WHEN task.created_at is NULL THEN 0 ELSE 1 END AS v1 FROM days_aug
LEFT JOIN task ON @start_aug + interval days day = task.created_at
ORDER BY date_aug;
------(�� �������) ����� ������� ����� ������� � ����������� ����� created_at. �������� ������, ������� ������� ���������� ������ �� �������, �������� ������ 5 ����� ������ �������.
use shop;
SELECT * FROM products ;
PREPARE prod from "DELETE FROM products ORDER BY created_at LIMIT ?";
SET @lim := (SELECT COUNT(*) -5 FROM products);
EXECUTE prod USING @lim;
CREATE TABLE IF NOT EXISTS test1 (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  created_at date NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO test1 VALUES
(1, '������ ������', '2019-11-01'),
(2, '������ ������', '2019-11-02'),
(3, '������ ������', '2019-11-03'),
(4, '��������� ������', '2019-11-04'),
(5, '����� ������', '2019-11-05'),
(6, '������ ������', '2019-11-06');
SELECT * FROM test1 ;
PREPARE del_test1 from "DELETE FROM test1 ORDER BY created_at LIMIT ?";
SET @lim := (SELECT COUNT(*) -5 FROM test1);
EXECUTE del_test1 USING @lim;
----�������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����. � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".
DELIMITER //

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello() RETURNS TEXT DETERMINISTIC
BEGIN
  RETURN CASE
      WHEN "06:00" <= CURTIME() AND CURTIME() < "12:00" THEN "������ ����"
      WHEN "12:00" <= CURTIME() AND CURTIME() < "18:00" THEN "������ ����"
      WHEN "18:00" <= CURTIME() AND CURTIME() < "00:00" THEN "������ �����"
      ELSE "������ ����"
    END;
END //
-------� ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. ��������� ����������� ����� ����� ��� ���� �� ���. ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������. ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������. ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.
DELIMITER //

CREATE DEFINER=`root`@`localhost` TRIGGER `products_BEFORE_INSERT` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
	if isnull(new.`name`) + isnull(new.`description`) !=1 then
		signal sqlstate '45000'
        set message_text = 'need insert some valut';
	
	END if;
END;
END //
----(�� �������) �������� �������� ������� ��� ���������� ������������� ����� ���������. ������� ��������� ���������� ������������������ � ������� ����� ����� ����� ���� ���������� �����. ����� ������� FIBONACCI(10) ������ ���������� ����� 55.
DELIMITER //
CREATE  FIBONACCI(n INT)
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE p1 INT DEFAULT 1;
    DECLARE p2 INT DEFAULT 1;
    DECLARE i INT DEFAULT 2;
    DECLARE res INT DEFAULT 0;
   
    IF (n <= 1) THEN RETURN n;
    ELSEIF (n = 2) THEN RETURN 1;
    END IF;  
    WHILE i < n DO
        SET i = i + 1;
	SET res = p2 + p1;
        SET p2 = p1;
        SET p1 = res;
    END WHILE;
    RETURN res;
    END;
END //