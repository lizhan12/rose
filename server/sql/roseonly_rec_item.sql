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
-- Table structure for table `rec_item`
--

DROP TABLE IF EXISTS `rec_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rec_item` (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(8) DEFAULT NULL,
  `cid` int(8) DEFAULT NULL,
  `r_main_img` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `style` varchar(255) DEFAULT NULL,
  `length` varchar(255) DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`r_id`),
  UNIQUE KEY `r_id_UNIQUE` (`r_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rec_item`
--

LOCK TABLES `rec_item` WRITE;
/*!40000 ALTER TABLE `rec_item` DISABLE KEYS */;
INSERT INTO `rec_item` VALUES (1,1,1,'p2_zs_main_1.png','鲜花玫瑰','经典朱砂','经典长形',1999.00),(2,2,1,'p5_zs_main_1.png','鲜花玫瑰','经典朱砂','经典长形',1520.00),(3,3,1,'zs_main_1.png','鲜花玫瑰','经典朱砂','经典长形',1999.00),(4,4,6,'p4_yh_main_1.png','鲜花玫瑰','经典朱砂','经典长形',1314.00),(5,1,1,'p2_zs_main_1.png','鲜花玫瑰','经典朱砂','经典长形',1999.00),(6,2,1,'p5_zs_main_1.png','鲜花玫瑰','经典朱砂','经典长形',1520.00),(7,3,1,'zs_main_1.png','鲜花玫瑰','经典朱砂','经典长形',1999.00),(8,4,7,'p4_yh_main_1.png','鲜花玫瑰','经典朱砂','经典长形',1314.00);
/*!40000 ALTER TABLE `rec_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-09 20:31:32
