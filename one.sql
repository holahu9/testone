CREATE DATABASE `plusone` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
CREATE TABLE `event_guests` (
  `event_guests_id` int NOT NULL AUTO_INCREMENT,
  `event_invitation_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `attended` tinyint DEFAULT NULL,
  `event_guestscol` varchar(45) DEFAULT NULL,
  `date_created` timestamp NULL DEFAULT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`event_guests_id`),
  UNIQUE KEY `event_invitation_id_UNIQUE` (`event_invitation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
​
​
CREATE TABLE `events` (
  `events_id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(45) DEFAULT NULL,
  `event_description` varchar(300) DEFAULT NULL,
  `event_location` varchar(200) DEFAULT NULL,
  `event_date` varchar(25) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`events_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
​
​
CREATE TABLE `events_invitation` (
  `event_invitation_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `event_id` int DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`event_invitation_id`),
  UNIQUE KEY `user_event_UNIQUE` (`user_id`,`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
​
​
CREATE TABLE `thread_responses` (
  `thread_responses_id` int NOT NULL AUTO_INCREMENT,
  `thread_id` int DEFAULT NULL,
  `response_content` blob,
  `user_id` int DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`thread_responses_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
​
​
CREATE TABLE `thread_reviews` (
  `thread_id` int NOT NULL AUTO_INCREMENT,
  `thread_title` varchar(45) DEFAULT NULL,
  `initial_post_content` blob,
  `user_id` int DEFAULT NULL,
  `event_invitation_id` int unsigned DEFAULT NULL,
  `post_id` int DEFAULT NULL,
  `guest_id` int DEFAULT NULL,
  `date_created` timestamp NOT NULL,
  PRIMARY KEY (`thread_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
​
​
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `hash_password` varchar(120) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `zoom_id` varchar(45) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_email_UNIQUE` (`email`),
  UNIQUE KEY `zoom_id_UNIQUE` (`zoom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
​
​
-- Views
​
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `plusone`.`get_all_event_guests` AS select `plusone`.`event_guests`.`event_guests_id` AS `event_guests_id`,`plusone`.`event_guests`.`event_invitation_id` AS `event_invitation_id`,`plusone`.`event_guests`.`user_id` AS `user_id`,`plusone`.`event_guests`.`attended` AS `attended`,`plusone`.`event_guests`.`event_guestscol` AS `event_guestscol`,`plusone`.`event_guests`.`date_created` AS `date_created`,`plusone`.`event_guests`.`date_modified` AS `date_modified` from `plusone`.`event_guests`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `plusone`.`get_all_events` AS select `plusone`.`events`.`events_id` AS `events_id`,`plusone`.`events`.`event_name` AS `event_name`,`plusone`.`events`.`event_location` AS `event_location`,`plusone`.`events`.`event_start_date` AS `event_start_date`,`plusone`.`events`.`event_end_date` AS `event_end_date`,`plusone`.`events`.`outdoor` AS `outdoor`,`plusone`.`events`.`date_created` AS `date_created` from `plusone`.`events`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `plusone`.`get_all_users` AS select `plusone`.`users`.`user_id` AS `user_id`,`plusone`.`users`.`user_email` AS `user_email`,`plusone`.`users`.`hash_password` AS `hash_password`,`plusone`.`users`.`first_name` AS `first_name`,`plusone`.`users`.`last_name` AS `last_name`,`plusone`.`users`.`zoom_id` AS `zoom_id`,`plusone`.`users`.`date_created` AS `date_created` from `plusone`.`users`;
​
​
-- Stored Procedure
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_credentials`(
	var_email varchar(45)
)
BEGIN
	select email, hash_password from users
    where email = var_email;
END$$
DELIMITER ;
​
​
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_users`()
BEGIN
SELECT * from users;
END$$
DELIMITER ;
​
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_into_users`(
	email varchar(45), 
    hash_password varchar(120), 
    first_name varchar(45), 
    last_name  varchar(45),
    gender enum('male','female'),
    phone_number varchar(15)
)
BEGIN
INSERT INTO users (email, hash_password, first_name, last_name, gender, phone_number)
VALUES (user_email, hash_password, first_name, last_name, gender, phone_number );
END$$
DELIMITER ;