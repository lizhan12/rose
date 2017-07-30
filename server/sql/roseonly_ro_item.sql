-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: roseonly
-- ------------------------------------------------------
-- Server version	5.7.18

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
-- Table structure for table `ro_item`
--

DROP TABLE IF EXISTS `ro_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ro_item` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `series` varchar(64) DEFAULT NULL,
  `sub_series` varchar(64) DEFAULT NULL,
  `qty` varchar(32) DEFAULT NULL,
  `size` varchar(32) DEFAULT NULL,
  `price` float(8,2) DEFAULT NULL,
  `img` varchar(64) DEFAULT NULL,
  `cid` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ro_item`
--

LOCK TABLES `ro_item` WRITE;
/*!40000 ALTER TABLE `ro_item` DISABLE KEYS */;
INSERT INTO `ro_item` VALUES (1,'鲜花玫瑰','经典永续系列','经典','19支','80cm长形',1999.00,'g1.jpg','1'),(2,'鲜花玫瑰','经典永续系列','经典','19支','80cm长形',1520.00,'g2.jpg','1'),(3,'鲜花玫瑰','经典永续系列','经典','19支','80cm长形',1999.00,'g3.jpg','3'),(4,'玫瑰熊甜心熊植绒天蓝','','','','大型方形',1314.00,'g4.jpg','6'),(5,'鲜花玫瑰','经典永续系列','经典','19支','80cm长形',1520.00,'g5.jpg','1'),(6,'鲜花玫瑰','经典永续系列','经典','19支','80cm长形',1314.00,'g6.jpg','1'),(7,'鲜花玫瑰','经典永续系列','经典','19支','80cm长形',1314.00,'g7.jpg','2'),(8,'鲜花玫瑰','经典永续系列','经典','19支','80cm长形',1999.00,'g8.jpg','3'),(9,'鲜花玫瑰','经典永续系列','经典','19支','80cm长形',999.00,'g9.jpg','4'),(10,'鲜花玫瑰','经典永续系列','经典','19支','80cm长形',999.00,'g10.jpg','5');
/*!40000 ALTER TABLE `ro_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-09 20:31:33
