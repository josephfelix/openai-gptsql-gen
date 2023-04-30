USE `dbreport_test`;

DROP TABLE IF EXISTS `users`;

/*!40101 SET @saved_cs_client     = @@character_set_client */
;

/*!50503 SET character_set_client = utf8mb4 */
;

CREATE TABLE `users` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT 'User first name',
  `lastname` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT 'User last name',
  `email` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT 'User email',
  `created_at` datetime COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'User created at on datetime format',
  `updated_at` datetime COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'User updated at on datetime format',
  `deleted_at` datetime COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'User deleted at on datetime format',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPRESSED COMMENT = 'Users table';

/*!40101 SET character_set_client = @saved_cs_client */
;

INSERT INTO `users` (`firstname`, `lastname`, `email`, `created_at`, `updated_at`, `deleted_at`)
VALUES
('John', 'Doe', 'john.doe@example.com', '2023-04-30 10:00:00', '2023-04-30 11:30:00', NULL),
('Jane', 'Doe', 'jane.doe@example.com', '2023-04-29 09:30:00', '2023-04-30 14:15:00', NULL),
('Bob', 'Smith', 'bob.smith@example.com', '2023-04-28 14:00:00', '2023-04-29 16:45:00', NULL),
('Alice', 'Johnson', 'alice.johnson@example.com', '2023-04-27 08:45:00', '2023-04-29 10:30:00', NULL),
('Tom', 'Lee', 'tom.lee@example.com', '2023-04-26 11:00:00', '2023-04-27 13:30:00', NULL),
('Mary', 'Johnson', 'mary.johnson@example.com', '2023-04-25 10:30:00', '2023-04-26 12:15:00', NULL),
('Peter', 'Brown', 'peter.brown@example.com', '2023-04-24 09:00:00', '2023-04-25 11:30:00', NULL),
('Karen', 'Davis', 'karen.davis@example.com', '2023-04-23 12:30:00', '2023-04-24 15:00:00', NULL),
('Jack', 'Wilson', 'jack.wilson@example.com', '2023-04-22 14:00:00', '2023-04-23 16:30:00', NULL),
('Sara', 'Jones', 'sara.jones@example.com', '2023-04-21 10:15:00', '2023-04-22 12:45:00', NULL),
('Mike', 'Johnson', 'mike.johnson@example.com', '2023-04-20 08:30:00', '2023-04-21 10:45:00', '2023-04-21 10:45:00'),
('Kelly', 'Smith', 'kelly.smith@example.com', '2023-04-19 09:45:00', '2023-04-20 11:30:00', NULL),
('Mark', 'Taylor', 'mark.taylor@example.com', '2023-04-18 12:00:00', '2023-04-19 14:15:00', NULL),
('Emily', 'White', 'emily.white@example.com', '2023-04-17 14:30:00', '2023-04-18 16:45:00', NULL),
('David', 'Brown', 'david.brown@example.com', '2023-04-16 09:00:00', '2023-04-17 11:30:00', NULL),
('Lisa', 'Johnson', 'lisa.johnson@example.com', '2023-04-15 11:15:00', '2023-04-16 13:45:00', NULL);