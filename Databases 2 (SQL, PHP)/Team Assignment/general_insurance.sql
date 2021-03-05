-- MariaDB dump 10.17  Distrib 10.4.14-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: general_insurance
-- ------------------------------------------------------
-- Server version	10.4.14-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `benefits`
--

DROP TABLE IF EXISTS `benefits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `benefits` (
  `INSUR_CODE` int(2) NOT NULL,
  `DESCRIPTION` varchar(30) DEFAULT NULL,
  KEY `INSUR_CODE` (`INSUR_CODE`),
  CONSTRAINT `benefits_ibfk_1` FOREIGN KEY (`INSUR_CODE`) REFERENCES `insurance_covers` (`INSUR_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `benefits`
--

LOCK TABLES `benefits` WRITE;
/*!40000 ALTER TABLE `benefits` DISABLE KEYS */;
INSERT INTO `benefits` VALUES (10,'Free Ambulance Transporation'),(10,'Half Price Prescriptions'),(10,'Free Check Ups'),(11,'Free Ambulance Transporation'),(11,'Free Prescriptions'),(11,'Free Check Ups'),(11,'Free ICU Entry'),(12,'Fire Hazard Damage'),(12,'House Burglary'),(12,'Earthquake Damage'),(13,'Car Check Up'),(13,'Car Theft'),(13,'Emergency Car Transportation');
/*!40000 ALTER TABLE `benefits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contracts` (
  `AFM` int(11) NOT NULL,
  `INSUR_CODE` int(2) NOT NULL,
  `SIGN_DATE` date DEFAULT NULL,
  `EXPIR_DATE` date DEFAULT NULL,
  KEY `AFM` (`AFM`),
  KEY `INSUR_CODE` (`INSUR_CODE`),
  CONSTRAINT `contracts_ibfk_1` FOREIGN KEY (`AFM`) REFERENCES `customers` (`AFM`),
  CONSTRAINT `contracts_ibfk_2` FOREIGN KEY (`INSUR_CODE`) REFERENCES `insurance_covers` (`INSUR_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contracts`
--

LOCK TABLES `contracts` WRITE;
/*!40000 ALTER TABLE `contracts` DISABLE KEYS */;
INSERT INTO `contracts` VALUES (18390008,10,'2020-01-01','2022-01-01'),(18390008,12,'2019-02-17','2022-02-17'),(18390037,10,'2019-06-14','2021-06-14'),(18390037,13,'2020-08-18','2021-08-18'),(54235325,10,'2018-12-25','2020-12-25'),(54235325,12,'2020-12-15','2023-12-15'),(54235325,13,'2020-03-03','2021-03-03'),(13295032,11,'2020-05-13','2023-05-13'),(13295032,12,'2019-04-02','2022-04-02'),(33292346,11,'2018-03-17','2021-03-17'),(33292346,12,'2018-01-02','2021-01-02'),(33292346,13,'2020-11-27','2021-11-27'),(18390008,11,'2020-04-05','2023-04-05'),(18390037,12,'2022-06-14','2023-06-14');
/*!40000 ALTER TABLE `contracts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER CONTRACTS_INSERT
AFTER INSERT ON CONTRACTS
FOR EACH ROW
BEGIN
UPDATE CUSTOMERS SET COST_OF_CONTRACTS = 
IFNULL(COST_OF_CONTRACTS, 0) + (
SELECT COST_YEARLY FROM INSURANCE_COVERS
where INSURANCE_COVERS.INSUR_CODE = NEW.INSUR_CODE)
WHERE CUSTOMERS.AFM = NEW.AFM;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `AFM` int(11) NOT NULL,
  `FULL_NAME` varchar(40) DEFAULT NULL,
  `ADDRESS` varchar(30) DEFAULT NULL,
  `PHONE` varchar(15) DEFAULT NULL,
  `DOY` varchar(20) DEFAULT NULL,
  `COST_OF_CONTRACTS` int(11) DEFAULT NULL,
  PRIMARY KEY (`AFM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (13295032,'Giorgos Manolakis','Triantafilou 13','2109734512','Petralwnwn',340),(18390008,'Eleftherios Vangelis','Thiseos 85','2109518352','Kallitheas',465),(18390037,'Antonios Thomakos','Platonou 68','2106401464','Peristeriou',330),(33292346,'Dimitrios Georgiakos','Kwnstantinoupoleos 32','2109543123','Kipselis',415),(54235325,'Kwstantinos Mantolinos','Spartis 90','2905432526','Kifisias',330);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `getexpirdateforantonis`
--

DROP TABLE IF EXISTS `getexpirdateforantonis`;
/*!50001 DROP VIEW IF EXISTS `getexpirdateforantonis`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `getexpirdateforantonis` (
  `EXPIR_DATE` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `getsigndateforantonis`
--

DROP TABLE IF EXISTS `getsigndateforantonis`;
/*!50001 DROP VIEW IF EXISTS `getsigndateforantonis`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `getsigndateforantonis` (
  `SIGN_DATE` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `information`
--

DROP TABLE IF EXISTS `information`;
/*!50001 DROP VIEW IF EXISTS `information`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `information` (
  `Customer name` tinyint NOT NULL,
  `Coverage` tinyint NOT NULL,
  `Cost per year` tinyint NOT NULL,
  `Minimum validity months` tinyint NOT NULL,
  `Date signed` tinyint NOT NULL,
  `Expiration date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `insurance_covers`
--

DROP TABLE IF EXISTS `insurance_covers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurance_covers` (
  `INSUR_CODE` int(2) NOT NULL,
  `DESCRIPTION` varchar(30) NOT NULL,
  `COST_YEARLY` int(11) NOT NULL,
  `MIN_VALIDITY_MONTHLY` int(11) NOT NULL,
  PRIMARY KEY (`INSUR_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurance_covers`
--

LOCK TABLES `insurance_covers` WRITE;
/*!40000 ALTER TABLE `insurance_covers` DISABLE KEYS */;
INSERT INTO `insurance_covers` VALUES (10,'Health Insurance',125,12),(11,'Critical Illness Cover',210,24),(12,'Home insurance',130,18),(13,'Car insurance',75,6);
/*!40000 ALTER TABLE `insurance_covers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `update_information`
--

DROP TABLE IF EXISTS `update_information`;
/*!50001 DROP VIEW IF EXISTS `update_information`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `update_information` (
  `FULL_NAME` tinyint NOT NULL,
  `AFM` tinyint NOT NULL,
  `ADDRESS` tinyint NOT NULL,
  `PHONE` tinyint NOT NULL,
  `DOY` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `getexpirdateforantonis`
--

/*!50001 DROP TABLE IF EXISTS `getexpirdateforantonis`*/;
/*!50001 DROP VIEW IF EXISTS `getexpirdateforantonis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `getexpirdateforantonis` AS select `contracts`.`EXPIR_DATE` AS `EXPIR_DATE` from `contracts` where `contracts`.`AFM` = 18390037 and `contracts`.`INSUR_CODE` = 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `getsigndateforantonis`
--

/*!50001 DROP TABLE IF EXISTS `getsigndateforantonis`*/;
/*!50001 DROP VIEW IF EXISTS `getsigndateforantonis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `getsigndateforantonis` AS select `contracts`.`SIGN_DATE` AS `SIGN_DATE` from `contracts` where `contracts`.`AFM` = 18390037 and `contracts`.`INSUR_CODE` = 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `information`
--

/*!50001 DROP TABLE IF EXISTS `information`*/;
/*!50001 DROP VIEW IF EXISTS `information`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `information` AS select `customers`.`FULL_NAME` AS `Customer name`,`insurance_covers`.`DESCRIPTION` AS `Coverage`,`insurance_covers`.`COST_YEARLY` AS `Cost per year`,`insurance_covers`.`MIN_VALIDITY_MONTHLY` AS `Minimum validity months`,`contracts`.`SIGN_DATE` AS `Date signed`,`contracts`.`EXPIR_DATE` AS `Expiration date` from ((`customers` join `contracts` on(`customers`.`AFM` = `contracts`.`AFM`)) join `insurance_covers` on(`contracts`.`INSUR_CODE` = `insurance_covers`.`INSUR_CODE`)) order by `customers`.`FULL_NAME` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `update_information`
--

/*!50001 DROP TABLE IF EXISTS `update_information`*/;
/*!50001 DROP VIEW IF EXISTS `update_information`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `update_information` AS select `customers`.`FULL_NAME` AS `FULL_NAME`,`customers`.`AFM` AS `AFM`,`customers`.`ADDRESS` AS `ADDRESS`,`customers`.`PHONE` AS `PHONE`,`customers`.`DOY` AS `DOY` from `customers` order by `customers`.`FULL_NAME` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-13 14:47:54
