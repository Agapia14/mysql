DROP DATABASE vk;
CREATE DATABASE vk;

SHOW DATABASES;

USE vk;

CREATE TABLE users (
id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY, 
first_name VARCHAR (100) NOT NULL COMMENT 'Имя пользователей',
last_name VARCHAR (100) NOT NULL COMMENT 'Пол',
birthday DATE NOT NULL COMMENT 'Пол',
gender CHAR (1) NOT NULL COMMENT 'Пол',
email VARCHAR (100) NOT NULL UNIQUE COMMENT 'Email пользователя',  -- email+phone - натуральный ключ
phone VARCHAR (11) NOT NULL UNIQUE COMMENT 'Номер телефона пользователя',
created_at DATETIME COMMENT 'Дата и время создания строки',
updated_at DATETIME COMMENT 'Дата и время обновления строки'
) COMMENT 'Таблица пользователей';

CREATE TABLE profiles (
user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Идентификатор строки',
city VARCHAR (100) COMMENT 'Город проживания',
country VARCHAR (100) COMMENT 'Страна проживания',
`status` VARCHAR (10) COMMENT 'Текущий статус',
сreated_at DATETIME COMMENT 'Дата и время создания строки',
updated_at DATETIME COMMENT 'Дата и время обновления строки'
) COMMENT 'Таблица профилей' ;

ALTER TABLE profiles ADD CONSTRAINT profiles_user_id FOREIGN KEY (user_id) REFERENCES user(id);
CREATE TABLE friendship (
user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на инициатора дружеских отношений',
friend_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на получателя запроса о дружбе',
request_type VARCHAR(10) COMMENT 'Тип запроса',
requested_at DATETIME COMMENT 'Время отправки приглашения',
confirmed_at DATETIME COMMENT 'Время подтверждения приглашения',
created_at DATETIME COMMENT 'Дата и время создания строки',
updated_at DATETIME COMMENT 'Дата и время обновления строки',
PRIMARY KEY (user_id, friend_id) COMMENT 'Составной первичный ключ'
);
ALTER TABLE friendship ADD CONSTRAINT friendship_user_id FOREIGN KEY (user_id) REFERENCES user(id);
ALTER TABLE friendship ADD CONSTRAINT friendship_friend_id FOREIGN KEY (friend_id) REFERENCES user(id);

CREATE TABLE media_likes (
media_id INT (10) UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Идентификатор медиафайла',
likes INT (10) UNSIGNED COMMENT 'Количество лайков медиафайла'
);

CREATE TABLE post_likes (
post_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Идентификатор поста',
likes INT UNSIGNED COMMENT 'Количество лайков поста'
);

CREATE TABLE user_likes (
user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Идентификатор пользователя',
likes INT UNSIGNED COMMENT 'Количество лайков пользователя'
);


