-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.--
use vk;
SELECT
from_user_id, to_user_id,
COUNT(*) AS fr
FROM messages
WHERE
to_user_id = '10'
GROUP BY from_user_id;

SELECT
from_user_id, to_user_id,
COUNT(*) AS fr
FROM messages
WHERE
from_user_id in (
SELECT 
if (from_user_id = 10, to_user_id,from_user_id) as friend_id
FROM friend_requests
WHERE
 (from_user_id = 10 or to_user_id = 10))
GROUP BY from_user_id;
---Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

select count(*) as total from posts_likes 
where post_id in (
	select id from media where user_id in (
		select user_id from profiles 
		where TIMESTAMPDIFF(year, birthday, now()) < 10)
	);

---Определить кто больше поставил лайков (всего) - мужчины или женщины?

select 
	case
		(
		(select count(*) from posts_likes where user_id in (
			select user_id from profiles where gender = 'M')) >
		(select count(*) from posts_likes where user_id in (
			select user_id from profiles where gender = 'F'))
		)
		when 1 then 'male'
		when 0 then 'female'
	end as result;

