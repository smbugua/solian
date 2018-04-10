-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 30, 2017 at 11:36 AM
-- Server version: 5.7.19
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vijay`
--

-- --------------------------------------------------------

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
CREATE TABLE IF NOT EXISTS `brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(300) NOT NULL,
  `dateadded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `brand`
--

INSERT INTO `brand` (`id`, `name`, `dateadded`) VALUES
(1, 'Ray Bands', '2017-11-27 21:26:16');

-- --------------------------------------------------------

--
-- Table structure for table `contactlens`
--

DROP TABLE IF EXISTS `contactlens`;
CREATE TABLE IF NOT EXISTS `contactlens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateadded` date NOT NULL,
  `patientid` int(11) NOT NULL,
  `staffid` varchar(11) NOT NULL,
  `prescription` text NOT NULL,
  `notes` text NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `eye` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invoiceitems`
--

DROP TABLE IF EXISTS `invoiceitems`;
CREATE TABLE IF NOT EXISTS `invoiceitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceid` int(11) NOT NULL,
  `productid` int(11) NOT NULL,
  `unitprice` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
CREATE TABLE IF NOT EXISTS `invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoicenumber` varchar(20) NOT NULL,
  `patientid` int(11) NOT NULL,
  `totalcost` double NOT NULL,
  `dateadded` date NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0 for unpaid,1 for partiallypaid ,2 for paid',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Triggers `invoices`
--
DROP TRIGGER IF EXISTS `delete trigger`;
DELIMITER $$
CREATE TRIGGER `delete trigger` AFTER DELETE ON `invoices` FOR EACH ROW DELETE from invoiceitems where invoiceid not in (SELECT id from invoices)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `itemtype`
--

DROP TABLE IF EXISTS `itemtype`;
CREATE TABLE IF NOT EXISTS `itemtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `dateadded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `itemtype`
--

INSERT INTO `itemtype` (`id`, `name`, `dateadded`) VALUES
(1, 'Plastic Frame', '2017-11-27 21:27:49');

-- --------------------------------------------------------

--
-- Table structure for table `medical`
--

DROP TABLE IF EXISTS `medical`;
CREATE TABLE IF NOT EXISTS `medical` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` int(11) NOT NULL,
  `conditionid` int(11) NOT NULL,
  `notes` text NOT NULL,
  `year` int(11) NOT NULL,
  `dateadded` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `medical_conditions`
--

DROP TABLE IF EXISTS `medical_conditions`;
CREATE TABLE IF NOT EXISTS `medical_conditions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
CREATE TABLE IF NOT EXISTS `patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `town` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `tel` varchar(40) NOT NULL,
  `has_gloucoma` int(11) NOT NULL DEFAULT '0',
  `has_diabetes` int(11) NOT NULL DEFAULT '0',
  `idno` varchar(40) NOT NULL,
  `sex` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `notes` text NOT NULL,
  `datecreated` date NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `name`, `address`, `town`, `email`, `tel`, `has_gloucoma`, `has_diabetes`, `idno`, `sex`, `dob`, `notes`, `datecreated`, `datemodified`) VALUES
(1, 'simon njoroge mbugua', '1592 -00902 kikuyu', 'Nairobi', 'smbugua11@gmail.com', '0728944815', 0, 0, '29907209', 'Male', '1993-05-27', 'New patient', '2017-11-24', '2017-11-24 08:55:58'),
(2, 'John', 'Kasarani', 'Kasarani', 'jm@gmail.com', '08937983', 0, 0, '78387397', 'Male', '2017-11-01', 'ok', '2017-11-24', '2017-11-24 14:40:14');

-- --------------------------------------------------------

--
-- Table structure for table `patient_exams`
--

DROP TABLE IF EXISTS `patient_exams`;
CREATE TABLE IF NOT EXISTS `patient_exams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateadded` date NOT NULL,
  `patientid` int(11) NOT NULL,
  `staffid` varchar(32) NOT NULL DEFAULT '0',
  `subjectiverx` text NOT NULL,
  `notes` text NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `eye` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient_exams`
--

INSERT INTO `patient_exams` (`id`, `dateadded`, `patientid`, `staffid`, `subjectiverx`, `notes`, `datemodified`, `eye`) VALUES
(1, '2017-11-27', 1, 'smbugua', '90', 'ok', '2017-11-27 10:01:53', 'RIGHT');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateadded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `productname` varchar(20) NOT NULL,
  `brandid` int(30) NOT NULL,
  `itemtypeid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `dateadded`, `productname`, `brandid`, `itemtypeid`) VALUES
(1, '2017-11-27 21:28:02', 'PX 2390 BLUE', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `productstock`
--

DROP TABLE IF EXISTS `productstock`;
CREATE TABLE IF NOT EXISTS `productstock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productid` int(11) NOT NULL,
  `totalstock` int(11) NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productstock`
--

INSERT INTO `productstock` (`id`, `productid`, `totalstock`, `datemodified`) VALUES
(1, 1, 90, '2017-11-29 11:23:02');

-- --------------------------------------------------------

--
-- Table structure for table `productstockmoves`
--

DROP TABLE IF EXISTS `productstockmoves`;
CREATE TABLE IF NOT EXISTS `productstockmoves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productid` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '0 for stock moved in',
  `daterecorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `stockmove` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productstockmoves`
--

INSERT INTO `productstockmoves` (`id`, `productid`, `type`, `daterecorded`, `stockmove`) VALUES
(1, 1, 0, '2017-11-29 11:23:02', 90);

-- --------------------------------------------------------

--
-- Table structure for table `receipts`
--

DROP TABLE IF EXISTS `receipts`;
CREATE TABLE IF NOT EXISTS `receipts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceid` int(50) NOT NULL,
  `amountdue` double NOT NULL,
  `amountpaid` double NOT NULL,
  `balance` double NOT NULL,
  `paymentmethod` varchar(45) NOT NULL,
  `mpesa` varchar(45) DEFAULT NULL,
  `cheque` varchar(45) DEFAULT NULL,
  `bankledger` varchar(45) DEFAULT NULL,
  `insuarance` varchar(200) NOT NULL,
  `recordedby` varchar(25) NOT NULL,
  `dateadded` date NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(11) NOT NULL,
  `main_name` varchar(200) NOT NULL,
  `main_location` varchar(200) NOT NULL,
  `main_tel` varchar(200) NOT NULL,
  `main_address` varchar(200) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `dateadded` date NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `main_name`, `main_location`, `main_tel`, `main_address`, `email`, `dateadded`, `datemodified`) VALUES
(1, 'Vijay Opticals', 'Harambee Ave Nairobi', '0928944815', 'Electricity House 13th Floor', 'vijay@gmail.com', '2016-09-05', '2017-11-30 11:04:45');

-- --------------------------------------------------------

--
-- Table structure for table `stockprice`
--

DROP TABLE IF EXISTS `stockprice`;
CREATE TABLE IF NOT EXISTS `stockprice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productid` int(11) NOT NULL,
  `stockid` int(11) NOT NULL COMMENT 'get id from stock moved in in stock movement table ',
  `cost` double NOT NULL,
  `price` double NOT NULL,
  `dateadded` date NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stockprice`
--

INSERT INTO `stockprice` (`id`, `productid`, `stockid`, `cost`, `price`, `dateadded`, `datemodified`) VALUES
(1, 1, 1, 2000, 5000, '2017-11-29', '2017-11-29 11:23:02');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(10) NOT NULL,
  `fullname` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `account_type` int(20) NOT NULL DEFAULT '0',
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `fullname`, `email`, `password`, `account_type`, `datemodified`) VALUES
(1, 'smbugua', 'Simon Mbugua', 'smbugua11@gmail.com', '21232f297a57a5a743894a0e4a801fc3', 0, '2016-08-12 18:51:21');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
