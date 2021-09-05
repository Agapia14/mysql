DROP DATABASE vk;
CREATE DATABASE vk;

SHOW DATABASES;


SELECT 1 FROM DUAL;
SELECT 1;
SELECT NOW();
SELECT current_timestamp();

USE vk;

-- DROP TABLE users;

SHOW TABLES;

CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки', 
	first_name VARCHAR(100) NOT NULL COMMENT 'Имя пользователя',
    last_name VARCHAR(100) NOT NULL COMMENT 'Фамилия пользователя',
    birthday DATE NOT NULL COMMENT 'Дата рождения',
    gender CHAR(1) NOT NULL COMMENT 'Пол',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email пользователя', 
    phone VARCHAR(11) NOT NULL UNIQUE COMMENT 'Номер телефона пользователя',    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время обновленния строки'
) COMMENT 'Таблица пользователей';

SELECT REGEXP_LIKE('+79991234567', '^\\+7[0-9]{10}$');

ALTER TABLE users MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP; 
ALTER TABLE users MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP; 
ALTER TABLE users MODIFY gender ENUM('M', 'F') NOT NULL COMMENT 'Пол'; 
ALTER TABLE users MODIFY phone VARCHAR(12) NOT NULL UNIQUE COMMENT 'Номер телефона пользователя'; 
-- ALTER TABLE users DROP CONSTRAINT сheck_phone;
ALTER TABLE users ADD CONSTRAINT сheck_phone CHECK (REGEXP_LIKE(phone, '^\\+7[0-9]{10}$')) ;

DESCRIBE users;

CREATE TABLE profiles (
    user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Идентификатор строки',
	city VARCHAR(100) COMMENT 'Город проживания',
    country VARCHAR(100) COMMENT 'Старана проживания',    
    `status` VARCHAR(10) COMMENT 'Текущий статус',
	created_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',    
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время обновленния строки'
) COMMENT "Таблица профилей";

ALTER TABLE profiles MODIFY `status` ENUM('Online', 'Offline', 'Inactive') NOT NULL; 

ALTER TABLE profiles ADD CONSTRAINT profiles_user_id FOREIGN KEY (user_id) REFERENCES users(id); 

-- DROP TABLE friendship;
CREATE TABLE friendship (
	user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на инициатора дружеских отношений',
    friend_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на получателя запроса о дружбе',
    request_type_id INT UNSIGNED NOT NULL COMMENT 'Тип запроса',
    requested_at DATETIME COMMENT 'Время отправки приглашения',
    confirmed_at DATETIME COMMENT 'Время подтверждения приглашения',
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',    
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время обновленния строки',
    PRIMARY KEY (user_id, friend_id) COMMENT 'Составной первичный ключ'
); 

ALTER TABLE friendship ADD CONSTRAINT friendship_user_id FOREIGN KEY (user_id) REFERENCES users(id); 
ALTER TABLE friendship ADD CONSTRAINT friendship_friend_id FOREIGN KEY (friend_id) REFERENCES users(id); 

-- ALTER TABLE friendship DROP COLUMN request_type;
-- ALTER TABLE friendship ADD COLUMN request_type_id  INT UNSIGNED NOT NULL COMMENT 'Тип запроса';

ALTER TABLE friendship MODIFY requested_at DATETIME NOT NULL COMMENT 'Время отправки приглашения'; 

DESCRIBE friendship;

CREATE TABLE friendship_request_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Типы запроса на дружбы";

ALTER TABLE friendship ADD CONSTRAINT friendship_request_type_id FOREIGN KEY (request_type_id) REFERENCES friendship_request_types(id); 

SHOW TABLES;
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сроки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название группы",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Группы";

CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL COMMENT "Ссылка на группу",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  PRIMARY KEY (community_id, user_id) COMMENT "Составной первичный ключ",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Участники групп, связь между пользователями и группами";

-- ALTER TABLE communities_users DROP CONSTRAINT communities_community_id;
-- ALTER TABLE communities_users ADD CONSTRAINT communities_community_id FOREIGN KEY (communities) REFERENCES community_id(id); 
ALTER TABLE communities_users ADD CONSTRAINT communities_user_id FOREIGN KEY (user_id) REFERENCES users(id); 

CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Сообщения";

ALTER TABLE messages ADD CONSTRAINT messages_from_user_id FOREIGN KEY (from_user_id) REFERENCES users(id); 
ALTER TABLE messages ADD CONSTRAINT messages_to_user_id FOREIGN KEY (to_user_id) REFERENCES users(id); 

-- DROP TABLE media;
CREATE TABLE media (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	filename VARCHAR(255) NOT NULL COMMENT "Полный путь к файлу",
    media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип файла",
    metadata JSON NOT NULL COMMENT "Метаданные файла (дополнительные параметры, переменного числа в вазисимости от типа файла)",
    user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
	created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Медиафайлы";

CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";

ALTER TABLE media ADD CONSTRAINT media_media_type_id FOREIGN KEY (media_type_id) REFERENCES media_types(id); 
ALTER TABLE media ADD CONSTRAINT media_user_id FOREIGN KEY (user_id) REFERENCES users(id); 

CREATE TABLE IF NOT EXISTS posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор поста",
  author_id INT UNSIGNED NOT NULL COMMENT "Ссылка на создателя поста",
  title VARCHAR(100) NOT NULL COMMENT "Заголовок поста",
  content TEXT NOT NULL COMMENT "Текст поста",  
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания поста",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления поста"
) COMMENT "Посты";

CREATE TABLE IF NOT EXISTS posts_likes (
  post_id INT UNSIGNED NOT NULL COMMENT "Идентификатор поста",
  from_user_id INT UNSIGNED NOT NULL COMMENT "Идентификатор пользователя, который поставил лайк",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время постановки лайка пользователем", 
  PRIMARY KEY (post_id, from_user_id) COMMENT "Составной первичный ключ"
) COMMENT "Лайки постов";

CREATE TABLE IF NOT EXISTS messages_likes (
  message_id INT UNSIGNED NOT NULL COMMENT "Идентификатор сообщения",
  from_user_id INT UNSIGNED NOT NULL COMMENT "Идентификатор пользователя, который поставил лайк",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время постановки лайка пользователем", 
  PRIMARY KEY (message_id, from_user_id) COMMENT "Составной первичный ключ"
) COMMENT "Лайки сообщений";

CREATE TABLE IF NOT EXISTS users_likes (
  to_user_id INT UNSIGNED NOT NULL COMMENT "Идентификатор пользователя, которому поставили лайк",
  from_user_id INT UNSIGNED NOT NULL COMMENT "Идентификатор пользователя, который поставил лайк",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время постановки лайка пользователем", 
  PRIMARY KEY (to_user_id, from_user_id) COMMENT "Составной первичный ключ"
) COMMENT "Лайки пользователей";



SHOW TABLES;
DESCRIBE users;

USE INFORMATION_SCHEMA;
SHOW TABLES;

USE vk;

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'vk';
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'INFORMATION_SCHEMA' AND TABLE_NAME LIKE '%CONSTR%';
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA = 'vk';
SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = 'vk';

SELECT * FROM users;
SELECT CONCAT('FOO', 'BAR');
SELECT CONCAT('+7', 9000000000 + FLOOR(999999999 * RAND()));

SELECT REGEXP_LIKE(CONCAT('+7', 9000000000 + FLOOR(999999999 * RAND())), '^\\+7[0-9]{10}$');

UPDATE users SET phone = CONCAT('+7', 9000000000 + FLOOR(999999999 * RAND())) WHERE id < 200;

SELECT * FROM users;

UPDATE users SET phone = CONCAT('17', 9000000000 + FLOOR(999999999 * RAND())) WHERE id < 200;

SELECT * FROM messages;

UPDATE messages SET
	from_user_id = FLOOR(1 + RAND() * 100),
    to_user_id = FLOOR(1 + RAND() * 100) 
     WHERE id < 200;
     
SELECT * FROM media;

DESC media;

SELECT * FROM media_types;
UPDATE media_types SET name = 'audio' WHERE id = 1;
UPDATE media_types SET name = 'image' WHERE id = 2;
UPDATE media_types SET name = 'video' WHERE id = 3;
UPDATE media_types SET name = 'gif' WHERE id = 4;
UPDATE media_types SET name = 'document' WHERE id = 5;

SELECT SUBSTR(MD5(RAND()), 1, 10);
SELECT CONCAT('https://www.some_server.com/some_directory/', SUBSTR(MD5(RAND()), 1, 10));
-- INSERT INTO media (filename, media_type_id, metadata, user_id) VALUE (
--	CONCAT('https://www.some_server.com/some_directory/', SUBSTR(MD5(RAND()), 1, 10)),
--    FLOOR(1 + RAND() * 5),
--    '{}',
--    FLOOR(1 + RAND() * 100)
-- );

SELECT CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "wav", "duration" : ', FLOOR(1 + RAND() * 100000), '}');
UPDATE media SET metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "wav", "duration" : ', FLOOR(1 + RAND() * 100000), '}')
WHERE media_type_id = 1;

SELECT metadata->"$.size" FROM media WHERE media_type_id = 1;
UPDATE media SET filename = CONCAT_WS('.', filename, metadata->"$.extension")
WHERE media_type_id = 1;
SELECT * FROM media WHERE media_type_id = 1;

SELECT * FROM media;
SELECT CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "png", "resolution" : "', CONCAT_WS('x', FLOOR(100 + RAND() * 1000), FLOOR(100 + RAND() * 1000)), '"}');
UPDATE media SET metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "png", "resolution" : "', CONCAT_WS('x', FLOOR(100 + RAND() * 1000), FLOOR(100 + RAND() * 1000)), '"}')
WHERE media_type_id = 2;

-- Смотрим все таблицы
USE vk;

SHOW TABLES;


-- Анализируем данные пользователей
SELECT * FROM users LIMIT 10;

-- Смотрим структуру таблицы пользователей
DESC users;

-- Приводим в порядок временные метки для users
 UPDATE users SET created_at = (SELECT created_at FROM messages WHERE users.id = messages.id),
                 updated_at = (SELECT updated_at FROM messages WHERE users.id = messages.id);

 UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;


-- Смотрим структуру профилей
DESC profiles;

-- Анализируем данные
SELECT * FROM profiles LIMIT 10;

-- Обновляем ссылки на фото:
 -- UPDATE profiles SET photo_id = FLOOR(1 + RAND() * 100);

-- Приводим в порядок временные метки для profiles
 UPDATE profiles SET created_at = (SELECT created_at FROM users WHERE profiles.user_id = users.id),
                    updated_at = (SELECT updated_at FROM users WHERE profiles.user_id = users.id);

 UPDATE profiles SET updated_at = NOW() WHERE updated_at < created_at;


-- Смотрим структуру таблицы сообщений
DESC messages;

-- Анализируем данные
SELECT * FROM messages LIMIT 10;

-- Приводим в порядок временные метки для messages
UPDATE messages SET updated_at = NOW() WHERE updated_at < created_at;


-- Анализируем типы медиаконтента
SELECT * FROM media_types;

-- Приводим в порядок временные метки для media_types
UPDATE media_types SET created_at = (SELECT created_at FROM messages WHERE media_types.id = messages.id),
                       updated_at = (SELECT updated_at FROM messages WHERE media_types.id = messages.id);

UPDATE media_types SET updated_at = NOW() WHERE updated_at < created_at;


-- Смотрим структуру таблицы медиаконтента 
DESC media;

-- Анализируем данные
SELECT * FROM media LIMIT 10;

-- Переименуем столбец пути к файлу 
ALTER TABLE media RENAME COLUMN filename TO filepath;

-- Обновляем данные для ссылки на тип и владельца
UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);
UPDATE media SET user_id = FLOOR(1 + RAND() * 100);

-- Создаём временную таблицу форматов медиафайлов
-- CREATE TEMPORARY TABLE extensions (name VARCHAR(10));

-- Заполняем значениями
INSERT INTO extensions VALUES ('jpg'), ('avi'), ('mkv'), ('png');

-- Проверяем
SELECT * FROM extensions;

-- Обновляем ссылку на файл
UPDATE media SET filepath = CONCAT(
  'https://gofile.io/',
  (SELECT last_name FROM users ORDER BY RAND() LIMIT 1),
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

-- Обновляем размер файлов
-- UPDATE media SET size = FLOOR(1000 + (RAND() * 100000)) WHERE size < 1000;

-- Заполняем метаданные
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');  

-- Возвращаем столбцу метеданных правильный тип
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- Приводим в порядок временные метки для medias
UPDATE media SET created_at = (SELECT created_at FROM messages WHERE media.id = messages.id),
                 updated_at = (SELECT updated_at FROM messages WHERE media.id = messages.id);

UPDATE media SET updated_at = NOW() WHERE updated_at < created_at;


-- Смотрим структуру таблицы дружбы
DESC friendship;

-- Анализируем данные
SELECT * FROM friendship;

-- Исправляем случай когда user_id = friend_id
UPDATE friendship SET friend_id = friend_id + 1 WHERE user_id = friend_id;


-- Приводим в порядок временные метки для friendship
UPDATE friendship SET requested_at = (SELECT created_at FROM messages WHERE friendship.user_id = messages.id),
                      confirmed_at = (SELECT updated_at FROM messages WHERE friendship.user_id  = messages.id);

UPDATE friendship SET created_at = (SELECT created_at FROM messages WHERE friendship.user_id = messages.id),
                      updated_at = (SELECT updated_at FROM messages WHERE friendship.user_id  = messages.id);

UPDATE friendship SET confirmed_at = NOW() WHERE confirmed_at < requested_at;
UPDATE friendship SET updated_at = NOW() WHERE updated_at < created_at;


-- Анализируем данные 
SELECT * FROM friendship_statuses;

-- Очищаем таблицу
TRUNCATE friendship_statuses;

-- Вставляем значения статусов дружбы
INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');

-- Обновляем ссылки на статус 
UPDATE friendship SET status_id = FLOOR(1 + RAND() * 3); 

-- Приводим в порядок временные метки для friendship_statuses            
UPDATE friendship_statuses SET created_at = (SELECT created_at FROM messages WHERE friendship_statuses.id = messages.id),
                               updated_at = (SELECT updated_at FROM messages WHERE friendship_statuses.id  = messages.id);

UPDATE friendship_statuses SET updated_at = NOW() WHERE updated_at < created_at;


-- Смотрим структуру таблицы групп
DESC communities;

-- Анализируем данные
SELECT * FROM communities;

-- Удаляем часть групп
DELETE FROM communities WHERE id > 20;

-- Приводим в порядок временные метки для communities            
UPDATE communities SET created_at = (SELECT created_at FROM messages WHERE communities.id = messages.id),
                       updated_at = (SELECT updated_at FROM messages WHERE communities.id = messages.id);

UPDATE communities SET updated_at = NOW() WHERE updated_at < created_at;


-- Анализируем таблицу связи пользователей и групп
SELECT * FROM communities_users;

-- Обновляем значения community_id
UPDATE communities_users SET community_id = FLOOR(1 + RAND() * 20);

-- Приводим в порядок временные метки для communities_users            
UPDATE communities_users SET created_at = (SELECT created_at FROM messages WHERE communities_users.user_id = messages.id);