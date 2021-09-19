SELECT NOW() FROM DUAL;
SELECT NOW();

USE vk;

SELECT * FROM vk.users;
SELECT * FROM vk.users WHERE id = 1;

SELECT * FROM vk.friendship;
SELECT * FROM vk.friendship WHERE user_id = 1;
SELECT FLOOR(2 + RAND() * 99);
UPDATE vk.friendship SET friend_id = FLOOR(2 + RAND() * 99) WHERE user_id = 1;
UPDATE vk.friendship SET user_id = 1 WHERE user_id < 20;

SHOW tables;
SELECT * FROM friendship_request_types;

UPDATE friendship_request_types SET name = 'friendship' WHERE id = 1;
UPDATE friendship_request_types SET name = 'subscribtion' WHERE id = 2;
UPDATE friendship_request_types SET name = 'block' WHERE id = 3;

DESC friendship;
SELECT * FROM vk.friendship WHERE user_id = 1 AND request_type_id = 1; -- 7
SELECT * FROM vk.friendship WHERE user_id = 1 AND request_type_id = 2; 

SELECT * FROM friendship WHERE user_id = 2 OR user_id = 5;
SELECT * FROM friendship WHERE user_id IN (2, 5, 8, 11, 14, 17);

INSERT INTO friendship (user_id, friend_id, request_type_id, requested_at) VALUES (2, 1, 1, NOW());
INSERT INTO friendship (user_id, friend_id, request_type_id, requested_at) VALUES (5, 1, 1, NOW());

INSERT INTO friendship (user_id, friend_id, request_type_id, requested_at) VALUES (2, 1, 1, NOW()), (5, 1, 1, NOW()), (8, 1, 1, NOW());
INSERT INTO friendship (user_id, friend_id, request_type_id, requested_at) VALUES (11, 1, 2, NOW()), (14, 1, 2, NOW()), (17, 1, 2, NOW());

SELECT * FROM vk.friendship WHERE friend_id = 1; 
/* A ->> B +

A -> B
B -> A */

-- Âñåõ äðóçåé ïîëüç. 1
SELECT * FROM friendship WHERE user_id = 1 AND request_type_id = 1; -- çàïðîñû íà äðóæáó îò 1
SELECT * FROM friendship WHERE friend_id = 1 AND request_type_id = 1; -- çàïðîñû íà äðóæáó ê 1 îò N

SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 1; -- çàïðîñû íà äðóæáó îò 1
SELECT friend_id AS from_user_id, user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 1;-- çàïðîñû íà äðóæáó ê 1 îò N
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 1
UNION
SELECT friend_id AS from_user_id, user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 1;

DELETE FROM friendship WHERE user_id = 1 AND friend_id IN (2, 5, 8);
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 2; -- çàïðîñû íà ïîäïèñêó îò 1
SELECT friend_id AS from_user_id, user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 2;-- çàïðîñû íà ïîäïèñêó ê 1 îò N

SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 2
UNION
SELECT friend_id AS from_user_id, user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 2;

SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 2
UNION ALL
SELECT friend_id AS from_user_id, user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 2;

-- âñå äðóçüÿ 1
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 1
UNION
SELECT friend_id AS from_user_id, user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 1
UNION
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 2
UNION
SELECT friend_id AS from_user_id, user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 2;

SELECT * FROM messages;
SELECT * FROM messages ORDER BY from_user_id;
SELECT * FROM messages ORDER BY from_user_id DESC;

SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 1
UNION
SELECT friend_id AS from_user_id, user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 1
UNION
SELECT user_id AS from_user_id, friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 2
UNION
SELECT friend_id AS from_user_id, user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 2
ORDER BY to_users_id;

-- Ãðóïïèðîâêà
SELECT * FROM messages WHERE from_user_id = 86;

SELECT * FROM media;
SELECT media_type_id, COUNT(id) FROM media GROUP BY media_type_id ORDER BY media_type_id desc;

-- SELECT 
-- FROM 
-- WHERE 
-- GROUP BY 
-- ORDER BY

-- Ïðè ãðóïïèðîâêå âû ìîæåòå âûáðàòü òîëüêî àãðåãàòû èëè ïîëÿ, ïî êîòîðûì âûïîëíÿåòñÿ ãðóïïèðîâêà

-- Ïîäçàïðîñà



SELECT * FROM information_schema.`COLUMNS` WHERE TABLE_SCHEMA = 'vk' AND TABLE_NAME = 'users';
SELECT * FROM users;



-- Ïîäçàïðîñ
SELECT * FROM profiles WHERE user_id = 1;
SELECT * FROM profiles WHERE user_id = 1 OR user_id = 2;
SELECT * FROM profiles WHERE user_id IN (1, 2);

SELECT friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 1
UNION
SELECT user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 1
UNION
SELECT friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 2
UNION
SELECT user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 2;

SELECT id, first_name, last_name FROM users WHERE id IN (
	SELECT friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 1
	UNION
	SELECT user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 1
	UNION
	SELECT friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 2
	UNION
	SELECT user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 2
);

-- ÑTE (èìåíîâàííûé ïîäçàïðîñ)

WITH friends AS (
	SELECT friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 1
	UNION
	SELECT user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 1
	UNION
	SELECT friend_id AS to_users_id FROM friendship WHERE user_id = 1 AND request_type_id = 2
	UNION
	SELECT user_id AS to_users_id FROM friendship WHERE friend_id = 1 AND request_type_id = 2
)
SELECT * FROM friends;

WITH friends AS (
	SELECT
		friend_id AS to_users_id
	FROM
		friendship
	WHERE
		user_id = 1
		AND request_type_id = 1
		
	UNION
	SELECT
		user_id AS to_users_id
	FROM
		friendship
	WHERE
		friend_id = 1
		AND request_type_id = 1
		
	UNION
	SELECT
		friend_id AS to_users_id
	FROM
		friendship
	WHERE
		user_id = 1
		AND request_type_id = 2
		
	UNION
	SELECT
		user_id AS to_users_id
	FROM
		friendship
	WHERE
		friend_id = 1
		AND request_type_id = 2 
)
SELECT
	id,
	first_name,
	last_name
FROM
	users
WHERE
	id IN (
	 SELECT to_users_id FROM friends 
	);

 
  -- ДЗ к 8 уроку
  
-- 3.Определим кто больше поставил лайков (всего)- мужчины или женщины:

SELECT p.gender, COUNT(l.user_id) AS total
  FROM profiles AS p
    INNER JOIN likes AS l
  ON p.user_id = l.user_id
  GROUP BY p.gender
  ORDER BY total DESC LIMIT 1;

-- 2.Подсчитать количество лайков, которые получили десять самых молодых пользователей:

SELECT SUM(total_likes) total FROM
  (SELECT COUNT(l.target_id) AS total_likes
    FROM profiles AS p
      LEFT JOIN likes AS l
        ON p.user_id = l.target_id AND l.target_type_id = 2
    GROUP BY p.user_id
    ORDER BY p.birthday 
    DESC LIMIT 10) as user_likes;

-- 1.Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети (наименьшее количество лайков и исходящих сообщений):
SELECT
  users.id,
  CONCAT(first_name, ' ', last_name) AS user,
  (COALESCE(likes_count, 0) + COALESCE(message_count, 0)) AS overall_activity
FROM users
LEFT JOIN (
  SELECT user_id, COUNT(*) AS likes_count
  FROM likes
  GROUP BY user_id
) likes_counts ON likes_counts.user_id = users.id
LEFT JOIN (
  SELECT from_user_id, COUNT(*) AS message_count
  FROM messages
  GROUP BY from_user_id
) message_counts ON message_counts.from_user_id = users.id
GROUP BY users.id
ORDER BY overall_activity
LIMIT 10;
