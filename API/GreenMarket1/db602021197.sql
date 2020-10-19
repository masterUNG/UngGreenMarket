-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 18, 2020 at 04:20 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db602021197`
--

-- --------------------------------------------------------

--
-- Table structure for table `orderTABLE`
--

CREATE TABLE `orderTABLE` (
  `id` int(11) NOT NULL,
  `OrderDateTime` text COLLATE utf8_unicode_ci NOT NULL,
  `idUser` text COLLATE utf8_unicode_ci NOT NULL,
  `NameUser` text COLLATE utf8_unicode_ci NOT NULL,
  `idShop` text COLLATE utf8_unicode_ci NOT NULL,
  `NameShop` text COLLATE utf8_unicode_ci NOT NULL,
  `idProduct` text COLLATE utf8_unicode_ci NOT NULL,
  `NameProduct` text COLLATE utf8_unicode_ci NOT NULL,
  `Price` text COLLATE utf8_unicode_ci NOT NULL,
  `Amount` text COLLATE utf8_unicode_ci NOT NULL,
  `Sum` text COLLATE utf8_unicode_ci NOT NULL,
  `Status` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orderTABLE`
--

INSERT INTO `orderTABLE` (`id`, `OrderDateTime`, `idUser`, `NameUser`, `idShop`, `NameShop`, `idProduct`, `NameProduct`, `Price`, `Amount`, `Sum`, `Status`) VALUES
(6, '54', '46', 'Master', '54', 'ร้าน มาสเตอร์ 1234', '[4, 5, 6, 5]', '[Product111, Water, Logitech, Water]', '[120, 400, 1000, 400]', '[1, 2, 1, 100]', '[120, 800, 1000, 40000]', 'Order'),
(7, '55', '48', 'test1', '55', 'TestShop Ung', '[7]', '[Monitor]', '[1200]', '[105]', '[126000]', 'Order'),
(8, '55', '46', 'Master', '55', 'TestShop Ung', '[7]', '[Monitor]', '[1200]', '[100]', '[120000]', 'Order');

-- --------------------------------------------------------

--
-- Table structure for table `productTABLE`
--

CREATE TABLE `productTABLE` (
  `id` int(11) NOT NULL,
  `idShop` text COLLATE utf8_unicode_ci NOT NULL,
  `NameProduct` text COLLATE utf8_unicode_ci NOT NULL,
  `PathImage` text COLLATE utf8_unicode_ci NOT NULL,
  `Price` text COLLATE utf8_unicode_ci NOT NULL,
  `Detail` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `productTABLE`
--

INSERT INTO `productTABLE` (`id`, `idShop`, `NameProduct`, `PathImage`, `Price`, `Detail`) VALUES
(4, '54', 'Product111', '/GreenMarket1/Product/product654994.jpg', '120', 'edfff tff ggffg Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
(5, '54', 'Water', '/GreenMarket1/Product/product212824.jpg', '400', 'rfff ggggg gggg'),
(6, '54', 'Logitech', '/GreenMarket1/Product/product280239.jpg', '1000', 'fggr gfg ggv'),
(7, '55', 'Monitor', '/GreenMarket1/Product/product813022.jpg', '1200', 'ererrer'),
(8, '58', 'Phone', '/GreenMarket1/Product/product754006.jpg', '1250', 'eeff fggg'),
(9, '58', 'ยา', '/GreenMarket1/Product/product88542.jpg', '500', 'errrr');

-- --------------------------------------------------------

--
-- Table structure for table `usertabie`
--

CREATE TABLE `usertabie` (
  `id` int(5) NOT NULL,
  `chooseType` text COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `houseno` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `villageNo` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `subdistrict` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `district` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `province` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `postalcode` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `tel` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `name1` text COLLATE utf8_unicode_ci NOT NULL,
  `storename` text COLLATE utf8_unicode_ci NOT NULL,
  `address` text COLLATE utf8_unicode_ci NOT NULL,
  `phone` text COLLATE utf8_unicode_ci NOT NULL,
  `urlImage` text COLLATE utf8_unicode_ci NOT NULL,
  `Token` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `usertabie`
--

INSERT INTO `usertabie` (`id`, `chooseType`, `name`, `surname`, `username`, `password`, `houseno`, `villageNo`, `subdistrict`, `district`, `province`, `postalcode`, `tel`, `name1`, `storename`, `address`, `phone`, `urlImage`, `Token`) VALUES
(42, 'dealer', 'fatihah', 'matmingsee', 'shop', '1234567', '106', '3', 'kholoh', 'waeng', 'naratiwat', '96160', '0928126763', 'ฟาตีหะ มะมิงซี', '', '106 ม.3 ต.ฆอเลาะ', '0928126763', '', ''),
(46, 'buyer', 'Master', 'Ung', 'masteruser', '123456', '123', '12', 'Bangna', 'Bangna', 'Bkk', '10260', '0818595309', '', '', '', '', '', ''),
(48, 'buyer', 'test1', 'aa', 'test1', '123456', 'fff', '85', 'hgg', 'ggg', 'ggg', '10260', '14455', '', '', '', '', '', ''),
(49, 'buyer', 'test2', 'rrr', 'test2', '123456', 'fff', '556', 'ggt', 'fgg', 'ggg', '966', '556', '', '', '', '', '', ''),
(50, 'buyer', 'test2', 'rrr', 'test2', '123456', 'fff', '556', 'ggt', 'fgg', 'ggg', '966', '556', '', '', '', '', '', ''),
(51, 'dealer', 'shop1', 'fff', 'shop1', '123456', '122', '222', 'dff', 'fff', 'fffg', '12457', '45554', '', '', '', '', '', ''),
(52, 'dealer', 'shop1', 'fff', 'shop1', '123456', '122', '222', 'dff', 'fff', 'fffg', '12457', '45554', '', '', '', '', '', ''),
(53, 'buyer', 'fgg', 'fgg', 'ffg', 'fggg', '344', '222', 'tgg', 'ggh', 'fgg', '1255', '5555', '', '', '', '', '', ''),
(54, 'dealer', ' มาสเตอร์', 'อึ่ง', 'ungshop', '123456', '111', '11', 'eee', 'eee', 'eee', '10260', '222', 'ร้าน มาสเตอร์ 1234', 'ร้าน มาสเตอร์ 1234', '1234 vvvv', '0818595309', '/GreenMarket1/shop/editShop3777.jpg', ''),
(55, 'dealer', 'Test11', 'sss', 'test11', '123456', '111', '11', 'eee', 'eee', 'eee', '10260', '222', 'TestShop Ung', 'TestShop Ung', '123', '123456', '/GreenMarket1/shop/shop232986.jpg', ''),
(56, 'buyer', 'test22', 'qq', 'test22', '123456', '111', '222', 'www', 'www', 'www', '10260', '222', '', '', '', '', '', ''),
(57, 'dealer', 'dausshop', 'ghjjuu', 'daus1', '123456', '5', '2', 'dd', 'dd', 'dd', '94110', '0123456789', '', '', '', '', '', ''),
(58, 'dealer', 'Dormon', 'aaaa', 'dorashop', '123456', '123', '123', 'eee', 'eee', 'BKK', '10260', '1234', 'Doramon', 'Doramon', '123', '12345678', '/GreenMarket1/shop/shop471436.jpg', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orderTABLE`
--
ALTER TABLE `orderTABLE`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `productTABLE`
--
ALTER TABLE `productTABLE`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usertabie`
--
ALTER TABLE `usertabie`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orderTABLE`
--
ALTER TABLE `orderTABLE`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `productTABLE`
--
ALTER TABLE `productTABLE`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `usertabie`
--
ALTER TABLE `usertabie`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
