USE `dbreport_test`;

DROP TABLE IF EXISTS `embeddings`;

/*!40101 SET @saved_cs_client     = @@character_set_client */
;

/*!50503 SET character_set_client = utf8mb4 */
;

CREATE TABLE `embeddings` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT 'Table name',
  `column_name` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT 'Column name',
  `embedding` text COLLATE utf8mb4_bin NOT NULL COMMENT 'Column embedding',
  `created_at` datetime COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Embedding created at on datetime format',
  `updated_at` datetime COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Embedding updated at on datetime format',
  `deleted_at` datetime COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Embedding deleted at on datetime format',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPRESSED COMMENT = 'Users table';

/*!40101 SET character_set_client = @saved_cs_client */
;