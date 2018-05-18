-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 18, 2018 at 08:46 AM
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
-- Database: `solian`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
CREATE TABLE IF NOT EXISTS `appointments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` int(11) NOT NULL,
  `notes` text NOT NULL,
  `type` varchar(200) NOT NULL,
  `datescheduled` date NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `brand`
--

INSERT INTO `brand` (`id`, `name`, `dateadded`) VALUES
(1, 'Mombasa', '2018-04-23 06:25:48'),
(2, 'Kilifi', '2018-04-23 06:26:06'),
(3, 'Machakos', '2018-04-23 06:26:26');

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
  `plotid` int(11) NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invoiceitems`
--

INSERT INTO `invoiceitems` (`id`, `invoiceid`, `productid`, `unitprice`, `quantity`, `plotid`, `total`) VALUES
(1, 1, 1, 1000000, 1, 1, 1000000);

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
CREATE TABLE IF NOT EXISTS `invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patientid` int(11) NOT NULL,
  `invoicenumber` varchar(200) NOT NULL,
  `totalcost` double DEFAULT NULL,
  `dateadded` date NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0 for unpaid,1 for partiallypaid ,2 for paid',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `patientid`, `invoicenumber`, `totalcost`, `dateadded`, `datemodified`, `status`) VALUES
(1, 1, 'INV-1-2018', 1000000, '2018-05-17', '2018-05-17 13:45:55', 0);

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
-- Table structure for table `invoice_installments`
--

DROP TABLE IF EXISTS `invoice_installments`;
CREATE TABLE IF NOT EXISTS `invoice_installments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceplanid` int(11) NOT NULL,
  `installment` double NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `datedue` date DEFAULT NULL,
  `datepaid` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invoice_installments`
--

INSERT INTO `invoice_installments` (`id`, `invoiceplanid`, `installment`, `status`, `datedue`, `datepaid`) VALUES
(1, 1, 100000, 0, '2018-06-18', '2018-05-18 08:44:20'),
(2, 1, 100000, 0, '2018-07-18', '2018-05-18 08:44:20'),
(3, 1, 100000, 0, '2018-08-18', '2018-05-18 08:44:20'),
(4, 1, 100000, 0, '2018-09-18', '2018-05-18 08:44:20'),
(5, 1, 100000, 0, '2018-10-18', '2018-05-18 08:44:20'),
(6, 1, 100000, 0, '2018-11-18', '2018-05-18 08:44:20'),
(7, 1, 100000, 0, '2018-12-18', '2018-05-18 08:44:20'),
(8, 1, 100000, 0, '2019-01-18', '2018-05-18 08:44:20'),
(9, 1, 100000, 0, '2019-02-18', '2018-05-18 08:44:20'),
(10, 1, 100000, 0, '2019-03-18', '2018-05-18 08:44:20');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_paymentplan`
--

DROP TABLE IF EXISTS `invoice_paymentplan`;
CREATE TABLE IF NOT EXISTS `invoice_paymentplan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceid` int(11) NOT NULL,
  `planid` int(11) NOT NULL,
  `period` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invoice_paymentplan`
--

INSERT INTO `invoice_paymentplan` (`id`, `invoiceid`, `planid`, `period`) VALUES
(1, 1, 1, 10);

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
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `itemtype`
--

INSERT INTO `itemtype` (`id`, `name`, `dateadded`) VALUES
(1, 'Solian 1', '2018-04-23 06:27:05'),
(2, 'Solian 2', '2018-04-23 06:27:14'),
(3, 'Solian 3', '2018-04-23 06:27:24'),
(4, 'Solian 4', '2018-04-23 06:27:31'),
(5, 'Solian 5', '2018-04-23 06:27:38'),
(6, 'Solian 6', '2018-04-23 06:27:51'),
(7, 'Solian 7', '2018-04-23 06:28:03'),
(8, 'Solian 8', '2018-04-23 06:28:11'),
(9, 'Solian 9', '2018-04-23 06:28:20'),
(10, 'Solian 10', '2018-04-23 06:28:32'),
(11, 'Solian 11', '2018-04-23 06:28:39'),
(12, 'Solian 12', '2018-04-23 06:28:46'),
(13, 'Solian 17', '2018-04-23 06:28:55'),
(14, 'Solian 18', '2018-04-23 06:29:04'),
(15, 'Solian 19', '2018-04-23 06:29:11'),
(16, 'Solian 21', '2018-04-23 06:29:27'),
(17, 'Solian 23', '2018-04-23 06:29:37');

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
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientid` int(11) NOT NULL,
  `msg` text NOT NULL,
  `tel` varchar(20) NOT NULL,
  `sender` varchar(20) NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `clientid`, `msg`, `tel`, `sender`, `datemodified`) VALUES
(1, 1, 'hi simon test  .Solian Investments Thanks you for your Business!.', '0728944815', 'smbugua', '2018-05-17 07:31:49'),
(2, 1, 'mueni is looking at you .Solian Investments Thanks you for your Business!.', '0728944815', 'smbugua', '2018-05-17 07:33:35'),
(3, 1, 'test .Solian Investments Thanks you for your Business!.', '0728944815', 'smbugua', '2018-05-17 14:22:33'),
(4, 1, 'Come collect your invoice  .Solian Investments Thanks you for your Business!.', '0728944815', 'smbugua', '2018-05-17 14:22:52'),
(5, 1, 'the receipt is ready .Solian Investments Thanks you for your Business!.', '0728944815', 'smbugua', '2018-05-17 14:23:08');

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
  `status` int(11) NOT NULL DEFAULT '0',
  `pin` int(11) NOT NULL DEFAULT '0',
  `idno` varchar(40) NOT NULL,
  `sex` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `notes` text NOT NULL,
  `datecreated` date NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=210 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `name`, `address`, `town`, `email`, `tel`, `status`, `pin`, `idno`, `sex`, `dob`, `notes`, `datecreated`, `datemodified`) VALUES
(1, 'simon njoroge mbugua', '1592 -00902 kikuyu', 'Nairobi', 'smbugua11@gmail.com', '0728944815', 0, 0, '29907209', 'Male', '1993-05-27', 'New patient', '2017-11-24', '2017-11-24 08:55:58'),
(2, 'John', 'Kasarani', 'Kasarani', 'jm@gmail.com', '08937983', 0, 0, '78387397', 'Male', '2017-11-01', 'ok', '2017-11-24', '2017-11-24 14:40:14'),
(3, '', '', '', '', '', 1, 0, '', 'Male', '0000-00-00', '', '2018-04-20', '2018-04-23 10:38:24'),
(4, 'Jessy Susan Sweet Halwenge', 'P.O BOX 84102-80100', 'Mombasa', '', '+447581022021', 0, 0, '21206868', 'female', '0000-00-00', 'Resides in the United States of America', '2018-04-20', '2018-04-20 13:04:29'),
(5, 'Peter Muoki Mutuku', '', 'Mombasa', 'peter.muoki.mutuku@gmail.com', '0721332066', 0, 0, '21735468', 'Male', '0000-00-00', '', '2018-04-20', '2018-04-20 13:26:07'),
(6, 'Robert Gerenge Nachieri', 'P.O Box 27341-00100', 'Mombasa', 'rgerenge@yahoo.com', '0721270428', 0, 0, '21754747', 'Male', '1979-12-03', '', '2018-04-20', '2018-04-25 12:00:35'),
(7, 'Maureen Akinyi Oliech', '', 'Mombasa', 'maureen72ke@yahoo.com', '0726266988 | 0721389202', 0, 0, '11229829', 'female', '1972-01-01', '', '2018-04-20', '2018-04-25 11:56:01'),
(8, 'Philip Lombu Mulaa & Judy Mwelu Justus', '87482-80100', 'Mombasa', 'jpmulaa@gmail.com', '0720279960', 0, 0, '20797430 | 29583294', 'Male', '1978-11-09', '', '2018-04-20', '2018-04-25 13:57:22'),
(9, 'Susan Njoki Njagi', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-20', '2018-04-20 14:02:58'),
(10, 'Solomon Kahuthu Ngare', '', '', '', '0722810302', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-20', '2018-04-20 14:04:10'),
(11, 'Joan Khandasi Kelengwe', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-20', '2018-04-20 14:29:48'),
(12, 'David Kiplagat Cheboi', 'P.O Box 1187-00600', 'Nairobi', '', '0722757122', 0, 0, '4827096', 'Male', '0000-00-00', '', '2018-04-20', '2018-04-25 12:14:32'),
(13, 'Erick Mbuthia Njuguna', 'P.O BOX 2272-80100', 'Mombasa', 'enjuguna007@gmail.com', '0729042880', 0, 0, '12597777', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 09:50:29'),
(14, 'Manase Ananda Calleb', '', 'Mombasa', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:12:50'),
(15, 'Grace Mumbi Njuguna', '', 'Mombasa', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:13:29'),
(16, 'Josphat Kibet Rotich', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:29:07'),
(17, 'Tretra Limited', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:29:34'),
(18, 'Clara Syengo', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:29:59'),
(19, 'Said Mohammed Kaleli', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:30:28'),
(20, 'Robert Tirop Birech', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:31:27'),
(21, 'Kelvin Bjorn Asige', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:31:48'),
(22, 'Maryann Njoki Murage', 'P.O.Box 80045-80100', 'Mombasa', '', '0718553950', 0, 0, '27400844', 'female', '1983-02-14', '', '2018-04-21', '2018-04-25 09:06:50'),
(23, 'Elizabeth Wamboi Kamau', 'P.O Box 1223-80100', 'Mombasa', 'lizkamash@hotmail.com', '0705236500', 0, 0, '29759493', 'female', '1993-03-31', '', '2018-04-21', '2018-04-25 09:25:48'),
(24, 'Alice Wanjiko William', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 07:32:51'),
(25, 'Rose Garllie Marete ', 'P.O Box 80045-80100', 'Mombasa', '', '0722818919', 0, 0, '0574543', 'female', '0000-00-00', '', '2018-04-21', '2018-04-25 11:47:51'),
(26, 'Esther Molo', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 07:37:01'),
(27, 'Moureen Wairimu Gacunji', 'P.O Box 95500-80106', 'Mombasa', '', '', 0, 0, '9989361', 'female', '0000-00-00', '', '2018-04-21', '2018-04-25 11:20:34'),
(28, 'Frida Njeri', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 07:42:01'),
(29, 'Anthony K Nyamancha', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:42:19'),
(30, 'Loice Kioko', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 07:43:06'),
(31, 'Caroline Muthoni', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 07:43:22'),
(32, 'Josphat Kinyua', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:43:55'),
(33, 'Thomas Mshindi', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:45:08'),
(34, 'Hannah Wanjiru Mburu', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 07:45:38'),
(35, 'Michael Mburu', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:45:53'),
(36, 'Regina Chebet', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 07:46:10'),
(37, 'Catherine Wanjiku Gichahi & Others', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:47:13'),
(38, 'Catherine Wanjiku Gichahi & Mohamed Amani', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:47:28'),
(39, 'Kennedy Wambua Mwanzia', '43437-80100', 'Mombasa', '', '', 0, 0, '23509277', 'Male', '1984-09-14', '', '2018-04-21', '2018-04-25 12:24:02'),
(40, 'Margaret Amanda Anaminyi', '', '', 'manaminyi@gmail.com', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 07:50:01'),
(41, 'Augustine Kathuku Mwanzia', 'P.O Box 43437-80100', 'Mombasa', '', '', 0, 0, '22400834', 'Male', '1982-01-02', '', '2018-04-21', '2018-04-25 14:19:13'),
(42, 'Jacob Mwanyika', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:51:32'),
(43, 'Wycliffe Ndemo Abuga', '', 'Mombasa', '', '0720458650', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 12:01:47'),
(44, 'Mahero Mariam N.', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 07:52:20'),
(45, 'Jane Gichuki', '', '', '', '', 1, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-25 10:10:02'),
(46, 'Ronald Muhanji Kivolwe', '', 'Mombasa', 'rkivolwe@gmail.com', '0722241836', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:57:23'),
(47, 'Jackline Murithi', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 07:59:12'),
(48, 'John Ngugi', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 07:59:25'),
(49, 'Stellah Kanini Mutua', 'P.O Box 69-80109', 'Mtwapa', 'mutuastellah@gmail.com', '0720393770', 0, 0, '24687188', 'female', '1986-01-01', '', '2018-04-21', '2018-04-25 09:31:47'),
(50, 'Vincent Kikumu', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 08:02:34'),
(51, 'Agnes Wanjiru Njagi', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 08:03:26'),
(52, 'Roseline Sambu Serem', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 08:03:54'),
(53, 'Berlice Omungu', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 08:04:18'),
(54, 'Patoch Limited', '', '', 'charles_maundu@tpdglobal.com,m.muimi@yahoo.com', '0726498546', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 14:17:35'),
(55, 'Clifford Waema', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 08:05:38'),
(56, 'Symon Kipruto Yatich', '', '', '', '0722296811', 0, 0, '20028174', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 14:14:24'),
(57, 'Dominion Daughters', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 08:06:27'),
(58, 'Krendile Limited', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 08:07:30'),
(59, 'Justus Mulwa Nduya', 'P.O Box 40589-80100', 'Mombasa', 'mulwa@mulwaadvocates.co', '0727168600', 0, 0, '10924828', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 11:37:30'),
(60, 'Antonius Gommans', 'P.O Box 83480-80100', 'Mombasa', 'antoniusgom@googlemail.com', '0717555513', 0, 0, '21369520', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 09:22:47'),
(61, 'Titus Kimuge Kipsang', '', 'Mombasa', 'tituskipsang09@gmail.com', '0722780033', 0, 0, '11187809', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 08:12:31'),
(62, 'Kimutai Tonui Robert Leonard', '', 'Mombasa', 'leonard@solian.co.ke', '0722324616', 0, 0, '13668013', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 08:16:24'),
(63, 'Raphael Smaug Ilunga Kyalo', '', 'Mombasa', 'kyalo@solian.co.ke', '0722305872', 0, 0, '7272336', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 08:17:32'),
(64, 'Roselyn Mulatia', 'P.O Box 90213-80100', 'Mombasa', 'rmulatya1@gmail.com', '0725853732', 0, 0, 'C031592', 'female', '1985-02-22', '', '2018-04-21', '2018-04-25 09:16:50'),
(65, 'Meshack Toroitich Kipturgo', '', 'Mombasa', 'meshackkipturgo@gmail.com', '0722520853', 0, 0, '9814098', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 08:21:56'),
(66, 'Joseph Munyithya', 'P.O BOX 3737-80100', 'Mombasa', 'jpjurists@gmail.com', '0773511546', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 08:56:24'),
(67, 'Samuel Muniu Kefa', '', 'Mombasa', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 08:57:27'),
(68, 'Samson Ngugi Ndara', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 08:58:32'),
(69, 'Comster Homes International Limited', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 08:59:00'),
(70, 'Stella Musomba', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 09:01:13'),
(71, 'Robert Mwatha', 'P.O Box 10457-80101', 'Mombasa', '', '', 0, 0, '9821718', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 11:04:20'),
(72, 'Susan Kanini Sammy', 'P.O Box 42327-80100', 'Mombasa', 'susan@inspectorate-ea.com', '0722991627', 0, 0, '10114236', 'female', '1969-02-14', '', '2018-04-21', '2018-04-25 11:12:37'),
(73, 'Nick Matheka Maundu', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 09:03:18'),
(74, 'Anne Wanjugu Gathii', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 09:04:00'),
(75, 'Selina Mwandawiro Wuganga', 'P.O Box 391-80100', 'Mombasa', 'noladsengs@gmail.com', '0722867782 / 0739249798', 0, 0, '10234168', 'female', '1969-04-11', '', '2018-04-21', '2018-04-25 09:42:06'),
(76, 'David Kipkemoi Kirui', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 09:31:57'),
(77, 'Dorothy Orina', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 09:32:19'),
(78, 'Gitech Co. Limited', '', 'Mombasa', '', '0725713632', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 12:06:19'),
(79, 'Herine Akelo Onyango', '', 'Mombasa', '', '0721284817', 0, 0, '16099487', 'female', '0000-00-00', '', '2018-04-21', '2018-04-25 14:22:44'),
(80, 'Maureen Odongo', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 09:45:52'),
(81, 'Mahero Mariam N.', '', 'Mombasa', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 09:46:20'),
(82, 'Stephen Wambiro Kibiro & Esther Wanjiku Njuguna', 'P.O Box 86559-80100', 'Mombasa', 'bluenile.international@yahoo.com', '0720419448', 0, 0, '21727070 | 22598132', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 13:50:31'),
(83, 'Francis Kamau Kibiro & Caroline Muthoni Mureithi', 'P.O Box 86559-80100', 'Mombasa', 'kamaufrancis70@yahoo.com', '0789260586', 0, 0, '2658841 | 22593153', 'Male', '1984-05-04', '', '2018-04-21', '2018-04-25 13:55:39'),
(84, 'Omondi Lilian Akoth', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 09:47:29'),
(85, 'Jane Gichuki', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 09:48:11'),
(86, 'Eric Njuguna', '', '', '', '0729042880', 1, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 09:47:25'),
(87, 'Brian Kosgei Kibet', 'P.O BOX 270-20406', 'Sotik', 'obryan.bk@gmail.com', '0720936161', 0, 0, '29547849', 'Male', '1992-12-12', '', '2018-04-21', '2018-04-25 12:13:12'),
(88, 'Jane Kivinya Mutua', 'P.O Box 1472-80100', 'Mombasa', 'jm.kivinya@gmail.com', '0720866382', 0, 0, '23807764', 'female', '1984-05-19', '', '2018-04-21', '2018-04-25 10:21:31'),
(89, 'Barka Swaleh Omar', '', '', '', '', 0, 0, '10831202', 'female', '0000-00-00', '', '2018-04-21', '2018-04-25 13:43:05'),
(90, 'Mahin Abdilahi Mohamed', '', 'Mombasa', '', '0722825006', 0, 0, '8470186', 'Male', '1968-02-20', '', '2018-04-21', '2018-04-25 12:12:00'),
(91, 'Abdulwahab Kassim', 'P.O Box 79585-00200', 'Nairobi', '', '0771031615', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 12:27:53'),
(92, 'Flavian Omungu', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 10:12:37'),
(93, 'Berlice Omungu', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 10:13:25'),
(94, 'Mutiga Anne Mumbi', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 10:14:42'),
(95, 'Catherine Mwalagho Wanjala', 'P.O Box 93271-80100', 'Mombasa', 'cathyjohntiriri@gmail.com', '0721721018 | 0732721018', 0, 0, '31613375', 'female', '0000-00-00', '', '2018-04-21', '2018-04-25 14:25:32'),
(96, 'Edith Kibe', '', '', '', '0722884994', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 10:16:38'),
(97, 'Marietha Kilinda', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 10:23:43'),
(98, 'Ruth Mueni Mbaluka', '', '', '', '0701734009', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 10:25:08'),
(99, 'Robert Mugu Mburu', 'P.O Box 42238-80100', 'Mombasa', '', '', 0, 0, '13019930', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 11:32:12'),
(100, 'Ngumbau Nickson Muli & Ngumbau Antony Muuo', 'P.O Box 2851-80100', 'Mombasa', '', '', 0, 0, '24691271 | 22206010', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 10:51:32'),
(101, 'Julius Kilonzo', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 10:30:53'),
(102, 'Mauta Kinyala', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 10:36:12'),
(103, 'Mckena Capital', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 12:15:03'),
(104, 'Anne Nyambura Mureithi', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 10:40:12'),
(105, 'Ernest Obuya', '', '', '', '0721299064', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 10:41:00'),
(106, 'Sylvester Onyango', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 10:44:52'),
(107, 'Joseph Legei Kuyo', '', '', '', '0717202717', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 10:45:32'),
(108, 'Stephen Anyenda', '', '', '', '0722951668', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 10:49:49'),
(109, 'Agnes Wachuka Gatheru', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 10:53:24'),
(110, 'Cootow Law Investments', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 10:53:38'),
(111, 'Esther Nyambura Mutega ', '', '', '', '0724986121', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 10:54:49'),
(112, 'Rael Rotich', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 10:55:49'),
(113, 'Diana Ndele', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 10:56:25'),
(114, 'Victor Were Wandei', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 10:56:39'),
(115, 'Godfrey Mutubia', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 10:56:59'),
(116, 'James Ngatia', '', '', '', '0712013818', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 10:59:47'),
(117, 'Abdulrahman Kimani Kabilia', '', '', '', '0724665594', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:01:16'),
(118, 'Oscar Mwite Omahe', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:02:04'),
(119, 'Rosemary Kavinya Kiilu', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 11:02:23'),
(120, 'Dennis Saitoti', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:02:45'),
(121, 'Scolastica  Nduta Mukova', '', '', '', '0721215755', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 11:03:36'),
(122, 'Solian Limited', '', '', 'info@solian.co.ke', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:04:17'),
(123, 'Saad Abud Mohammed', '', '', '', '0720426085', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:06:36'),
(124, 'Zainab Awadh Hemed', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 11:07:11'),
(125, 'Jabir Nyokabi Fatma', '', '', '', '0722378329', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 11:08:35'),
(126, 'Anne Mueni Ndemwa', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 11:08:56'),
(127, 'Abebe Gebre Yohannes', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:09:28'),
(128, 'Olad Hassan', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:14:07'),
(129, 'Japheth Clinton Ogamba', '', '', '', '0739130897', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:16:12'),
(130, 'Dalton Kaimuru Ndirangu', '', '', '', '0720872911', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:19:13'),
(131, 'Virtous Group Limited ', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:21:57'),
(132, 'Lina Wairimu Wainaina', '', '', '', '0722785782', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:25:03'),
(133, 'Albert T. Keno', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:25:28'),
(134, 'Peter Migosi Migosi', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:25:49'),
(135, 'Esther Njeri & Francis Kariuki', '', '', '', '', 0, 0, '0720324787', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:27:40'),
(136, 'Ruth Kwamboka Obare', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 11:28:01'),
(137, 'Faveo Limited', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:29:12'),
(138, 'Kahsu Abraha Tesfaghtorohis', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:29:41'),
(139, 'David Burugu Gitau', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:29:58'),
(140, 'Justus Munyao Kyungu', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:30:27'),
(141, 'Pamela Kemunto Ogega', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 11:30:46'),
(142, 'Simon Kachapin Kitalei', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:31:09'),
(143, 'Benjamin Masaku', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:31:22'),
(144, 'Mathews Mutual Mulelo', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:37:14'),
(145, 'Creekside Investments', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:37:39'),
(146, 'Mary Colleta Kemunto', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 11:38:02'),
(147, 'Francis Asuma Mitiambo', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:38:23'),
(148, 'Petrolina Malemba Sio', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 11:38:40'),
(149, 'Lorine Dina Msangi', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 11:38:59'),
(150, 'Collins Mtula Sio', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:39:24'),
(151, 'Shem Morara Gisore', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:41:51'),
(152, 'Daniel Maei Mungala', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:42:13'),
(153, 'Eunice Migosi', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 11:42:39'),
(154, 'Tarsila Janet Rabuku Odongo', '', '', '', '0722908826', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 11:46:04'),
(155, 'Philip Tete Ngonyo', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:46:23'),
(156, 'Dick James Safari', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:53:04'),
(157, 'Ipsum Investments Ltd', '', '', '', '0722785782', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 11:54:09'),
(158, 'Kelvin Ngigi Mbugua', 'P.O Box 42199-80100', 'Mombasa', 'mbugua.ngigi@gmail.com', '0713861916', 0, 0, '23572051', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-25 11:29:31'),
(159, 'Winnie Njeri Maina', '', '', '', '0722257146', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 11:58:04'),
(160, 'Ronald Osewe', '', '', '', '0721518628', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:00:50'),
(161, 'Dorcas Waithira Njuguna', '', '', '', '0722628395', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:03:26'),
(162, 'William Kipkorir Munai', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:03:58'),
(163, 'Wycliffe Ndemo & Mercy Mwikali', '', '', '', '0720450658', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:06:06'),
(164, 'Robert Joseph Wamukoya', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:07:02'),
(165, 'Daniel Mukunga Mwai', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:07:18'),
(166, 'Linet Nyawara Adiema', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:08:16'),
(167, 'Danikki Limited', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:08:35'),
(168, 'Hussein Mohammed', '', '', '', '0724557612', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:10:25'),
(169, 'Alex Makau', '', '', '', '0701335143', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:12:30'),
(170, 'Samuel Njaaga Muguna', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:12:56'),
(171, 'Caroline Gommans', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:13:53'),
(172, 'John Nyakawa Ondari', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:15:07'),
(173, 'Evans Mongare Achoki', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:15:21'),
(174, 'Kay Ndeto Gommans', '', '', '', '0710185271', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:16:06'),
(175, 'Anne Hamburger', '', '', 'annhamberger@gmail.com', '0722878311', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:17:27'),
(176, 'Anne Cherop', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:17:52'),
(177, 'Viola Yator', '', '', '', '0723013901', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:18:40'),
(178, 'Eunice,Viola & Alice', '', '', '', '0723013901', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:19:35'),
(179, 'Samir Gulam Abbass Baloo', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:25:02'),
(180, 'Peterson Thegetha Kinyua', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:25:25'),
(181, 'Stanley Kipturgo', '', '', '', '0722855780', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:26:05'),
(182, 'Augustine Maburuburu Matundura ', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:27:17'),
(183, 'Dorothy Nasimiyu Wasike', 'P.O. Box 6463-30100', 'Eldoret', 'bakefun@yahoo.com', '0791155009', 0, 0, '14528064', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:30:01'),
(184, 'Driscillar Hope Koya Mashiniko', '', '', 'kdriscilah@gmail.com', '0727616210', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:32:11'),
(185, 'Samora Machel Godfreys', 'P. O. Box Number 81039-80100 ', 'Mombasa', 'samora@buzzafrique.co.ke', '0721587514', 0, 0, '13892049', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:34:18'),
(186, 'Edward Mburu Kariuki', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:34:50'),
(187, 'Gateway Innovations', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:35:10'),
(188, 'Virtous KAG Women Group', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:35:26'),
(189, 'Christine Kipsang', '', '', '', '0722780030', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:36:07'),
(190, 'Kipkemoi Serem,Roseline Serem & Winnie Wacuka', '', '', 'serem@yahoo.com', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:48:30'),
(191, 'Bryfin Ventures Limited', '', '', '', '0716615931', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:49:08'),
(192, 'Nicholas Okwemba Lisero', 'P.O Box', 'Nairobi', 'nicklisero@gmail.com', '0721305708', 0, 0, '22703646', 'Male', '1982-09-13', '', '2018-04-21', '2018-04-25 10:01:47'),
(193, 'Jubilee Sawa Sawa Group', '', '', '', '0722670700', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:50:30'),
(194, 'Angela Mutinda Munyao', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:50:55'),
(195, 'Penina Bancy Wanjiru Munyi', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:51:15'),
(196, 'Jackline Maina', '', '', '', '0728787201', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:51:51'),
(197, 'Benjamin Muithya Mutambuki', '', '', '', '0733555224', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:53:30'),
(198, 'Rosemary Njeri Mureithi', '', '', 'rnjerimureithi@gmail.com', '0722591568', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:55:38'),
(199, 'James Sigei', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-21', '2018-04-21 12:56:09'),
(200, 'Caroline Akinyi Odera', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:57:49'),
(201, 'Jacqueline Wanjiku Kiono', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 12:58:12'),
(202, 'Esther Nyawira Muchugu', '', '', 'esther.muchugu@intertek.com', '0729907161', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 13:03:12'),
(203, 'Hannah Wanjiku', '', '', '', '', 0, 0, '', 'female', '0000-00-00', '', '2018-04-21', '2018-04-21 13:03:41'),
(204, 'Realest Limited', 'P.O Box 2372-00200', 'Nairobi', '', '', 0, 0, 'CPR/2014/127580', 'Male', '0000-00-00', '', '2018-04-25', '2018-04-25 11:08:44'),
(205, 'Burnace Wambui Njagi', 'P.O Box 42238-80100', 'Mombasa', '', '', 0, 0, '9629543', 'female', '1969-11-27', '', '2018-04-25', '2018-04-25 11:26:34'),
(206, 'Capel Mwaluko Musyoki', '', '', 'capelmusyoki@gmail.com', '', 0, 0, '35584387', 'Male', '0000-00-00', '', '2018-04-25', '2018-04-25 12:17:11'),
(207, 'Martin Musyoki', '', '', 'martsyoki@gmail.com', '', 0, 0, '25777267', 'Male', '0000-00-00', '', '2018-04-25', '2018-04-25 12:18:07'),
(208, 'Ann Jebet', '41798-80100', 'Mombasa', 'annejebettal@gmail.com', '', 0, 0, '27643860', 'female', '0000-00-00', '', '2018-04-25', '2018-04-25 12:22:15'),
(209, 'Justus Kevin Maina', '', '', '', '', 0, 0, '', 'Male', '0000-00-00', '', '2018-04-27', '2018-04-27 17:33:25');

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
-- Table structure for table `paymentmodes`
--

DROP TABLE IF EXISTS `paymentmodes`;
CREATE TABLE IF NOT EXISTS `paymentmodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mode` varchar(200) NOT NULL,
  `dateadded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paymentmodes`
--

INSERT INTO `paymentmodes` (`id`, `mode`, `dateadded`) VALUES
(1, 'M-Pesa Paybill', '2018-04-23 07:56:14'),
(2, 'Cheque', '2018-04-23 07:56:14'),
(3, 'Cash Deposit / Bank Deposit', '2018-04-23 07:56:37'),
(4, 'Wire Transfer RTGS', '2018-04-23 07:56:37');

-- --------------------------------------------------------

--
-- Table structure for table `plots`
--

DROP TABLE IF EXISTS `plots`;
CREATE TABLE IF NOT EXISTS `plots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerid` int(11) NOT NULL,
  `projectid` int(11) NOT NULL,
  `plotno` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `dateallocated` date NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plots`
--

INSERT INTO `plots` (`id`, `customerid`, `projectid`, `plotno`, `price`, `dateallocated`, `datemodified`) VALUES
(1, 103, 1, 10, 2000000, '2018-05-04', '2018-05-04 13:39:17'),
(2, 103, 1, 63, 3000000, '2018-05-04', '2018-05-04 13:39:26');

-- --------------------------------------------------------

--
-- Table structure for table `plotstatus`
--

DROP TABLE IF EXISTS `plotstatus`;
CREATE TABLE IF NOT EXISTS `plotstatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) NOT NULL,
  `plotno` int(11) NOT NULL,
  `dateadded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=932 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plotstatus`
--

INSERT INTO `plotstatus` (`id`, `projectid`, `plotno`, `dateadded`, `status`) VALUES
(1, 1, 1, '2018-05-17 12:00:05', 1),
(2, 1, 2, '2018-05-17 12:00:05', 0),
(3, 1, 3, '2018-05-17 12:00:05', 0),
(4, 1, 4, '2018-05-17 12:00:05', 0),
(5, 1, 5, '2018-05-17 12:00:05', 0),
(6, 1, 6, '2018-05-17 12:00:05', 0),
(7, 1, 7, '2018-05-17 12:00:05', 0),
(8, 1, 8, '2018-05-17 12:00:05', 0),
(9, 1, 9, '2018-05-17 12:00:05', 0),
(10, 1, 10, '2018-05-17 12:00:05', 0),
(11, 1, 11, '2018-05-17 12:00:05', 0),
(12, 1, 12, '2018-05-17 12:00:05', 0),
(13, 1, 13, '2018-05-17 12:00:05', 0),
(14, 1, 14, '2018-05-17 12:00:05', 0),
(15, 1, 15, '2018-05-17 12:00:05', 0),
(16, 1, 16, '2018-05-17 12:00:05', 0),
(17, 1, 17, '2018-05-17 12:00:05', 0),
(18, 1, 18, '2018-05-17 12:00:05', 0),
(19, 1, 19, '2018-05-17 12:00:05', 0),
(20, 1, 20, '2018-05-17 12:00:05', 0),
(21, 1, 21, '2018-05-17 12:00:05', 0),
(22, 1, 22, '2018-05-17 12:00:05', 0),
(23, 1, 23, '2018-05-17 12:00:05', 0),
(24, 1, 24, '2018-05-17 12:00:05', 0),
(25, 1, 25, '2018-05-17 12:00:05', 0),
(26, 1, 26, '2018-05-17 12:00:05', 0),
(27, 1, 27, '2018-05-17 12:00:05', 0),
(28, 1, 28, '2018-05-17 12:00:05', 0),
(29, 1, 29, '2018-05-17 12:00:05', 0),
(30, 1, 30, '2018-05-17 12:00:05', 0),
(31, 1, 31, '2018-05-17 12:00:05', 0),
(32, 1, 32, '2018-05-17 12:00:05', 0),
(33, 1, 33, '2018-05-17 12:00:05', 0),
(34, 1, 34, '2018-05-17 12:00:05', 0),
(35, 1, 35, '2018-05-17 12:00:05', 0),
(36, 1, 36, '2018-05-17 12:00:05', 0),
(37, 1, 37, '2018-05-17 12:00:05', 0),
(38, 1, 38, '2018-05-17 12:00:05', 0),
(39, 1, 39, '2018-05-17 12:00:05', 0),
(40, 1, 40, '2018-05-17 12:00:05', 0),
(41, 1, 41, '2018-05-17 12:00:05', 0),
(42, 1, 42, '2018-05-17 12:00:05', 0),
(43, 1, 43, '2018-05-17 12:00:05', 0),
(44, 1, 44, '2018-05-17 12:00:05', 0),
(45, 1, 45, '2018-05-17 12:00:05', 0),
(46, 1, 46, '2018-05-17 12:00:05', 0),
(47, 1, 47, '2018-05-17 12:00:05', 0),
(48, 1, 48, '2018-05-17 12:00:05', 0),
(49, 1, 49, '2018-05-17 12:00:05', 0),
(50, 1, 50, '2018-05-17 12:00:05', 0),
(51, 1, 51, '2018-05-17 12:00:05', 0),
(52, 1, 52, '2018-05-17 12:00:05', 0),
(53, 1, 53, '2018-05-17 12:00:05', 0),
(54, 1, 54, '2018-05-17 12:00:05', 0),
(55, 1, 55, '2018-05-17 12:00:05', 0),
(56, 1, 56, '2018-05-17 12:00:05', 0),
(57, 1, 57, '2018-05-17 12:00:05', 0),
(58, 1, 58, '2018-05-17 12:00:05', 0),
(59, 1, 59, '2018-05-17 12:00:05', 0),
(60, 1, 60, '2018-05-17 12:00:05', 0),
(61, 1, 61, '2018-05-17 12:00:05', 0),
(62, 2, 1, '2018-05-17 12:00:05', 0),
(63, 2, 2, '2018-05-17 12:00:05', 0),
(64, 2, 3, '2018-05-17 12:00:05', 0),
(65, 2, 4, '2018-05-17 12:00:05', 0),
(66, 2, 5, '2018-05-17 12:00:05', 0),
(67, 2, 6, '2018-05-17 12:00:05', 0),
(68, 2, 7, '2018-05-17 12:00:05', 0),
(69, 2, 8, '2018-05-17 12:00:05', 0),
(70, 2, 9, '2018-05-17 12:00:05', 0),
(71, 2, 10, '2018-05-17 12:00:05', 0),
(72, 2, 11, '2018-05-17 12:00:05', 0),
(73, 2, 12, '2018-05-17 12:00:05', 0),
(74, 2, 13, '2018-05-17 12:00:05', 0),
(75, 2, 14, '2018-05-17 12:00:05', 0),
(76, 2, 15, '2018-05-17 12:00:05', 0),
(77, 2, 16, '2018-05-17 12:00:05', 0),
(78, 2, 17, '2018-05-17 12:00:05', 0),
(79, 2, 18, '2018-05-17 12:00:05', 0),
(80, 2, 19, '2018-05-17 12:00:05', 0),
(81, 2, 20, '2018-05-17 12:00:05', 0),
(82, 2, 21, '2018-05-17 12:00:05', 0),
(83, 2, 22, '2018-05-17 12:00:05', 0),
(84, 2, 23, '2018-05-17 12:00:05', 0),
(85, 2, 24, '2018-05-17 12:00:05', 0),
(86, 2, 25, '2018-05-17 12:00:05', 0),
(87, 2, 26, '2018-05-17 12:00:05', 0),
(88, 2, 27, '2018-05-17 12:00:05', 0),
(89, 2, 28, '2018-05-17 12:00:05', 0),
(90, 2, 29, '2018-05-17 12:00:05', 0),
(91, 2, 30, '2018-05-17 12:00:05', 0),
(92, 3, 1, '2018-05-17 12:00:05', 0),
(93, 3, 2, '2018-05-17 12:00:05', 0),
(94, 3, 3, '2018-05-17 12:00:05', 0),
(95, 3, 4, '2018-05-17 12:00:05', 0),
(96, 3, 5, '2018-05-17 12:00:05', 0),
(97, 3, 6, '2018-05-17 12:00:05', 0),
(98, 3, 7, '2018-05-17 12:00:05', 0),
(99, 3, 8, '2018-05-17 12:00:05', 0),
(100, 3, 9, '2018-05-17 12:00:05', 0),
(101, 3, 10, '2018-05-17 12:00:05', 0),
(102, 3, 11, '2018-05-17 12:00:05', 0),
(103, 3, 12, '2018-05-17 12:00:05', 0),
(104, 3, 13, '2018-05-17 12:00:05', 0),
(105, 3, 14, '2018-05-17 12:00:05', 0),
(106, 3, 15, '2018-05-17 12:00:05', 0),
(107, 3, 16, '2018-05-17 12:00:05', 0),
(108, 3, 17, '2018-05-17 12:00:05', 0),
(109, 3, 18, '2018-05-17 12:00:05', 0),
(110, 3, 19, '2018-05-17 12:00:05', 0),
(111, 3, 20, '2018-05-17 12:00:05', 0),
(112, 3, 21, '2018-05-17 12:00:05', 0),
(113, 3, 22, '2018-05-17 12:00:05', 0),
(114, 3, 23, '2018-05-17 12:00:05', 0),
(115, 3, 24, '2018-05-17 12:00:05', 0),
(116, 3, 25, '2018-05-17 12:00:05', 0),
(117, 3, 26, '2018-05-17 12:00:05', 0),
(118, 3, 27, '2018-05-17 12:00:05', 0),
(119, 3, 28, '2018-05-17 12:00:05', 0),
(120, 3, 29, '2018-05-17 12:00:05', 0),
(121, 3, 30, '2018-05-17 12:00:05', 0),
(122, 3, 31, '2018-05-17 12:00:05', 0),
(123, 3, 32, '2018-05-17 12:00:05', 0),
(124, 3, 33, '2018-05-17 12:00:05', 0),
(125, 3, 34, '2018-05-17 12:00:05', 0),
(126, 3, 35, '2018-05-17 12:00:05', 0),
(127, 3, 36, '2018-05-17 12:00:05', 0),
(128, 3, 37, '2018-05-17 12:00:05', 0),
(129, 3, 38, '2018-05-17 12:00:05', 0),
(130, 3, 39, '2018-05-17 12:00:05', 0),
(131, 3, 40, '2018-05-17 12:00:05', 0),
(132, 3, 41, '2018-05-17 12:00:05', 0),
(133, 3, 42, '2018-05-17 12:00:05', 0),
(134, 3, 43, '2018-05-17 12:00:05', 0),
(135, 3, 44, '2018-05-17 12:00:05', 0),
(136, 3, 45, '2018-05-17 12:00:05', 0),
(137, 3, 46, '2018-05-17 12:00:05', 0),
(138, 3, 47, '2018-05-17 12:00:05', 0),
(139, 3, 48, '2018-05-17 12:00:05', 0),
(140, 3, 49, '2018-05-17 12:00:05', 0),
(141, 3, 50, '2018-05-17 12:00:05', 0),
(142, 3, 51, '2018-05-17 12:00:05', 0),
(143, 3, 52, '2018-05-17 12:00:05', 0),
(144, 3, 53, '2018-05-17 12:00:05', 0),
(145, 3, 54, '2018-05-17 12:00:05', 0),
(146, 3, 55, '2018-05-17 12:00:05', 0),
(147, 3, 56, '2018-05-17 12:00:05', 0),
(148, 5, 1, '2018-05-17 12:00:05', 0),
(149, 5, 2, '2018-05-17 12:00:05', 0),
(150, 5, 3, '2018-05-17 12:00:05', 0),
(151, 5, 4, '2018-05-17 12:00:05', 0),
(152, 5, 5, '2018-05-17 12:00:05', 0),
(153, 5, 6, '2018-05-17 12:00:05', 0),
(154, 5, 7, '2018-05-17 12:00:05', 0),
(155, 5, 8, '2018-05-17 12:00:05', 0),
(156, 5, 9, '2018-05-17 12:00:05', 0),
(157, 5, 10, '2018-05-17 12:00:05', 0),
(158, 5, 11, '2018-05-17 12:00:05', 0),
(159, 5, 12, '2018-05-17 12:00:05', 0),
(160, 5, 13, '2018-05-17 12:00:05', 0),
(161, 5, 14, '2018-05-17 12:00:05', 0),
(162, 5, 15, '2018-05-17 12:00:05', 0),
(163, 5, 16, '2018-05-17 12:00:05', 0),
(164, 5, 17, '2018-05-17 12:00:05', 0),
(165, 5, 18, '2018-05-17 12:00:05', 0),
(166, 5, 19, '2018-05-17 12:00:05', 0),
(167, 5, 20, '2018-05-17 12:00:05', 0),
(168, 5, 21, '2018-05-17 12:00:05', 0),
(169, 5, 22, '2018-05-17 12:00:05', 0),
(170, 5, 23, '2018-05-17 12:00:05', 0),
(171, 6, 1, '2018-05-17 12:00:05', 0),
(172, 6, 2, '2018-05-17 12:00:05', 0),
(173, 6, 3, '2018-05-17 12:00:05', 0),
(174, 6, 4, '2018-05-17 12:00:05', 0),
(175, 6, 5, '2018-05-17 12:00:05', 0),
(176, 6, 6, '2018-05-17 12:00:05', 0),
(177, 6, 7, '2018-05-17 12:00:05', 0),
(178, 6, 8, '2018-05-17 12:00:05', 0),
(179, 6, 9, '2018-05-17 12:00:05', 0),
(180, 6, 10, '2018-05-17 12:00:05', 0),
(181, 6, 11, '2018-05-17 12:00:05', 0),
(182, 6, 12, '2018-05-17 12:00:05', 0),
(183, 6, 13, '2018-05-17 12:00:05', 0),
(184, 6, 14, '2018-05-17 12:00:05', 0),
(185, 6, 15, '2018-05-17 12:00:05', 0),
(186, 6, 16, '2018-05-17 12:00:05', 0),
(187, 6, 17, '2018-05-17 12:00:05', 0),
(188, 6, 18, '2018-05-17 12:00:05', 0),
(189, 6, 19, '2018-05-17 12:00:05', 0),
(190, 6, 20, '2018-05-17 12:00:05', 0),
(191, 6, 21, '2018-05-17 12:00:05', 0),
(192, 6, 22, '2018-05-17 12:00:05', 0),
(193, 6, 23, '2018-05-17 12:00:05', 0),
(194, 7, 1, '2018-05-17 12:00:05', 0),
(195, 7, 2, '2018-05-17 12:00:05', 0),
(196, 7, 3, '2018-05-17 12:00:05', 0),
(197, 7, 4, '2018-05-17 12:00:05', 0),
(198, 7, 5, '2018-05-17 12:00:05', 0),
(199, 7, 6, '2018-05-17 12:00:05', 0),
(200, 7, 7, '2018-05-17 12:00:05', 0),
(201, 7, 8, '2018-05-17 12:00:05', 0),
(202, 7, 9, '2018-05-17 12:00:05', 0),
(203, 7, 10, '2018-05-17 12:00:05', 0),
(204, 7, 11, '2018-05-17 12:00:05', 0),
(205, 7, 12, '2018-05-17 12:00:05', 0),
(206, 7, 13, '2018-05-17 12:00:05', 0),
(207, 7, 14, '2018-05-17 12:00:05', 0),
(208, 7, 15, '2018-05-17 12:00:05', 0),
(209, 7, 16, '2018-05-17 12:00:05', 0),
(210, 7, 17, '2018-05-17 12:00:05', 0),
(211, 7, 18, '2018-05-17 12:00:05', 0),
(212, 7, 19, '2018-05-17 12:00:05', 0),
(213, 7, 20, '2018-05-17 12:00:05', 0),
(214, 7, 21, '2018-05-17 12:00:05', 0),
(215, 7, 22, '2018-05-17 12:00:05', 0),
(216, 7, 23, '2018-05-17 12:00:05', 0),
(217, 8, 1, '2018-05-17 12:00:05', 0),
(218, 8, 2, '2018-05-17 12:00:05', 0),
(219, 8, 3, '2018-05-17 12:00:05', 0),
(220, 8, 4, '2018-05-17 12:00:05', 0),
(221, 8, 5, '2018-05-17 12:00:05', 0),
(222, 8, 6, '2018-05-17 12:00:05', 0),
(223, 8, 7, '2018-05-17 12:00:05', 0),
(224, 8, 8, '2018-05-17 12:00:05', 0),
(225, 8, 9, '2018-05-17 12:00:05', 0),
(226, 8, 10, '2018-05-17 12:00:05', 0),
(227, 8, 11, '2018-05-17 12:00:05', 0),
(228, 8, 12, '2018-05-17 12:00:05', 0),
(229, 8, 13, '2018-05-17 12:00:05', 0),
(230, 8, 14, '2018-05-17 12:00:05', 0),
(231, 8, 15, '2018-05-17 12:00:05', 0),
(232, 8, 16, '2018-05-17 12:00:05', 0),
(233, 8, 17, '2018-05-17 12:00:05', 0),
(234, 8, 18, '2018-05-17 12:00:05', 0),
(235, 8, 19, '2018-05-17 12:00:05', 0),
(236, 8, 20, '2018-05-17 12:00:05', 0),
(237, 8, 21, '2018-05-17 12:00:05', 0),
(238, 8, 22, '2018-05-17 12:00:05', 0),
(239, 8, 23, '2018-05-17 12:00:05', 0),
(240, 8, 24, '2018-05-17 12:00:05', 0),
(241, 8, 25, '2018-05-17 12:00:05', 0),
(242, 8, 26, '2018-05-17 12:00:05', 0),
(243, 8, 27, '2018-05-17 12:00:05', 0),
(244, 8, 28, '2018-05-17 12:00:05', 0),
(245, 8, 29, '2018-05-17 12:00:05', 0),
(246, 8, 30, '2018-05-17 12:00:05', 0),
(247, 8, 31, '2018-05-17 12:00:05', 0),
(248, 8, 32, '2018-05-17 12:00:05', 0),
(249, 8, 33, '2018-05-17 12:00:05', 0),
(250, 8, 34, '2018-05-17 12:00:05', 0),
(251, 8, 35, '2018-05-17 12:00:05', 0),
(252, 8, 36, '2018-05-17 12:00:05', 0),
(253, 8, 37, '2018-05-17 12:00:05', 0),
(254, 8, 38, '2018-05-17 12:00:05', 0),
(255, 8, 39, '2018-05-17 12:00:05', 0),
(256, 8, 40, '2018-05-17 12:00:05', 0),
(257, 8, 41, '2018-05-17 12:00:05', 0),
(258, 8, 42, '2018-05-17 12:00:05', 0),
(259, 8, 43, '2018-05-17 12:00:05', 0),
(260, 8, 44, '2018-05-17 12:00:05', 0),
(261, 8, 45, '2018-05-17 12:00:05', 0),
(262, 8, 46, '2018-05-17 12:00:05', 0),
(263, 8, 47, '2018-05-17 12:00:05', 0),
(264, 8, 48, '2018-05-17 12:00:05', 0),
(265, 8, 49, '2018-05-17 12:00:05', 0),
(266, 8, 50, '2018-05-17 12:00:05', 0),
(267, 8, 51, '2018-05-17 12:00:05', 0),
(268, 8, 52, '2018-05-17 12:00:05', 0),
(269, 8, 53, '2018-05-17 12:00:05', 0),
(270, 8, 54, '2018-05-17 12:00:05', 0),
(271, 8, 55, '2018-05-17 12:00:05', 0),
(272, 8, 56, '2018-05-17 12:00:05', 0),
(273, 8, 57, '2018-05-17 12:00:05', 0),
(274, 8, 58, '2018-05-17 12:00:05', 0),
(275, 8, 59, '2018-05-17 12:00:05', 0),
(276, 8, 60, '2018-05-17 12:00:05', 0),
(277, 8, 61, '2018-05-17 12:00:05', 0),
(278, 8, 62, '2018-05-17 12:00:05', 0),
(279, 8, 63, '2018-05-17 12:00:05', 0),
(280, 8, 64, '2018-05-17 12:00:05', 0),
(281, 8, 65, '2018-05-17 12:00:05', 0),
(282, 8, 66, '2018-05-17 12:00:05', 0),
(283, 8, 67, '2018-05-17 12:00:05', 0),
(284, 8, 68, '2018-05-17 12:00:05', 0),
(285, 8, 69, '2018-05-17 12:00:05', 0),
(286, 8, 70, '2018-05-17 12:00:05', 0),
(287, 8, 71, '2018-05-17 12:00:05', 0),
(288, 8, 72, '2018-05-17 12:00:05', 0),
(289, 8, 73, '2018-05-17 12:00:05', 0),
(290, 8, 74, '2018-05-17 12:00:05', 0),
(291, 8, 75, '2018-05-17 12:00:05', 0),
(292, 8, 76, '2018-05-17 12:00:05', 0),
(293, 8, 77, '2018-05-17 12:00:05', 0),
(294, 8, 78, '2018-05-17 12:00:05', 0),
(295, 8, 79, '2018-05-17 12:00:05', 0),
(296, 8, 80, '2018-05-17 12:00:05', 0),
(297, 8, 81, '2018-05-17 12:00:05', 0),
(298, 8, 82, '2018-05-17 12:00:05', 0),
(299, 8, 83, '2018-05-17 12:00:05', 0),
(300, 8, 84, '2018-05-17 12:00:05', 0),
(301, 8, 85, '2018-05-17 12:00:05', 0),
(302, 8, 86, '2018-05-17 12:00:05', 0),
(303, 8, 87, '2018-05-17 12:00:05', 0),
(304, 8, 88, '2018-05-17 12:00:05', 0),
(305, 8, 89, '2018-05-17 12:00:05', 0),
(306, 8, 90, '2018-05-17 12:00:05', 0),
(307, 8, 91, '2018-05-17 12:00:05', 0),
(308, 8, 92, '2018-05-17 12:00:05', 0),
(309, 8, 93, '2018-05-17 12:00:05', 0),
(310, 8, 94, '2018-05-17 12:00:05', 0),
(311, 8, 95, '2018-05-17 12:00:05', 0),
(312, 9, 1, '2018-05-17 12:00:05', 0),
(313, 9, 2, '2018-05-17 12:00:05', 0),
(314, 9, 3, '2018-05-17 12:00:05', 0),
(315, 9, 4, '2018-05-17 12:00:05', 0),
(316, 9, 5, '2018-05-17 12:00:05', 0),
(317, 9, 6, '2018-05-17 12:00:05', 0),
(318, 9, 7, '2018-05-17 12:00:05', 0),
(319, 9, 8, '2018-05-17 12:00:05', 0),
(320, 9, 9, '2018-05-17 12:00:05', 0),
(321, 9, 10, '2018-05-17 12:00:05', 0),
(322, 9, 11, '2018-05-17 12:00:05', 0),
(323, 9, 12, '2018-05-17 12:00:05', 0),
(324, 9, 13, '2018-05-17 12:00:05', 0),
(325, 9, 14, '2018-05-17 12:00:05', 0),
(326, 9, 15, '2018-05-17 12:00:05', 0),
(327, 9, 16, '2018-05-17 12:00:05', 0),
(328, 9, 17, '2018-05-17 12:00:05', 0),
(329, 9, 18, '2018-05-17 12:00:05', 0),
(330, 9, 19, '2018-05-17 12:00:05', 0),
(331, 10, 1, '2018-05-17 12:00:05', 0),
(332, 10, 2, '2018-05-17 12:00:05', 0),
(333, 10, 3, '2018-05-17 12:00:05', 0),
(334, 10, 4, '2018-05-17 12:00:05', 0),
(335, 10, 5, '2018-05-17 12:00:05', 0),
(336, 10, 6, '2018-05-17 12:00:05', 0),
(337, 10, 7, '2018-05-17 12:00:05', 0),
(338, 10, 8, '2018-05-17 12:00:05', 0),
(339, 10, 9, '2018-05-17 12:00:05', 0),
(340, 10, 10, '2018-05-17 12:00:05', 0),
(341, 10, 11, '2018-05-17 12:00:05', 0),
(342, 10, 12, '2018-05-17 12:00:05', 0),
(343, 10, 13, '2018-05-17 12:00:05', 0),
(344, 10, 14, '2018-05-17 12:00:05', 0),
(345, 10, 15, '2018-05-17 12:00:05', 0),
(346, 10, 16, '2018-05-17 12:00:05', 0),
(347, 10, 17, '2018-05-17 12:00:05', 0),
(348, 10, 18, '2018-05-17 12:00:05', 0),
(349, 10, 19, '2018-05-17 12:00:05', 0),
(350, 10, 20, '2018-05-17 12:00:05', 0),
(351, 10, 21, '2018-05-17 12:00:05', 0),
(352, 10, 22, '2018-05-17 12:00:05', 0),
(353, 10, 23, '2018-05-17 12:00:05', 0),
(354, 10, 24, '2018-05-17 12:00:05', 0),
(355, 10, 25, '2018-05-17 12:00:05', 0),
(356, 10, 26, '2018-05-17 12:00:05', 0),
(357, 10, 27, '2018-05-17 12:00:05', 0),
(358, 10, 28, '2018-05-17 12:00:05', 0),
(359, 10, 29, '2018-05-17 12:00:05', 0),
(360, 10, 30, '2018-05-17 12:00:05', 0),
(361, 10, 31, '2018-05-17 12:00:05', 0),
(362, 12, 1, '2018-05-17 12:00:05', 0),
(363, 12, 2, '2018-05-17 12:00:05', 0),
(364, 12, 3, '2018-05-17 12:00:05', 0),
(365, 12, 4, '2018-05-17 12:00:05', 0),
(366, 12, 5, '2018-05-17 12:00:05', 0),
(367, 12, 6, '2018-05-17 12:00:05', 0),
(368, 12, 7, '2018-05-17 12:00:05', 0),
(369, 12, 8, '2018-05-17 12:00:05', 0),
(370, 12, 9, '2018-05-17 12:00:05', 0),
(371, 12, 10, '2018-05-17 12:00:05', 0),
(372, 12, 11, '2018-05-17 12:00:05', 0),
(373, 12, 12, '2018-05-17 12:00:05', 0),
(374, 12, 13, '2018-05-17 12:00:05', 0),
(375, 12, 14, '2018-05-17 12:00:05', 0),
(376, 12, 15, '2018-05-17 12:00:05', 0),
(377, 12, 16, '2018-05-17 12:00:05', 0),
(378, 12, 17, '2018-05-17 12:00:05', 0),
(379, 12, 18, '2018-05-17 12:00:05', 0),
(380, 12, 19, '2018-05-17 12:00:05', 0),
(381, 12, 20, '2018-05-17 12:00:05', 0),
(382, 12, 21, '2018-05-17 12:00:05', 0),
(383, 12, 22, '2018-05-17 12:00:05', 0),
(384, 12, 23, '2018-05-17 12:00:05', 0),
(385, 12, 24, '2018-05-17 12:00:05', 0),
(386, 12, 25, '2018-05-17 12:00:05', 0),
(387, 12, 26, '2018-05-17 12:00:05', 0),
(388, 12, 27, '2018-05-17 12:00:05', 0),
(389, 12, 28, '2018-05-17 12:00:05', 0),
(390, 12, 29, '2018-05-17 12:00:05', 0),
(391, 12, 30, '2018-05-17 12:00:05', 0),
(392, 12, 31, '2018-05-17 12:00:05', 0),
(393, 12, 32, '2018-05-17 12:00:05', 0),
(394, 12, 33, '2018-05-17 12:00:05', 0),
(395, 12, 34, '2018-05-17 12:00:05', 0),
(396, 12, 35, '2018-05-17 12:00:05', 0),
(397, 12, 36, '2018-05-17 12:00:05', 0),
(398, 12, 37, '2018-05-17 12:00:05', 0),
(399, 12, 38, '2018-05-17 12:00:05', 0),
(400, 12, 39, '2018-05-17 12:00:05', 0),
(401, 12, 40, '2018-05-17 12:00:05', 0),
(402, 12, 41, '2018-05-17 12:00:05', 0),
(403, 12, 42, '2018-05-17 12:00:05', 0),
(404, 12, 43, '2018-05-17 12:00:05', 0),
(405, 12, 44, '2018-05-17 12:00:05', 0),
(406, 12, 45, '2018-05-17 12:00:05', 0),
(407, 12, 46, '2018-05-17 12:00:05', 0),
(408, 12, 47, '2018-05-17 12:00:05', 0),
(409, 12, 48, '2018-05-17 12:00:05', 0),
(410, 12, 49, '2018-05-17 12:00:05', 0),
(411, 12, 50, '2018-05-17 12:00:05', 0),
(412, 12, 51, '2018-05-17 12:00:05', 0),
(413, 12, 52, '2018-05-17 12:00:05', 0),
(414, 12, 53, '2018-05-17 12:00:05', 0),
(415, 12, 54, '2018-05-17 12:00:05', 0),
(416, 12, 55, '2018-05-17 12:00:05', 0),
(417, 12, 56, '2018-05-17 12:00:05', 0),
(418, 12, 57, '2018-05-17 12:00:05', 0),
(419, 12, 58, '2018-05-17 12:00:05', 0),
(420, 12, 59, '2018-05-17 12:00:05', 0),
(421, 12, 60, '2018-05-17 12:00:05', 0),
(422, 12, 61, '2018-05-17 12:00:05', 0),
(423, 12, 62, '2018-05-17 12:00:05', 0),
(424, 12, 63, '2018-05-17 12:00:05', 0),
(425, 12, 64, '2018-05-17 12:00:05', 0),
(426, 12, 65, '2018-05-17 12:00:05', 0),
(427, 12, 66, '2018-05-17 12:00:05', 0),
(428, 12, 67, '2018-05-17 12:00:05', 0),
(429, 12, 68, '2018-05-17 12:00:05', 0),
(430, 12, 69, '2018-05-17 12:00:05', 0),
(431, 12, 70, '2018-05-17 12:00:05', 0),
(432, 12, 71, '2018-05-17 12:00:05', 0),
(433, 12, 72, '2018-05-17 12:00:05', 0),
(434, 12, 73, '2018-05-17 12:00:05', 0),
(435, 12, 74, '2018-05-17 12:00:05', 0),
(436, 12, 75, '2018-05-17 12:00:05', 0),
(437, 12, 76, '2018-05-17 12:00:05', 0),
(438, 12, 77, '2018-05-17 12:00:05', 0),
(439, 12, 78, '2018-05-17 12:00:05', 0),
(440, 12, 79, '2018-05-17 12:00:05', 0),
(441, 12, 80, '2018-05-17 12:00:05', 0),
(442, 12, 81, '2018-05-17 12:00:05', 0),
(443, 12, 82, '2018-05-17 12:00:05', 0),
(444, 12, 83, '2018-05-17 12:00:05', 0),
(445, 12, 84, '2018-05-17 12:00:05', 0),
(446, 12, 85, '2018-05-17 12:00:05', 0),
(447, 12, 86, '2018-05-17 12:00:05', 0),
(448, 12, 87, '2018-05-17 12:00:05', 0),
(449, 12, 88, '2018-05-17 12:00:05', 0),
(450, 12, 89, '2018-05-17 12:00:05', 0),
(451, 12, 90, '2018-05-17 12:00:05', 0),
(452, 12, 91, '2018-05-17 12:00:05', 0),
(453, 12, 92, '2018-05-17 12:00:05', 0),
(454, 12, 93, '2018-05-17 12:00:05', 0),
(455, 12, 94, '2018-05-17 12:00:05', 0),
(456, 12, 95, '2018-05-17 12:00:05', 0),
(457, 12, 96, '2018-05-17 12:00:05', 0),
(458, 12, 97, '2018-05-17 12:00:05', 0),
(459, 12, 98, '2018-05-17 12:00:05', 0),
(460, 12, 99, '2018-05-17 12:00:05', 0),
(461, 12, 100, '2018-05-17 12:00:05', 0),
(462, 12, 101, '2018-05-17 12:00:05', 0),
(463, 12, 102, '2018-05-17 12:00:05', 0),
(464, 12, 103, '2018-05-17 12:00:05', 0),
(465, 12, 104, '2018-05-17 12:00:05', 0),
(466, 12, 105, '2018-05-17 12:00:05', 0),
(467, 12, 106, '2018-05-17 12:00:05', 0),
(468, 12, 107, '2018-05-17 12:00:05', 0),
(469, 12, 108, '2018-05-17 12:00:05', 0),
(470, 12, 109, '2018-05-17 12:00:05', 0),
(471, 12, 110, '2018-05-17 12:00:05', 0),
(472, 12, 111, '2018-05-17 12:00:05', 0),
(473, 12, 112, '2018-05-17 12:00:05', 0),
(474, 12, 113, '2018-05-17 12:00:05', 0),
(475, 12, 114, '2018-05-17 12:00:05', 0),
(476, 12, 115, '2018-05-17 12:00:05', 0),
(477, 12, 116, '2018-05-17 12:00:05', 0),
(478, 12, 117, '2018-05-17 12:00:05', 0),
(479, 12, 118, '2018-05-17 12:00:05', 0),
(480, 12, 119, '2018-05-17 12:00:05', 0),
(481, 12, 120, '2018-05-17 12:00:05', 0),
(482, 12, 121, '2018-05-17 12:00:05', 0),
(483, 12, 122, '2018-05-17 12:00:05', 0),
(484, 12, 123, '2018-05-17 12:00:05', 0),
(485, 12, 124, '2018-05-17 12:00:05', 0),
(486, 12, 125, '2018-05-17 12:00:05', 0),
(487, 12, 126, '2018-05-17 12:00:05', 0),
(488, 12, 127, '2018-05-17 12:00:05', 0),
(489, 12, 128, '2018-05-17 12:00:05', 0),
(490, 12, 129, '2018-05-17 12:00:05', 0),
(491, 12, 130, '2018-05-17 12:00:05', 0),
(492, 12, 131, '2018-05-17 12:00:05', 0),
(493, 12, 132, '2018-05-17 12:00:05', 0),
(494, 12, 133, '2018-05-17 12:00:05', 0),
(495, 12, 134, '2018-05-17 12:00:05', 0),
(496, 12, 135, '2018-05-17 12:00:05', 0),
(497, 12, 136, '2018-05-17 12:00:05', 0),
(498, 12, 137, '2018-05-17 12:00:05', 0),
(499, 12, 138, '2018-05-17 12:00:05', 0),
(500, 12, 139, '2018-05-17 12:00:05', 0),
(501, 12, 140, '2018-05-17 12:00:05', 0),
(502, 12, 141, '2018-05-17 12:00:05', 0),
(503, 12, 142, '2018-05-17 12:00:05', 0),
(504, 12, 143, '2018-05-17 12:00:05', 0),
(505, 12, 144, '2018-05-17 12:00:05', 0),
(506, 12, 145, '2018-05-17 12:00:05', 0),
(507, 12, 146, '2018-05-17 12:00:05', 0),
(508, 12, 147, '2018-05-17 12:00:05', 0),
(509, 12, 148, '2018-05-17 12:00:05', 0),
(510, 12, 149, '2018-05-17 12:00:05', 0),
(511, 12, 150, '2018-05-17 12:00:05', 0),
(512, 12, 151, '2018-05-17 12:00:05', 0),
(513, 12, 152, '2018-05-17 12:00:05', 0),
(514, 12, 153, '2018-05-17 12:00:05', 0),
(515, 12, 154, '2018-05-17 12:00:05', 0),
(516, 12, 155, '2018-05-17 12:00:05', 0),
(517, 12, 156, '2018-05-17 12:00:05', 0),
(518, 12, 157, '2018-05-17 12:00:05', 0),
(519, 12, 158, '2018-05-17 12:00:05', 0),
(520, 12, 159, '2018-05-17 12:00:05', 0),
(521, 12, 160, '2018-05-17 12:00:05', 0),
(522, 12, 161, '2018-05-17 12:00:05', 0),
(523, 12, 162, '2018-05-17 12:00:05', 0),
(524, 12, 163, '2018-05-17 12:00:05', 0),
(525, 13, 1, '2018-05-17 12:00:05', 0),
(526, 13, 2, '2018-05-17 12:00:05', 0),
(527, 13, 3, '2018-05-17 12:00:05', 0),
(528, 13, 4, '2018-05-17 12:00:05', 0),
(529, 13, 5, '2018-05-17 12:00:05', 0),
(530, 13, 6, '2018-05-17 12:00:05', 0),
(531, 13, 7, '2018-05-17 12:00:05', 0),
(532, 13, 8, '2018-05-17 12:00:05', 0),
(533, 13, 9, '2018-05-17 12:00:05', 0),
(534, 13, 10, '2018-05-17 12:00:05', 0),
(535, 13, 11, '2018-05-17 12:00:05', 0),
(536, 13, 12, '2018-05-17 12:00:05', 0),
(537, 13, 13, '2018-05-17 12:00:05', 0),
(538, 13, 14, '2018-05-17 12:00:05', 0),
(539, 13, 15, '2018-05-17 12:00:05', 0),
(540, 13, 16, '2018-05-17 12:00:05', 0),
(541, 13, 17, '2018-05-17 12:00:05', 0),
(542, 13, 18, '2018-05-17 12:00:05', 0),
(543, 13, 19, '2018-05-17 12:00:05', 0),
(544, 13, 20, '2018-05-17 12:00:05', 0),
(545, 13, 21, '2018-05-17 12:00:05', 0),
(546, 13, 22, '2018-05-17 12:00:05', 0),
(547, 13, 23, '2018-05-17 12:00:05', 0),
(548, 13, 24, '2018-05-17 12:00:05', 0),
(549, 13, 25, '2018-05-17 12:00:05', 0),
(550, 13, 26, '2018-05-17 12:00:05', 0),
(551, 13, 27, '2018-05-17 12:00:05', 0),
(552, 13, 28, '2018-05-17 12:00:05', 0),
(553, 13, 29, '2018-05-17 12:00:05', 0),
(554, 13, 30, '2018-05-17 12:00:05', 0),
(555, 13, 31, '2018-05-17 12:00:05', 0),
(556, 13, 32, '2018-05-17 12:00:05', 0),
(557, 13, 33, '2018-05-17 12:00:05', 0),
(558, 13, 34, '2018-05-17 12:00:05', 0),
(559, 13, 35, '2018-05-17 12:00:05', 0),
(560, 13, 36, '2018-05-17 12:00:05', 0),
(561, 13, 37, '2018-05-17 12:00:05', 0),
(562, 13, 38, '2018-05-17 12:00:05', 0),
(563, 13, 39, '2018-05-17 12:00:05', 0),
(564, 13, 40, '2018-05-17 12:00:05', 0),
(565, 13, 41, '2018-05-17 12:00:05', 0),
(566, 13, 42, '2018-05-17 12:00:05', 0),
(567, 13, 43, '2018-05-17 12:00:05', 0),
(568, 13, 44, '2018-05-17 12:00:05', 0),
(569, 13, 45, '2018-05-17 12:00:05', 0),
(570, 13, 46, '2018-05-17 12:00:05', 0),
(571, 13, 47, '2018-05-17 12:00:05', 0),
(572, 13, 48, '2018-05-17 12:00:05', 0),
(573, 13, 49, '2018-05-17 12:00:05', 0),
(574, 13, 50, '2018-05-17 12:00:05', 0),
(575, 13, 51, '2018-05-17 12:00:05', 0),
(576, 13, 52, '2018-05-17 12:00:05', 0),
(577, 13, 53, '2018-05-17 12:00:05', 0),
(578, 13, 54, '2018-05-17 12:00:05', 0),
(579, 13, 55, '2018-05-17 12:00:05', 0),
(580, 13, 56, '2018-05-17 12:00:05', 0),
(581, 13, 57, '2018-05-17 12:00:05', 0),
(582, 13, 58, '2018-05-17 12:00:05', 0),
(583, 13, 59, '2018-05-17 12:00:05', 0),
(584, 13, 60, '2018-05-17 12:00:05', 0),
(585, 13, 61, '2018-05-17 12:00:05', 0),
(586, 13, 62, '2018-05-17 12:00:05', 0),
(587, 13, 63, '2018-05-17 12:00:05', 0),
(588, 13, 64, '2018-05-17 12:00:05', 0),
(589, 13, 65, '2018-05-17 12:00:05', 0),
(590, 13, 66, '2018-05-17 12:00:05', 0),
(591, 13, 67, '2018-05-17 12:00:05', 0),
(592, 13, 68, '2018-05-17 12:00:05', 0),
(593, 13, 69, '2018-05-17 12:00:05', 0),
(594, 13, 70, '2018-05-17 12:00:05', 0),
(595, 13, 71, '2018-05-17 12:00:05', 0),
(596, 13, 72, '2018-05-17 12:00:05', 0),
(597, 13, 73, '2018-05-17 12:00:05', 0),
(598, 13, 74, '2018-05-17 12:00:05', 0),
(599, 13, 75, '2018-05-17 12:00:05', 0),
(600, 13, 76, '2018-05-17 12:00:05', 0),
(601, 13, 77, '2018-05-17 12:00:05', 0),
(602, 13, 78, '2018-05-17 12:00:05', 0),
(603, 13, 79, '2018-05-17 12:00:05', 0),
(604, 13, 80, '2018-05-17 12:00:05', 0),
(605, 13, 81, '2018-05-17 12:00:05', 0),
(606, 13, 82, '2018-05-17 12:00:05', 0),
(607, 13, 83, '2018-05-17 12:00:05', 0),
(608, 13, 84, '2018-05-17 12:00:05', 0),
(609, 13, 85, '2018-05-17 12:00:05', 0),
(610, 13, 86, '2018-05-17 12:00:05', 0),
(611, 13, 87, '2018-05-17 12:00:05', 0),
(612, 13, 88, '2018-05-17 12:00:05', 0),
(613, 13, 89, '2018-05-17 12:00:05', 0),
(614, 13, 90, '2018-05-17 12:00:05', 0),
(615, 13, 91, '2018-05-17 12:00:05', 0),
(616, 13, 92, '2018-05-17 12:00:05', 0),
(617, 13, 93, '2018-05-17 12:00:05', 0),
(618, 13, 94, '2018-05-17 12:00:05', 0),
(619, 13, 95, '2018-05-17 12:00:05', 0),
(620, 13, 96, '2018-05-17 12:00:05', 0),
(621, 13, 97, '2018-05-17 12:00:05', 0),
(622, 13, 98, '2018-05-17 12:00:05', 0),
(623, 13, 99, '2018-05-17 12:00:05', 0),
(624, 13, 100, '2018-05-17 12:00:05', 0),
(625, 14, 1, '2018-05-17 12:00:05', 0),
(626, 14, 2, '2018-05-17 12:00:05', 0),
(627, 14, 3, '2018-05-17 12:00:05', 0),
(628, 14, 4, '2018-05-17 12:00:05', 0),
(629, 14, 5, '2018-05-17 12:00:05', 0),
(630, 14, 6, '2018-05-17 12:00:05', 0),
(631, 14, 7, '2018-05-17 12:00:05', 0),
(632, 14, 8, '2018-05-17 12:00:05', 0),
(633, 14, 9, '2018-05-17 12:00:05', 0),
(634, 14, 10, '2018-05-17 12:00:05', 0),
(635, 14, 11, '2018-05-17 12:00:05', 0),
(636, 14, 12, '2018-05-17 12:00:05', 0),
(637, 14, 13, '2018-05-17 12:00:05', 0),
(638, 14, 14, '2018-05-17 12:00:05', 0),
(639, 14, 15, '2018-05-17 12:00:05', 0),
(640, 14, 16, '2018-05-17 12:00:05', 0),
(641, 14, 17, '2018-05-17 12:00:05', 0),
(642, 14, 18, '2018-05-17 12:00:05', 0),
(643, 14, 19, '2018-05-17 12:00:05', 0),
(644, 14, 20, '2018-05-17 12:00:05', 0),
(645, 14, 21, '2018-05-17 12:00:05', 0),
(646, 14, 22, '2018-05-17 12:00:05', 0),
(647, 14, 23, '2018-05-17 12:00:05', 0),
(648, 14, 24, '2018-05-17 12:00:05', 0),
(649, 14, 25, '2018-05-17 12:00:05', 0),
(650, 14, 26, '2018-05-17 12:00:05', 0),
(651, 14, 27, '2018-05-17 12:00:05', 0),
(652, 14, 28, '2018-05-17 12:00:05', 0),
(653, 14, 29, '2018-05-17 12:00:05', 0),
(654, 14, 30, '2018-05-17 12:00:05', 0),
(655, 14, 31, '2018-05-17 12:00:05', 0),
(656, 14, 32, '2018-05-17 12:00:05', 0),
(657, 14, 33, '2018-05-17 12:00:05', 0),
(658, 14, 34, '2018-05-17 12:00:05', 0),
(659, 14, 35, '2018-05-17 12:00:05', 0),
(660, 14, 36, '2018-05-17 12:00:05', 0),
(661, 14, 37, '2018-05-17 12:00:05', 0),
(662, 14, 38, '2018-05-17 12:00:05', 0),
(663, 14, 39, '2018-05-17 12:00:05', 0),
(664, 14, 40, '2018-05-17 12:00:05', 0),
(665, 14, 41, '2018-05-17 12:00:05', 0),
(666, 14, 42, '2018-05-17 12:00:05', 0),
(667, 14, 43, '2018-05-17 12:00:05', 0),
(668, 14, 44, '2018-05-17 12:00:05', 0),
(669, 14, 45, '2018-05-17 12:00:05', 0),
(670, 14, 46, '2018-05-17 12:00:05', 0),
(671, 14, 47, '2018-05-17 12:00:05', 0),
(672, 16, 1, '2018-05-17 12:00:05', 0),
(673, 16, 2, '2018-05-17 12:00:05', 0),
(674, 16, 3, '2018-05-17 12:00:05', 0),
(675, 16, 4, '2018-05-17 12:00:05', 0),
(676, 16, 5, '2018-05-17 12:00:05', 0),
(677, 16, 6, '2018-05-17 12:00:05', 0),
(678, 16, 7, '2018-05-17 12:00:05', 0),
(679, 16, 8, '2018-05-17 12:00:05', 0),
(680, 16, 9, '2018-05-17 12:00:05', 0),
(681, 16, 10, '2018-05-17 12:00:05', 0),
(682, 16, 11, '2018-05-17 12:00:05', 0),
(683, 16, 12, '2018-05-17 12:00:05', 0),
(684, 16, 13, '2018-05-17 12:00:05', 0),
(685, 16, 14, '2018-05-17 12:00:05', 0),
(686, 16, 15, '2018-05-17 12:00:05', 0),
(687, 16, 16, '2018-05-17 12:00:05', 0),
(688, 16, 17, '2018-05-17 12:00:05', 0),
(689, 16, 18, '2018-05-17 12:00:05', 0),
(690, 16, 19, '2018-05-17 12:00:05', 0),
(691, 16, 20, '2018-05-17 12:00:05', 0),
(692, 16, 21, '2018-05-17 12:00:05', 0),
(693, 16, 22, '2018-05-17 12:00:05', 0),
(694, 16, 23, '2018-05-17 12:00:05', 0),
(695, 16, 24, '2018-05-17 12:00:05', 0),
(696, 16, 25, '2018-05-17 12:00:05', 0),
(697, 16, 26, '2018-05-17 12:00:05', 0),
(698, 16, 27, '2018-05-17 12:00:05', 0),
(699, 16, 28, '2018-05-17 12:00:05', 0),
(700, 16, 29, '2018-05-17 12:00:05', 0),
(701, 16, 30, '2018-05-17 12:00:05', 0),
(702, 16, 31, '2018-05-17 12:00:05', 0),
(703, 16, 32, '2018-05-17 12:00:05', 0),
(704, 16, 33, '2018-05-17 12:00:05', 0),
(705, 16, 34, '2018-05-17 12:00:05', 0),
(706, 16, 35, '2018-05-17 12:00:05', 0),
(707, 16, 36, '2018-05-17 12:00:05', 0),
(708, 16, 37, '2018-05-17 12:00:05', 0),
(709, 16, 38, '2018-05-17 12:00:05', 0),
(710, 16, 39, '2018-05-17 12:00:05', 0),
(711, 16, 40, '2018-05-17 12:00:05', 0),
(712, 16, 41, '2018-05-17 12:00:05', 0),
(713, 16, 42, '2018-05-17 12:00:05', 0),
(714, 16, 43, '2018-05-17 12:00:05', 0),
(715, 16, 44, '2018-05-17 12:00:05', 0),
(716, 16, 45, '2018-05-17 12:00:05', 0),
(717, 16, 46, '2018-05-17 12:00:05', 0),
(718, 16, 47, '2018-05-17 12:00:05', 0),
(719, 16, 48, '2018-05-17 12:00:05', 0),
(720, 16, 49, '2018-05-17 12:00:05', 0),
(721, 16, 50, '2018-05-17 12:00:05', 0),
(722, 16, 51, '2018-05-17 12:00:05', 0),
(723, 16, 52, '2018-05-17 12:00:05', 0),
(724, 16, 53, '2018-05-17 12:00:05', 0),
(725, 16, 54, '2018-05-17 12:00:05', 0),
(726, 16, 55, '2018-05-17 12:00:05', 0),
(727, 16, 56, '2018-05-17 12:00:05', 0),
(728, 16, 57, '2018-05-17 12:00:05', 0),
(729, 16, 58, '2018-05-17 12:00:05', 0),
(730, 16, 59, '2018-05-17 12:00:05', 0),
(731, 16, 60, '2018-05-17 12:00:05', 0),
(732, 16, 61, '2018-05-17 12:00:05', 0),
(733, 16, 62, '2018-05-17 12:00:05', 0),
(734, 16, 63, '2018-05-17 12:00:05', 0),
(735, 16, 64, '2018-05-17 12:00:05', 0),
(736, 16, 65, '2018-05-17 12:00:05', 0),
(737, 16, 66, '2018-05-17 12:00:05', 0),
(738, 16, 67, '2018-05-17 12:00:05', 0),
(739, 16, 68, '2018-05-17 12:00:05', 0),
(740, 16, 69, '2018-05-17 12:00:05', 0),
(741, 16, 70, '2018-05-17 12:00:05', 0),
(742, 16, 71, '2018-05-17 12:00:05', 0),
(743, 16, 72, '2018-05-17 12:00:05', 0),
(744, 16, 73, '2018-05-17 12:00:05', 0),
(745, 16, 74, '2018-05-17 12:00:05', 0),
(746, 16, 75, '2018-05-17 12:00:05', 0),
(747, 16, 76, '2018-05-17 12:00:05', 0),
(748, 16, 77, '2018-05-17 12:00:05', 0),
(749, 16, 78, '2018-05-17 12:00:05', 0),
(750, 16, 79, '2018-05-17 12:00:05', 0),
(751, 16, 80, '2018-05-17 12:00:05', 0),
(752, 16, 81, '2018-05-17 12:00:05', 0),
(753, 16, 82, '2018-05-17 12:00:05', 0),
(754, 16, 83, '2018-05-17 12:00:05', 0),
(755, 16, 84, '2018-05-17 12:00:05', 0),
(756, 16, 85, '2018-05-17 12:00:05', 0),
(757, 16, 86, '2018-05-17 12:00:05', 0),
(758, 16, 87, '2018-05-17 12:00:05', 0),
(759, 16, 88, '2018-05-17 12:00:05', 0),
(760, 16, 89, '2018-05-17 12:00:05', 0),
(761, 16, 90, '2018-05-17 12:00:05', 0),
(762, 16, 91, '2018-05-17 12:00:05', 0),
(763, 16, 92, '2018-05-17 12:00:05', 0),
(764, 16, 93, '2018-05-17 12:00:05', 0),
(765, 16, 94, '2018-05-17 12:00:05', 0),
(766, 16, 95, '2018-05-17 12:00:05', 0),
(767, 16, 96, '2018-05-17 12:00:05', 0),
(768, 16, 97, '2018-05-17 12:00:05', 0),
(769, 16, 98, '2018-05-17 12:00:05', 0),
(770, 16, 99, '2018-05-17 12:00:05', 0),
(771, 16, 100, '2018-05-17 12:00:05', 0),
(772, 16, 101, '2018-05-17 12:00:05', 0),
(773, 16, 102, '2018-05-17 12:00:05', 0),
(774, 16, 103, '2018-05-17 12:00:05', 0),
(775, 16, 104, '2018-05-17 12:00:05', 0),
(776, 16, 105, '2018-05-17 12:00:05', 0),
(777, 16, 106, '2018-05-17 12:00:05', 0),
(778, 16, 107, '2018-05-17 12:00:05', 0),
(779, 16, 108, '2018-05-17 12:00:05', 0),
(780, 16, 109, '2018-05-17 12:00:05', 0),
(781, 16, 110, '2018-05-17 12:00:05', 0),
(782, 16, 111, '2018-05-17 12:00:05', 0),
(783, 16, 112, '2018-05-17 12:00:05', 0),
(784, 16, 113, '2018-05-17 12:00:05', 0),
(785, 16, 114, '2018-05-17 12:00:05', 0),
(786, 16, 115, '2018-05-17 12:00:05', 0),
(787, 16, 116, '2018-05-17 12:00:05', 0),
(788, 16, 117, '2018-05-17 12:00:05', 0),
(789, 16, 118, '2018-05-17 12:00:05', 0),
(790, 16, 119, '2018-05-17 12:00:05', 0),
(791, 16, 120, '2018-05-17 12:00:05', 0),
(792, 16, 121, '2018-05-17 12:00:05', 0),
(793, 16, 122, '2018-05-17 12:00:05', 0),
(794, 16, 123, '2018-05-17 12:00:05', 0),
(795, 16, 124, '2018-05-17 12:00:05', 0),
(796, 16, 125, '2018-05-17 12:00:05', 0),
(797, 16, 126, '2018-05-17 12:00:05', 0),
(798, 16, 127, '2018-05-17 12:00:05', 0),
(799, 16, 128, '2018-05-17 12:00:05', 0),
(800, 16, 129, '2018-05-17 12:00:05', 0),
(801, 16, 130, '2018-05-17 12:00:05', 0),
(802, 16, 131, '2018-05-17 12:00:05', 0),
(803, 16, 132, '2018-05-17 12:00:05', 0),
(804, 16, 133, '2018-05-17 12:00:05', 0),
(805, 16, 134, '2018-05-17 12:00:05', 0),
(806, 16, 135, '2018-05-17 12:00:05', 0),
(807, 16, 136, '2018-05-17 12:00:05', 0),
(808, 16, 137, '2018-05-17 12:00:05', 0),
(809, 16, 138, '2018-05-17 12:00:05', 0),
(810, 16, 139, '2018-05-17 12:00:05', 0),
(811, 16, 140, '2018-05-17 12:00:05', 0),
(812, 16, 141, '2018-05-17 12:00:05', 0),
(813, 16, 142, '2018-05-17 12:00:05', 0),
(814, 16, 143, '2018-05-17 12:00:05', 0),
(815, 16, 144, '2018-05-17 12:00:05', 0),
(816, 16, 145, '2018-05-17 12:00:05', 0),
(817, 16, 146, '2018-05-17 12:00:05', 0),
(818, 16, 147, '2018-05-17 12:00:05', 0),
(819, 16, 148, '2018-05-17 12:00:05', 0),
(820, 16, 149, '2018-05-17 12:00:05', 0),
(821, 16, 150, '2018-05-17 12:00:05', 0),
(822, 16, 151, '2018-05-17 12:00:05', 0),
(823, 16, 152, '2018-05-17 12:00:05', 0),
(824, 16, 153, '2018-05-17 12:00:05', 0),
(825, 16, 154, '2018-05-17 12:00:05', 0),
(826, 16, 155, '2018-05-17 12:00:05', 0),
(827, 16, 156, '2018-05-17 12:00:05', 0),
(828, 16, 157, '2018-05-17 12:00:05', 0),
(829, 16, 158, '2018-05-17 12:00:05', 0),
(830, 16, 159, '2018-05-17 12:00:05', 0),
(831, 16, 160, '2018-05-17 12:00:05', 0),
(832, 16, 161, '2018-05-17 12:00:05', 0),
(833, 16, 162, '2018-05-17 12:00:05', 0),
(834, 16, 163, '2018-05-17 12:00:05', 0),
(835, 16, 164, '2018-05-17 12:00:05', 0),
(836, 16, 165, '2018-05-17 12:00:05', 0),
(837, 16, 166, '2018-05-17 12:00:05', 0),
(838, 16, 167, '2018-05-17 12:00:05', 0),
(839, 16, 168, '2018-05-17 12:00:05', 0),
(840, 16, 169, '2018-05-17 12:00:05', 0),
(841, 16, 170, '2018-05-17 12:00:05', 0),
(842, 16, 171, '2018-05-17 12:00:05', 0),
(843, 16, 172, '2018-05-17 12:00:05', 0),
(844, 16, 173, '2018-05-17 12:00:05', 0),
(845, 16, 174, '2018-05-17 12:00:05', 0),
(846, 16, 175, '2018-05-17 12:00:05', 0),
(847, 16, 176, '2018-05-17 12:00:05', 0),
(848, 16, 177, '2018-05-17 12:00:05', 0),
(849, 16, 178, '2018-05-17 12:00:05', 0),
(850, 16, 179, '2018-05-17 12:00:05', 0),
(851, 17, 1, '2018-05-17 12:00:05', 0),
(852, 17, 2, '2018-05-17 12:00:05', 0),
(853, 17, 3, '2018-05-17 12:00:05', 0),
(854, 17, 4, '2018-05-17 12:00:05', 0),
(855, 17, 5, '2018-05-17 12:00:05', 0),
(856, 17, 6, '2018-05-17 12:00:05', 0),
(857, 17, 7, '2018-05-17 12:00:05', 0),
(858, 17, 8, '2018-05-17 12:00:05', 0),
(859, 17, 9, '2018-05-17 12:00:05', 0),
(860, 17, 10, '2018-05-17 12:00:05', 0),
(861, 17, 11, '2018-05-17 12:00:05', 0),
(862, 17, 12, '2018-05-17 12:00:05', 0),
(863, 17, 13, '2018-05-17 12:00:05', 0),
(864, 17, 14, '2018-05-17 12:00:05', 0),
(865, 17, 15, '2018-05-17 12:00:05', 0),
(866, 17, 16, '2018-05-17 12:00:05', 0),
(867, 17, 17, '2018-05-17 12:00:05', 0),
(868, 17, 18, '2018-05-17 12:00:05', 0),
(869, 17, 19, '2018-05-17 12:00:05', 0),
(870, 17, 20, '2018-05-17 12:00:05', 0),
(871, 17, 21, '2018-05-17 12:00:05', 0),
(872, 17, 22, '2018-05-17 12:00:05', 0),
(873, 17, 23, '2018-05-17 12:00:05', 0),
(874, 17, 24, '2018-05-17 12:00:05', 0),
(875, 17, 25, '2018-05-17 12:00:05', 0),
(876, 17, 26, '2018-05-17 12:00:05', 0),
(877, 17, 27, '2018-05-17 12:00:05', 0),
(878, 17, 28, '2018-05-17 12:00:05', 0),
(879, 17, 29, '2018-05-17 12:00:05', 0),
(880, 17, 30, '2018-05-17 12:00:05', 0),
(881, 17, 31, '2018-05-17 12:00:05', 0),
(882, 17, 32, '2018-05-17 12:00:05', 0),
(883, 17, 33, '2018-05-17 12:00:05', 0),
(884, 17, 34, '2018-05-17 12:00:05', 0),
(885, 17, 35, '2018-05-17 12:00:05', 0),
(886, 17, 36, '2018-05-17 12:00:05', 0),
(887, 18, 1, '2018-05-17 12:00:05', 0),
(888, 18, 2, '2018-05-17 12:00:05', 0),
(889, 18, 3, '2018-05-17 12:00:05', 0),
(890, 18, 4, '2018-05-17 12:00:05', 0),
(891, 18, 5, '2018-05-17 12:00:05', 0),
(892, 18, 6, '2018-05-17 12:00:05', 0),
(893, 18, 7, '2018-05-17 12:00:05', 0),
(894, 18, 8, '2018-05-17 12:00:05', 0),
(895, 18, 9, '2018-05-17 12:00:05', 0),
(896, 18, 10, '2018-05-17 12:00:05', 0),
(897, 18, 11, '2018-05-17 12:00:05', 0),
(898, 18, 12, '2018-05-17 12:00:05', 0),
(899, 18, 13, '2018-05-17 12:00:05', 0),
(900, 18, 14, '2018-05-17 12:00:05', 0),
(901, 18, 15, '2018-05-17 12:00:05', 0),
(902, 18, 16, '2018-05-17 12:00:05', 0),
(903, 18, 17, '2018-05-17 12:00:05', 0),
(904, 18, 18, '2018-05-17 12:00:05', 0),
(905, 18, 19, '2018-05-17 12:00:05', 0),
(906, 18, 20, '2018-05-17 12:00:05', 0),
(907, 18, 21, '2018-05-17 12:00:05', 0),
(908, 18, 22, '2018-05-17 12:00:05', 0),
(909, 18, 23, '2018-05-17 12:00:05', 0),
(910, 18, 24, '2018-05-17 12:00:05', 0),
(911, 18, 25, '2018-05-17 12:00:05', 0),
(912, 18, 26, '2018-05-17 12:00:05', 0),
(913, 18, 27, '2018-05-17 12:00:05', 0),
(914, 18, 28, '2018-05-17 12:00:05', 0),
(915, 18, 29, '2018-05-17 12:00:05', 0),
(916, 18, 30, '2018-05-17 12:00:05', 0),
(917, 18, 31, '2018-05-17 12:00:05', 0),
(918, 18, 32, '2018-05-17 12:00:05', 0),
(919, 18, 33, '2018-05-17 12:00:05', 0),
(920, 18, 34, '2018-05-17 12:00:05', 0),
(921, 18, 35, '2018-05-17 12:00:05', 0),
(922, 18, 36, '2018-05-17 12:00:05', 0),
(923, 18, 37, '2018-05-17 12:00:05', 0),
(924, 18, 38, '2018-05-17 12:00:05', 0),
(925, 18, 39, '2018-05-17 12:00:05', 0),
(926, 18, 40, '2018-05-17 12:00:05', 0),
(927, 18, 41, '2018-05-17 12:00:05', 0),
(928, 18, 42, '2018-05-17 12:00:05', 0),
(929, 18, 43, '2018-05-17 12:00:05', 0),
(930, 18, 44, '2018-05-17 12:00:05', 0),
(931, 18, 45, '2018-05-17 12:00:05', 0);

-- --------------------------------------------------------

--
-- Table structure for table `plot_customers`
--

DROP TABLE IF EXISTS `plot_customers`;
CREATE TABLE IF NOT EXISTS `plot_customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientid` int(11) NOT NULL,
  `plotid` int(11) NOT NULL,
  `dateadded` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plot_customers`
--

INSERT INTO `plot_customers` (`id`, `clientid`, `plotid`, `dateadded`) VALUES
(1, 1, 1, '2018-05-17');

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
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `dateadded`, `productname`, `brandid`, `itemtypeid`) VALUES
(1, '2018-05-17 09:45:13', 'Solian 1 Plot', 2, 1),
(2, '2018-04-23 15:00:54', 'Solian 2 Plot', 1, 2),
(3, '2018-04-23 14:46:17', 'Solian 3 Plot', 1, 3),
(4, '2018-04-23 14:46:45', 'Solian 4 Apartments', 1, 4),
(5, '2018-04-23 06:41:48', 'Solian 5 Plot', 2, 5),
(6, '2018-04-23 06:42:11', 'Solian 6 Plot', 2, 6),
(7, '2018-04-23 06:43:19', 'Solian 7 Plot', 2, 7),
(8, '2018-04-23 15:01:10', 'Solian 8 Plot', 2, 8),
(9, '2018-04-23 06:44:19', 'Solian 9 House Bedsi', 1, 9),
(10, '2018-04-23 06:44:43', 'Solian 10 Plot', 1, 10),
(11, '2018-04-23 14:44:36', 'Solian 11 Offices', 2, 11),
(12, '2018-04-23 06:53:07', 'Solian 12 Plot', 2, 12),
(13, '2018-04-23 06:53:49', 'Solian 17 Plot', 2, 13),
(14, '2018-04-23 06:54:07', 'Solian 18 Plot', 2, 14),
(15, '2018-04-23 06:54:27', 'Solian 18 Apartment', 2, 14),
(16, '2018-04-23 06:54:50', 'Solian 19 Plot', 2, 15),
(17, '2018-04-23 14:45:51', 'Solian 21 Plot', 3, 16),
(18, '2018-04-23 06:55:39', 'Solian 23 Plot', 2, 17);

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
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productstock`
--

INSERT INTO `productstock` (`id`, `productid`, `totalstock`, `datemodified`) VALUES
(1, 5, 24, '2018-04-23 07:02:09'),
(2, 1, 58, '2018-05-17 13:45:55'),
(3, 2, 31, '2018-04-23 07:41:41'),
(4, 3, 57, '2018-04-23 07:42:57'),
(5, 6, 24, '2018-04-23 07:44:26'),
(6, 7, 24, '2018-04-23 07:49:57'),
(7, 8, 96, '2018-04-23 07:52:03'),
(8, 9, 20, '2018-04-23 07:57:42'),
(9, 10, 32, '2018-04-23 08:50:20'),
(10, 12, 164, '2018-04-23 15:06:13'),
(11, 13, 101, '2018-04-23 15:09:49'),
(12, 14, 48, '2018-04-23 15:32:47'),
(13, 16, 180, '2018-04-23 15:34:35'),
(14, 17, 37, '2018-04-23 15:36:24'),
(15, 18, 46, '2018-04-23 15:38:53');

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
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productstockmoves`
--

INSERT INTO `productstockmoves` (`id`, `productid`, `type`, `daterecorded`, `stockmove`) VALUES
(1, 5, 0, '2018-04-23 07:02:09', 24),
(2, 1, 0, '2018-04-23 07:40:13', 62),
(3, 2, 0, '2018-04-23 07:41:41', 31),
(4, 3, 0, '2018-04-23 07:42:57', 57),
(5, 6, 0, '2018-04-23 07:44:26', 24),
(6, 7, 0, '2018-04-23 07:49:57', 24),
(7, 8, 0, '2018-04-23 07:52:03', 96),
(8, 9, 0, '2018-04-23 07:57:42', 20),
(9, 10, 0, '2018-04-23 08:50:20', 32),
(10, 12, 0, '2018-04-23 15:06:13', 164),
(11, 13, 0, '2018-04-23 15:09:49', 101),
(12, 14, 0, '2018-04-23 15:32:47', 48),
(13, 16, 0, '2018-04-23 15:34:35', 180),
(14, 17, 0, '2018-04-23 15:36:24', 37),
(15, 18, 0, '2018-04-23 15:38:53', 46);

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
  `wire` varchar(200) DEFAULT NULL,
  `recordedby` varchar(25) NOT NULL,
  `dateadded` date NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `receipts`
--

INSERT INTO `receipts` (`id`, `invoiceid`, `amountdue`, `amountpaid`, `balance`, `paymentmethod`, `mpesa`, `cheque`, `bankledger`, `wire`, `recordedby`, `dateadded`, `datemodified`) VALUES
(1, 21, 1500000, 100000, 1400000, '1', 'Test', NULL, NULL, NULL, 'smbugua', '2018-05-03', '2018-05-04 08:40:59');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(11) NOT NULL,
  `main_name` varchar(200) NOT NULL,
  `main_location` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `main_tel` varchar(200) NOT NULL,
  `main_address` varchar(200) DEFAULT NULL,
  `website` varchar(200) NOT NULL,
  `dateadded` date NOT NULL,
  `datemodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `main_name`, `main_location`, `email`, `main_tel`, `main_address`, `website`, `dateadded`, `datemodified`) VALUES
(1, 'Solian Ltd', 'Solian Business Centre 1st Floor,\r\nLinks Road, Nyali', 'info@solian.co.ke', '+254700360579/ +254782360579', 'The Palm Breeze Building ', 'www.solian.co.ke', '2016-09-05', '2018-04-30 09:47:56');

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
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stockprice`
--

INSERT INTO `stockprice` (`id`, `productid`, `stockid`, `cost`, `price`, `dateadded`, `datemodified`) VALUES
(1, 5, 1, 1500000, 2750000, '2018-04-23', '2018-04-23 07:02:09'),
(2, 1, 2, 20100000, 1000000, '2011-03-01', '2018-04-23 07:40:13'),
(3, 2, 3, 25000000, 1450000, '2011-03-01', '2018-04-23 07:41:41'),
(4, 3, 4, 37000000, 1450000, '2012-01-01', '2018-04-23 07:42:57'),
(5, 6, 5, 25000000, 2750000, '2014-04-01', '2018-04-23 07:44:26'),
(6, 7, 6, 19000000, 2400000, '2015-07-01', '2018-04-23 07:49:57'),
(7, 8, 7, 14000000, 199000, '2015-04-01', '2018-04-23 07:52:03'),
(8, 9, 8, 93311500, 6500000, '2018-04-23', '2018-04-23 07:57:42'),
(9, 10, 9, 11200000, 1400000, '2014-07-01', '2018-04-23 08:50:20'),
(10, 12, 10, 120000000, 1970000, '2015-11-19', '2018-04-23 15:06:13'),
(11, 13, 11, 19500000, 750000, '2017-03-31', '2018-04-23 15:09:49'),
(12, 14, 12, 122000000, 4000000, '2017-03-14', '2018-04-23 15:32:47'),
(13, 16, 13, 5625000, 235000, '2017-07-20', '2018-04-23 15:34:35'),
(14, 17, 14, 23900000, 1700000, '2017-06-23', '2018-04-23 15:36:24'),
(15, 18, 15, 42000000, 2400000, '2017-12-11', '2018-04-23 15:38:53');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `fullname`, `email`, `password`, `account_type`, `datemodified`) VALUES
(1, 'smbugua', 'Simon Mbugua', 'smbugua11@gmail.com', '21232f297a57a5a743894a0e4a801fc3', 0, '2016-08-12 18:51:21'),
(2, 'BKosgei', 'Brian Kosgei', 'brian@solian.co.ke', '21232f297a57a5a743894a0e4a801fc3', 0, '2018-04-25 08:37:45');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
