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
  `fk_nickName` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`groupIDX`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dgroup`
--

LOCK TABLES `dgroup` WRITE;
/*!40000 ALTER TABLE `dgroup` DISABLE KEYS */;
INSERT INTO `dgroup` VALUES (1,1,'러닝모임','서울','운동','20~30대','매주 수요일 서울 올림픽공원에서 같이 러닝 뛰실분들을 구합니다.',0,'2023-12-02 14:15:36','정의'),(3,1,'첫 모임 생성입니다.','서울','운동','20~30대','제발 모임이 생성 되기를..',0,'2023-12-02 15:21:25','정의'),(4,1,'날씨 좋은날 산책할 모임','인천','문화','20~30대','날씨 좋은 날 같이 크리스마스를 즐기실분들을 구합니다',0,'2023-12-02 15:24:52','정의'),(5,1,'크리스마스 같이 놀분들 구합니다','서울','문화','20대','같이 크리스마스날 국밥을 먹어요',0,'2023-12-02 15:28:35','정의'),(6,1,'1월1일 정동진에 갈 모임입니다.','강원','여행','연령무관','1월 1일 새해의 기운을 다지러 가실분들을 구합니다.',0,'2023-12-02 15:38:44','정의'),(7,2,'우리 같이 보드게임해요','광주','게임','20~30대후반','같이 혜화에서 보드게임하실분 구합니다',0,'2023-12-02 16:24:07','정의'),(8,2,'등산 원정모임 ','경기','운동','20대~50대','같이 산을 정복합시다.',0,'2023-12-02 16:24:36','정의'),(9,2,'K리그 서울 경기 모임','서울','문화','20대~4대','같이 FC서울 경기를 직관하실 분들을 구합니다.',0,'2023-12-02 16:25:58','정의'),(10,2,'리그오브레전드 파티원을 구합니다.','서울','게임','20대','같이 시간날때마다 5인큐 및 5vs5 하실분들을 구해요',0,'2023-12-02 16:26:26','정의'),(11,2,'서울 편입 공부 하실 분들 구합니다','서울','공부','20대','편입 목표로 같이 으쌰으쌰 하실분들 구합니다.',0,'2023-12-02 16:26:51','정의'),(12,2,'헬스모임','인천','운동','20대~30대','같이 식단하며 몸 키우실분들',1,'2023-12-02 16:27:22','정의'),(13,2,'Spring 개발 모임','서울','공부','20대~30','같이 Spring 공부를 하며 홈페이지 개발 공부하실분들을 구합니다. 예시로 모임사이트!',-2,'2023-12-02 16:27:56','정의'),(15,1,'제에에목','서울','운동','10대만','장난',-3,'2023-12-02 17:08:12','정의'),(16,1,'제에에123목','서울','운동','10대만','장난',0,'2023-12-02 17:08:18','정의'),(17,1,'543수정','충청','영화','30대까지','장난231321',2,'2023-12-03 14:09:41','정의'),(18,1,'제에에123123목','서울','운동','10대만','장난',-3,'2023-12-02 17:08:20','정의'),(19,1,'제에에123123목','서울','운동','10대만','장난',5,'2023-12-02 17:08:20','정의');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_board`
--

LOCK TABLES `group_board` WRITE;
/*!40000 ALTER TABLE `group_board` DISABLE KEYS */;
INSERT INTO `group_board` VALUES (1,1,1,'아니 왜 다 날라감?ㅋㅋㅇ','2023-12-06 13:24:44'),(2,3,1,'ㅎㅇㅎㅇ','2023-12-06 16:33:55');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_board_comment`
--

LOCK TABLES `group_board_comment` WRITE;
/*!40000 ALTER TABLE `group_board_comment` DISABLE KEYS */;
INSERT INTO `group_board_comment` VALUES (1,1,1,'ㄹㅇㄹㅇ','2023-12-06 13:24:46'),(2,1,1,'ㅇㄴㅁㅇㄴㅁ','2023-12-06 13:24:48'),(3,1,1,'ㅇㅁㄴㅁㅇㄴㅁㅇㄴ','2023-12-06 13:24:49'),(4,2,1,'ㅋㅋ','2023-12-06 16:34:31');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_members`
--

LOCK TABLES `group_members` WRITE;
/*!40000 ALTER TABLE `group_members` DISABLE KEYS */;
INSERT INTO `group_members` VALUES (3,1,1,'Good','2023-12-06 14:36:55'),(4,1,2,'Waiting','2023-12-06 14:37:02'),(5,3,1,'Good','2023-12-06 16:34:16'),(6,3,2,'Waiting','2023-12-06 16:34:24');
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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes_group`
--

LOCK TABLES `likes_group` WRITE;
/*!40000 ALTER TABLE `likes_group` DISABLE KEYS */;
INSERT INTO `likes_group` VALUES (29,1,17),(41,1,14),(73,2,17),(74,1,12);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'admin','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4','닉네임이에요','000215','남자','인천','01012345987','hello@naver.com'),(2,'admin2','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4','저는무려2번째회원이랍니다.','000123','남자','인천','01029381239','hallo@naver.com');
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

-- Dump completed on 2023-12-07  2:07:29
