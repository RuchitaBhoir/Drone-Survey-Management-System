CREATE DATABASE  IF NOT EXISTS "drone_survey_db" /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `drone_survey_db`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: mysql-22b4f09b-ashishsiot-1be3.h.aivencloud.com    Database: drone_survey_db
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '125ffd4f-0644-11f1-8336-862ccfb062c6:1-16,
78331da0-fb6e-11f0-81b2-862ccfb05de2:1-94';

--
-- Table structure for table `drones`
--

DROP TABLE IF EXISTS `drones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `drone_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('AVAILABLE','IN_MISSION') COLLATE utf8mb4_unicode_ci DEFAULT 'AVAILABLE',
  `battery_level` int DEFAULT '100',
  `last_location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_battery_level` (`battery_level`),
  CONSTRAINT `drones_chk_1` CHECK (((`battery_level` >= 0) and (`battery_level` <= 100)))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drones`
--

LOCK TABLES `drones` WRITE;
/*!40000 ALTER TABLE `drones` DISABLE KEYS */;
INSERT INTO `drones` VALUES (1,'DJI Phantom 4 Pro','IN_MISSION',95,'Hangar A, Bay 1','2026-01-27 12:12:36'),(2,'DJI Mavic 3','IN_MISSION',78,'Field Site Alpha','2026-01-27 12:12:36'),(3,'Autel EVO II','IN_MISSION',100,'Hangar B, Bay 3','2026-01-27 12:12:36');
/*!40000 ALTER TABLE `drones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `missions`
--

DROP TABLE IF EXISTS `missions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `missions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mission_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `area_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `altitude` int DEFAULT '100',
  `pattern_type` enum('PERIMETER','CROSSHATCH') COLLATE utf8mb4_unicode_ci DEFAULT 'PERIMETER',
  `status` enum('PLANNED','IN_PROGRESS','PAUSED','COMPLETED','ABORTED') COLLATE utf8mb4_unicode_ci DEFAULT 'PLANNED',
  `progress` int DEFAULT '0',
  `center_lat` decimal(10,8) DEFAULT NULL,
  `center_lng` decimal(11,8) DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `paused_at` timestamp NULL DEFAULT NULL,
  `aborted_at` timestamp NULL DEFAULT NULL,
  `last_progress_update` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_pattern_type` (`pattern_type`),
  KEY `idx_started_at` (`started_at`),
  KEY `idx_center_location` (`center_lat`,`center_lng`),
  CONSTRAINT `missions_chk_1` CHECK (((`progress` >= 0) and (`progress` <= 100)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `missions`
--

LOCK TABLES `missions` WRITE;
/*!40000 ALTER TABLE `missions` DISABLE KEYS */;
INSERT INTO `missions` VALUES (1,'Agricultural Survey Mission','North Field Area',120,'CROSSHATCH','PLANNED',0,NULL,NULL,NULL,NULL,NULL,NULL,'2026-01-27 12:12:36'),(2,'Perimeter Mapping','Construction Site B',80,'PERIMETER','IN_PROGRESS',45,NULL,NULL,NULL,NULL,NULL,NULL,'2026-01-27 12:12:36'),(3,'Forest Coverage Scan','National Park Zone 3',150,'CROSSHATCH','COMPLETED',100,NULL,NULL,NULL,NULL,NULL,NULL,'2026-01-27 12:12:36'),(4,'Priya Home Construction mission','Mumbai',103,'PERIMETER','IN_PROGRESS',99,NULL,NULL,'2026-01-27 19:45:53',NULL,NULL,'2026-01-27 19:50:52','2026-01-27 19:43:33'),(5,'Test Mission','Chruch Road',100,'PERIMETER','IN_PROGRESS',17,NULL,NULL,'2026-01-27 20:13:56',NULL,NULL,'2026-01-27 20:14:49','2026-01-27 20:05:12');
/*!40000 ALTER TABLE `missions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveys`
--

DROP TABLE IF EXISTS `surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surveys` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `status` enum('pending','in_progress','completed','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_createdAt` (`createdAt`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surveys`
--

LOCK TABLES `surveys` WRITE;
/*!40000 ALTER TABLE `surveys` DISABLE KEYS */;
INSERT INTO `surveys` VALUES (1,'Agricultural Field Survey','Survey of 50-acre corn field for crop health analysis','Farm Road 123, County A',40.71280000,-74.00600000,'pending','2026-01-27 12:12:36','2026-01-27 12:12:36',NULL),(2,'Construction Site Mapping','3D mapping of construction site for progress tracking','Downtown District',40.75890000,-73.98510000,'in_progress','2026-01-27 12:12:36','2026-01-27 12:12:36',NULL),(3,'Wildlife Habitat Assessment','Aerial survey of forest area for wildlife monitoring','National Park Reserve',40.74890000,-73.96800000,'completed','2026-01-27 12:12:36','2026-01-27 12:12:36',NULL);
/*!40000 ALTER TABLE `surveys` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-10 11:23:27
