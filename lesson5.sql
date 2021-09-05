/*Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.*/
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
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
  UPDATE users
	SET created_at = NOW() AND updated_at = NOW();
/*Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.*/
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL,
  name VARCHAR(255),
  birthday_at DATE,
  created_at VARCHAR(255) ,
  updated_at VARCHAR(255)
);
INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Наталья', '1984-11-12', '20.10.2017 9:10', '20.10.2017 9:10'),
  ('Александр', '1985-05-20', '20.10.2017 10:10', '20.10.2017 10:10'),
  ('Сергей', '1988-02-14', '20.10.2017 11:10', '20.10.2017 11:10'),
  ('Иван', '1998-01-12', '20.10.2017 12:10', '20.10.2017 8:10'),
  ('Мария', '1992-08-29', '20.10.2017 13:10', '20.10.2017 13:10');
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
/*В таблице складских запасов storehouses_products в поле value могут встречаться
 самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
 Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
 Однако, нулевые запасы должны выводиться в конце, после всех записей*/
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
   /*Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')*/
    SELECT * FROM users WHERE DATE_FORMAT(birthday_at,'%M') in ('may', 'august');
   --ИЛИ--
   SELECT * FROM users WHERE birthday_at RLIKE '^[0-9]{4}-(05|08)-[0-9]{2}';
   /*Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.*/
  CREATE TABLE catalogs (
  id SERIAL,
  name VARCHAR(255),
  UNIQUE unique_name(name(10))
);
INSERT INTO catalogs (id, name) VALUES
  (1, 'Процессоры'),
  (2, 'Материнские платы'),
  (5, 'Видеокарты');  
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);
/*Подсчитайте средний возраст пользователей в таблице users*/
SELECT AVG(age) FROM (SELECT Year(current_timestamp) - Year(birthday_at) as age FROM users) as result;
/*Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/
SELECT
    DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10))) AS week_day_of_birthday_in_this_Year,
    COUNT(*) AS amount_of_birthday
FROM
    users
GROUP BY 
    week_day_of_birthday_in_this_Year
ORDER BY
	amount_of_birthday DESC;
_--Подсчитайте произведение чисел в столбце таблицы--
SELECT round(exp(sum(log(id))), 10) from users;
