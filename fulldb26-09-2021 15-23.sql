#
# TABLE STRUCTURE FOR: all_keywords
#

DROP TABLE IF EXISTS `all_keywords`;

CREATE TABLE `all_keywords` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `keyword` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `keyword` (`keyword`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `all_keywords_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `all_keywords` (`id`, `user_id`, `keyword`, `created_at`) VALUES ('1', '11', NULL, '1996-08-29 07:24:47');
INSERT INTO `all_keywords` (`id`, `user_id`, `keyword`, `created_at`) VALUES ('2', '12', NULL, '1983-05-13 06:44:35');
INSERT INTO `all_keywords` (`id`, `user_id`, `keyword`, `created_at`) VALUES ('3', '13', NULL, '1996-09-20 02:42:51');
INSERT INTO `all_keywords` (`id`, `user_id`, `keyword`, `created_at`) VALUES ('4', '14', NULL, '1993-02-04 08:01:34');
INSERT INTO `all_keywords` (`id`, `user_id`, `keyword`, `created_at`) VALUES ('5', '15', NULL, '2003-11-13 18:07:14');
INSERT INTO `all_keywords` (`id`, `user_id`, `keyword`, `created_at`) VALUES ('6', '16', NULL, '2003-09-30 00:06:55');
INSERT INTO `all_keywords` (`id`, `user_id`, `keyword`, `created_at`) VALUES ('7', '18', NULL, '2005-09-27 10:19:30');
INSERT INTO `all_keywords` (`id`, `user_id`, `keyword`, `created_at`) VALUES ('8', '19', NULL, '1985-05-07 15:07:38');
INSERT INTO `all_keywords` (`id`, `user_id`, `keyword`, `created_at`) VALUES ('9', '20', NULL, '2021-01-05 22:07:10');
INSERT INTO `all_keywords` (`id`, `user_id`, `keyword`, `created_at`) VALUES ('10', '11', NULL, '1992-11-24 01:51:58');


#
# TABLE STRUCTURE FOR: cast_and_crew
#

DROP TABLE IF EXISTS `cast_and_crew`;

CREATE TABLE `cast_and_crew` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title_id` bigint(20) unsigned DEFAULT NULL,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  `creator_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `title_id` (`title_id`),
  KEY `role_id` (`role_id`),
  KEY `creator_id` (`creator_id`),
  CONSTRAINT `cast_and_crew_ibfk_1` FOREIGN KEY (`title_id`) REFERENCES `titles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `cast_and_crew_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `cast_and_crew_ibfk_3` FOREIGN KEY (`creator_id`) REFERENCES `creators` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

#
# TABLE STRUCTURE FOR: companies
#

DROP TABLE IF EXISTS `companies`;

CREATE TABLE `companies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `company` (`company`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `companies` (`id`, `company`) VALUES ('1', 'McDermott, Windler and Boehm');


#
# TABLE STRUCTURE FOR: countries
#

DROP TABLE IF EXISTS `countries`;

CREATE TABLE `countries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `country` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `country` (`country`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `countries` (`id`, `country`) VALUES ('3', '');
INSERT INTO `countries` (`id`, `country`) VALUES ('10', '113053464');
INSERT INTO `countries` (`id`, `country`) VALUES ('2', '2689');
INSERT INTO `countries` (`id`, `country`) VALUES ('6', '305');
INSERT INTO `countries` (`id`, `country`) VALUES ('4', '4020468');
INSERT INTO `countries` (`id`, `country`) VALUES ('1', '407');
INSERT INTO `countries` (`id`, `country`) VALUES ('5', '5663702');
INSERT INTO `countries` (`id`, `country`) VALUES ('9', '79887');
INSERT INTO `countries` (`id`, `country`) VALUES ('8', '88543');
INSERT INTO `countries` (`id`, `country`) VALUES ('7', '93275');


#
# TABLE STRUCTURE FOR: creators
#

DROP TABLE IF EXISTS `creators`;

CREATE TABLE `creators` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `date_of_death` date DEFAULT NULL,
  `gender` enum('m','f','nb','ud') COLLATE utf8_unicode_ci DEFAULT 'ud',
  `photo` bigint(20) unsigned DEFAULT NULL,
  `country_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `creator_name_idx` (`first_name`,`last_name`),
  KEY `photo` (`photo`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `creators_ibfk_1` FOREIGN KEY (`photo`) REFERENCES `images` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `creators_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

#
# TABLE STRUCTURE FOR: follow_genre
#

DROP TABLE IF EXISTS `follow_genre`;

CREATE TABLE `follow_genre` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `genre_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `follow_genre_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `follow_genre_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `follow_genre` (`id`, `user_id`, `genre_id`, `created_at`, `updated_at`) VALUES ('1', '11', '1', '1991-07-07 06:32:25', '1992-03-12 04:27:37');
INSERT INTO `follow_genre` (`id`, `user_id`, `genre_id`, `created_at`, `updated_at`) VALUES ('2', '12', '2', '1974-04-05 20:37:33', '2017-08-20 09:59:54');
INSERT INTO `follow_genre` (`id`, `user_id`, `genre_id`, `created_at`, `updated_at`) VALUES ('3', '13', '3', '1972-07-12 00:51:39', '2000-05-11 11:01:02');
INSERT INTO `follow_genre` (`id`, `user_id`, `genre_id`, `created_at`, `updated_at`) VALUES ('4', '14', '4', '1983-04-23 03:16:55', '1995-09-24 09:29:27');
INSERT INTO `follow_genre` (`id`, `user_id`, `genre_id`, `created_at`, `updated_at`) VALUES ('5', '15', '5', '1971-06-03 20:52:04', '1972-02-17 02:50:46');
INSERT INTO `follow_genre` (`id`, `user_id`, `genre_id`, `created_at`, `updated_at`) VALUES ('6', '16', '6', '1985-06-29 17:02:10', '1972-07-03 17:51:58');
INSERT INTO `follow_genre` (`id`, `user_id`, `genre_id`, `created_at`, `updated_at`) VALUES ('7', '18', '7', '1978-09-30 18:09:09', '1998-06-29 07:02:29');
INSERT INTO `follow_genre` (`id`, `user_id`, `genre_id`, `created_at`, `updated_at`) VALUES ('8', '19', '8', '1971-12-01 15:15:17', '1991-09-06 01:00:18');
INSERT INTO `follow_genre` (`id`, `user_id`, `genre_id`, `created_at`, `updated_at`) VALUES ('9', '20', '9', '1976-04-12 02:21:08', '1996-03-29 17:25:51');
INSERT INTO `follow_genre` (`id`, `user_id`, `genre_id`, `created_at`, `updated_at`) VALUES ('10', '11', '10', '1970-06-10 16:03:35', '1991-10-17 01:17:25');


#
# TABLE STRUCTURE FOR: follow_keyword
#

DROP TABLE IF EXISTS `follow_keyword`;

CREATE TABLE `follow_keyword` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `keyword_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `keyword_id` (`keyword_id`),
  CONSTRAINT `follow_keyword_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `follow_keyword_ibfk_2` FOREIGN KEY (`keyword_id`) REFERENCES `all_keywords` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `follow_keyword` (`id`, `user_id`, `keyword_id`, `created_at`, `updated_at`) VALUES ('1', '11', '1', '2006-02-19 14:22:32', '1978-06-12 03:49:05');
INSERT INTO `follow_keyword` (`id`, `user_id`, `keyword_id`, `created_at`, `updated_at`) VALUES ('2', '12', '2', '2005-06-18 15:06:59', '1993-11-30 00:43:29');
INSERT INTO `follow_keyword` (`id`, `user_id`, `keyword_id`, `created_at`, `updated_at`) VALUES ('3', '13', '3', '1987-07-06 13:34:09', '1987-08-31 16:01:13');
INSERT INTO `follow_keyword` (`id`, `user_id`, `keyword_id`, `created_at`, `updated_at`) VALUES ('4', '14', '4', '1981-09-05 15:25:32', '1991-05-14 18:16:53');
INSERT INTO `follow_keyword` (`id`, `user_id`, `keyword_id`, `created_at`, `updated_at`) VALUES ('5', '15', '5', '2014-05-30 16:52:12', '1982-10-16 06:54:19');
INSERT INTO `follow_keyword` (`id`, `user_id`, `keyword_id`, `created_at`, `updated_at`) VALUES ('6', '16', '6', '1977-09-20 16:03:49', '2014-09-23 03:23:19');
INSERT INTO `follow_keyword` (`id`, `user_id`, `keyword_id`, `created_at`, `updated_at`) VALUES ('7', '18', '7', '1989-10-12 06:05:07', '2011-02-11 12:31:51');
INSERT INTO `follow_keyword` (`id`, `user_id`, `keyword_id`, `created_at`, `updated_at`) VALUES ('8', '19', '8', '2008-04-16 09:10:37', '1983-12-10 04:55:09');
INSERT INTO `follow_keyword` (`id`, `user_id`, `keyword_id`, `created_at`, `updated_at`) VALUES ('9', '20', '9', '1991-12-13 22:07:14', '1979-07-26 23:05:25');
INSERT INTO `follow_keyword` (`id`, `user_id`, `keyword_id`, `created_at`, `updated_at`) VALUES ('10', '11', '10', '1998-04-29 16:56:17', '1986-01-21 15:47:27');


#
# TABLE STRUCTURE FOR: follow_list
#

DROP TABLE IF EXISTS `follow_list`;

CREATE TABLE `follow_list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `list_id` (`list_id`),
  CONSTRAINT `follow_list_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `follow_list_ibfk_2` FOREIGN KEY (`list_id`) REFERENCES `user_lists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `follow_list` (`id`, `user_id`, `list_id`, `created_at`, `updated_at`) VALUES ('1', '11', '1', '2014-09-22 20:44:11', '2001-01-16 12:30:20');
INSERT INTO `follow_list` (`id`, `user_id`, `list_id`, `created_at`, `updated_at`) VALUES ('2', '12', '2', '2010-01-09 00:51:30', '2005-07-19 00:02:41');
INSERT INTO `follow_list` (`id`, `user_id`, `list_id`, `created_at`, `updated_at`) VALUES ('3', '13', '3', '2015-04-23 14:10:00', '1970-02-14 07:52:49');
INSERT INTO `follow_list` (`id`, `user_id`, `list_id`, `created_at`, `updated_at`) VALUES ('4', '14', '4', '2001-10-31 16:46:05', '1984-01-10 06:27:26');
INSERT INTO `follow_list` (`id`, `user_id`, `list_id`, `created_at`, `updated_at`) VALUES ('5', '15', '5', '2004-04-30 16:50:44', '2003-10-31 13:37:40');
INSERT INTO `follow_list` (`id`, `user_id`, `list_id`, `created_at`, `updated_at`) VALUES ('6', '16', '6', '1985-09-24 17:50:53', '1978-01-16 09:13:04');
INSERT INTO `follow_list` (`id`, `user_id`, `list_id`, `created_at`, `updated_at`) VALUES ('7', '18', '7', '2011-08-20 06:10:01', '2006-05-15 23:10:25');
INSERT INTO `follow_list` (`id`, `user_id`, `list_id`, `created_at`, `updated_at`) VALUES ('8', '19', '8', '2019-03-16 13:33:04', '1979-10-17 08:16:27');
INSERT INTO `follow_list` (`id`, `user_id`, `list_id`, `created_at`, `updated_at`) VALUES ('9', '20', '9', '1990-04-08 16:37:41', '1990-01-15 06:33:01');
INSERT INTO `follow_list` (`id`, `user_id`, `list_id`, `created_at`, `updated_at`) VALUES ('10', '11', '10', '1988-07-02 07:09:27', '2017-10-11 08:49:28');


#
# TABLE STRUCTURE FOR: follow_user
#

DROP TABLE IF EXISTS `follow_user`;

CREATE TABLE `follow_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `follower_id` bigint(20) unsigned NOT NULL,
  `target_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `follower_id` (`follower_id`),
  KEY `target_id` (`target_id`),
  CONSTRAINT `follow_user_ibfk_1` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `follow_user_ibfk_2` FOREIGN KEY (`target_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `follow_user` (`id`, `follower_id`, `target_id`, `created_at`, `updated_at`) VALUES ('1', '11', '11', '1988-02-12 17:27:31', '2021-01-01 20:12:08');
INSERT INTO `follow_user` (`id`, `follower_id`, `target_id`, `created_at`, `updated_at`) VALUES ('2', '12', '12', '1982-02-26 11:40:38', '2004-02-29 06:52:06');
INSERT INTO `follow_user` (`id`, `follower_id`, `target_id`, `created_at`, `updated_at`) VALUES ('3', '13', '13', '2014-12-12 22:57:06', '1996-11-16 02:41:35');
INSERT INTO `follow_user` (`id`, `follower_id`, `target_id`, `created_at`, `updated_at`) VALUES ('4', '14', '14', '2003-09-28 13:03:31', '2020-01-29 18:44:16');
INSERT INTO `follow_user` (`id`, `follower_id`, `target_id`, `created_at`, `updated_at`) VALUES ('5', '15', '15', '2010-10-23 07:09:21', '1991-04-02 07:46:10');
INSERT INTO `follow_user` (`id`, `follower_id`, `target_id`, `created_at`, `updated_at`) VALUES ('6', '16', '16', '2008-05-04 06:11:46', '1976-07-05 11:39:17');
INSERT INTO `follow_user` (`id`, `follower_id`, `target_id`, `created_at`, `updated_at`) VALUES ('7', '18', '18', '1985-12-04 12:15:43', '1979-11-15 06:35:05');
INSERT INTO `follow_user` (`id`, `follower_id`, `target_id`, `created_at`, `updated_at`) VALUES ('8', '19', '19', '2018-10-30 21:31:15', '1992-07-08 07:19:21');
INSERT INTO `follow_user` (`id`, `follower_id`, `target_id`, `created_at`, `updated_at`) VALUES ('9', '20', '20', '2004-03-31 13:12:03', '2019-12-06 05:35:51');
INSERT INTO `follow_user` (`id`, `follower_id`, `target_id`, `created_at`, `updated_at`) VALUES ('10', '11', '11', '2006-05-04 19:56:58', '1991-05-21 08:44:11');


#
# TABLE STRUCTURE FOR: genres
#

DROP TABLE IF EXISTS `genres`;

CREATE TABLE `genres` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `genre` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `genre` (`genre`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `genres` (`id`, `genre`) VALUES ('6', '');
INSERT INTO `genres` (`id`, `genre`) VALUES ('8', '1');
INSERT INTO `genres` (`id`, `genre`) VALUES ('2', '2');
INSERT INTO `genres` (`id`, `genre`) VALUES ('10', '3');
INSERT INTO `genres` (`id`, `genre`) VALUES ('7', '4');
INSERT INTO `genres` (`id`, `genre`) VALUES ('5', '5');
INSERT INTO `genres` (`id`, `genre`) VALUES ('3', '6');
INSERT INTO `genres` (`id`, `genre`) VALUES ('1', '7');
INSERT INTO `genres` (`id`, `genre`) VALUES ('4', '8');
INSERT INTO `genres` (`id`, `genre`) VALUES ('9', '9');


#
# TABLE STRUCTURE FOR: images
#

DROP TABLE IF EXISTS `images`;

CREATE TABLE `images` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `images` (`id`, `filename`, `path`) VALUES ('1', 'fuga', '');
INSERT INTO `images` (`id`, `filename`, `path`) VALUES ('2', 'sit', '');
INSERT INTO `images` (`id`, `filename`, `path`) VALUES ('3', 'consequatur', '');
INSERT INTO `images` (`id`, `filename`, `path`) VALUES ('4', 'amet', '');
INSERT INTO `images` (`id`, `filename`, `path`) VALUES ('5', 'id', '');
INSERT INTO `images` (`id`, `filename`, `path`) VALUES ('6', 'sunt', '');
INSERT INTO `images` (`id`, `filename`, `path`) VALUES ('7', 'praesentium', '');
INSERT INTO `images` (`id`, `filename`, `path`) VALUES ('8', 'vel', '');
INSERT INTO `images` (`id`, `filename`, `path`) VALUES ('9', 'corrupti', '');
INSERT INTO `images` (`id`, `filename`, `path`) VALUES ('10', 'dolores', '');


#
# TABLE STRUCTURE FOR: messages
#

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user` bigint(20) unsigned DEFAULT NULL,
  `to_user` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `body_text` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `from_user` (`from_user`),
  KEY `to_user` (`to_user`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

#
# TABLE STRUCTURE FOR: rating
#

DROP TABLE IF EXISTS `rating`;

CREATE TABLE `rating` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `rating` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `rating` (`rating`),
  KEY `title_id` (`title_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`title_id`) REFERENCES `titles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `rating` (`id`, `title_id`, `user_id`, `rating`, `created_at`, `updated_at`) VALUES ('1', '1', '11', 255, '2015-07-27 01:18:02', '1979-11-17 22:54:39');
INSERT INTO `rating` (`id`, `title_id`, `user_id`, `rating`, `created_at`, `updated_at`) VALUES ('2', '2', '12', 2, '2012-10-16 16:29:29', '2006-06-05 21:57:14');
INSERT INTO `rating` (`id`, `title_id`, `user_id`, `rating`, `created_at`, `updated_at`) VALUES ('3', '3', '13', 2, '2019-07-29 00:49:32', '1976-08-20 23:38:35');
INSERT INTO `rating` (`id`, `title_id`, `user_id`, `rating`, `created_at`, `updated_at`) VALUES ('4', '4', '14', 0, '1978-06-20 14:27:34', '2011-09-01 09:00:43');
INSERT INTO `rating` (`id`, `title_id`, `user_id`, `rating`, `created_at`, `updated_at`) VALUES ('5', '5', '15', 0, '1972-06-04 09:59:40', '2000-03-18 04:48:02');
INSERT INTO `rating` (`id`, `title_id`, `user_id`, `rating`, `created_at`, `updated_at`) VALUES ('6', '6', '16', 255, '2002-05-06 12:13:08', '2002-05-28 09:58:30');
INSERT INTO `rating` (`id`, `title_id`, `user_id`, `rating`, `created_at`, `updated_at`) VALUES ('7', '7', '18', 255, '2009-10-17 16:32:44', '2019-08-18 00:20:49');
INSERT INTO `rating` (`id`, `title_id`, `user_id`, `rating`, `created_at`, `updated_at`) VALUES ('8', '8', '19', 255, '1975-10-05 17:11:04', '1979-11-06 19:01:41');
INSERT INTO `rating` (`id`, `title_id`, `user_id`, `rating`, `created_at`, `updated_at`) VALUES ('9', '9', '20', 255, '2009-08-07 17:50:20', '1983-07-06 12:58:14');
INSERT INTO `rating` (`id`, `title_id`, `user_id`, `rating`, `created_at`, `updated_at`) VALUES ('10', '10', '11', 255, '1995-10-28 14:55:08', '2003-09-27 04:56:14');


#
# TABLE STRUCTURE FOR: reviews
#

DROP TABLE IF EXISTS `reviews`;

CREATE TABLE `reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `body` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_positive` bit(1) DEFAULT b'1',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `is_positive` (`is_positive`),
  KEY `title_id` (`title_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`title_id`) REFERENCES `titles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `reviews` (`id`, `title_id`, `user_id`, `body`, `is_positive`, `created_at`) VALUES ('1', '1', '11', 'Adipisci ipsam et incidunt asperiores quam nostrum nihil. Velit dolorem quis vel nisi. Est corporis rerum magnam aut.', '0', '2008-07-08 05:54:05');
INSERT INTO `reviews` (`id`, `title_id`, `user_id`, `body`, `is_positive`, `created_at`) VALUES ('2', '2', '12', 'Laboriosam aliquam error nihil eum similique voluptatem. Aut quis sunt nam at. Tempore commodi at ea quas.', '0', '2017-03-25 20:48:04');
INSERT INTO `reviews` (`id`, `title_id`, `user_id`, `body`, `is_positive`, `created_at`) VALUES ('3', '3', '13', 'Repudiandae veniam minima dolore debitis dicta. Suscipit nisi recusandae animi et expedita ducimus explicabo.', '1', '1995-07-22 01:51:28');
INSERT INTO `reviews` (`id`, `title_id`, `user_id`, `body`, `is_positive`, `created_at`) VALUES ('4', '4', '14', 'Ex ea officia delectus consequuntur ipsum. Unde consequatur labore possimus dolor numquam. Et ut cum eligendi ea iusto quis et aliquam. Id culpa maxime aperiam porro consequuntur.', '0', '1976-09-18 01:05:38');
INSERT INTO `reviews` (`id`, `title_id`, `user_id`, `body`, `is_positive`, `created_at`) VALUES ('5', '5', '15', 'Perferendis quae hic ut rerum dolores. Voluptas est sed sit ea. Iste omnis est quae voluptatum ullam consectetur nemo.', '1', '2001-01-27 11:09:58');
INSERT INTO `reviews` (`id`, `title_id`, `user_id`, `body`, `is_positive`, `created_at`) VALUES ('6', '6', '16', 'Est adipisci cumque eveniet culpa. Velit ut earum provident excepturi dolorem consequatur.', '0', '1989-06-29 14:41:36');
INSERT INTO `reviews` (`id`, `title_id`, `user_id`, `body`, `is_positive`, `created_at`) VALUES ('7', '7', '18', 'Quis magnam doloremque doloremque illum aut. Qui quod esse nemo vitae provident et rerum. Qui mollitia beatae qui labore ipsa sequi.', '0', '2014-01-11 16:34:17');
INSERT INTO `reviews` (`id`, `title_id`, `user_id`, `body`, `is_positive`, `created_at`) VALUES ('8', '8', '19', 'Quas adipisci sunt omnis omnis quia qui. Non non dolorem nihil quidem eum error qui. Et excepturi dolore vel maxime dolorem sint. Sed consequatur veritatis aperiam ullam voluptatem aut deserunt.', '1', '1998-06-20 07:22:36');
INSERT INTO `reviews` (`id`, `title_id`, `user_id`, `body`, `is_positive`, `created_at`) VALUES ('9', '9', '20', 'Sit rerum eum repellat dolorem debitis laborum eum. Consectetur voluptates fuga ut qui eum rerum quisquam. Esse hic asperiores tempora mollitia velit a.', '0', '1987-09-30 16:45:06');
INSERT INTO `reviews` (`id`, `title_id`, `user_id`, `body`, `is_positive`, `created_at`) VALUES ('10', '10', '11', 'Quis est eveniet quis. Maiores impedit est fuga et. Tenetur sint laborum tempora provident ut voluptatem. Sint et in sint aut.', '0', '1985-05-19 22:10:00');


#
# TABLE STRUCTURE FOR: roles
#

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `roles` (`id`, `role`) VALUES ('2', '');
INSERT INTO `roles` (`id`, `role`) VALUES ('4', '1');
INSERT INTO `roles` (`id`, `role`) VALUES ('9', '2');
INSERT INTO `roles` (`id`, `role`) VALUES ('1', '3');
INSERT INTO `roles` (`id`, `role`) VALUES ('6', '4');
INSERT INTO `roles` (`id`, `role`) VALUES ('5', '5');
INSERT INTO `roles` (`id`, `role`) VALUES ('3', '6');
INSERT INTO `roles` (`id`, `role`) VALUES ('7', '7');
INSERT INTO `roles` (`id`, `role`) VALUES ('10', '8');
INSERT INTO `roles` (`id`, `role`) VALUES ('8', '9');


#
# TABLE STRUCTURE FOR: title_company
#

DROP TABLE IF EXISTS `title_company`;

CREATE TABLE `title_company` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title_id` bigint(20) unsigned DEFAULT NULL,
  `company_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `title_id` (`title_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `title_company_ibfk_1` FOREIGN KEY (`title_id`) REFERENCES `titles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `title_company_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `title_company` (`id`, `title_id`, `company_id`) VALUES ('1', '1', '1');
INSERT INTO `title_company` (`id`, `title_id`, `company_id`) VALUES ('2', '2', '1');
INSERT INTO `title_company` (`id`, `title_id`, `company_id`) VALUES ('3', '3', '1');
INSERT INTO `title_company` (`id`, `title_id`, `company_id`) VALUES ('4', '4', '1');
INSERT INTO `title_company` (`id`, `title_id`, `company_id`) VALUES ('5', '5', '1');
INSERT INTO `title_company` (`id`, `title_id`, `company_id`) VALUES ('6', '6', '1');
INSERT INTO `title_company` (`id`, `title_id`, `company_id`) VALUES ('7', '7', '1');
INSERT INTO `title_company` (`id`, `title_id`, `company_id`) VALUES ('8', '8', '1');
INSERT INTO `title_company` (`id`, `title_id`, `company_id`) VALUES ('9', '9', '1');
INSERT INTO `title_company` (`id`, `title_id`, `company_id`) VALUES ('10', '10', '1');


#
# TABLE STRUCTURE FOR: title_country
#

DROP TABLE IF EXISTS `title_country`;

CREATE TABLE `title_country` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title_id` bigint(20) unsigned DEFAULT NULL,
  `country_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `title_id` (`title_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `title_country_ibfk_1` FOREIGN KEY (`title_id`) REFERENCES `titles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `title_country_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `title_country` (`id`, `title_id`, `country_id`) VALUES ('1', '1', '1');
INSERT INTO `title_country` (`id`, `title_id`, `country_id`) VALUES ('2', '2', '2');
INSERT INTO `title_country` (`id`, `title_id`, `country_id`) VALUES ('3', '3', '3');
INSERT INTO `title_country` (`id`, `title_id`, `country_id`) VALUES ('4', '4', '4');
INSERT INTO `title_country` (`id`, `title_id`, `country_id`) VALUES ('5', '5', '5');
INSERT INTO `title_country` (`id`, `title_id`, `country_id`) VALUES ('6', '6', '6');
INSERT INTO `title_country` (`id`, `title_id`, `country_id`) VALUES ('7', '7', '7');
INSERT INTO `title_country` (`id`, `title_id`, `country_id`) VALUES ('8', '8', '8');
INSERT INTO `title_country` (`id`, `title_id`, `country_id`) VALUES ('9', '9', '9');
INSERT INTO `title_country` (`id`, `title_id`, `country_id`) VALUES ('10', '10', '10');


#
# TABLE STRUCTURE FOR: title_info
#

DROP TABLE IF EXISTS `title_info`;

CREATE TABLE `title_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title_id` bigint(20) unsigned DEFAULT NULL,
  `title_type_id` bigint(20) unsigned DEFAULT 1,
  `poster` bigint(20) unsigned DEFAULT 2,
  `tagline` varchar(200) COLLATE utf8_unicode_ci DEFAULT ' ',
  `synopsis` varchar(500) COLLATE utf8_unicode_ci DEFAULT ' ',
  `release_date` date DEFAULT NULL,
  `rars` enum('0+','6+','12+','16+','18+','NR') COLLATE utf8_unicode_ci DEFAULT 'NR',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `release_date` (`release_date`),
  KEY `title_id` (`title_id`),
  KEY `title_type_id` (`title_type_id`),
  KEY `poster` (`poster`),
  CONSTRAINT `title_info_ibfk_1` FOREIGN KEY (`title_id`) REFERENCES `titles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `title_info_ibfk_2` FOREIGN KEY (`title_type_id`) REFERENCES `title_types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `title_info_ibfk_3` FOREIGN KEY (`poster`) REFERENCES `images` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

#
# TABLE STRUCTURE FOR: title_types
#

DROP TABLE IF EXISTS `title_types`;

CREATE TABLE `title_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title_type` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `title_type` (`title_type`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `title_types` (`id`, `title_type`) VALUES ('10', 'Architecto consequatur quo aut qui veniam sed.');
INSERT INTO `title_types` (`id`, `title_type`) VALUES ('1', 'Beatae amet magnam sed sed corporis numquam.');
INSERT INTO `title_types` (`id`, `title_type`) VALUES ('3', 'Corporis quia accusamus repudiandae ipsa.');
INSERT INTO `title_types` (`id`, `title_type`) VALUES ('4', 'Iure voluptatum non officia eligendi alias velit iste.');
INSERT INTO `title_types` (`id`, `title_type`) VALUES ('8', 'Nulla quae quod labore repellat eos.');
INSERT INTO `title_types` (`id`, `title_type`) VALUES ('5', 'Odio labore nobis doloribus autem enim.');
INSERT INTO `title_types` (`id`, `title_type`) VALUES ('6', 'Optio quia numquam odio.');
INSERT INTO `title_types` (`id`, `title_type`) VALUES ('9', 'Quaerat eos possimus enim qui dolor sapiente.');
INSERT INTO `title_types` (`id`, `title_type`) VALUES ('7', 'Recusandae molestiae aut sit consequuntur alias.');
INSERT INTO `title_types` (`id`, `title_type`) VALUES ('2', 'Temporibus dolor eum est quis voluptas.');


#
# TABLE STRUCTURE FOR: titles
#

DROP TABLE IF EXISTS `titles`;

CREATE TABLE `titles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `original_title` varchar(100) COLLATE utf8_unicode_ci DEFAULT ' ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `title` (`title`),
  KEY `original_title` (`original_title`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `titles` (`id`, `title`, `original_title`) VALUES ('1', 'Voluptatem sit voluptas reprehenderit vel ipsum.', 'Est excepturi dolorum ut quis maiores minima.');
INSERT INTO `titles` (`id`, `title`, `original_title`) VALUES ('2', 'Fugit quis voluptates tempora nemo eum.', 'Sunt cumque aperiam culpa molestiae molestias voluptas autem.');
INSERT INTO `titles` (`id`, `title`, `original_title`) VALUES ('3', 'Velit repellat et mollitia blanditiis nesciunt vero dicta.', 'Doloremque ipsa et sequi rerum odio harum molestiae.');
INSERT INTO `titles` (`id`, `title`, `original_title`) VALUES ('4', 'Est et laborum veritatis et.', 'Aut tempore dicta et distinctio.');
INSERT INTO `titles` (`id`, `title`, `original_title`) VALUES ('5', 'Est sit laudantium repudiandae veniam voluptatem error.', 'Consequatur beatae sint explicabo repellat architecto molestiae.');
INSERT INTO `titles` (`id`, `title`, `original_title`) VALUES ('6', 'Incidunt in eaque sed eveniet sunt corrupti.', 'Debitis dolores quaerat quaerat voluptatem aut cupiditate.');
INSERT INTO `titles` (`id`, `title`, `original_title`) VALUES ('7', 'Ea quisquam perspiciatis doloremque voluptate.', 'Ut reprehenderit ipsam corrupti dolorem voluptatibus sit quia.');
INSERT INTO `titles` (`id`, `title`, `original_title`) VALUES ('8', 'Hic quis quia aperiam tempora est ut quas necessitatibus.', 'Esse placeat asperiores et consequatur ut omnis qui expedita.');
INSERT INTO `titles` (`id`, `title`, `original_title`) VALUES ('9', 'Ut necessitatibus et nemo aliquid reiciendis aut.', 'Atque aut est vitae.');
INSERT INTO `titles` (`id`, `title`, `original_title`) VALUES ('10', 'Ut ducimus et occaecati earum voluptatibus quia reprehenderit.', 'Totam tempore ut occaecati et voluptatem ratione.');


#
# TABLE STRUCTURE FOR: user_list_items
#

DROP TABLE IF EXISTS `user_list_items`;

CREATE TABLE `user_list_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` bigint(20) unsigned NOT NULL,
  `title_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `list_id` (`list_id`),
  KEY `title_id` (`title_id`),
  CONSTRAINT `user_list_items_ibfk_1` FOREIGN KEY (`list_id`) REFERENCES `user_lists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_list_items_ibfk_2` FOREIGN KEY (`title_id`) REFERENCES `titles` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `user_list_items` (`id`, `list_id`, `title_id`, `created_at`) VALUES ('1', '1', '1', '2017-08-30 12:52:10');
INSERT INTO `user_list_items` (`id`, `list_id`, `title_id`, `created_at`) VALUES ('2', '2', '2', '1983-07-02 01:20:24');
INSERT INTO `user_list_items` (`id`, `list_id`, `title_id`, `created_at`) VALUES ('3', '3', '3', '1999-12-01 17:10:56');
INSERT INTO `user_list_items` (`id`, `list_id`, `title_id`, `created_at`) VALUES ('4', '4', '4', '1982-12-09 19:09:41');
INSERT INTO `user_list_items` (`id`, `list_id`, `title_id`, `created_at`) VALUES ('5', '5', '5', '2018-02-07 16:47:49');
INSERT INTO `user_list_items` (`id`, `list_id`, `title_id`, `created_at`) VALUES ('6', '6', '6', '1985-09-16 05:53:02');
INSERT INTO `user_list_items` (`id`, `list_id`, `title_id`, `created_at`) VALUES ('7', '7', '7', '2004-10-11 00:44:38');
INSERT INTO `user_list_items` (`id`, `list_id`, `title_id`, `created_at`) VALUES ('8', '8', '8', '1993-08-10 20:21:33');
INSERT INTO `user_list_items` (`id`, `list_id`, `title_id`, `created_at`) VALUES ('9', '9', '9', '2011-12-03 20:15:46');
INSERT INTO `user_list_items` (`id`, `list_id`, `title_id`, `created_at`) VALUES ('10', '10', '10', '1973-08-16 13:44:10');


#
# TABLE STRUCTURE FOR: user_lists
#

DROP TABLE IF EXISTS `user_lists`;

CREATE TABLE `user_lists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `list_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT ' ',
  `description` varchar(100) COLLATE utf8_unicode_ci DEFAULT ' ',
  `is_private` bit(1) DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `list_name` (`list_name`),
  KEY `is_private` (`is_private`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_lists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `user_lists` (`id`, `user_id`, `list_name`, `description`, `is_private`, `created_at`) VALUES ('1', '11', 'ipsum', 'Esse quod et sit corrupti sed eos et. Ab rem ut quasi quisquam dolor et. Pariatur nulla quasi beatae', '1', '1996-07-13 10:23:07');
INSERT INTO `user_lists` (`id`, `user_id`, `list_name`, `description`, `is_private`, `created_at`) VALUES ('2', '12', 'corporis', 'Commodi est cupiditate dolor eius. Commodi aut quam quaerat ducimus fuga quas. Voluptatibus impedit ', '1', '1980-08-30 06:54:32');
INSERT INTO `user_lists` (`id`, `user_id`, `list_name`, `description`, `is_private`, `created_at`) VALUES ('3', '13', 'magni', 'Sit est enim sed eos aspernatur maiores eligendi quia. Illum exercitationem numquam labore minus. Qu', '0', '1974-02-18 15:11:00');
INSERT INTO `user_lists` (`id`, `user_id`, `list_name`, `description`, `is_private`, `created_at`) VALUES ('4', '14', 'nostrum', 'Dignissimos ratione nulla blanditiis qui quis dolorem omnis quae. Velit facilis dolore omnis quaerat', '0', '1981-01-03 02:44:51');
INSERT INTO `user_lists` (`id`, `user_id`, `list_name`, `description`, `is_private`, `created_at`) VALUES ('5', '15', 'necessitatibus', 'Omnis in rerum ipsam consequuntur qui quaerat tenetur et. Voluptates alias qui quia omnis occaecati ', '1', '2017-04-21 16:28:27');
INSERT INTO `user_lists` (`id`, `user_id`, `list_name`, `description`, `is_private`, `created_at`) VALUES ('6', '16', 'consequatur', 'Quia commodi architecto ea et beatae magni voluptas. Dolorum cupiditate eligendi voluptatem cupidita', '0', '2007-06-07 13:29:22');
INSERT INTO `user_lists` (`id`, `user_id`, `list_name`, `description`, `is_private`, `created_at`) VALUES ('7', '18', 'aut', 'Aut neque nihil consequatur fugit perspiciatis. Harum sunt dolor distinctio et. Laudantium occaecati', '1', '1976-09-09 04:17:18');
INSERT INTO `user_lists` (`id`, `user_id`, `list_name`, `description`, `is_private`, `created_at`) VALUES ('8', '19', 'voluptatibus', 'Rerum et sapiente soluta ducimus facere. Inventore in vel est rem.', '1', '2020-01-08 15:39:57');
INSERT INTO `user_lists` (`id`, `user_id`, `list_name`, `description`, `is_private`, `created_at`) VALUES ('9', '20', 'quibusdam', 'Rerum et inventore totam nemo et. Accusantium doloribus eveniet a nihil quia quos. Laudantium dignis', '1', '1977-11-13 07:14:31');
INSERT INTO `user_lists` (`id`, `user_id`, `list_name`, `description`, `is_private`, `created_at`) VALUES ('10', '11', 'ipsa', 'Assumenda et nesciunt magni. Ut aut rem dolorum qui. Neque quis eos eligendi harum beatae enim adipi', '0', '2011-03-26 00:59:48');


#
# TABLE STRUCTURE FOR: user_profiles
#

DROP TABLE IF EXISTS `user_profiles`;

CREATE TABLE `user_profiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `avatar` bigint(20) unsigned DEFAULT 1,
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT ' ',
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT ' ',
  `gender` enum('m','f','nb','ud') COLLATE utf8_unicode_ci DEFAULT 'ud',
  `date_of_birth` date DEFAULT NULL,
  `country_id` bigint(20) unsigned DEFAULT NULL,
  `about` varchar(350) COLLATE utf8_unicode_ci DEFAULT ' ',
  `is_private` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_name_idx` (`first_name`,`last_name`),
  KEY `user_id` (`user_id`),
  KEY `avatar` (`avatar`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `user_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `user_profiles_ibfk_2` FOREIGN KEY (`avatar`) REFERENCES `images` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `user_profiles_ibfk_3` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `user_profiles` (`id`, `user_id`, `updated_at`, `avatar`, `first_name`, `last_name`, `gender`, `date_of_birth`, `country_id`, `about`, `is_private`) VALUES ('1', '11', '1987-04-17 03:46:24', '1', 'Tyler', 'Dickinson', 'f', '1998-03-17', '1', ' ', '0');
INSERT INTO `user_profiles` (`id`, `user_id`, `updated_at`, `avatar`, `first_name`, `last_name`, `gender`, `date_of_birth`, `country_id`, `about`, `is_private`) VALUES ('2', '12', '1986-09-16 13:00:50', '1', 'Wilfred', 'Goyette', 'nb', '2019-09-13', '2', ' ', '1');
INSERT INTO `user_profiles` (`id`, `user_id`, `updated_at`, `avatar`, `first_name`, `last_name`, `gender`, `date_of_birth`, `country_id`, `about`, `is_private`) VALUES ('3', '13', '1980-01-18 21:11:35', '1', 'Lela', 'Ferry', 'nb', '2001-11-05', '3', ' ', '0');
INSERT INTO `user_profiles` (`id`, `user_id`, `updated_at`, `avatar`, `first_name`, `last_name`, `gender`, `date_of_birth`, `country_id`, `about`, `is_private`) VALUES ('4', '14', '1987-04-25 01:30:41', '1', 'Marianna', 'Kreiger', 'ud', '1990-10-31', '4', ' ', '1');
INSERT INTO `user_profiles` (`id`, `user_id`, `updated_at`, `avatar`, `first_name`, `last_name`, `gender`, `date_of_birth`, `country_id`, `about`, `is_private`) VALUES ('5', '15', '2016-06-16 11:21:29', '1', 'Orville', 'Reilly', 'ud', '1973-02-15', '5', ' ', '0');
INSERT INTO `user_profiles` (`id`, `user_id`, `updated_at`, `avatar`, `first_name`, `last_name`, `gender`, `date_of_birth`, `country_id`, `about`, `is_private`) VALUES ('6', '16', '1981-04-03 23:37:09', '1', 'Cheyenne', 'Hane', 'f', '1982-09-26', '6', ' ', '1');
INSERT INTO `user_profiles` (`id`, `user_id`, `updated_at`, `avatar`, `first_name`, `last_name`, `gender`, `date_of_birth`, `country_id`, `about`, `is_private`) VALUES ('7', '18', '1991-06-23 23:36:24', '1', 'Hayley', 'Yundt', 'nb', '1983-05-05', '7', ' ', '0');
INSERT INTO `user_profiles` (`id`, `user_id`, `updated_at`, `avatar`, `first_name`, `last_name`, `gender`, `date_of_birth`, `country_id`, `about`, `is_private`) VALUES ('8', '19', '2018-01-08 13:24:04', '1', 'Earl', 'Baumbach', 'ud', '1999-06-21', '8', ' ', '0');
INSERT INTO `user_profiles` (`id`, `user_id`, `updated_at`, `avatar`, `first_name`, `last_name`, `gender`, `date_of_birth`, `country_id`, `about`, `is_private`) VALUES ('9', '20', '1974-12-04 01:19:48', '1', 'Ara', 'Brown', 'ud', '1971-08-15', '9', ' ', '1');
INSERT INTO `user_profiles` (`id`, `user_id`, `updated_at`, `avatar`, `first_name`, `last_name`, `gender`, `date_of_birth`, `country_id`, `about`, `is_private`) VALUES ('10', '11', '1975-04-22 00:52:17', '1', 'Axel', 'Kreiger', 'ud', '1984-07-23', '10', ' ', '0');


#
# TABLE STRUCTURE FOR: users
#

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `signed_up_at` timestamp NULL DEFAULT current_timestamp(),
  `username` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` bigint(20) unsigned DEFAULT NULL,
  `password_hash` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `signed_up_at`, `username`, `email`, `phone_number`, `password_hash`) VALUES ('11', '2012-12-10 06:12:34', 'tfritsch', 'ritchie.marcelle@example.org', '9108963131', '23d4d89f1b7ab2050da356dab531277356009c11');
INSERT INTO `users` (`id`, `signed_up_at`, `username`, `email`, `phone_number`, `password_hash`) VALUES ('12', '1976-08-25 16:11:28', 'sanford.reva', 'adan.hahn@example.org', '684', '1802886dc0ea41f2c433d76d845a8bdcbaa6d7a4');
INSERT INTO `users` (`id`, `signed_up_at`, `username`, `email`, `phone_number`, `password_hash`) VALUES ('13', '1975-02-04 03:12:23', 'ondricka.gennaro', 'hhyatt@example.net', '76', 'f44888f0954bd4e85b809cc009ebec0e8aefa44e');
INSERT INTO `users` (`id`, `signed_up_at`, `username`, `email`, `phone_number`, `password_hash`) VALUES ('14', '2010-03-18 01:27:37', 'porter.strosin', 'annabell.kunze@example.com', '545', '662eee2b58e51f90fc90f0dddcb1706725e0f62a');
INSERT INTO `users` (`id`, `signed_up_at`, `username`, `email`, `phone_number`, `password_hash`) VALUES ('15', '2003-05-16 13:56:43', 'lleffler', 'creinger@example.net', '0', '768747a4c12cb2ba8bf54ad90125d6cafdd9ab07');
INSERT INTO `users` (`id`, `signed_up_at`, `username`, `email`, `phone_number`, `password_hash`) VALUES ('16', '2002-06-14 05:50:16', 'hermann.zoie', 'carlee.stanton@example.net', '57', '3a93ae9b60f38e3abb7f31eade6dd92c5678e778');
INSERT INTO `users` (`id`, `signed_up_at`, `username`, `email`, `phone_number`, `password_hash`) VALUES ('18', '1974-01-30 04:11:05', 'milan.rutherford', 'dereck.glover@example.com', '417', 'd532f72b543f5273207d9683d091763f83a0e0f3');
INSERT INTO `users` (`id`, `signed_up_at`, `username`, `email`, `phone_number`, `password_hash`) VALUES ('19', '1978-01-19 16:14:37', 'hilll.sandy', 'everett.kovacek@example.com', '1', 'a52660d30b9566de9e8b08c9c0b3cf70a06dc3b0');
INSERT INTO `users` (`id`, `signed_up_at`, `username`, `email`, `phone_number`, `password_hash`) VALUES ('20', '1989-01-14 20:25:43', 'charber', 'tyrel92@example.com', '97', '8b29f57baf7275159bfdcd5631f76019f70a58da');


#
# TABLE STRUCTURE FOR: votes_on_genre
#

DROP TABLE IF EXISTS `votes_on_genre`;

CREATE TABLE `votes_on_genre` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title_id` bigint(20) unsigned DEFAULT NULL,
  `genre_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `vote` bit(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `title_id` (`title_id`),
  KEY `genre_id` (`genre_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `votes_on_genre_ibfk_1` FOREIGN KEY (`title_id`) REFERENCES `titles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `votes_on_genre_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `votes_on_genre_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `votes_on_genre` (`id`, `title_id`, `genre_id`, `user_id`, `vote`, `created_at`) VALUES ('1', '1', '1', '11', NULL, '1974-09-23 13:56:07');
INSERT INTO `votes_on_genre` (`id`, `title_id`, `genre_id`, `user_id`, `vote`, `created_at`) VALUES ('2', '2', '2', '12', NULL, '2015-11-25 17:55:01');
INSERT INTO `votes_on_genre` (`id`, `title_id`, `genre_id`, `user_id`, `vote`, `created_at`) VALUES ('3', '3', '3', '13', NULL, '2007-06-04 20:20:02');
INSERT INTO `votes_on_genre` (`id`, `title_id`, `genre_id`, `user_id`, `vote`, `created_at`) VALUES ('4', '4', '4', '14', NULL, '2004-11-01 21:51:30');
INSERT INTO `votes_on_genre` (`id`, `title_id`, `genre_id`, `user_id`, `vote`, `created_at`) VALUES ('5', '5', '5', '15', NULL, '1980-09-29 14:31:35');
INSERT INTO `votes_on_genre` (`id`, `title_id`, `genre_id`, `user_id`, `vote`, `created_at`) VALUES ('6', '6', '6', '16', NULL, '2004-01-13 22:01:08');
INSERT INTO `votes_on_genre` (`id`, `title_id`, `genre_id`, `user_id`, `vote`, `created_at`) VALUES ('7', '7', '7', '18', NULL, '1972-12-08 17:42:29');
INSERT INTO `votes_on_genre` (`id`, `title_id`, `genre_id`, `user_id`, `vote`, `created_at`) VALUES ('8', '8', '8', '19', NULL, '1983-12-05 02:44:41');
INSERT INTO `votes_on_genre` (`id`, `title_id`, `genre_id`, `user_id`, `vote`, `created_at`) VALUES ('9', '9', '9', '20', NULL, '2002-06-16 20:14:22');
INSERT INTO `votes_on_genre` (`id`, `title_id`, `genre_id`, `user_id`, `vote`, `created_at`) VALUES ('10', '10', '10', '11', NULL, '2000-04-28 13:48:00');


#
# TABLE STRUCTURE FOR: votes_on_keywords
#

DROP TABLE IF EXISTS `votes_on_keywords`;

CREATE TABLE `votes_on_keywords` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title_id` bigint(20) unsigned DEFAULT NULL,
  `keyword_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `vote` bit(1) DEFAULT b'1',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `title_id` (`title_id`),
  KEY `keyword_id` (`keyword_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `votes_on_keywords_ibfk_1` FOREIGN KEY (`title_id`) REFERENCES `titles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `votes_on_keywords_ibfk_2` FOREIGN KEY (`keyword_id`) REFERENCES `all_keywords` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `votes_on_keywords_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `votes_on_keywords` (`id`, `title_id`, `keyword_id`, `user_id`, `vote`, `created_at`) VALUES ('1', '1', '1', '11', '1', '2002-10-19 06:25:56');
INSERT INTO `votes_on_keywords` (`id`, `title_id`, `keyword_id`, `user_id`, `vote`, `created_at`) VALUES ('2', '2', '2', '12', '1', '1971-02-23 23:30:59');
INSERT INTO `votes_on_keywords` (`id`, `title_id`, `keyword_id`, `user_id`, `vote`, `created_at`) VALUES ('3', '3', '3', '13', '1', '2006-04-21 20:49:55');
INSERT INTO `votes_on_keywords` (`id`, `title_id`, `keyword_id`, `user_id`, `vote`, `created_at`) VALUES ('4', '4', '4', '14', '1', '1991-06-07 04:58:48');
INSERT INTO `votes_on_keywords` (`id`, `title_id`, `keyword_id`, `user_id`, `vote`, `created_at`) VALUES ('5', '5', '5', '15', '1', '2017-02-21 10:12:42');
INSERT INTO `votes_on_keywords` (`id`, `title_id`, `keyword_id`, `user_id`, `vote`, `created_at`) VALUES ('6', '6', '6', '16', '1', '2015-09-11 19:53:30');
INSERT INTO `votes_on_keywords` (`id`, `title_id`, `keyword_id`, `user_id`, `vote`, `created_at`) VALUES ('7', '7', '7', '18', '1', '2011-11-03 19:01:09');
INSERT INTO `votes_on_keywords` (`id`, `title_id`, `keyword_id`, `user_id`, `vote`, `created_at`) VALUES ('8', '8', '8', '19', '1', '1996-05-06 17:25:03');
INSERT INTO `votes_on_keywords` (`id`, `title_id`, `keyword_id`, `user_id`, `vote`, `created_at`) VALUES ('9', '9', '9', '20', '1', '2020-05-06 01:32:52');
INSERT INTO `votes_on_keywords` (`id`, `title_id`, `keyword_id`, `user_id`, `vote`, `created_at`) VALUES ('10', '10', '10', '11', '1', '1997-08-26 13:25:40');


#
# TABLE STRUCTURE FOR: watchlist
#

DROP TABLE IF EXISTS `watchlist`;

CREATE TABLE `watchlist` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `is_seen` bit(1) DEFAULT b'0',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `title_id` (`title_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `watchlist_ibfk_1` FOREIGN KEY (`title_id`) REFERENCES `titles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `watchlist_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `watchlist` (`id`, `title_id`, `user_id`, `is_seen`, `created_at`, `updated_at`) VALUES ('1', '1', '11', '1', '1980-01-07 07:15:33', '2008-05-26 05:46:53');
INSERT INTO `watchlist` (`id`, `title_id`, `user_id`, `is_seen`, `created_at`, `updated_at`) VALUES ('2', '2', '12', '0', '2005-01-12 20:57:47', '1989-10-29 02:36:28');
INSERT INTO `watchlist` (`id`, `title_id`, `user_id`, `is_seen`, `created_at`, `updated_at`) VALUES ('3', '3', '13', '1', '2012-07-02 01:39:31', '2020-11-25 01:42:37');
INSERT INTO `watchlist` (`id`, `title_id`, `user_id`, `is_seen`, `created_at`, `updated_at`) VALUES ('4', '4', '14', '0', '1970-05-15 23:45:21', '2020-03-12 22:28:28');
INSERT INTO `watchlist` (`id`, `title_id`, `user_id`, `is_seen`, `created_at`, `updated_at`) VALUES ('5', '5', '15', '1', '1986-05-05 12:54:56', '2002-05-02 05:28:45');
INSERT INTO `watchlist` (`id`, `title_id`, `user_id`, `is_seen`, `created_at`, `updated_at`) VALUES ('6', '6', '16', '0', '2011-03-06 06:05:13', '2010-10-29 02:10:43');
INSERT INTO `watchlist` (`id`, `title_id`, `user_id`, `is_seen`, `created_at`, `updated_at`) VALUES ('7', '7', '18', '1', '1977-04-17 05:03:12', '1986-10-15 11:39:47');
INSERT INTO `watchlist` (`id`, `title_id`, `user_id`, `is_seen`, `created_at`, `updated_at`) VALUES ('8', '8', '19', '0', '2021-06-14 16:07:27', '2000-06-02 20:22:29');
INSERT INTO `watchlist` (`id`, `title_id`, `user_id`, `is_seen`, `created_at`, `updated_at`) VALUES ('9', '9', '20', '0', '1996-04-18 04:30:16', '1986-06-23 19:46:39');
INSERT INTO `watchlist` (`id`, `title_id`, `user_id`, `is_seen`, `created_at`, `updated_at`) VALUES ('10', '10', '11', '1', '2008-06-23 10:03:30', '1993-12-21 22:27:21');


