INSERT INTO users (firstname, lastname, email, phone)
VALUES ('Ivan', 'Ivanov', 'ivan@mail.com', '89213549561'),
('Stepan', 'Stepanov', 'stepan@mail.com', '89213549562'),
('Timur', 'Tomson', 'timur@mail.com', '89213549563'),
('Alex', 'Polev', 'polev@mail.com', '89213549565'),
('Svetlana', 'Petrova', 'svetlana@mail.com', '89213549567'),
('Olga', 'Gromova', 'olga@mail.com', '89213549568'),
('Vladimir', 'Purtov', 'vladimir@mail.com', '89213549565'),
('Sam', 'Serov', 'sam@mail.com', '89213549560'),
('Petr', 'Mohov', 'petr@mail.com', '89213549567'),
('Oksana', 'Morozova', 'm0rozova@mail.com', '89219549561');
INSERT INTO users (firstname, lastname, email, phone)
VALUES  ('Timur', 'Tomson', 'timur@mail.com', '89213549563'),
('Alex', 'Polev', 'polev@mail.com', '89213549565'),
('Svetlana', 'Petrova', 'svetlana@mail.com', '89213549567'),
('Olga', 'Gromova', 'olga@mail.com', '89213549568'),
('Vladimir', 'Purtov', 'vladimir@mail.com', '89213549565'),
('Sam', 'Serov', 'sam@mail.com', '89213549560'),
('Petr', 'Mohov', 'petr@mail.com', '89213549567'),
('Oksana', 'Morozova', 'm0rozova@mail.com', '89219549561');
SELECT * FROM users;
INSERT INTO communities(name,description)
VALUES ('boks','show fights'),
('boks','show fights'),
('mma','show fights'),
('cinema','movie screening'),
('fitness','workout'),
('construction','building tips'),
('match tv','sports channel'),
('match fighter','sports channel'),
('sports medicine','advice'),
('tourism','');
SELECT * FROM communities;
INSERT INTO communities_users(community_id,user_id,created_at )
VALUES ('1','1','2020-06-05 21:19:40'),
('2','45','2020-07-05 21:19:40'),
('3','55','2020-08-05 21:19:40'),
('4','56','2020-09-05 21:19:40'),
('5','57','2020-10-05 21:19:40'),
('6','58','2020-11-05 21:19:40'),
('7','69','2020-12-05 21:19:40'),
('8','70','2020-01-05 21:19:40'),
('9','71','2020-04-05 21:19:40'),
('10','72','2020-03-05 21:19:40');
SELECT * FROM communities_users;
INSERT INTO friend_requests(from_user_id,to_user_id,accepted)
VALUES ('58','70','1'),
('1','57','1'),
('55','45','1'),
('56','57','0'),
('57','58','1'),
('69','70','1'),
('70','71','0'),
('71','72','1'),
('72','69','1'),
('69','45','1');
INSERT INTO media_types(name)
VALUES ('magazines'),
('newspapers'),
('radio'),
('TV'),
('news agencies'),
('press service'),
('Internet'),
('Books'),
('Bulletins'),
('Compilations');
INSERT INTO media(user_id,media_types_id,file_name,file_size,created_at)
VALUES ('1','1','NULL','1056','2015-04-03 04:23:03'),
('69','2','NULL','1123','2015-04-03 04:23:03'),
('55','3','NULL','1234','2016-04-03 04:23:03'),
('56','4','NULL','6745','2017-04-03 04:23:03'),
('45','5','NULL','9876','2018-04-03 04:23:03'),
('57','6','NULL','3456','2019-04-03 04:23:03'),
('58','7','NULL','1345','2013-04-03 04:23:03'),
('69','8','NULL','8790','2015-08-15 04:23:03'),
('70','9','NULL','4123','2015-11-09 04:23:03'),
('71','10','NULL','9745','2020-04-03 04:23:03');
INSERT INTO messages(from_user_id,to_user_id,txt,is_delivered,created_at,updated_at)
VALUES ('1','45','hello','1','2015-04-03 04:23:03','2015-04-03 04:24:03'),
('45','55','hello','1','2016-04-03 04:23:03','2016-04-03 04:24:03'),
('55','57','hello','1','2017-04-03 04:23:03','2017-04-03 04:24:03'),
('57','45','hello','1','2011-04-03 04:23:03','2011-04-03 04:24:03'),
('58','57','hello','1','2014-04-03 04:23:03','2014-04-03 04:24:03'),
('69','70','hello','1','2017-04-03 04:23:03','2017-04-03 04:24:03'),
('70','1','hello','1','2018-04-03 04:23:03','2018-04-03 04:24:03'),
('71','58','hello','1','2019-04-03 04:23:03','2019-04-03 04:24:03'),
('71','45','hello','1','2013-04-03 04:23:03','2013-04-03 04:24:03'),
('45','70','hello','1','2020-04-03 04:23:03','2020-04-03 04:24:03');
INSERT INTO profiles(user_id,gender,birthday,photo_id,city,country)
VALUES ('56','M','1993-09-21 ','1','Moscow','Russia'),
('57','f','1999-06-08 ','2','Saint Petersburg','Russia'),
('58','f','1997-11-23 ','3','Moscow','Russia'),
('69','M','1991-04-15 ','4','Moscow','Russia'),
('72','f','2001-12-03 ','5','Moscow','Russia'),
('74','M','1999-01-03 ','6','Saint Petersburg','Russia'),
('78','M','1997-11-17 ','7','Saint Petersburg','Russia'),
('119','M','1986-04-03 ','8','Saint Petersburg','Russia'),
('120','M','1993-11-03 ','9','Saint Petersburg','Russia'),
('133','f','1999-09-11 ','10','Saint Petersburg','Russia');
SELECT * FROM users;
------Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке

SELECT DISTINCT firstname FROM users ORDER BY firstname;
-------Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)
ALTER TABLE profiles
ADD is_active BIT DEFAULT false NULL;
UPDATE profiles
SET
	is_active = false
WHERE (YEAR(CURRENT_DATE) - YEAR(birthday)) < 18;
SELECT birthday FROM profiles
WHERE (YEAR(CURRENT_DATE) - YEAR(birthday)) < 18;
-----Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)
SELECT * FROM messages;
DELETE FROM messages
WHERE created_at < CURRENT_TIMESTAMP();

