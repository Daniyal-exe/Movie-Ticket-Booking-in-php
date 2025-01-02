-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: Jan 02, 2025 at 04:05 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `movie_ticket_booking`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `password`) VALUES
(1, 'Admin', 'admin@gmail.com', 'admin123');

-- --------------------------------------------------------

--
-- Table structure for table `cinemas`
--

CREATE TABLE `cinemas` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `city` text DEFAULT NULL,
  `address` text DEFAULT NULL,
  `seats` int(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cinemas`
--

INSERT INTO `cinemas` (`id`, `name`, `city`, `address`, `seats`) VALUES
(1, 'Nueplex Cinema', 'Karachi', 'Khayaban-e-Shaheen, Phase VIII, DHA', 50),
(2, 'Atrium Cinemas', 'Karachi', '249 Staff Lanes, ZaibunNissa Street, Saddar', 50),
(3, 'The Arena', 'Karachi', '8th and 9th Floor, Bahria Town Tower, Tariq Road', 50);

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

CREATE TABLE `movies` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `image` varchar(255) NOT NULL,
  `genre` text NOT NULL,
  `imdb_ratings` float NOT NULL DEFAULT 0,
  `is_upcoming` tinyint(1) NOT NULL DEFAULT 0,
  `release_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`id`, `name`, `image`, `genre`, `imdb_ratings`, `is_upcoming`, `release_date`) VALUES
(1, 'Mission: Impossible - The Final Reckoning', 'Mission_Impossible1735729176.jpg', 'Action, Spy Thriller', 1, 1, '2025-05-23'),
(2, 'Paddington in Peru', 'Paddington1735729253.jpg', 'Adventure, Comedy, Family', 1, 1, '2025-05-09'),
(3, 'Superman', 'Superman1735729512.jpg', 'Superhero, Action, Adventure', 1, 1, '2025-07-11'),
(4, 'Avatar: Fire and Ash', 'Avatar1735729563.jpg', 'Science Fiction, Action, Adventure, Epic', 1, 1, '2025-12-19'),
(5, '28 Years Later', '28_Years_Later1735730326.jpg', 'Horror, Apocalypse, Action', 1, 1, '2025-06-20'),
(6, 'Jurassic World Rebirth', 'Jurassic_Park1735729684.jpg', 'Science Fiction, Action', 1, 1, '2025-07-02'),
(7, 'The Wild Robot', 'The_Wild_Robot1735731047.jpg', 'Animation, Family', 8.2, 0, '2024-06-20'),
(8, 'Gladiator II', 'Gladiator_21735731285.jpg', 'Action, Drama', 6.7, 0, '2024-11-22'),
(9, 'Smile 2', 'Smile_21735731356.jpg', 'Horror, Mystery, Thriller', 6.8, 0, '2024-10-18'),
(10, 'Drive', 'Drive1735731422.jpg', 'Action, Drama', 7.8, 0, '2011-09-16'),
(11, '***** ****', 'Fight_Club1735731509.jpg', 'Drama, Thriller', 8.8, 0, '1999-10-15'),
(12, 'Interstellar', 'Interstellar1735731616.jpg', 'Sci-Fi, Adventure, Drama', 8.6, 0, '2014-11-07'),
(13, 'Mission: Impossible – Dead Reckoning Part One', 'Mission_Impossible_Dead1735732958.jpg', 'Action, Adventure, Thriller', 7.7, 0, '2023-07-12'),
(14, 'Your Name', 'Your_Name1735733013.jpg', 'Animation, Drama, Fantasy', 8.4, 0, '2016-08-26'),
(15, 'Harry Potter and the Chamber of Secrets', 'Harry_Potter1735733104.jpg', 'Adventure, Family, Fantasy', 7.4, 0, '2002-11-15'),
(16, 'The Lord of the Rings: The Fellowship of the Ring', 'Lord_of_the_Rings1735733198.jpg', 'Adventure, Drama, Fantasy', 8.8, 0, '2001-12-19'),
(17, 'The Boy and the Heron', 'The_Boy1735733326.jpg', 'Animation, Fantasy', 8, 0, '2023-11-22'),
(18, 'Oppenheimer ', 'Oppenheimer1735733372.jpg', 'Biography, Drama, History', 8.9, 0, '2023-07-21');

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `cinema_id` int(11) NOT NULL,
  `play_slot` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `payment_status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `cinema_id` int(11) NOT NULL,
  `play_date` date NOT NULL,
  `play_slot1` time NOT NULL,
  `play_slot2` time NOT NULL,
  `play_slot3` time NOT NULL,
  `price_per_seat` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `schedules`
--

INSERT INTO `schedules` (`id`, `movie_id`, `cinema_id`, `play_date`, `play_slot1`, `play_slot2`, `play_slot3`, `price_per_seat`) VALUES
(1, 18, 3, '2025-01-13', '12:00:00', '16:00:00', '20:30:00', 600),
(2, 18, 1, '2025-01-13', '12:00:00', '16:00:00', '20:30:00', 600),
(3, 18, 2, '2025-01-13', '12:00:00', '16:00:00', '20:30:00', 600),
(4, 14, 1, '2025-01-20', '14:00:00', '18:00:00', '23:00:00', 600),
(5, 12, 1, '2025-01-21', '12:00:00', '16:00:00', '21:00:00', 800),
(6, 12, 2, '2025-01-21', '12:00:00', '16:00:00', '21:00:00', 800),
(7, 12, 3, '2025-01-22', '12:00:00', '16:00:00', '21:00:00', 800),
(8, 11, 1, '2025-01-25', '18:00:00', '21:00:00', '00:00:00', 600),
(9, 13, 2, '2025-01-15', '11:00:00', '14:00:00', '18:00:00', 600),
(10, 8, 3, '2025-01-27', '12:00:00', '15:00:00', '18:00:00', 600);

-- --------------------------------------------------------

--
-- Table structure for table `seats`
--

CREATE TABLE `seats` (
  `id` int(11) NOT NULL,
  `row` char(1) NOT NULL,
  `number` int(11) NOT NULL,
  `cinema_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `seats`
--

INSERT INTO `seats` (`id`, `row`, `number`, `cinema_id`) VALUES
(1, 'A', 1, 10),
(2, 'A', 2, 10),
(3, 'A', 3, 10),
(4, 'A', 4, 10),
(5, 'A', 5, 10),
(6, 'A', 6, 10),
(7, 'A', 7, 10),
(8, 'A', 8, 10),
(9, 'A', 9, 10),
(10, 'A', 10, 10),
(11, 'B', 1, 10),
(12, 'B', 2, 10),
(13, 'B', 3, 10),
(14, 'B', 4, 10),
(15, 'B', 5, 10),
(16, 'B', 6, 10),
(17, 'B', 7, 10),
(18, 'B', 8, 10),
(19, 'B', 9, 10),
(20, 'B', 10, 10),
(21, 'C', 1, 10),
(22, 'C', 2, 10),
(23, 'C', 3, 10),
(24, 'C', 4, 10),
(25, 'C', 5, 10),
(26, 'C', 6, 10),
(27, 'C', 7, 10),
(28, 'C', 8, 10),
(29, 'C', 9, 10),
(30, 'C', 10, 10),
(31, 'D', 1, 10),
(32, 'D', 2, 10),
(33, 'D', 3, 10),
(34, 'D', 4, 10),
(35, 'D', 5, 10),
(36, 'D', 6, 10),
(37, 'D', 7, 10),
(38, 'D', 8, 10),
(39, 'D', 9, 10),
(40, 'D', 10, 10),
(41, 'E', 1, 10),
(42, 'E', 2, 10),
(43, 'E', 3, 10),
(44, 'E', 4, 10),
(45, 'E', 5, 10),
(46, 'E', 6, 10),
(47, 'E', 7, 10),
(48, 'E', 8, 10),
(49, 'E', 9, 10),
(50, 'E', 10, 10),
(51, 'F', 1, 10),
(52, 'F', 2, 10),
(53, 'F', 3, 10),
(54, 'F', 4, 10),
(55, 'F', 5, 10),
(56, 'F', 6, 10),
(57, 'F', 7, 10),
(58, 'F', 8, 10),
(59, 'F', 9, 10),
(60, 'F', 10, 10),
(61, 'G', 1, 10),
(62, 'G', 2, 10),
(63, 'G', 3, 10),
(64, 'G', 4, 10),
(65, 'G', 5, 10),
(66, 'G', 6, 10),
(67, 'G', 7, 10),
(68, 'G', 8, 10),
(69, 'G', 9, 10),
(70, 'G', 10, 10),
(71, 'H', 1, 10),
(72, 'H', 2, 10),
(73, 'H', 3, 10),
(74, 'H', 4, 10),
(75, 'H', 5, 10),
(76, 'H', 6, 10),
(77, 'H', 7, 10),
(78, 'H', 8, 10),
(79, 'H', 9, 10),
(80, 'H', 10, 10),
(81, 'A', 1, 11),
(82, 'A', 2, 11),
(83, 'A', 3, 11),
(84, 'A', 4, 11),
(85, 'A', 5, 11),
(86, 'A', 6, 11),
(87, 'A', 7, 11),
(88, 'A', 8, 11),
(89, 'A', 9, 11),
(90, 'A', 10, 11),
(91, 'B', 1, 11),
(92, 'B', 2, 11),
(93, 'B', 3, 11),
(94, 'B', 4, 11),
(95, 'B', 5, 11),
(96, 'B', 6, 11),
(97, 'B', 7, 11),
(98, 'B', 8, 11),
(99, 'B', 9, 11),
(100, 'B', 10, 11),
(101, 'C', 1, 11),
(102, 'C', 2, 11),
(103, 'C', 3, 11),
(104, 'C', 4, 11),
(105, 'C', 5, 11),
(106, 'C', 6, 11),
(107, 'C', 7, 11),
(108, 'C', 8, 11),
(109, 'C', 9, 11),
(110, 'C', 10, 11),
(111, 'D', 1, 11),
(112, 'D', 2, 11),
(113, 'D', 3, 11),
(114, 'D', 4, 11),
(115, 'D', 5, 11),
(116, 'D', 6, 11),
(117, 'D', 7, 11),
(118, 'D', 8, 11),
(119, 'D', 9, 11),
(120, 'D', 10, 11),
(121, 'E', 1, 11),
(122, 'E', 2, 11),
(123, 'E', 3, 11),
(124, 'E', 4, 11),
(125, 'E', 5, 11),
(126, 'E', 6, 11),
(127, 'E', 7, 11),
(128, 'E', 8, 11),
(129, 'E', 9, 11),
(130, 'E', 10, 11),
(131, 'F', 1, 11),
(132, 'F', 2, 11),
(133, 'F', 3, 11),
(134, 'F', 4, 11),
(135, 'F', 5, 11),
(136, 'F', 6, 11),
(137, 'F', 7, 11),
(138, 'F', 8, 11),
(139, 'F', 9, 11),
(140, 'F', 10, 11),
(141, 'G', 1, 11),
(142, 'G', 2, 11),
(143, 'G', 3, 11),
(144, 'G', 4, 11),
(145, 'G', 5, 11),
(146, 'G', 6, 11),
(147, 'G', 7, 11),
(148, 'G', 8, 11),
(149, 'G', 9, 11),
(150, 'G', 10, 11),
(151, 'A', 1, 12),
(152, 'A', 2, 12),
(153, 'A', 3, 12),
(154, 'A', 4, 12),
(155, 'A', 5, 12),
(156, 'A', 6, 12),
(157, 'A', 7, 12),
(158, 'A', 8, 12),
(159, 'A', 9, 12),
(160, 'A', 10, 12),
(161, 'B', 1, 12),
(162, 'B', 2, 12),
(163, 'B', 3, 12),
(164, 'B', 4, 12),
(165, 'B', 5, 12),
(166, 'B', 6, 12),
(167, 'B', 7, 12),
(168, 'B', 8, 12),
(169, 'B', 9, 12),
(170, 'B', 10, 12),
(171, 'C', 1, 12),
(172, 'C', 2, 12),
(173, 'C', 3, 12),
(174, 'C', 4, 12),
(175, 'C', 5, 12),
(176, 'C', 6, 12),
(177, 'C', 7, 12),
(178, 'C', 8, 12),
(179, 'C', 9, 12),
(180, 'C', 10, 12),
(181, 'D', 1, 12),
(182, 'D', 2, 12),
(183, 'D', 3, 12),
(184, 'D', 4, 12),
(185, 'D', 5, 12),
(186, 'D', 6, 12),
(187, 'D', 7, 12),
(188, 'D', 8, 12),
(189, 'D', 9, 12),
(190, 'D', 10, 12),
(191, 'A', 1, 1),
(192, 'A', 2, 1),
(193, 'A', 3, 1),
(194, 'A', 4, 1),
(195, 'A', 5, 1),
(196, 'A', 6, 1),
(197, 'A', 7, 1),
(198, 'A', 8, 1),
(199, 'A', 9, 1),
(200, 'A', 10, 1),
(201, 'B', 1, 1),
(202, 'B', 2, 1),
(203, 'B', 3, 1),
(204, 'B', 4, 1),
(205, 'B', 5, 1),
(206, 'B', 6, 1),
(207, 'B', 7, 1),
(208, 'B', 8, 1),
(209, 'B', 9, 1),
(210, 'B', 10, 1),
(211, 'C', 1, 1),
(212, 'C', 2, 1),
(213, 'C', 3, 1),
(214, 'C', 4, 1),
(215, 'C', 5, 1),
(216, 'C', 6, 1),
(217, 'C', 7, 1),
(218, 'C', 8, 1),
(219, 'C', 9, 1),
(220, 'C', 10, 1),
(221, 'D', 1, 1),
(222, 'D', 2, 1),
(223, 'D', 3, 1),
(224, 'D', 4, 1),
(225, 'D', 5, 1),
(226, 'D', 6, 1),
(227, 'D', 7, 1),
(228, 'D', 8, 1),
(229, 'D', 9, 1),
(230, 'D', 10, 1),
(231, 'E', 1, 1),
(232, 'E', 2, 1),
(233, 'E', 3, 1),
(234, 'E', 4, 1),
(235, 'E', 5, 1),
(236, 'E', 6, 1),
(237, 'E', 7, 1),
(238, 'E', 8, 1),
(239, 'E', 9, 1),
(240, 'E', 10, 1),
(241, 'A', 1, 2),
(242, 'A', 2, 2),
(243, 'A', 3, 2),
(244, 'A', 4, 2),
(245, 'A', 5, 2),
(246, 'A', 6, 2),
(247, 'A', 7, 2),
(248, 'A', 8, 2),
(249, 'A', 9, 2),
(250, 'A', 10, 2),
(251, 'B', 1, 2),
(252, 'B', 2, 2),
(253, 'B', 3, 2),
(254, 'B', 4, 2),
(255, 'B', 5, 2),
(256, 'B', 6, 2),
(257, 'B', 7, 2),
(258, 'B', 8, 2),
(259, 'B', 9, 2),
(260, 'B', 10, 2),
(261, 'C', 1, 2),
(262, 'C', 2, 2),
(263, 'C', 3, 2),
(264, 'C', 4, 2),
(265, 'C', 5, 2),
(266, 'C', 6, 2),
(267, 'C', 7, 2),
(268, 'C', 8, 2),
(269, 'C', 9, 2),
(270, 'C', 10, 2),
(271, 'D', 1, 2),
(272, 'D', 2, 2),
(273, 'D', 3, 2),
(274, 'D', 4, 2),
(275, 'D', 5, 2),
(276, 'D', 6, 2),
(277, 'D', 7, 2),
(278, 'D', 8, 2),
(279, 'D', 9, 2),
(280, 'D', 10, 2),
(281, 'E', 1, 2),
(282, 'E', 2, 2),
(283, 'E', 3, 2),
(284, 'E', 4, 2),
(285, 'E', 5, 2),
(286, 'E', 6, 2),
(287, 'E', 7, 2),
(288, 'E', 8, 2),
(289, 'E', 9, 2),
(290, 'E', 10, 2),
(291, 'A', 1, 3),
(292, 'A', 2, 3),
(293, 'A', 3, 3),
(294, 'A', 4, 3),
(295, 'A', 5, 3),
(296, 'A', 6, 3),
(297, 'A', 7, 3),
(298, 'A', 8, 3),
(299, 'A', 9, 3),
(300, 'A', 10, 3),
(301, 'B', 1, 3),
(302, 'B', 2, 3),
(303, 'B', 3, 3),
(304, 'B', 4, 3),
(305, 'B', 5, 3),
(306, 'B', 6, 3),
(307, 'B', 7, 3),
(308, 'B', 8, 3),
(309, 'B', 9, 3),
(310, 'B', 10, 3),
(311, 'C', 1, 3),
(312, 'C', 2, 3),
(313, 'C', 3, 3),
(314, 'C', 4, 3),
(315, 'C', 5, 3),
(316, 'C', 6, 3),
(317, 'C', 7, 3),
(318, 'C', 8, 3),
(319, 'C', 9, 3),
(320, 'C', 10, 3),
(321, 'D', 1, 3),
(322, 'D', 2, 3),
(323, 'D', 3, 3),
(324, 'D', 4, 3),
(325, 'D', 5, 3),
(326, 'D', 6, 3),
(327, 'D', 7, 3),
(328, 'D', 8, 3),
(329, 'D', 9, 3),
(330, 'D', 10, 3),
(331, 'E', 1, 3),
(332, 'E', 2, 3),
(333, 'E', 3, 3),
(334, 'E', 4, 3),
(335, 'E', 5, 3),
(336, 'E', 6, 3),
(337, 'E', 7, 3),
(338, 'E', 8, 3),
(339, 'E', 9, 3),
(340, 'E', 10, 3);

-- --------------------------------------------------------

--
-- Table structure for table `seats_reserved`
--

CREATE TABLE `seats_reserved` (
  `id` int(11) NOT NULL,
  `reservation_id` int(11) NOT NULL,
  `seat_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(255) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` text DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_approved` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cinemas`
--
ALTER TABLE `cinemas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cinema_cinema_id` (`cinema_id`),
  ADD KEY `reservation_movie_id_movies` (`movie_id`),
  ADD KEY `user_user_id` (`user_id`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movies_movie_id` (`movie_id`),
  ADD KEY `cinemas_cinema_id` (`cinema_id`);

--
-- Indexes for table `seats`
--
ALTER TABLE `seats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seats_cinema_id` (`cinema_id`);

--
-- Indexes for table `seats_reserved`
--
ALTER TABLE `seats_reserved`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reservations_seat_id` (`reservation_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cinemas`
--
ALTER TABLE `cinemas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `movies`
--
ALTER TABLE `movies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `seats`
--
ALTER TABLE `seats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=341;

--
-- AUTO_INCREMENT for table `seats_reserved`
--
ALTER TABLE `seats_reserved`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `cinema_cinema_id` FOREIGN KEY (`cinema_id`) REFERENCES `cinemas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservation_movie_id_movies` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `schedules`
--
ALTER TABLE `schedules`
  ADD CONSTRAINT `cinemas_cinema_id` FOREIGN KEY (`cinema_id`) REFERENCES `cinemas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `movies_movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `seats`
--
ALTER TABLE `seats`
  ADD CONSTRAINT `seats_cinema_id` FOREIGN KEY (`cinema_id`) REFERENCES `cinemas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `seats_reserved`
--
ALTER TABLE `seats_reserved`
  ADD CONSTRAINT `reservations_seat_id` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
