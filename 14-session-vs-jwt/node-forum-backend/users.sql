-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: 21.09.2024 klo 13:53
-- Palvelimen versio: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sql-inject`
--

-- --------------------------------------------------------

--
-- Rakenne taululle `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `realname` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(16) NOT NULL DEFAULT 'user',
  `publickey` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vedos taulusta `users`
--

INSERT INTO `users` (`id`, `username`, `realname`, `password`, `role`, `publickey`) VALUES
(1, 'seppo', 'Seppo Sikäläinen', '$2y$10$YEx6h/Ss199hm2MKfxXXdua9.7JDGJqa.Te4gto/TTTTVyGgZHUFK', 'user', '-----BEGIN PUBLIC KEY-----\r\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwsZfmgOlO9R0JMG5ctt5\r\nYNHvbut6ZJnoZxzdjTfX/2KiWsC+M3ZrCZQq9U8zvpogM6gg8LGx7a60MLZLrov0\r\nEm9SnhblgUfKqZ3IjvM9AZZrCKt5OkKJBs5nBeJUlAah7FCy0QPyQFIOcZf+kYzQ\r\ni4+Rkjb3osQK0ksb5ho6p/nw/f7TWEJNXNrtNjT82HEobZ5Fer9xAZtEfNkhAJia\r\nHGXOrQtGjfiS6cry/0joKHX3htNlqL4vZB4skULetYq1RUI2TOjWEx25MDv5ZyZN\r\nCPzJ7+eyk2pXOIjMVL6NaC2N6k9OVRiHTr7Q1z+lc0s2mCdDWZHcTjJJD+Wfc9rQ\r\nAwIDAQAB\r\n-----END PUBLIC KEY-----\r\n'),
(2, 'teppo', 'Teppo Teikäläinen', '$2y$10$7x3WA0eY/jEJ8KiGI5DdwOh2aB543YY.vhqj.str3Qnp3o7QR7Q5e', 'user', '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwsZfmgOlO9R0JMG5ctt5\nYNHvbut6ZJnoZxzdjTfX/2KiWsC+M3ZrCZQq9U8zvpogM6gg8LGx7a60MLZLrov0\nEm9SnhblgUfKqZ3IjvM9AZZrCKt5OkKJBs5nBeJUlAah7FCy0QPyQFIOcZf+kYzQ\ni4+Rkjb3osQK0ksb5ho6p/nw/f7TWEJNXNrtNjT82HEobZ5Fer9xAZtEfNkhAJia\nHGXOrQtGjfiS6cry/0joKHX3htNlqL4vZB4skULetYq1RUI2TOjWEx25MDv5ZyZN\nCPzJ7+eyk2pXOIjMVL6NaC2N6k9OVRiHTr7Q1z+lc0s2mCdDWZHcTjJJD+Wfc9rQ\nAwIDAQAB\n-----END PUBLIC KEY-----\n'),
(3, 'matti', 'Matti Meikäläinen', '$2y$10$g3spj.5CFKjEN0Hvjs3FfuaE.dQ5qrLy/A6g1QGPUq0Q8d4Sw.I7a', 'user', '-----BEGIN PUBLIC KEY-----\r\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7kRfYr0O+b2n7cfVkwr3\r\n2jSNlgmFzGQkDmeNRAYGOsf9cGUMDGE0TKObBWd6tQiSR3HEYaYsQJLBFJigIrL4\r\nLQX55TixkkMyALnM3oU4rYRZHuss1bdyd+dOipVNMcXEfK/Xsn2yGJ6zCbhLrCC/\r\nfnsqctrFfCd13f2XQnErBrIWfU5We/tZXFAUXmDancnjMkNda5i9IDPnrCSO53Bv\r\nevvhGsaZCn9+WhxvsaYey7b0nUu7Pd/HuMJRfJbWa7cLVOu+Jqudatn03HUA7A0i\r\nhmeAxrZ77RKcO14f0qVrvR4/7sx0ri2QfxdGpXLseO5LbfR5d5uKfMQSeiIXYjb3\r\nowIDAQAB\r\n-----END PUBLIC KEY-----\r\n'),
(4, 'heikki', 'Heikki Heikinheimo', '$2y$10$wIKJuvb6d7NQMZxMp94T3OD.sHAkBAP87rB/fIcSp2CnFPq1fxmgS', 'user', NULL),
(5, 'mehdi', 'Mehdi Moderaattori', '$2y$10$kVacsEUZ7FgbmQddIpyVF.gQrtrCDhMDZ1Ws.gpWRda3IeVXn6IAy', 'moderator', NULL),
(6, 'admin', 'Admin Padmin', '$2y$10$g.E3ZCYUUbMA70pn9mxo4eOCSkfrBQlmA4C/6GGDt7IEKKsGfpZei', 'admin', NULL),
(9, 'mari', 'Mari Mode', '$2y$10$klnSr8W09xdzSPTcuhmHwOBfo4IhaQ33k9BfbtMt6wdrD62oXZYo2', 'moderator', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
