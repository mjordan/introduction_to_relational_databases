-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: ClassSchedules
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classes` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`class_id`),
  KEY `course_id` (`course_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  CONSTRAINT `fk_classes_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES (1,3,3,'2015-04-13','09:00:00'),(2,3,3,'2015-04-20','09:00:00'),(3,3,3,'2015-04-27','09:00:00'),(4,3,3,'2015-04-08','09:00:00'),(5,3,3,'2015-04-15','09:00:00'),(6,3,3,'2015-04-22','09:00:00'),(7,3,3,'2015-04-29','09:00:00'),(8,1,1,'2015-04-07','13:00:00'),(9,1,1,'2015-04-14','13:00:00'),(10,1,1,'2015-04-21','13:00:00'),(11,1,1,'2015-04-28','13:00:00'),(12,2,4,'2015-04-13','10:30:00'),(13,2,4,'2015-04-20','10:30:00'),(14,2,4,'2015-04-27','10:30:00'),(15,2,4,'2015-04-01','10:30:00'),(16,2,4,'2015-04-08','10:30:00'),(17,2,4,'2015-04-15','10:30:00'),(18,2,4,'2015-04-22','10:30:00'),(19,2,4,'2015-04-29','10:30:00'),(20,4,2,'2015-04-01','14:30:00'),(21,4,2,'2015-04-08','14:30:00'),(22,4,2,'2015-04-15','14:30:00'),(23,4,2,'2015-04-22','14:30:00'),(24,4,2,'2015-04-29','14:30:00'),(25,4,2,'2015-04-10','14:30:00'),(26,4,2,'2015-04-17','14:30:00'),(27,4,2,'2015-04-24','14:30:00'),(28,1,1,'2015-04-09','13:00:00'),(29,1,1,'2015-04-16','13:00:00'),(30,1,1,'2015-04-23','13:00:00'),(31,1,1,'2015-04-30','13:00:00');
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` text COLLATE utf8_unicode_ci,
  `department` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `semester` text COLLATE utf8_unicode_ci,
  `num_students_enrolled` int(11) DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'HUM331','Introduction to Relational Databases for the Humanities','Humanities','01-2015',19),(2,'HUM342','Creating Digital Texts using TEI','Humanities','01-2015',14),(3,'ENG423','The Digital Book','English','01-2105',96),(4,'HIST320','Introduction to Digital Humanities for Historians','History','01-2015',29);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_instructors`
--

DROP TABLE IF EXISTS `courses_instructors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_instructors` (
  `course_id` int(11) NOT NULL,
  `instructor_id` int(11) NOT NULL,
  PRIMARY KEY (`course_id`,`instructor_id`),
  KEY `fk_courses_instructors_2_idx` (`instructor_id`),
  CONSTRAINT `fk_courses_instructors_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_instructors_2` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`instructor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_instructors`
--

LOCK TABLES `courses_instructors` WRITE;
/*!40000 ALTER TABLE `courses_instructors` DISABLE KEYS */;
INSERT INTO `courses_instructors` VALUES (1,1),(2,2),(4,2),(1,3),(3,3),(3,4);
/*!40000 ALTER TABLE `courses_instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructors`
--

DROP TABLE IF EXISTS `instructors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructors` (
  `instructor_id` int(11) NOT NULL AUTO_INCREMENT,
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The instructor''s last name (or name conventionally used in alphabetical lists)\n',
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_address` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`instructor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructors`
--

LOCK TABLES `instructors` WRITE;
/*!40000 ALTER TABLE `instructors` DISABLE KEYS */;
INSERT INTO `instructors` VALUES (1,'Jin-Soon','Sin','sin_jin_soon@examle.com'),(2,'Novak','Stanislaw','stanislaw_novak@example.com'),(3,'Turay','Tandice','tandice_turay@example.com'),(4,'Roy','Shanta','shanta_roy@example.com'),(5,'Khatami','Paree','paree_khatami@example.com');
/*!40000 ALTER TABLE `instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL AUTO_INCREMENT,
  `room_number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `room_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `has_projector` tinyint(1) DEFAULT NULL,
  `has_whiteboard` tinyint(1) DEFAULT NULL,
  `capacity` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,'EUB2130',NULL,'Classroom',1,1,'32'),(2,'EUB2133',NULL,'Classroom',1,1,'40'),(3,'EUB1000','Lecture Theatre 1000','Lecture Theatre',1,0,'200'),(4,'EUA35',NULL,'Seminar',0,1,'16');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-20 11:39:48
