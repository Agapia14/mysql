-- Требования к курсовому проекту
-- 1. Составить общее текстовое описание БД и решаемых ею задач;
-- 2. минимальное количество таблиц - 10;
-- 3. скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами);
-- 4. создать ERDiagram для БД;
--  5. скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);
-- 6. представления (минимум 2);
-- 7. хранимые процедуры / триггеры;
-- Суть проекта LS упрощенная модель хранения данных сервиса IMDb с добавлением элементов социальной сети и акцентом на составление списков.
-- Всё начинается с самых простых, редко изменяющихся данных: список стран, кинокомпаний, жанров, всевозможных профессий/позиций в производственном процессе и список типов экранных сущностей (так как это могут не только фильмы, но и, например, сериалы, в базе они называются абстрактно titles).
-- TITLES
-- Ключевые характеристики:
 -- Название
 -- Оригинальное название (необязательно)
-- -------------Дополнительные характеристики:
-- Тип (фильм, сериал, анимация, короткометражка и тд)
-- Постер
-- Теглайн
-- Синопсис
-- Дата выхода
-- Возрастное ограничение
-- Состав съемочной группы
-- Компания-производитель (может быть несколько)
-- Страна (может быть несколько)
-- Жанр (может быть несколько)

-- USER
-- Главная движущая сила сервиса – это, естественно, пользователи Их **регистрационные данные** (таблица users):
-- Username
-- Email
-- Номер телефона
-- Пароль
-- Дополнительная информация, которую пользователь может предоставить, заполнив свой **профиль**:
-- Аватар
-- Имя
-- Фамилия
-- Дата рождения
-- Страна
-- О себе
-- Приватность аккаунта

-- ПОЛЬЗОВАТЕЛИ МОГУТ:
-- **Действия с другими пользователями:**
  -- Подписываться друг на друга
  -- Переписываться друг с другом

-- **Действия со списками:**
  -- Добавлять фильмы в список «Буду смотреть»
  -- Отправлять фильмы в список «Просмотрено»
  -- Создавать свои собственные списки фильмов (например, сохраняя свои поисковые запросы: «хочу все китайские дорамы про вампиров, вышедшие после 2000» или совсем просто – «мои любимые сериалы отобранные мной вручную»)
  -- Подписываться на списки других пользователей
  -- Подписываться на конкретный жанр (чтобы получать уведомления о выходе нового триллера, например)
  -- Подписываться на ключевые слова – это что-то вроде меток (хочу узнавать, когда чему-то поставят метку «лакорн»)

-- **Выражать свое мнение:**
  -- Выставлять фильму рейтинг
  -- Писать отзывы на фильмы
  -- Лайкать/дизлайкать отзывы других пользователей
  -- Лайкать/дизлайкать указанный жанр фильма (ведь часто бывает, что заявленный, например, триллер в фильме так и не наступает)
  -- Предлагать свой вариант жанра (из списка существующих)
  -- Проставлять фильму ключевые слова/метки (новые или из списка уже добавленных),
  -- Лайкать/дизлайкать метки, поставленные другими пользователями

-- Лайки/дизлайки позволяют вычислять в списках фильмов те, которые по мнению пользователей наиболее ярко выражают жанр или тему (по метке). В сочетании с возможностями разных подписок такое выражение мнения сильно облегчает подбор рекомендаций для конкретного пользователя и подбор похожих фильмов.
DROP DATABASE IF EXISTS LS;
CREATE DATABASE LS;
USE LS;
-- ----------------------------------- GENERAL INFO
DROP TABLE IF EXISTS companies;
CREATE TABLE companies (
	id SERIAL PRIMARY KEY,
	company VARCHAR(200) UNIQUE NOT NULL
);
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
	id SERIAL PRIMARY KEY,
	country VARCHAR(200) UNIQUE NOT NULL
);
DROP TABLE IF EXISTS genres;
CREATE TABLE genres (
	id SERIAL PRIMARY KEY,
	genre VARCHAR(200) UNIQUE NOT NULL
);
DROP TABLE IF EXISTS images;
CREATE TABLE images (
	id SERIAL PRIMARY KEY,
	filename VARCHAR(200) NOT NULL,
	path VARCHAR(200) NOT NULL
);
DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
	id SERIAL PRIMARY KEY,
	role VARCHAR(200) UNIQUE NOT NULL
);
DROP TABLE IF EXISTS title_types;
CREATE TABLE title_types (
	id SERIAL PRIMARY KEY,
	title_type VARCHAR(200) UNIQUE NOT NULL
);

-- ----------------------------------- USERS
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	signed_up_at TIMESTAMP DEFAULT now(),
	username VARCHAR(50) UNIQUE,
	email VARCHAR(100) UNIQUE,
	phone_number BIGINT UNSIGNED UNIQUE,
	password_hash VARCHAR(100)
);
DROP TABLE IF EXISTS user_profiles;
CREATE TABLE user_profiles (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED,
	updated_at TIMESTAMP DEFAULT now(),
	avatar BIGINT UNSIGNED DEFAULT 1,
	first_name VARCHAR(100) DEFAULT ' ',
	last_name VARCHAR(100) DEFAULT ' ',
	gender ENUM ('m', 'f', 'nb', 'ud') DEFAULT 'ud',
	date_of_birth DATE,
	country_id BIGINT UNSIGNED,
	about VARCHAR(350) DEFAULT ' ',
    is_private BIT DEFAULT 0,
    INDEX user_name_idx (first_name, last_name),

	FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (avatar) REFERENCES images (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE,
	FOREIGN KEY (country_id) REFERENCES countries (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user BIGINT UNSIGNED,
	to_user BIGINT UNSIGNED,
	created_at TIMESTAMP DEFAULT now(),
	body_text TEXT NOT NULL,
	FOREIGN KEY (from_user) REFERENCES users (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE,
	FOREIGN KEY (to_user) REFERENCES users (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);
-- ----------------------------------- TITLES
DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
	id SERIAL PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	original_title VARCHAR(100) DEFAULT ' ',
	INDEX (title),
	INDEX (original_title)
);
DROP TABLE IF EXISTS title_info;
CREATE TABLE title_info (
	id SERIAL PRIMARY KEY,
	title_id BIGINT UNSIGNED,
	title_type_id BIGINT UNSIGNED DEFAULT 1,
	poster BIGINT UNSIGNED DEFAULT 2,
	tagline VARCHAR(200) DEFAULT ' ',
	synopsis VARCHAR(500) DEFAULT ' ',
	release_date DATE,
	rars ENUM ('0+', '6+', '12+', '16+', '18+', 'NR') DEFAULT 'NR',
	INDEX (release_date),
	FOREIGN KEY (title_id) REFERENCES titles (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (title_type_id) REFERENCES title_types (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE,
	FOREIGN KEY (poster) REFERENCES images (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);
-- ----------------------------------- TITLES ADDITIONAL INFO
DROP TABLE IF EXISTS title_country;
CREATE TABLE title_country (
	id SERIAL PRIMARY KEY,
	title_id BIGINT UNSIGNED,
	country_id BIGINT UNSIGNED,
	FOREIGN KEY (title_id) REFERENCES titles (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (country_id) REFERENCES countries (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS title_company;
CREATE TABLE title_company (
	id SERIAL PRIMARY KEY,
	title_id BIGINT UNSIGNED,
	company_id BIGINT UNSIGNED,
	FOREIGN KEY (title_id) REFERENCES titles (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (company_id) REFERENCES companies (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS creators;
CREATE TABLE creators (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(200),
	last_name VARCHAR(200),
	date_of_birth DATE,
	date_of_death DATE DEFAULT NULL,
	gender ENUM ('m', 'f', 'nb', 'ud') DEFAULT 'ud',
	photo BIGINT UNSIGNED,
	country_id BIGINT UNSIGNED,
	INDEX creator_name_idx (first_name, last_name),
	FOREIGN KEY (photo) REFERENCES images (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE,
	FOREIGN KEY (country_id) REFERENCES countries (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS cast_and_crew;
CREATE TABLE cast_and_crew (
	id SERIAL PRIMARY KEY,
	title_id BIGINT UNSIGNED,
	role_id BIGINT UNSIGNED,
	creator_id BIGINT UNSIGNED,
	FOREIGN KEY (title_id) REFERENCES titles (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (role_id) REFERENCES roles (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE,
	FOREIGN KEY (creator_id) REFERENCES creators (id)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);
-- ----------------------------------- TITLES INFO, INFLUENCED BY USERS
DROP TABLE IF EXISTS all_keywords;
CREATE TABLE all_keywords (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED,
	keyword VARCHAR(100) UNIQUE,
	created_at TIMESTAMP DEFAULT now(),
	FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS votes_on_keywords;
CREATE TABLE votes_on_keywords (
	id SERIAL PRIMARY KEY,
	title_id BIGINT UNSIGNED,
	keyword_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED,
	vote BIT DEFAULT 1,
	created_at TIMESTAMP DEFAULT now(),
    FOREIGN KEY (title_id) REFERENCES titles (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (keyword_id) REFERENCES all_keywords (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS votes_on_genre;
CREATE TABLE votes_on_genre (
	id SERIAL PRIMARY KEY,
	title_id BIGINT UNSIGNED,
	genre_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED,
	vote BIT,
	created_at TIMESTAMP DEFAULT now(),
    FOREIGN KEY (title_id) REFERENCES titles (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (genre_id) REFERENCES genres (id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS rating;
CREATE TABLE rating (
	id SERIAL PRIMARY KEY,
	title_id BIGINT UNSIGNED,
	user_id BIGINT UNSIGNED,
	rating TINYINT UNSIGNED NOT NULL DEFAULT 0,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP DEFAULT now(),
    INDEX (rating),

	FOREIGN KEY (title_id) REFERENCES titles (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
	id SERIAL PRIMARY KEY,
	title_id BIGINT UNSIGNED,
	user_id BIGINT UNSIGNED,
	body VARCHAR(500),
	is_positive BIT DEFAULT 1,
	created_at TIMESTAMP DEFAULT now(),
    
    INDEX (is_positive),

	FOREIGN KEY (title_id) REFERENCES titles (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS votes_on_reviews;
CREATE TABLE votes_on_reviews (
	id SERIAL PRIMARY KEY,
	review_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED,
	vote BIT,
	created_at TIMESTAMP DEFAULT now(),
    FOREIGN KEY (review_id) REFERENCES reviews (id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
-- ----------------------------------- LISTS
DROP TABLE IF EXISTS watchlist;
CREATE TABLE watchlist (
	id SERIAL PRIMARY KEY,
	title_id BIGINT UNSIGNED,
	user_id BIGINT UNSIGNED,
	is_seen BIT DEFAULT 0,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP DEFAULT now(),
    FOREIGN KEY (title_id) REFERENCES titles (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS user_lists;
CREATE TABLE user_lists (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED,
	list_name VARCHAR(50) DEFAULT ' ',
	description VARCHAR(100) DEFAULT ' ',
	is_private BIT DEFAULT 0,
	created_at TIMESTAMP DEFAULT now(),
    INDEX (list_name),
	INDEX (is_private),

	FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS user_list_items;
CREATE TABLE user_list_items (
	id SERIAL PRIMARY KEY,
	list_id BIGINT UNSIGNED NOT NULL,
	title_id BIGINT UNSIGNED,
	created_at TIMESTAMP DEFAULT now(),
	FOREIGN KEY (list_id) REFERENCES user_lists (id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (title_id) REFERENCES titles (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);
-- ----------------------------------- FOLLOWERS
DROP TABLE IF EXISTS follow_user;
CREATE TABLE follow_user (
	id SERIAL PRIMARY KEY,
	follower_id BIGINT UNSIGNED NOT NULL,
	target_id BIGINT UNSIGNED NOT NULL,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP DEFAULT now(),
	FOREIGN KEY (follower_id) REFERENCES users (id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (target_id) REFERENCES users (id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS follow_keyword;
CREATE TABLE follow_keyword (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED,
	keyword_id BIGINT UNSIGNED NOT NULL,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP DEFAULT now(),
    FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (keyword_id) REFERENCES all_keywords (id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS follow_genre;
CREATE TABLE follow_genre (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED,
	genre_id BIGINT UNSIGNED NOT NULL,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP DEFAULT now(),
    FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (genre_id) REFERENCES genres (id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
DROP TABLE IF EXISTS follow_list;
CREATE TABLE follow_list (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED,
	list_id BIGINT UNSIGNED NOT NULL,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP DEFAULT now(),
    FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (list_id) REFERENCES user_lists (id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
-- ----------------------- FUNCTIONS -----------------------
-- ---------------------------------------------------------
-- ----------------------------------- GENRE RELEVANCY COUNT function
DROP FUNCTION IF EXISTS g_relevancy;
DELIMITER //
CREATE FUNCTION g_relevancy(t_id INT UNSIGNED, g_id INT UNSIGNED)
	RETURNS INT DETERMINISTIC
BEGIN
	RETURN (SELECT likes.c - dislikes.c
			  FROM (
					   SELECT count(vote) AS c
						 FROM votes_on_genre
						WHERE vote = 1 AND title_id = t_id AND genre_id = g_id
				   ) AS likes
					   JOIN (
				  SELECT count(vote) AS c
					FROM votes_on_genre
				   WHERE vote = 0 AND title_id = t_id AND genre_id = g_id
							) AS dislikes
		   );
END;
//
DELIMITER ;
-- DROP FUNCTION IF EXISTS g_relevancy;
-- ----------------------------------- KEYWORD RELEVANCY COUNT function
DROP FUNCTION IF EXISTS k_relevancy;
DELIMITER //
CREATE FUNCTION k_relevancy(t_id INT UNSIGNED, k_id INT UNSIGNED)
	RETURNS INT DETERMINISTIC
BEGIN
	RETURN (SELECT likes.c - dislikes.c
			  FROM (
					   SELECT count(vote) AS c
						 FROM votes_on_keywords
						WHERE vote = 1 AND title_id = t_id AND keyword_id = k_id
				   ) AS likes
					   JOIN (
				  SELECT count(vote) AS c
					FROM votes_on_keywords
				   WHERE vote = 0 AND title_id = t_id AND keyword_id = k_id
							) AS dislikes
		   );
END;
//
DELIMITER ;
-- DROP FUNCTION IF EXISTS k_relevancy;
-- ----------------------------------- REVIEW RATING function
DROP FUNCTION IF EXISTS review_rate;
DELIMITER //
CREATE FUNCTION review_rate(r_id INT UNSIGNED)
	RETURNS INT DETERMINISTIC
BEGIN
	RETURN (SELECT likes.c - dislikes.c
			  FROM (
					   SELECT count(vote) AS c
						 FROM votes_on_reviews
						WHERE vote = 1 AND review_id = r_id
				   ) AS likes
					   JOIN (
				  SELECT count(vote) AS c
					FROM votes_on_reviews
				   WHERE vote = 0 AND review_id = r_id
							) AS dislikes
		   );
END;
//
DELIMITER ;
-- DROP FUNCTION IF EXISTS review_rate;

-- ----------------------- BASIC VIEWS ---------------------
-- ---------------------------------------------------------

--  COUNTRIES GENERAL INFO view
CREATE OR REPLACE VIEW countries_info AS
		SELECT c.id as c_id,
		   c.country,
		   tc.c1 AS all_titles,
		   up.c2 AS all_users,
		   cr.c3 AS all_creators
	  FROM countries c
			   LEFT JOIN (SELECT count(title_id) AS c1,
								 country_id
							FROM title_country
						   GROUP BY country_id
						 ) AS tc ON c.id = tc.country_id
			   LEFT JOIN (SELECT count(user_id) AS c2,
								 country_id
							FROM user_profiles
						   GROUP BY country_id
						 ) AS up ON c.id = up.country_id
			   LEFT JOIN (SELECT count(id) AS c3,
								 country_id
							FROM creators
						   GROUP BY country_id
						 ) AS cr ON c.id = cr.country_id
	 GROUP BY
		 c.country
	 ORDER BY
     c.country;
--- DROP VIEW IF EXISTS countries_info;
------------------ TITLES & COUNTRIES view
CREATE OR REPLACE VIEW titles_and_countries AS
	SELECT t.id AS t_id,
		   t.title,
		   c.id AS c_id,
		   c.country
	  FROM titles t
			   JOIN title_country tc ON t.id = tc.title_id
			   JOIN countries c ON tc.country_id = c.id
	 ORDER BY
		 t.id;
-------------- TITLES & PRODUCTION COMPANIES view
CREATE OR REPLACE VIEW titles_and_companies AS
	SELECT t.id AS t_id,
		   t.title,
		   c.id AS comp_id,
		   c.company
	  FROM titles t
			   JOIN title_company tc ON t.id = tc.title_id
			   JOIN companies c ON tc.company_id = c.id
	 ORDER BY
		 t.id;
-- DROP VIEW IF EXISTS titles_and_companies;
--  ------------------------TITLES & CREATORS view
CREATE OR REPLACE VIEW titles_and_cast AS
	SELECT t.id AS t_id,
		   t.title,
		   r.id AS r_id,
		   r.role,
		   cr.id AS cr_id,
		   concat_ws(' ', cr.first_name, cr.last_name) AS name,
		   ti.release_date
	  	  FROM creators cr
			   INNER JOIN cast_and_crew cac ON cr.id = cac.creator_id
			   INNER JOIN titles t ON cac.title_id = t.id
			   INNER JOIN roles r ON cac.role_id = r.id
			   INNER JOIN title_info ti ON t.id = ti.title_id
               ORDER BY
		 t.id;
-- DROP VIEW IF EXISTS titles_and_cast;

-- ---------------------VIEWS WITH VOTES 
-------- GENRES GENERAL INFO view
CREATE OR REPLACE VIEW genres_info AS
	SELECT g.id AS g_id,
		   g.genre,
		   fg.c AS followers,
		   vog.c AS all_titles,
		   vog_r.c AS relevant_titles
	  FROM genres g
			   LEFT JOIN (SELECT count(user_id) AS c,
								 genre_id
							FROM follow_genre
						   GROUP BY genre_id
						 ) AS fg ON g.id = fg.genre_id
			   LEFT JOIN (SELECT count(title_id) AS c, -- All titles
								 genre_id
							FROM votes_on_genre
						   GROUP BY genre_id
						 ) AS vog ON g.id = vog.genre_id
			   LEFT JOIN (SELECT count(title_id) AS c,
								 genre_id
							FROM votes_on_genre
						   WHERE g_relevancy(title_id, genre_id) > 0
						   GROUP BY genre_id
						 ) AS vog_r ON g.id = vog_r.genre_id
	 ORDER BY
		 g.genre;
-- DROP VIEW IF EXISTS genres_info;
-- ----------------------TITLES & THEIR GENRES view
CREATE OR REPLACE VIEW titles_and_genres AS
	SELECT t.id AS t_id,
		   t.title,
		   g.id AS g_id,
		   g.genre,
		   g_relevancy(t.id, g.id) AS relevancy
	  FROM titles t
			   LEFT JOIN votes_on_genre vog ON t.id = vog.title_id
			   LEFT JOIN genres g ON vog.genre_id = g.id
	 GROUP BY
		 t.id, g.genre
	 ORDER BY
		 t.id, relevancy DESC;
-- DROP VIEW IF EXISTS titles_and_genres;
-- ------------------------KEYWORDS GENERAL INFO view
CREATE OR REPLACE VIEW keywords_info AS
	SELECT ak.id AS k_id,
		   ak.keyword,
		   fk.c AS followers,
		   vok.c AS all_titles,
		   vok_r.c AS relevant_titles
	  FROM all_keywords ak
			   LEFT JOIN (SELECT count(user_id) AS c,
								 keyword_id
							FROM follow_keyword
						   GROUP BY keyword_id
						 ) AS fk ON ak.id = fk.keyword_id
			   LEFT JOIN (SELECT count(title_id) AS c, -- All titles
								 keyword_id
							FROM votes_on_keywords
						   GROUP BY keyword_id
						 ) AS vok ON ak.id = vok.keyword_id
			   LEFT JOIN (SELECT count(title_id) AS c, -- Relevant titles
								 keyword_id
							FROM votes_on_keywords
						   WHERE k_relevancy(title_id, keyword_id) > 0
						   GROUP BY keyword_id
						 ) AS vok_r ON ak.id = vok_r.keyword_id
                         ORDER BY
		 ak.id;
-- DROP VIEW IF EXISTS keywords_info;
-- ----------------------------------- TITLES & KEYWORDS view
CREATE OR REPLACE VIEW titles_and_keywords AS
	SELECT t.id AS t_id,
		   t.title,
		   ak.id AS k_id,
		   ak.keyword,
		   k_relevancy(t.id, ak.id) AS relevancy
	  FROM titles t
			   LEFT JOIN votes_on_keywords vok ON t.id = vok.title_id
			   LEFT JOIN all_keywords ak ON vok.keyword_id = ak.id
	 GROUP BY
		 t.id, ak.keyword
	 ORDER BY
		 t.id, relevancy DESC;
-- DROP VIEW IF EXISTS titles_and_genres;
-- ----------------------------------- REVIEWS INFO view
CREATE OR REPLACE VIEW reviews_info AS
	SELECT r.title_id AS t_id,
		   t.title,
		   r.id AS rev_id,
		   r.body,
		   CASE (r.is_positive)
			   WHEN 1 THEN 'positive'
			   WHEN 0 THEN 'negative'
			   END AS mood,
		   review_rate(r.id) AS voted,
		   u.username
	  FROM reviews r
			   JOIN titles t ON r.title_id = t.id
			   JOIN users u ON r.user_id = u.id
	 ORDER BY
		 r.id;
-- DROP VIEW IF EXISTS reviews_info;
-- ---------------------------------------------------------
-- ----------------------- PROFILE VIEWS ---
-- ----------------------------------- TITLES PROFILES view
CREATE OR REPLACE VIEW t_profiles AS
	SELECT t.id AS t_id,
		   t.title,
		   tt.title_type,
		   r.avgr AS rating,
		   r.count AS r_votes,
		   seen.c AS was_seen,
		   to_w.c AS on_watchlist,
		   uli.c AS on_user_lists,
		   r2.c AS reviewed,
		   ti.release_date,
		   ti.rars,
		   t.original_title,
		   ti.poster,
		   ti.tagline,
		   ti.synopsis
	  FROM titles AS t
			   INNER JOIN title_info ti ON t.id = ti.title_id
			   INNER JOIN title_types tt ON tt.id = ti.title_type_id
			   LEFT JOIN (SELECT title_id,
								 round(avg(rating)) AS avgr,
								 count(rating) AS count
							FROM rating
						   GROUP BY title_id
						 ) AS r ON r.title_id = t.id
			   LEFT JOIN (SELECT count(is_seen) AS c,
								 title_id
							FROM watchlist
						   WHERE is_seen = 1
						   GROUP BY title_id
						 ) seen ON seen.title_id = t.id
			   LEFT JOIN (SELECT count(is_seen) AS c,
								 title_id
							FROM watchlist
						   WHERE is_seen = 0
						   GROUP BY title_id
						 ) to_w ON to_w.title_id = t.id
			   LEFT JOIN (SELECT count(list_id) AS c,
								 title_id
							FROM user_list_items
						   GROUP BY title_id
						 ) uli ON t.id = uli.title_id
			   LEFT JOIN (SELECT count(id) AS c,
								 title_id
                                 FROM reviews
						   GROUP BY title_id
						 ) r2 ON t.id = r2.title_id
	 ORDER BY
		 t.id;
-- DROP VIEW IF EXISTS t_profiles;
-- ----------------------------------- USERS PROFILES view
CREATE OR REPLACE VIEW u_profiles AS
	SELECT u.id AS u_id,
		   concat_ws(' ', up.first_name, up.last_name) AS name,
		   u.username,
		   u.phone_number,
		   u.email,
		   up.date_of_birth,
		   TIMESTAMPDIFF(YEAR, up.date_of_birth, NOW()) AS age,
		   CASE (up.gender)
			   WHEN 'm' THEN 'male'
			   WHEN 'f' THEN 'female'
			   WHEN 'nb' THEN 'non-binary'
			   WHEN 'ud' THEN 'undefined'
			   END AS gender,
		   CASE (up.is_private)
			   WHEN 1 THEN 'private'
			   WHEN 0 THEN 'public'
			   END AS account,
		   fu_t.c AS followers,
		   fu_f.c AS following,
		   to_w.c AS to_watch,
		   seen.c AS titles_seen,
		   ul.lists,
		   r.c AS reviews,
		   r2.c AS rated_titles,
		   r2.avg_rating,
		   c.country,
		   up.avatar,
		   up.about
            FROM users u
			   LEFT JOIN user_profiles up ON u.id = up.user_id
			   LEFT JOIN countries c ON up.country_id = c.id
			   LEFT JOIN (SELECT count((id)) AS c, -- Number of followers
								 target_id
							FROM follow_user
						   GROUP BY target_id
						 ) fu_t ON u.id = fu_t.target_id
			   LEFT JOIN (SELECT count((id)) AS c, -- Number of users, he/she is following
								 follower_id
							FROM follow_user
						   GROUP BY follower_id
						 ) fu_f ON u.id = fu_f.follower_id
			   LEFT JOIN (SELECT user_id,
								 count(title_id) AS c
							FROM watchlist
						   WHERE is_seen = 0
						   GROUP BY user_id
						 ) to_w ON u.id = to_w.user_id
			   LEFT JOIN (SELECT user_id,
								 count(title_id) AS c
							FROM watchlist
						   WHERE is_seen = 1
						   GROUP BY user_id
						 ) seen ON u.id = seen.user_id
			   LEFT JOIN (SELECT count(list_name) AS lists,
								 user_id
							FROM user_lists
						   GROUP BY user_id
						 ) ul ON u.id = ul.user_id
			   LEFT JOIN (SELECT count(id) AS c,
								 user_id
							FROM reviews
						   GROUP BY user_id
						 ) r ON u.id = r.user_id
			   LEFT JOIN (SELECT count(id) AS c,
								 round(avg(rating)) AS avg_rating,
								 user_id
							FROM rating
						   GROUP BY user_id
						 ) r2 ON u.id = r2.user_id
                         ORDER BY
		 u.id;
-- DROP VIEW IF EXISTS u_profiles;
-- ----------------------------------- CREATORS PROFILES view
CREATE OR REPLACE VIEW cr_profiles AS
	SELECT cr.id AS cr_id,
		   concat_ws(' ', cr.first_name, cr.last_name) AS name,
		   TIMESTAMPDIFF(YEAR, cr.date_of_birth, NOW()) AS age,
		   CASE (cr.gender)
			   WHEN 'm' THEN 'male'
			   WHEN 'f' THEN 'female'
			   WHEN 'nb' THEN 'non-binary'
			   WHEN 'ud' THEN 'undefined'
			   END AS gender,
		   cac.c AS filmography,
		   cr_r.role,
		   cr_r.r_count,
		   cr.date_of_birth,
	       cn.id AS c_id,
		   cn.country
	  FROM creators cr
			   JOIN countries cn ON cr.country_id = cn.id
			   LEFT JOIN (SELECT creator_id,
								 title_id,
								 count(title_id) AS c
							FROM cast_and_crew
						   GROUP BY creator_id
						 ) cac ON cac.creator_id = cr.id
			   LEFT JOIN (SELECT creator_id,
								 role_id,
								 r.role AS role,
								 count(role_id) AS r_count
							FROM cast_and_crew
									 JOIN roles r ON cast_and_crew.role_id = r.id
						   GROUP BY creator_id, role_id
						   ORDER BY creator_id, r_count DESC
						 ) AS cr_r ON cr_r.creator_id = cr.id
	 ORDER BY
      cr.id;
-- DROP VIEW IF EXISTS cr_profiles;
USE LS;

-- ----------------------------------- Filmography

DROP PROCEDURE IF EXISTS filmography;
DELIMITER //
CREATE PROCEDURE filmography(IN for_person_id INT)
BEGIN

	SELECT name, title, role, release_date
	  FROM titles_and_cast
	 WHERE cr_id = for_person_id
	 ORDER BY role, release_date DESC;
END//
DELIMITER ;

CALL filmography(3);

-- ----------------------------------- Top 5 titles on keyword
DROP PROCEDURE IF EXISTS top_on_keyword;
DELIMITER //
CREATE PROCEDURE top_on_keyword(IN for_keyword VARCHAR(100))
BEGIN

	SELECT tp.title, tp.rating
	  FROM t_profiles tp
			   JOIN titles_and_keywords tak ON tp.t_id = tak.t_id
	 WHERE tak.keyword = for_keyword
	 ORDER BY
		 tp.rating DESC
	 LIMIT 5;

END //
DELIMITER ;

CALL top_on_keyword('vampire');


-- ----------------------------------- Combination of genre and title type query
DROP PROCEDURE IF EXISTS genre_and_type_combo;
DELIMITER //
CREATE PROCEDURE genre_and_type_combo(IN for_type VARCHAR(100),
									  IN for_genre VARCHAR(100))
BEGIN
	SELECT tp.title, tp.rating
	  FROM t_profiles tp
			   JOIN titles_and_genres tag ON tp.t_id = tag.t_id
	 WHERE tp.title_type = for_type
	   AND tag.relevancy > 0
	   AND tag.genre = for_genre
	 ORDER BY
		 tp.rating DESC, tag.relevancy DESC;
END //
DELIMITER ;

CALL genre_and_type_combo('TV Series', 'Drama');

-- ----------------------------------- All titles somehow related to Korea
DROP PROCEDURE IF EXISTS country_related;
DELIMITER //
CREATE PROCEDURE country_related(IN for_country VARCHAR(100))
BEGIN

	SELECT tp.title, tp.rating
	  FROM t_profiles tp
			   JOIN titles_and_countries tac ON tp.t_id = tac.t_id
	 WHERE tac.country = for_country
     	 UNION
         SELECT tp.title, tp.rating
	  FROM t_profiles tp
			   JOIN titles_and_cast tac ON tp.t_id = tac.t_id
			   JOIN cr_profiles crp ON crp.cr_id = tac.cr_id
	 WHERE crp.country = for_country
	 GROUP BY
		 tp.title;
         END //
DELIMITER ;
CALL country_related('Korea');
-- ----------------------------------- Some good titles for kids
DROP PROCEDURE IF EXISTS titles_for_kids;
DELIMITER //
CREATE PROCEDURE titles_for_kids(IN how_many INT)
BEGIN

	SELECT title,
		   title_type,
		   rars
	  FROM t_profiles
	 WHERE (rars = '0+' OR rars = '6+') AND rars != 'NR' AND rating >= 6
	 ORDER BY
		 rand()
	 LIMIT how_many;

END //
DELIMITER ;

CALL titles_for_kids(10);

