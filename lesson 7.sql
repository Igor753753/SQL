use shop;
----Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
SELECT * FROM orders;
SELECT * FROM users;
SELECT * FROM orders_products;
---в таблице order id BIGINT UNSIGNED ,изменим и user_id на BIGINT UNSIGNED--
ALTER TABLE
 orders 
CHANGE COLUMN
 user_id user_id BIGINT UNSIGNED NOT NULL;
---созданим внешние ключи ---
 
ALTER TABLE
 	orders_products 
 CHANGE COLUMN
 	order_id order_id BIGINT UNSIGNED NOT NULL;
 ALTER TABLE
 	orders_products 
 CHANGE COLUMN
	product_id product_id BIGINT UNSIGNED NOT NULL;
 ALTER TABLE
 	orders_products
 ADD CONSTRAINT fk_order_id
 	FOREIGN KEY(order_id)
	REFERENCES orders(id)
	ON DELETE RESTRICT 
	ON UPDATE RESTRICT;	
UPDATE orders
	SET created_at = NOW()
	WHERE created_at is NULL;	
UPDATE orders
 	SET updated_at = NOW()
 	WHERE created_at is NULL;	
ALTER TABLE
 	orders_products
ADD CONSTRAINT fk_order_product_id
 	FOREIGN KEY(product_id)
	REFERENCES products(id)
	ON DELETE RESTRICT 
 	ON UPDATE RESTRICT; 	
 
 INSERT INTO orders(user_id)
 VALUES (15); -- check == true
 INSERT INTO
	orders(user_id)
 values
    (1), -- Геннадий
	(2), -- Наталья
 	(5), -- Иван
 	(6); -- Мария
 INSERT INTO
	orders_products(order_id, product_id)
 VALUES
 	(1, 1),
 	(1, 1); -- check == true	
 -- товары заказанные Геннадий
 INSERT INTO
 	orders_products(order_id, product_id)
 VALUES
	(1, 1),
 	(1, 2);	
 -- товары заказанные  Наталья
 INSERT INTO
 	orders_products(order_id, product_id)
 VALUES
 	(2, 1),
 	(2, 2);	
-- товары заказанные  Иван
 INSERT INTO
 	orders_products(order_id, product_id)
 VALUES
 	(3, 1),
 	(3, 2),
    (3, 3);
--товары заказанные Мария
 INSERT INTO
	orders_products(order_id, product_id, total)
VALUES
	(4, 1, 1),
 	(4, 2, 2),
 	(4, 3, 2);	
 SELECT 
	u.id AS user_id, u.name,
	o.id AS order_id
FROM 
	users AS u
RIGHT JOIN
	orders AS o 
ON
	u.id = o.user_id;	
-----Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT * FROM products ;
SELECT * FROM catalogs ;
SELECT 
	pr.id, pr.name, pr.price,
	ct.id AS prct_id,
	ct.name AS catalog
FROM
	products AS pr
JOIN
	catalogs AS ct
ON 
	pr.catalog_id = ct.id; 
--Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
CREATE TABLE  flights(
 	id SERIAL PRIMARY KEY,
 	`from` VARCHAR(30) NOT NULL COMMENT 'en', 
 	`to` VARCHAR(30) NOT NULL COMMENT 'en'
);
CREATE TABLE   cities(
 	label VARCHAR(30) PRIMARY KEY COMMENT 'en', 
	name VARCHAR(30) COMMENT 'ru'
 );
 ALTER TABLE flights
 ADD CONSTRAINT fk_from_label
 FOREIGN KEY(`from`)
 REFERENCES cities(label);
 ALTER TABLE flights
 ADD CONSTRAINT fk_to_label
 FOREIGN KEY(`to`)
 REFERENCES cities(label);  
 INSERT INTO cities VALUES
 	('Saint Petersburg', 'Санкт-Петербург'),
	('Adler', 'Адлер'),
	('Vorkuta', 'Воркута'),
	('Khabarovsk', 'Хабаровск');
 	
INSERT INTO flights VALUES
	(NULL, 'Adler', 'Khabarovsk'),
	(NULL, 'Khabarovsk', 'Vorkuta'),
 	(NULL, 'Vorkuta', 'Saint Petersburg'),
	(NULL, 'Saint Petersburg', 'Adler');
SELECT
	id AS fl_id,
	(SELECT name FROM cities WHERE label = `from`) AS `from`,
	(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM
	flights
ORDER BY
	fl_id;