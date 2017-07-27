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
-- Table structure for table `ro_color`
--

DROP TABLE IF EXISTS `ro_color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ro_color` (
  `co_id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `c_color_name` varchar(32) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `c_color_img` varchar(64) DEFAULT NULL,
  `c_main_img` varchar(255) DEFAULT NULL,
  `c_intro_img` varchar(255) DEFAULT NULL,
  `current_col_img` varchar(64) DEFAULT NULL,
  `c_intro_img_3` varchar(64) DEFAULT NULL,
  `c_intro_img_4` varchar(64) DEFAULT NULL,
  `c_intro_img_5` varchar(64) DEFAULT NULL,
  `cid_all` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`co_id`),
  UNIQUE KEY `co_id_UNIQUE` (`co_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ro_color`
--

LOCK TABLES `ro_color` WRITE;
/*!40000 ALTER TABLE `ro_color` DISABLE KEYS */;
INSERT INTO `ro_color` VALUES (1,1,'朱砂',1,'p2_zs.png','p2_zs_main_1.png,p2_zs_main_2.png,p2_zs_main_3.png,p2_zs_main_4.png,','p2_zs_intro_1.jpg,p2_zs_intro_2.jpg,p2_zs_intro_3.jpg,p2_zs_intro_4.jpg,p2_zs_intro_5.jpg','p2_zs.png','zs_intro_3.jpg','zs_intro_4.jpg','zs_intro_5.jpg','1'),(2,2,'朱砂',1,'p5_zs.png,p5_cx.png,p5_qd.png,p5_yd.png','p5_zs_main_1.png,p5_zs_main_2.png,p5_zs_main_3.png','p5_intro_1.jpg,p5_zs_intro_2.jpg,p5_zs_intro_3.jpg,p5_zs_intro_4.jpg,p5_intro_5.jpg,p5_zs_intro_6.jpg','p5_zs.png','zs_intro_3.jpg','zs_intro_4.jpg','zs_intro_5.jpg','1,2,3,5'),(3,2,'初心',2,'p5_zs.png,p5_cx.png,p5_qd.png,p5_yd.png','p5_cx_main_1.png,p5_cx_main_2.png,p5_cx_main_3.png','p5_intro_1.jpg,p5_cx_intro_2.jpg,p5_cx_intro_3.jpg,p5_cx_intro_4.jpg,p5_intro_5.jpg,p5_zs_intro_6.jpg','p5_cx.png','cx_intro_3.jpg','cx_intro_4.jpg','cx_intro_5.jpg','1,2,3,5'),(4,2,'情动',3,'p5_zs.png,p5_cx.png,p5_qd.png,p5_yd.png','p5_qd_main_1.png,p5_qd_main_2.png,p5_qd_main_3.png','p5_intro_1.jpg,p5_qd_intro_2.jpg,p5_qd_intro_3.jpg,p5_qd_intro_4.jpg,p5_intro_5.jpg,p5_zs_intro_6.jpg','p5_qd.png','qd_intro_3.jpg','qd_intro_4.jpg','qd_intro_5.jpg','1,2,3,5'),(5,2,'约定',5,'p5_zs.png,p5_cx.png,p5_qd.png,p5_yd.png','p5_yd_main_1.png,p5_yd_main_2.png,p5_yd_main_3.png','p5_intro_1.jpg,p5_yd_intro_2.jpg,p5_yd_intro_3.jpg,p5_yd_intro_4.jpg,p5_intro_5.jpg,p5_zs_intro_6.jpg','p5_yd.png','yd_intro_3.jpg','yd_intro_4.jpg','yd_intro_5.jpg','1,2,3,5'),(6,4,'殷红',6,'p4_yh.png,p4_tl.png','p4_yh_main_1.png,p4_yh_main_2.png,p4_yh_main_3.png,p4_yh_main_4.png,','p4_intro_1.jpg,p4_intro_2.jpg,p4_yh_intro_3.jpg,p4_yh_intro_4.jpg,p4_yh_intro_5.jpg','p4_yh.png','zs_intro_3.jpg','zs_intro_4.jpg','zs_intro_5.jpg','6,7'),(7,4,'天蓝',7,'p4_yh.png,p4_tl.png','p4_tl_main_1.png,p4_tl_main_2.png,p4_tl_main_3.png,p4_tl_main_4.png,','p4_intro_1.jpg,p4_intro_2.jpg,p4_tl_intro_3.jpg,p4_tl_intro_4.jpg,p4_tl_intro_5.jpg','p4_tl.png','cx_intro_3.jpg','cx_intro_4.jpg','cx_intro_5.jpg','6,7'),(8,3,'朱砂',1,'zs.png,cx.png,qd.png,jy.png,yd.png','zs_main_1.png,zs_main_2.png,zs_main_3.png,zs_main_4.png','zs_intro_1,zs_intro_2.jpg,zs_intro_3.jpg,zs_intro_4.jpg,zs_intro_5.jpg','zs.png','zs_intro_3.jpg','zs_intro_4.jpg','zs_intro_5.jpg','1,2,3,4,5'),(9,3,'初心',2,'zs.png,cx.png,qd.png,jy.png,yd.png','cx_main_1.png,cx_main_2.png,cx_main_3.png,cx_main_4.png','cx_intro_1.jpg,cx_intro_2.jpg,cx_intro_3.jpg,cx_intro_4.jpg,cx_intro_5.jpg','cx.png','cx_intro_3.jpg','cx_intro_4.jpg','cx_intro_5.jpg','1,2,3,4,5'),(10,3,'情动',3,'zs.png,cx.png,qd.png,jy.png,yd.png','qd_main_1.png,qd_main_2.png,qd_main_3.png,qd_main_4.png','qd_intro_1.jpg,qd_intro_2.jpg,qd_intro_3.jpg,qd_intro_4.jpg,qd_intro_5.jpg','qd.png','qd_intro_3.jpg','qd_intro_4.jpg','qd_intro_5.jpg','1,2,3,4,5'),(11,3,'惊艳',4,'zs.png,cx.png,qd.png,jy.png,yd.png','cx_main_1.png,cx_main_2.png,cx_main_3.png,cx_main_4.png','jy_intro_1.jpg,jy_intro_2.jpg,jy_intro_3.jpg,jy_intro_4.jpg,jy_intro_5.jpg','jy.png','jy_intro_3.jpg','jy_intro_4.jpg','jy_intro_5.jpg','1,2,3,4,5'),(12,3,'约定',5,'zs.png,cx.png,qd.png,jy.png,yd.png','yd_main_1.png,yd_main_2.png,yd_main_3.png,yd_main_4.png','yd_intro_1.jpg,yd_intro_2.jpg,yd_intro_3.jpg,yd_intro_4.jpg,yd_intro_5.jpg','yd.png','yd_intro_3.jpg','yd_intro_4.jpg','yd_intro_5.jpg','1,2,3,4,5');
/*!40000 ALTER TABLE `ro_color` ENABLE KEYS */;
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
