-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 10, 2018 at 11:11 AM
-- Server version: 5.7.21
-- PHP Version: 5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webtech`
--
CREATE DATABASE IF NOT EXISTS `webtech` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `webtech`;

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

DROP TABLE IF EXISTS `request`;
CREATE TABLE IF NOT EXISTS `request` (
  `requestID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(111) NOT NULL,
  `vehicleID` int(11) NOT NULL,
  `requestType` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `rentStartdate` date DEFAULT NULL,
  `rentEnddate` date DEFAULT NULL,
  PRIMARY KEY (`requestID`),
  KEY `vehicle_Id` (`vehicleID`) USING BTREE,
  KEY `user_Id` (`userID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `request`
--

INSERT INTO `request` (`requestID`, `userID`, `vehicleID`, `requestType`, `status`, `rentStartdate`, `rentEnddate`) VALUES
(3, 3, 3, 'rent', 'approved', '0000-00-00', '0000-00-00'),
(4, 4, 2, 'rent', 'approved', '0000-00-00', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE IF NOT EXISTS `transaction` (
  `trans_Id` int(11) NOT NULL AUTO_INCREMENT,
  `requestID` int(11) NOT NULL,
  `amount` int(50) NOT NULL,
  `paymentMode` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`trans_Id`),
  KEY `request_Id` (`requestID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_Id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `contact_No` int(50) NOT NULL,
  `acctype` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`user_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_Id`, `firstname`, `lastname`, `address`, `contact_No`, `acctype`, `username`, `password`, `status`) VALUES
(0, 'Raoul', 'Madayag', 'Baguio ', 123213, 'Admin', 'admin', 'admin', 'activated'),
(1, 'Allen', 'Batac', 'Baguio', 432345234, 'Service Provider', 'sp', 'sp', 'activated'),
(2, 'Iris', 'Quiming', 'Pangasinan', 9864455, 'Client', 'client', 'client', 'activated');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
CREATE TABLE IF NOT EXISTS `vehicle` (
  `vehicleID` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `year` varchar(50) NOT NULL,
  `capacity` varchar(50) NOT NULL,
  `rent_Price` varchar(50) NOT NULL,
  `carType` varchar(50) NOT NULL,
  `color` varchar(50) NOT NULL,
  `licensePlate` varchar(50) NOT NULL,
  `currentMileage` varchar(50) NOT NULL,
  `vehicleStatus` varchar(45) NOT NULL DEFAULT 'undefined',
  `photo` varchar(250) DEFAULT NULL,
  `spID` int(11) NOT NULL,
  PRIMARY KEY (`vehicleID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`vehicleID`, `brand`, `model`, `year`, `capacity`, `rent_Price`, `carType`, `color`, `licensePlate`, `currentMileage`, `vehicleStatus`, `photo`, `spID`) VALUES
(2, 'Honda', 'Accord', '2018', '5', '1500', 'sedan', 'black', 'UWH-526', '14466', 'available', '', 1),
(3, 'Toyota', 'Fortuner', '2018', '7', '3000', 'suv', 'white', 'XGT-547', '17890', 'available', '', 1),
(4, 'Isuzu', 'Crosswind', '2018', '7', '6000', 'auv', 'gray', 'ZAC-594', '9230', 'available', '', 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `t_requestID` FOREIGN KEY (`requestID`) REFERENCES `request` (`requestID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
