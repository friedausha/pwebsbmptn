/*
SQLyog Community v12.3.1 (64 bit)
MySQL - 10.1.16-MariaDB : Database - sbmptn
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sbmptn` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `sbmptn`;

/*Table structure for table `daftar` */

DROP TABLE IF EXISTS `daftar`;

CREATE TABLE `daftar` (
  `kap` varchar(16) NOT NULL,
  `pin` varchar(16) NOT NULL,
  `nisn` varchar(16) NOT NULL,
  `stat_bayar` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`kap`),
  UNIQUE KEY `kap` (`kap`),
  KEY `nisn.daf` (`nisn`),
  CONSTRAINT `nisn.daf` FOREIGN KEY (`nisn`) REFERENCES `nisn` (`nisn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `daftar` */

/*Table structure for table `nisn` */

DROP TABLE IF EXISTS `nisn`;

CREATE TABLE `nisn` (
  `nisn` varchar(16) NOT NULL,
  `nama` char(30) NOT NULL,
  `tempat_lahir` char(30) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  PRIMARY KEY (`nisn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `nisn` */

insert  into `nisn`(`nisn`,`nama`,`tempat_lahir`,`tanggal_lahir`) values 
('9912019273721','Frieda Uswatun','Malang','1997-09-26'),
('99172137263','Irsyad Rizaldi','Jakarta','1997-10-29'),
('9918237464','Pius Pambudi','Tuban','1997-05-20');

/*Table structure for table `user_info` */

DROP TABLE IF EXISTS `user_info`;

CREATE TABLE `user_info` (
  `nisn` varchar(16) DEFAULT NULL,
  `alamat` varchar(30) DEFAULT NULL,
  `kota` varchar(30) DEFAULT NULL,
  `provinsi` varchar(30) DEFAULT NULL,
  `sekolah_asal` varchar(30) DEFAULT NULL,
  `pasfoto` tinytext,
  KEY `nisn_user` (`nisn`),
  CONSTRAINT `nisn_user` FOREIGN KEY (`nisn`) REFERENCES `nisn` (`nisn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `user_info` */

/* Function  structure for function  `carinisn` */

/*!50003 DROP FUNCTION IF EXISTS `carinisn` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `carinisn`(uname varchar(30), tempat varchar(30), tanggal date) RETURNS varchar(16) CHARSET latin1
    DETERMINISTIC
begin
	declare hasil varchar(16);
	select nisn into hasil from nisn where nama=uname and tempat_lahir = tempat and tanggal_lahir=tanggal;
	call dapatkap(hasil, 'Belum');
	return hasil;
end */$$
DELIMITER ;

/* Function  structure for function  `RandString` */

/*!50003 DROP FUNCTION IF EXISTS `RandString` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `RandString`(length SMALLINT(3)) RETURNS varchar(100) CHARSET utf8
begin
    SET @returnStr = '';
    SET @allowedChars = '0123456789';
    SET @i = 0;
    WHILE (@i < length) DO
        SET @returnStr = CONCAT(@returnStr, substring(@allowedChars, FLOOR(RAND() * LENGTH(@allowedChars) + 1), 1));
        SET @i = @i + 1;
    END WHILE;
    RETURN @returnStr;
END */$$
DELIMITER ;

/* Procedure structure for procedure `dapatkap` */

/*!50003 DROP PROCEDURE IF EXISTS  `dapatkap` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `dapatkap`(noinduk varchar(16), stat varchar(10))
begin
	declare rndstr varchar(12);
	declare rndstr1 varchar(16);
	set rndstr = RandString(12);
	set rndstr1 = RandString(16);
	insert into daftar values (rndstr, rndstr1, noinduk, stat);
	/*update daftar
	set kap=RandString(12);
	update daftar
	Set pin=RandString(16);
	update daftar
	set nisn=noinduk;
	update daftar set stat_bayar=stat;*/
end */$$
DELIMITER ;

/* Procedure structure for procedure `sudahbayar` */

/*!50003 DROP PROCEDURE IF EXISTS  `sudahbayar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sudahbayar`(noinduk varchar(16))
begin
	
	update daftar set stat_bayar = 'Sudah' where nisn=noinduk;
end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
