-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 12, 2024 at 07:42 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `latihan5`
--

-- --------------------------------------------------------

--
-- Table structure for table `data_barang`
--

CREATE TABLE `data_barang` (
  `id` int(11) NOT NULL,
  `nama` varchar(60) NOT NULL,
  `kategori_id` int(11) NOT NULL,
  `harga_beli` int(11) NOT NULL,
  `harga_jual` int(11) NOT NULL,
  `stok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `data_barang`
--

INSERT INTO `data_barang` (`id`, `nama`, `kategori_id`, `harga_beli`, `harga_jual`, `stok`) VALUES
(1, 'Redmi', 2, 10000000, 15000000, 7),
(2, 'Mie Ayam', 4, 15000, 10000, 96),
(4, 'Alphard', 3, 100000000, 100000000, 2),
(5, 'Pecel Lele', 4, 20000, 25000, 92),
(8, 'Iphone 14 ', 2, 50000000, 45000000, 4);

-- --------------------------------------------------------

--
-- Table structure for table `detail_transaksi`
--

CREATE TABLE `detail_transaksi` (
  `id` int(11) NOT NULL,
  `transaksi_id` int(11) NOT NULL,
  `barang_id` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `diskon` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_transaksi`
--

INSERT INTO `detail_transaksi` (`id`, `transaksi_id`, `barang_id`, `jumlah`, `diskon`) VALUES
(1, 1, 1, 50, 0),
(2, 2, 1, 100, 0),
(3, 3, 2, 50, 0),
(4, 6, 1, 4, 0),
(5, 7, 1, 4, 0),
(6, 8, 5, 4, 0),
(7, 9, 1, 6, 0),
(9, 11, 1, 3, 0),
(10, 12, 1, 5, 0),
(11, 13, 1, 5, 0),
(12, 14, 2, 4, 0),
(14, 16, 5, 4, 0),
(15, 17, 4, 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id`, `nama`) VALUES
(1, 'Elektronik'),
(2, 'Handphone'),
(3, 'Kendaraan'),
(4, 'Makanan'),
(5, 'Minuman'),
(7, 'Buah Buahan');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id` int(11) NOT NULL,
  `tanggal` datetime NOT NULL,
  `customer` varchar(30) NOT NULL,
  `sub_total` decimal(10,2) NOT NULL,
  `diskon` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id`, `tanggal`, `customer`, `sub_total`, `diskon`, `total`) VALUES
(1, '2023-12-28 21:30:59', 'zenn', 750000.00, 20, 600000.00),
(2, '2024-01-12 12:43:22', 'zennmht', 1500000.00, 20, 1200000.00),
(3, '2024-01-22 12:54:30', 'zennmhtr', 50000.00, 0, 50000.00),
(4, '2024-01-22 12:54:30', 'zain', 50000.00, 0, 50000.00),
(6, '2024-01-12 03:08:33', 'Zaini M', 60000000.00, 20, 48000000.00),
(7, '2024-01-12 03:08:56', 'Zaini M', 60000000.00, 20, 48000000.00),
(8, '2024-01-12 03:12:38', 'zenn', 100000.00, 0, 100000.00),
(9, '2024-01-12 03:14:04', 'zaini', 90000000.00, 20, 72000000.00),
(10, '2024-01-12 03:16:21', 'Zaini Muhtarom', 2500000.00, 20, 2000000.00),
(11, '2024-01-12 03:19:00', 'Zaini', 45000000.00, 20, 36000000.00),
(12, '2024-01-12 03:22:44', 'Zaini Muhtarom', 75000000.00, 20, 60000000.00),
(13, '2024-01-12 03:27:29', 'Azka', 75000000.00, 20, 60000000.00),
(14, '2024-01-12 03:30:00', 'Ubaid', 40000.00, 0, 40000.00),
(15, '2024-01-12 03:35:37', 'Zaini', 99999999.99, 20, 99999999.99),
(16, '2024-01-12 13:07:00', 'Zaini Muhtarom', 100000.00, 0, 100000.00),
(17, '2024-01-12 13:21:15', 'Zaini Muhtarom', 99999999.99, 20, 99999999.99);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(250) NOT NULL,
  `nama` varchar(200) NOT NULL,
  `role` tinyint(1) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `nama`, `role`) VALUES
(1, 'zennmht', 'zenn', 'zain', 1),
(2, 'azka', 'hirzin', 'rafi', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_barang`
--
ALTER TABLE `data_barang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kategori_id` (`kategori_id`);

--
-- Indexes for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaksi_id` (`transaksi_id`),
  ADD KEY `barang_id` (`barang_id`) USING BTREE;

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data_barang`
--
ALTER TABLE `data_barang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `data_barang`
--
ALTER TABLE `data_barang`
  ADD CONSTRAINT `data_barang_ibfk_1` FOREIGN KEY (`kategori_id`) REFERENCES `kategori` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD CONSTRAINT `detail_transaksi_ibfk_1` FOREIGN KEY (`barang_id`) REFERENCES `data_barang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detail_transaksi_ibfk_2` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
