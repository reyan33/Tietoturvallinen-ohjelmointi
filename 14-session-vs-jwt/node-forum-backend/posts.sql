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
-- Rakenne taululle `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `author` int(11) NOT NULL,
  `posted` date NOT NULL DEFAULT current_timestamp(),
  `signature` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vedos taulusta `posts`
--

INSERT INTO `posts` (`id`, `title`, `body`, `author`, `posted`, `signature`) VALUES
(1, 'Frist post', 'Olin eka lols modet haisee', 1, '2024-08-20', 'wX1uVwKInIHyRj/nZanzhj13+FFQn1sbv7aQqeYxSonojWHvvMn1/+ddJ89aLsgY0kE7W++XHOmJhLoT9tpWeBx/3W/lMAURk85KPEJkzKxbF8jvic5Rgwk852yq0Tnc1E3XuMjS81qAKe21SOTcenN3eN8przTNhmYU9b9HSUxVs3gug/ivILoYuXsAEcltDmpEMZsw+5y9NfEEccNSP/z0gbJn6xKh1tEurFPETx4Fxm3rgEz9sgsnhXJgRjpkP57shRXOlxf+jIawearmoBSNNxvShF4Ms6t2uHjcehFG6R6Wzz9rHGbNY4aY1+R0AOLChiBhGwyiNgs1q8b8rw=='),
(2, 'Mitä kuuluu', 'Moi seppo mikä pössis', 2, '2024-08-20', 'AmUF6WZNMkVPgvE6xxm3Yi/QCkelZ/EfhY5RtXzlXLAsX/kLVnfnSvfoMIdMGfvrQW8Fqmu4D4/iH5Y8brCU3NQD8/tZgWXpKZzvfCJvodOdIXZWbt7iK6/5ZByps1ZAWw8lsQ1wVrpuqYCBg3HElf7P8CPjxIfASgmRdt0BozdF9pimueiLXtFBa1YCdhluy8S4ZXFAbXkGLrYkAutgux2xoJUoolDrOhcJKuywdfXzRz/R+ZGxddTL0OcAom6GZwFsyz5BQFiPZ4Yn6Bx5+GnPEH2ZDWADbkck1Zu3QcD/KR98oRF7thDjq1N293YFiXNPjHmdjRm06/0w04BgEw=='),
(3, 'Ihan jees', 'Ihan jeespoks', 1, '2024-08-20', NULL),
(4, 'Sää', 'Ilmoja pidelly nimittäin', 1, '2024-08-20', 'qiIjfsx7R4ngRrQspLP6OI+iYCgndxSmMkJ758y2pKdIMw2/zVgQX/Xrw6JRSMpb3gwu43Y6RpQSFCaj9zoOK8621R6Wyg7mZikGsRfomB9MrRw6mw63PP7Gky5VYP5PRDxojHkdSVr8pjIbmKkLYqYrLQWEhre+FP6cKjSQmo863rId/pKPAunTj9xNspBDICnazybCLly7PfxW8RNbzpEIRqalFhALoVNchxZjMEqvBuzmUynCROKFq1Lk0dMumybY80RD/K1kag3BNRz1BG46BmDyKyhAt6gifAMEzUzsIIHR+8VNEZ7+W43GCx9n58hS6xiW7B9mCebJLzzLWQ=='),
(13, 'Matin posti', 'Mulla on asiaa nimittäin tässä', 3, '2024-09-03', NULL),
(14, 'Pomo', 'kumartakaa', 6, '2024-09-06', NULL),
(15, 'Matti testaa', 'Nyt testaa matti että toimiiko signeeraus vaiko eikö.', 3, '2024-09-14', 'muJYFH9cKZPfvHJcMQ+WzMQrvDRRIuA8dBH4YTmPsipEerwae5ZDV7ar0qb5J8V2Oo46w1N8nCpd851V3kE9iktacL+6nrxyVqY1kbsw9MwRdsEgvm/QKocxv9+bl85Z0MLV/arPg+G054yZQlHcmuaSQ8zfdQaG6d5rX6V5vddkSgcFrC2MRr/KHmKze3czBKAeqc1h/NCNUcmWaJJo0X7NCN9cVsb04C3na3cBJ3pfUrQkSjSGkEoPPM3EXFcPFrD/7YZ2RHLR4LJxX4kXPvo5cl3GnGcFUoMaE3e280u1sL9wKb6PlcumIyIv9zzvMPKX0/MebVjkjHs+lWjAbw=='),
(16, 'Matti testaa lisää', 'Nyt testataan jopa toisen kerran että toimiiko.', 3, '2024-09-14', 'JHzmAREWGwyKoJaL+5t3FFkraY2LmP34thRcATHyXDMktkHEmP9ovR6zCczb+fJulbn6QGS7yg5x9T5jGOFkWKMGaEtNYCFqXijUYd1KoAS5nudlea6zaOHcynPWBzVg3bst9UuszL7Al23pEkt+LeXi85RyTUInVHmQWrfmC5N40Qnz/XtLF2bLC3am6EPttizs3DjoTZIpcaeL5XdjegkzP6RsLoN41p/Cc8lp/ChdtaumM5wxhJ0S05BGFrMt0XlBFs6aWO361pxeYC8kaXCFfTuoaMggEzZ09YcKuWf474ARnGMBqmxxlf/4utSYbSWuv81IaFHZqlXdn2kzoA=='),
(17, 'Matin viimeinen testi', 'Nyt tulee sellainen testi että ei ole monet kuullu', 3, '2024-09-14', 'diipadaapa'),
(18, 'No vielä yksi', 'Entäs kokonaan ilman siggiä?', 3, '2024-09-14', ''),
(19, 'Heikin viesti', 'Moi heikki', 4, '2024-09-14', ''),
(20, 'Heikin siggi', 'Kokeillaan siggiä vaikka ei oo', 4, '2024-09-14', 'asdf'),
(21, 'Matti ja hyvä siggi', 'Tässä on viesti', 3, '2024-09-14', 'hrgV54fF8UDNK+QWygT0S0LloVyU25JUWIWsZTjUdkpMxKoiWiLwshyc+brUVGKd2znX7PE03cAImGrVyjXvEuH7GRHP9n2PyPqISUW8riN93RMwbIsTwXIs5fZgZ/R0PYQOc9mDtKJ1CcbuGqBsCjre5LavxiBpp8AHBcI1eV2iwZzm0/tnwzVHCr3s1pGPCf2O7DEs++vGQnXSMFpi2fDZO/VwmKUtejHcdh3eTah0k517mqfOjvA/ASNDoFDGMy0MxVyb/uwgulOZ2xtFZghv9t6CYtiBhqTh7h1UR7CAPn1b/RpQPGKbsc+jpo8Cic3+FYycxDqbTj37FtMFdA==');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `author` (`author`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Rajoitteet vedostauluille
--

--
-- Rajoitteet taululle `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`author`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
