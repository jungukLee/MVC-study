-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
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

--
-- Table structure for table `dgroup`
--

DROP TABLE IF EXISTS `dgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dgroup` (
  `groupIDX` int NOT NULL AUTO_INCREMENT,
  `fk_memberIDX` int NOT NULL,
  `title` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  `category` varchar(45) NOT NULL,
  `generation` varchar(45) NOT NULL,
  `introduce` varchar(2000) NOT NULL,
  `likes` int DEFAULT '0',
  `cread_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`groupIDX`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dgroup`
--

LOCK TABLES `dgroup` WRITE;
/*!40000 ALTER TABLE `dgroup` DISABLE KEYS */;
INSERT INTO `dgroup` VALUES (75,4,'312','부산','영화','312','132',3,'2023-12-09 14:14:29','1702131269555_스크린샷(1).png');
/*!40000 ALTER TABLE `dgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_board`
--

DROP TABLE IF EXISTS `group_board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_board` (
  `boardIDX` int NOT NULL AUTO_INCREMENT,
  `fk_groupIDX` int NOT NULL,
  `fk_memberIDX` int NOT NULL,
  `content` varchar(45) NOT NULL,
  `cread_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`boardIDX`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_board`
--

LOCK TABLES `group_board` WRITE;
/*!40000 ALTER TABLE `group_board` DISABLE KEYS */;
INSERT INTO `group_board` VALUES (11,75,4,'dsaasdasdsdadsadas','2023-12-09 14:15:14'),(12,75,4,'ㅁㄴㅇㄴㅇㅁㄴㅇㅁㄴㅇㅁ','2023-12-09 14:15:19');
/*!40000 ALTER TABLE `group_board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_board_comment`
--

DROP TABLE IF EXISTS `group_board_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_board_comment` (
  `commentIDX` int NOT NULL AUTO_INCREMENT,
  `fk_boardIDX` int NOT NULL,
  `fk_memberIDX` int NOT NULL,
  `content` varchar(45) NOT NULL,
  `cread_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`commentIDX`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_board_comment`
--

LOCK TABLES `group_board_comment` WRITE;
/*!40000 ALTER TABLE `group_board_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_board_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_members`
--

DROP TABLE IF EXISTS `group_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_members` (
  `group_membersIDX` int NOT NULL AUTO_INCREMENT,
  `fk_groupIDX` int NOT NULL,
  `fk_memberIDX` int NOT NULL,
  `member_status` varchar(30) DEFAULT NULL,
  `joined_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`group_membersIDX`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_members`
--

LOCK TABLES `group_members` WRITE;
/*!40000 ALTER TABLE `group_members` DISABLE KEYS */;
INSERT INTO `group_members` VALUES (38,75,4,'Master','2023-12-09 14:14:29'),(40,75,6,'Waiting','2023-12-09 14:32:04');
/*!40000 ALTER TABLE `group_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes_group`
--

DROP TABLE IF EXISTS `likes_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes_group` (
  `likes_groupIDX` int NOT NULL AUTO_INCREMENT,
  `fk_memberIDX` int NOT NULL,
  `fk_groupIDX` int NOT NULL,
  PRIMARY KEY (`likes_groupIDX`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes_group`
--

LOCK TABLES `likes_group` WRITE;
/*!40000 ALTER TABLE `likes_group` DISABLE KEYS */;
INSERT INTO `likes_group` VALUES (86,4,75),(89,6,75);
/*!40000 ALTER TABLE `likes_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `memberIDX` int NOT NULL AUTO_INCREMENT,
  `id` varchar(45) NOT NULL,
  `password` varchar(2000) NOT NULL,
  `nickname` varchar(15) NOT NULL,
  `age` varchar(45) NOT NULL,
  `gender` varchar(45) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`memberIDX`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (4,'admin','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4','dldldl','000215','여자','서울','12331231','213123231132'),(6,'admin1','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4','123','123312','여자','서울','2132131212','12132123123');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-09 23:38:48
