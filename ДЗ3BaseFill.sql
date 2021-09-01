#
# TABLE STRUCTURE FOR: friendship
#

DROP TABLE IF EXISTS `friendship`;

CREATE TABLE `friendship` (
  `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на инициатора дружеских отношений',
  `friend_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на получателя запроса о дружбе',
  `request_type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Тип запроса',
  `requested_at` datetime DEFAULT NULL COMMENT 'Время отправки приглашения',
  `confirmed_at` datetime DEFAULT NULL COMMENT 'Время подтверждения приглашения',
  `created_at` datetime DEFAULT NULL COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT NULL COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`user_id`,`friend_id`) COMMENT 'Составной первичный ключ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#
# TABLE STRUCTURE FOR: profiles
#

DROP TABLE IF EXISTS `profiles`;

CREATE TABLE `profiles` (
  `user_id` int(10) unsigned NOT NULL COMMENT 'Идентификатор строки',
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Город проживания',
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Страна проживания',
  `status` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Текущий статус',
  `сreated_at` datetime DEFAULT NULL COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT NULL COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `profiles_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица профилей';

#
# TABLE STRUCTURE FOR: users
#

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Имя пользователей',
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Пол',
  `birthday` date NOT NULL COMMENT 'Пол',
  `gender` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Пол',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Email пользователя',
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Номер телефона пользователя',
  `created_at` datetime DEFAULT NULL COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT NULL COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица пользователей';

INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (1, 'Dayana', 'Kuhic', '1979-09-30', 'a', 'margaret.nienow@example.net', '08657797200', '1985-05-17 15:32:38', '1975-03-31 07:32:08');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (2, 'Edwina', 'Mosciski', '2001-03-18', 'q', 'zlubowitz@example.net', '(715)064-26', '1989-11-27 03:28:33', '1995-09-27 08:51:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (3, 'Heber', 'Zemlak', '1970-12-08', 'f', 'viva76@example.com', '+35(4)28986', '1975-12-15 10:14:39', '2003-11-08 22:38:55');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (4, 'Leon', 'Marks', '2010-11-04', 'j', 'sigurd78@example.net', '+00(3)88859', '2006-07-16 23:53:05', '2014-07-26 22:48:25');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (5, 'Armand', 'Abbott', '1987-07-26', 'o', 'vidal.corwin@example.com', '09504649145', '2018-06-23 19:14:37', '2002-04-22 16:36:24');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (6, 'Keith', 'Wilkinson', '2009-11-23', 'q', 'raphaelle.daniel@example.net', '1-423-524-4', '2005-09-09 17:14:22', '2001-12-19 18:22:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (7, 'Merle', 'Shields', '1999-01-11', 'l', 'jillian34@example.net', '05299721123', '2021-03-01 20:09:57', '2004-02-26 16:35:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (8, 'Peggie', 'Ferry', '2009-07-24', 'v', 'jacobi.era@example.org', '658.665.182', '1979-09-03 18:55:04', '1979-08-18 02:18:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (9, 'Coleman', 'Luettgen', '2017-02-15', 'u', 'marks.derrick@example.org', '1-839-516-8', '1983-11-19 10:08:34', '1993-02-13 19:19:03');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (10, 'Lisette', 'Gorczany', '2021-07-06', 'b', 'nbrown@example.com', '(329)442-27', '1983-08-22 09:17:07', '1979-02-16 12:44:12');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (11, 'Torrey', 'Halvorson', '1984-09-24', 'v', 'zoie.carroll@example.com', '+42(3)79514', '1999-06-21 04:18:57', '1971-02-28 17:23:12');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (12, 'Sonya', 'Schmeler', '2001-10-16', 'j', 'vlarkin@example.net', '+35(5)48852', '2013-11-09 02:11:16', '2004-01-09 03:49:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (13, 'Mallory', 'Mosciski', '2014-01-26', 'q', 'lonny39@example.com', '167.994.840', '1989-06-03 18:11:21', '1991-12-26 16:53:19');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (14, 'Nina', 'Schuppe', '1989-07-22', 'o', 'ike27@example.org', '(754)811-41', '1994-12-27 21:08:14', '1982-10-01 03:05:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (15, 'Dorian', 'O\'Connell', '1985-12-29', 'f', 'ward.alden@example.net', '1-254-518-5', '2007-02-24 18:55:25', '2019-03-24 04:31:28');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (16, 'Lexie', 'McDermott', '2007-12-14', 'r', 'abshire.chester@example.com', '059.000.879', '2009-06-09 03:47:13', '1990-12-03 00:59:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (17, 'Halie', 'Barrows', '1973-07-05', 'f', 'shirley.ward@example.com', '1-573-000-3', '2020-05-07 18:34:39', '1995-05-27 03:55:44');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (18, 'Lulu', 'Sawayn', '1981-07-27', 'x', 'goldner.morgan@example.org', '(161)293-18', '1976-12-27 02:41:15', '2018-05-04 04:13:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (19, 'Marie', 'Rohan', '1973-04-05', 'f', 'dhowell@example.org', '(203)193-95', '1994-02-20 19:15:52', '2021-01-06 18:55:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (20, 'Walton', 'Sawayn', '1981-02-23', 'n', 'houston.davis@example.org', '1-396-503-0', '2010-08-11 11:43:05', '1971-12-31 19:57:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (21, 'Annabell', 'Hane', '2011-08-05', 'h', 'qmertz@example.net', '(707)710-99', '1998-04-03 04:17:57', '2017-07-28 18:55:20');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (22, 'Fern', 'Gislason', '1999-01-11', 'd', 'ryan.violette@example.com', '511-790-465', '1994-06-24 11:08:37', '2012-08-30 16:17:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (23, 'Lucienne', 'Hirthe', '1988-05-09', 'c', 'rupert.willms@example.org', '+64(1)21204', '1999-12-05 18:04:57', '1976-08-23 23:58:00');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (24, 'Jackeline', 'Stokes', '2011-07-17', 'v', 'lmills@example.com', '502-108-275', '1984-05-23 04:18:18', '2007-10-29 13:54:17');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (25, 'Darrin', 'Wolf', '1971-05-31', 'p', 'arne.ratke@example.org', '214.175.471', '2012-10-11 15:50:47', '1978-08-04 14:54:57');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (26, 'Chad', 'Hoppe', '1995-12-03', 'v', 'ellie.jones@example.net', '+90(7)64412', '2003-07-22 08:07:06', '1990-06-30 16:21:29');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (27, 'Cassandre', 'Lesch', '2008-11-01', 'b', 'jovan.white@example.net', '1-055-915-5', '2001-01-08 12:37:31', '1986-09-30 18:34:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (28, 'Catalina', 'Jaskolski', '2003-12-19', 'x', 'allison.shanahan@example.com', '1-019-688-1', '1978-12-27 10:28:14', '2020-06-20 09:34:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (29, 'Salma', 'Boehm', '1999-11-07', 's', 'hoppe.vada@example.org', '1-420-603-9', '1972-04-12 09:23:16', '2015-12-06 16:37:20');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (30, 'Kristy', 'Hyatt', '1998-06-17', 'z', 'zturner@example.com', '136.357.147', '2009-02-27 01:06:42', '2009-08-10 19:26:31');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (31, 'Emmy', 'Greenfelder', '1983-02-14', 'z', 'hamill.avery@example.com', '(519)632-71', '2014-10-21 13:43:54', '1988-11-03 02:51:05');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (32, 'Ozella', 'Murazik', '1971-07-09', 'g', 'deckow.ben@example.com', '1-078-313-1', '1979-04-15 13:41:11', '2015-11-25 07:12:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (33, 'Amy', 'Brakus', '2014-08-10', 'z', 'dwisozk@example.com', '994.625.721', '1984-07-02 11:25:03', '1976-08-07 16:02:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (34, 'Spencer', 'Trantow', '2001-03-30', 'b', 'arjun03@example.net', '326-313-223', '1989-09-26 20:45:01', '2003-11-25 01:40:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (35, 'Arturo', 'Walter', '2011-11-03', 'h', 'aniya27@example.org', '(225)450-04', '2019-10-17 06:34:51', '2010-01-19 05:23:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (36, 'Gail', 'Pollich', '2006-04-30', 'k', 'hbalistreri@example.net', '1-950-411-4', '1978-09-03 03:58:05', '1998-01-15 14:46:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (37, 'Citlalli', 'Welch', '1986-09-26', 'o', 'bosco.ima@example.net', '00669865058', '2017-01-19 11:31:00', '2007-05-21 05:58:02');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (38, 'Dell', 'Stehr', '1985-01-27', 'k', 'myrtis08@example.org', '654.983.696', '1981-07-02 15:46:16', '1973-11-24 19:42:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (39, 'Emanuel', 'Nitzsche', '2018-03-13', 'c', 'fabian13@example.com', '(478)623-15', '2005-12-05 02:50:55', '2002-10-29 09:42:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (40, 'Maxwell', 'Rosenbaum', '1988-01-20', 'j', 'lisandro.gleichner@example.com', '554.003.539', '2005-12-21 13:30:21', '1986-07-24 23:07:43');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (41, 'Misty', 'Bins', '1975-06-06', 'l', 'feeney.darrell@example.com', '442-927-661', '1983-02-11 19:10:26', '2005-05-14 15:26:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (42, 'Tony', 'Krajcik', '2015-11-03', 's', 'devyn.boehm@example.net', '600.178.101', '2020-07-25 03:32:15', '1988-01-29 09:35:13');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (43, 'Davonte', 'Muller', '2001-01-08', 's', 'block.eldred@example.com', '(107)524-77', '1980-01-19 13:23:53', '2004-02-09 00:07:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (44, 'Jettie', 'Simonis', '2000-07-12', 'n', 'hodkiewicz.ethelyn@example.com', '(560)606-02', '1990-07-14 21:00:06', '2014-06-07 15:02:15');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (45, 'Jude', 'Stamm', '1971-10-26', 'e', 'yeichmann@example.com', '1-672-871-8', '1998-09-29 09:26:54', '2013-06-02 09:04:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (46, 'Savannah', 'Jakubowski', '2014-03-24', 'e', 'granville.runolfsdottir@example.com', '245-587-596', '1977-07-13 14:18:30', '1998-11-13 01:28:21');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (47, 'Graham', 'Legros', '1988-10-09', 'a', 'douglas23@example.org', '(107)978-15', '1987-08-27 06:38:14', '2019-05-15 15:32:55');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (48, 'Tyson', 'Bartell', '2021-02-25', 'j', 'ashly62@example.com', '(791)286-47', '2008-08-01 19:53:11', '1987-09-16 09:52:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (49, 'Jamarcus', 'Larkin', '2011-12-18', 'w', 'pmueller@example.net', '851.961.791', '1984-02-10 17:44:52', '1997-10-04 17:31:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (50, 'Allan', 'Brekke', '1976-09-06', 'e', 'hilll.brisa@example.net', '260-463-873', '2018-08-26 13:49:37', '2007-01-06 15:03:41');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (51, 'Linnie', 'Beer', '1994-10-12', 'o', 'marvin.oceane@example.org', '+02(9)24272', '1990-01-11 01:15:00', '1984-10-21 18:09:49');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (52, 'Katrine', 'Schimmel', '1977-09-04', 'x', 'ritchie.maureen@example.net', '362.470.986', '1984-04-18 10:12:57', '1985-12-06 11:39:43');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (53, 'Magali', 'Rice', '1997-08-24', 'd', 'jaqueline03@example.net', '(285)430-54', '2018-06-06 17:41:52', '2002-03-27 15:10:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (54, 'Christop', 'Daugherty', '2004-02-13', 'u', 'kshlerin.amir@example.org', '(483)210-92', '1977-07-28 03:57:39', '2005-03-28 08:23:49');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (55, 'Taya', 'Gleichner', '2004-08-22', 's', 'ycorwin@example.org', '(739)042-99', '1997-09-03 06:42:10', '2003-05-16 22:08:19');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (56, 'Adelle', 'Cummings', '2020-06-20', 'u', 'jane28@example.org', '+46(5)28425', '1980-03-03 05:25:01', '1988-07-28 16:37:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (57, 'Camille', 'Bode', '1984-06-05', 'o', 'lukas55@example.com', '+15(8)52406', '1986-05-28 11:52:22', '1980-02-29 03:48:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (58, 'Bertram', 'Ziemann', '2004-10-20', 'n', 'lwill@example.org', '07850015714', '1995-12-16 08:33:25', '2014-06-23 18:01:48');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (59, 'Janelle', 'Williamson', '1978-06-13', 'f', 'raven64@example.net', '730-605-018', '1990-09-24 07:27:52', '1976-02-02 09:37:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (60, 'Matilda', 'Kertzmann', '2020-10-06', 'm', 'dickinson.libby@example.com', '1-718-076-4', '2014-01-26 07:14:45', '2009-02-09 06:11:45');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (61, 'Stacy', 'Block', '2003-09-09', 'a', 'batz.arden@example.org', '624.776.451', '2012-11-07 17:05:20', '2003-02-21 15:08:39');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (62, 'Ayla', 'Sporer', '1999-06-23', 'p', 'wilhelm32@example.com', '910-546-232', '1985-02-28 05:02:11', '2020-05-31 02:29:12');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (63, 'Viola', 'Donnelly', '1970-05-15', 'v', 'farrell.gardner@example.org', '556.634.847', '2005-06-26 06:29:52', '1993-09-28 23:08:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (64, 'Oda', 'Hoeger', '2014-09-13', 'z', 'predovic.unique@example.net', '(531)378-87', '1985-05-02 06:50:12', '1971-12-16 18:00:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (65, 'Amir', 'Blick', '1972-07-28', 'q', 'littel.edison@example.org', '644-221-984', '2004-06-03 19:38:03', '1989-02-14 07:34:23');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (66, 'Glenna', 'Lueilwitz', '1984-11-29', 'w', 'uhickle@example.com', '094.933.317', '2007-09-11 22:15:36', '2005-06-04 18:46:12');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (67, 'Arno', 'Schulist', '2011-09-24', 'p', 'weissnat.brant@example.com', '948.354.331', '2011-10-07 05:30:31', '1984-01-22 03:58:57');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (68, 'Tracey', 'Mayer', '2011-02-05', 'r', 'hailee.kilback@example.com', '(890)951-63', '1988-05-01 03:10:38', '1983-05-16 03:33:14');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (69, 'Rickey', 'Schinner', '2013-03-02', 'l', 'shana.collier@example.org', '(785)154-87', '1983-08-08 23:29:00', '2006-06-23 14:33:39');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (70, 'Lizzie', 'Muller', '1999-12-14', 'e', 'xblock@example.org', '(183)910-07', '1999-12-11 21:45:52', '1988-10-30 08:46:08');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (71, 'Cassidy', 'Corwin', '1981-06-16', 'g', 'effie35@example.com', '+36(0)91481', '1976-04-28 02:53:30', '1983-01-26 03:32:05');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (72, 'Christian', 'Marvin', '1986-04-10', 'a', 'ansel.friesen@example.org', '823-642-985', '2002-11-13 12:06:38', '1982-06-01 08:31:20');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (73, 'Patrick', 'Kemmer', '1986-03-25', 'b', 'toni.kautzer@example.org', '1-457-137-0', '1977-01-28 10:24:55', '2002-03-04 05:53:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (74, 'Keeley', 'Schroeder', '2009-04-03', 'r', 'emelia53@example.org', '08511574966', '1997-04-02 14:36:01', '1995-10-29 10:49:06');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (75, 'Paul', 'Crist', '2004-02-27', 'q', 'gisselle.hickle@example.org', '266-146-406', '1971-03-22 09:17:05', '1986-06-07 05:51:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (76, 'Edgardo', 'Gleason', '1972-09-14', 'c', 'bonnie.bahringer@example.com', '03259195363', '2018-05-13 04:47:46', '1996-12-25 01:39:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (77, 'Lavinia', 'Quigley', '1997-02-07', 'n', 'bianka10@example.org', '034.478.082', '1986-06-13 08:01:20', '1981-08-24 11:56:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (78, 'Cleora', 'Gleason', '1994-09-04', 'l', 'brionna.cremin@example.com', '1-639-609-6', '1985-11-30 18:16:05', '2013-08-02 20:41:00');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (79, 'Baron', 'Jaskolski', '1980-04-05', 'e', 'zwintheiser@example.net', '698-931-282', '1995-10-15 11:57:47', '2007-12-24 13:39:57');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (80, 'Kellie', 'Turcotte', '2021-02-11', 'q', 'dario.runolfsson@example.org', '124.403.152', '1980-03-30 05:19:52', '2012-11-22 02:13:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (81, 'Alexa', 'Gottlieb', '1978-12-18', 'p', 'bschaefer@example.org', '1-778-190-4', '1994-12-21 02:44:18', '1982-12-01 13:59:35');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (82, 'Laisha', 'Kshlerin', '2008-07-11', 'v', 'gregory20@example.com', '434-011-676', '1970-05-16 11:35:41', '1976-02-18 15:39:06');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (83, 'Alexane', 'Predovic', '2001-04-08', 'l', 'kenny23@example.net', '235.529.573', '2012-07-13 11:07:33', '1978-01-08 07:27:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (84, 'Russ', 'Hand', '1990-09-25', 'o', 'gaylord.lemke@example.org', '859.339.035', '1981-06-15 13:51:43', '1970-01-05 10:20:37');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (85, 'Brisa', 'Runolfsdottir', '2019-03-02', 'j', 'sauer.kory@example.net', '426.011.727', '1978-07-27 01:28:01', '2003-03-25 08:08:35');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (86, 'Nina', 'Parisian', '2002-08-27', 'a', 'jacobson.manuel@example.net', '(616)270-76', '1979-02-18 09:15:11', '2013-09-20 07:30:57');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (87, 'Caleigh', 'Kirlin', '2005-10-24', 'k', 'raheem.graham@example.com', '108.807.301', '1991-11-02 06:50:57', '2021-08-30 11:52:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (88, 'Will', 'Roob', '1980-07-07', 'b', 'edward.zulauf@example.net', '(780)280-10', '2017-08-24 08:58:04', '1971-05-12 04:50:07');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (89, 'Hettie', 'Hessel', '1986-05-14', 'z', 'werner80@example.net', '640.220.376', '2005-01-28 21:37:46', '1976-11-27 11:29:08');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (90, 'Granville', 'Hayes', '1980-08-13', 'r', 'schimmel.lavonne@example.org', '534-994-077', '1977-01-26 05:13:15', '1989-10-09 14:20:55');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (91, 'Mabelle', 'Padberg', '1974-10-19', 'v', 'vjenkins@example.org', '1-651-143-3', '1992-12-08 08:53:40', '2011-12-13 19:09:08');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (92, 'Pierre', 'Turcotte', '2005-11-05', 's', 'javier35@example.com', '299-137-359', '1971-02-16 23:00:16', '1973-03-14 23:33:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (93, 'Ed', 'Bashirian', '1990-08-13', 'o', 'aniya32@example.net', '(360)964-33', '1993-12-23 17:00:55', '1991-04-17 23:29:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (94, 'Ursula', 'Herman', '2018-03-28', 'y', 'carlee.bashirian@example.net', '(861)590-19', '2015-08-02 04:31:26', '2011-11-23 01:03:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (95, 'Leonardo', 'Ward', '1973-02-15', 'i', 'annabel.pacocha@example.com', '1-940-255-1', '2004-01-26 23:14:59', '2011-04-12 16:33:27');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (96, 'Stella', 'Champlin', '1994-03-14', 'y', 'hayden95@example.com', '216-720-873', '2004-07-25 15:37:55', '2016-11-19 08:58:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (97, 'Regan', 'Mraz', '1970-07-19', 'i', 'kimberly.lubowitz@example.com', '+45(6)37539', '1974-03-09 07:23:22', '2005-03-05 01:28:31');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (98, 'Angela', 'Wintheiser', '1993-12-23', 's', 'ilene46@example.net', '1-496-512-5', '2010-08-30 09:33:22', '2013-09-17 21:19:08');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (99, 'Brittany', 'Keebler', '1996-08-21', 'u', 'pward@example.net', '237.165.235', '1997-10-09 19:10:47', '1981-05-18 14:06:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`, `created_at`, `updated_at`) VALUES (100, 'Elias', 'Bernhard', '2004-07-17', 'o', 'mose48@example.org', '668.250.314', '2005-09-20 15:04:42', '1983-12-02 22:12:30');


