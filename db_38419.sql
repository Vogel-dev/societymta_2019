-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 137.74.0.12:3306
-- Czas generowania: 09 Lut 2019, 13:29
-- Wersja serwera: 10.1.26-MariaDB-0+deb9u1
-- Wersja PHP: 7.1.20-1+0~20180910100532.3+stretch~1.gbp17c613

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `db_38419`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `smtadb_accounts`
--

CREATE TABLE `smtadb_accounts` (
  `dbid` int(11) NOT NULL,
  `login` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `haslo` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `kasa` float NOT NULL,
  `brudnakasa` float NOT NULL,
  `punkty` int(11) NOT NULL DEFAULT '0',
  `poziom` int(11) NOT NULL DEFAULT '0',
  `xp` int(11) NOT NULL DEFAULT '0',
  `pp` int(11) NOT NULL,
  `infoadm` text NOT NULL,
  `pg` int(11) NOT NULL,
  `bkasa` float NOT NULL,
  `premium` date DEFAULT '0000-00-00',
  `rejestracja` date NOT NULL,
  `serial` text CHARACTER SET latin7 NOT NULL,
  `whitelist` text NOT NULL,
  `skin` int(11) NOT NULL DEFAULT '0',
  `prawko_a` int(11) NOT NULL,
  `prawko_b` int(11) NOT NULL,
  `prawko_c` int(11) NOT NULL,
  `online` int(11) NOT NULL,
  `pos` text CHARACTER SET latin2,
  `radia` text NOT NULL,
  `wyplata` int(11) NOT NULL,
  `najedzenie` int(11) NOT NULL,
  `warny` int(11) NOT NULL,
  `przynety` int(11) NOT NULL,
  `mpunkty` int(11) NOT NULL,
  `mskrzynki` int(11) NOT NULL,
  `mulepszenie1` int(11) NOT NULL,
  `mulepszenie2` int(11) NOT NULL,
  `mulepszenie3` int(11) NOT NULL,
  `kzlecenia` int(11) NOT NULL,
  `kpunkty` int(11) NOT NULL,
  `kulepszenie1` int(11) NOT NULL,
  `kulepszenie2` int(11) NOT NULL,
  `kulepszenie3` int(11) NOT NULL,
  `fzlecenia` int(11) NOT NULL,
  `fpunkty` int(11) NOT NULL,
  `fulepszenie1` int(11) NOT NULL,
  `fulepszenie2` int(11) NOT NULL,
  `fulepszenie3` int(11) NOT NULL,
  `szlecenia` int(11) NOT NULL,
  `spunkty` int(11) NOT NULL,
  `sulepszenie1` int(11) NOT NULL,
  `sulepszenie2` int(11) NOT NULL,
  `sulepszenie3` int(11) NOT NULL,
  `sulepszenie4` int(11) NOT NULL,
  `kopwykopania` int(11) NOT NULL,
  `koppunkty` int(11) NOT NULL,
  `kopulepszenie1` int(11) NOT NULL,
  `kopulepszenie2` int(11) NOT NULL,
  `koszlecenia` int(11) NOT NULL,
  `kospunkty` int(11) NOT NULL,
  `kosulepszenie1` int(11) NOT NULL,
  `kosulepszenie2` int(11) NOT NULL,
  `azlecenia` int(11) NOT NULL,
  `apunkty` int(11) NOT NULL,
  `aulepszenie1` int(11) NOT NULL,
  `aulepszenie2` int(11) NOT NULL,
  `weed1` int(11) NOT NULL,
  `weed2` int(11) NOT NULL,
  `meta1` int(11) NOT NULL,
  `meta2` int(11) NOT NULL,
  `koka1` int(11) NOT NULL,
  `koka2` int(11) NOT NULL,
  `odkryl_grob` int(11) NOT NULL DEFAULT '0',
  `orank` int(11) NOT NULL DEFAULT '1',
  `org` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL,
  `levelpkt` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Neveron';

--
-- Zrzut danych tabeli `smtadb_accounts`
--


-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `smtadb_admins`
--

CREATE TABLE `smtadb_admins` (
  `id` int(11) NOT NULL,
  `gracz` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `serial` text CHARACTER SET latin2 NOT NULL,
  `ranga` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `tranga` int(11) NOT NULL,
  `hex` text NOT NULL,
  `rapsy` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Neveron';

--
-- Zrzut danych tabeli `smtadb_admins`
--

INSERT INTO `smtadb_admins` (`id`, `gracz`, `serial`, `ranga`, `tranga`, `hex`, `rapsy`) VALUES
(1, 'Vogel', 's1', 'ARCon', 4, '#FF0000', 779),
(2, 'Daniele_Lertivo', 's2', 'ARCon', 4, '#FF0000', 599),
(3, 'Vittorio_Lertivo', 's3', 'Administrator', 3, '#9932CC', 31),

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `smtadb_bans`
--

CREATE TABLE `smtadb_bans` (
  `id` int(11) NOT NULL,
  `nick` text CHARACTER SET latin2,
  `serial` text CHARACTER SET latin2,
  `ip` text CHARACTER SET latin2,
  `data` text CHARACTER SET latin7,
  `admin` text CHARACTER SET latin2,
  `powod` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `smtadb_bans`
--

INSERT INTO `smtadb_bans` (`id`, `nick`, `serial`, `ip`, `data`, `admin`, `powod`) VALUES

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `smtadb_businesses`
--

CREATE TABLE `smtadb_businesses` (
  `id` int(11) NOT NULL,
  `owner` varchar(512) COLLATE utf16_polish_ci NOT NULL,
  `xyz` varchar(512) COLLATE utf16_polish_ci NOT NULL,
  `cost` int(11) NOT NULL,
  `zajety` varchar(1) COLLATE utf16_polish_ci NOT NULL DEFAULT 'n',
  `nazwa` varchar(255) COLLATE utf16_polish_ci NOT NULL,
  `saldo` int(11) NOT NULL DEFAULT '0',
  `data` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_polish_ci;

--
-- Zrzut danych tabeli `smtadb_businesses`
--

INSERT INTO `smtadb_businesses` (`id`, `owner`, `xyz`, `cost`, `zajety`, `nazwa`, `saldo`, `data`) VALUES
(1, '366', '-2176.460938,-46.627930,35.312515', 175000, 't', '\"Gringlianka\"', 135940, '2019-02-11 03:27:21'),
(2, '259', '-1968.130859,298.372070,35.171875', 145000, 't', '\"Samochodowa asteroida\"', 108369, '2019-02-12 20:14:47'),
(3, '83', '-1761.231445,962.802734,24.882812', 85000, 't', 'Zajezdnia tramwajowa', 54635, '2019-02-15 20:59:09'),
(5, '260', '-1805.569336,948.140625,24.890625', 47500, 't', 'Pizzeria \"El Kapucyno\"', 19022, '2019-02-17 20:48:54'),
(6, '13', '-1910.417969,825.706055,35.171875', 52000, 't', '\"Strefa Burgera 51\"', 241326, '2019-02-10 19:58:11'),
(7, '259', '-2032.500977,161.489258,29.046106', 99500, 't', '\"Warsztat u Janusza\"', 72228, '2019-02-12 15:15:52'),
(8, '694', '-2321.431641,-161.245117,35.554688', 32000, 't', '\"Burger w Pysku\"', 3974, '2019-02-14 20:45:11'),
(9, '434', '-2268.777344,-156.165039,35.320312', 223000, 't', '\"Turborura\"', 198523, '2019-02-12 20:39:55'),
(11, '25', '-1641.452148,1208.314453,7.179688', 175920, 't', '\"Krolewska opona\"', 809560, '2019-02-22 20:41:37'),
(12, '216', '-2022.719727,-100.136719,35.164062', 19000, 't', '\"Zlota kierownica\"', 57, '2019-02-11 15:32:05'),
(13, '434', '-1690.713867,18.775391,3.554688', 425000, 't', '\"European Car Import\"', 397280, '2019-02-13 20:51:53'),
(14, '840', '-1742.242188,40.923828,3.554688', 2350000, 't', 'Port', 1664108, '2019-02-11 17:15:50'),
(15, '366', '-1896.932617,-562.332031,24.593750', 16000, 't', '\"Kraina zlomu\"', 13565, '2019-02-14 21:36:36'),
(16, '2', '-1807.358398,898.226562,24.890625', 3500000, 't', 'Kasyno \"Czterech Smokow\"', 11170974, '2019-05-22 15:56:42'),
(17, '844', '-1192.836914,-1073.700195,129.218750', 350000, 't', 'Farma Williego Becwala', 210756, '2019-02-11 09:09:26'),
(18, '6', '-502.471680,-536.570312,25.523438', 8500000, 't', 'Fabryka diamentow', 15841854, '2019-05-25 21:27:19'),
(19, '292', '-1877.565430,826.191406,35.172081', 1675000, 't', '\"Vixa Club\"', 313040, '2019-02-11 20:20:18'),
(20, '2', '-1720.365234,1356.427734,7.187500', 750000, 't', 'Pizzeria \"Lertivo\"', 2356856, '2019-02-23 05:50:33'),
(21, '260', '-2070.824219,1367.132812,7.100666', 550000, 't', '\"Szpachla u Miroslawa\"', 502690, '2019-02-13 20:31:00'),
(22, '224', '-2432.103516,-186.226562,35.320312', 375000, 't', '\"Monopolowy u Stolara\"', 310983, '2019-02-11 19:07:11'),
(23, '289', '-37.627930,-300.357422,5.429688', 4500000, 't', 'International Car Import', 3220260, '2019-02-14 20:16:19');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `smtadb_exchangedp`
--

CREATE TABLE `smtadb_exchangedp` (
  `id` int(11) NOT NULL,
  `nick` text NOT NULL,
  `dbid` int(11) NOT NULL,
  `ilosc` int(11) NOT NULL,
  `cena` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `smtadb_factions`
--

CREATE TABLE `smtadb_factions` (
  `dbid` int(11) NOT NULL,
  `nick` text NOT NULL,
  `frakcja` text NOT NULL,
  `ranga` text NOT NULL,
  `wyplata` int(11) NOT NULL,
  `minuty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `smtadb_factions`
--

INSERT INTO `smtadb_factions` (`dbid`, `nick`, `frakcja`, `ranga`, `wyplata`, `minuty`) VALUES
(1, 'Vogel', 'SAPD', 'Komendant', 500, 0),

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `smtadb_houses`
--

CREATE TABLE `smtadb_houses` (
  `id` int(11) NOT NULL,
  `owner` int(11) DEFAULT NULL,
  `owner_name` text CHARACTER SET latin7,
  `name` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `data` date NOT NULL,
  `organization` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `wejscie` text CHARACTER SET latin7 NOT NULL,
  `wyjscie` text CHARACTER SET latin7 NOT NULL,
  `tpw` text CHARACTER SET latin7 NOT NULL,
  `cost` int(11) NOT NULL DEFAULT '0',
  `zamek` int(11) NOT NULL DEFAULT '0',
  `lokatorzy` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `smtadb_interiors`
--

CREATE TABLE `smtadb_interiors` (
  `uid` int(11) NOT NULL,
  `name` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `en_marker` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL COMMENT 'x,y,z,i,d - miejsce markera wejscia',
  `en_tp` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL COMMENT 'x,y,z,rz,i,d - miejsce gdzie nas marker wejscia tepnie',
  `ex_marker` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL COMMENT 'x,y,z,i,d - miejsce markera wyjscia',
  `ex_tp` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL COMMENT 'x,y,z,rz,i,d - miejsce gdzie nas marker wyjscia tepnie',
  `locked` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `smtadb_interiors`
--

INSERT INTO `smtadb_interiors` (`uid`, `name`, `en_marker`, `en_tp`, `ex_marker`, `ex_tp`, `locked`) VALUES
(1, 'Szkoła jazdy', '-2026.59, -101.23, 35.26, 0,0', '2436.94, -1655.90, 1016.14,1,0', '2433.92, -1655.81, 1016.24,1,0', '-2026.73, -99.00, 35.16,0,0', 0),
(2, 'Sklep z ubraniami', '-1806.68, 531.27, 35.17, 0, 0', '2400.49, -1730.88, 1070.43, 1, 0', '2402.18, -1730.78, 1070.43 ,1, 0', '-1806.94, 533.74, 35.17, 0, 0', 0),
(3, 'Restauracja \"Gringlianka\"', '-2177.96, -42.38, 35.33, 0, 0', '1950.66, -1691.85, 990.03, 1, 0', '1949.17, -1691.85, 990.03, 1, 0', '-2176.63, -42.38, 35.31, 0, 0', 0),
(4, 'Kasyno', '-1810.02, 902.54, 24.89, 0, 0', '2015.80, 1017.79, 996.88, 10, 0', '2018.51, 1017.80, 996.88, 10, 0', '-1808.50, 904.05, 24.89, 0, 0', 0),
(5, 'Szpital', '-2655.11, 639.32, 14.45, 0, 0', '1608.77, 1715.79, -33.73, 1, 0', '1610.94, 1715.83, -33.73, 1, 0', '-2655.09, 636.81, 14.45, 0, 0', 0),
(6, 'Komisariat', '-1605.63, 710.80, 13.87, 0, 0', '238.54, 141.68, 1003.02, 3, 0', '238.56, 139.36, 1003.02, 3, 0', '-1605.44, 715.05, 12.54, 0, 0', 0),
(7, '\"Vixa Club\"', '-1881.45, 823.09, 35.18, 0, 0', '493.36, -24.22, 1000.68, 17, 0', '493.36, -24.22, 1000.68, 17, 0', '-1883.51, 825.03, 35.17, 0, 0', 0),
(8, 'Urząd miasta', '-2765.26, 375.57, 6.34, 0, 0', '2459.52, -1776.58, 37.54, 1, 0', '2461.35, -1776.48, 37.54, 1, 0', '-2761.32, 375.29, 5.18, 0, 0', 0),
(9, '\"Monopolowy u Stolara\"', '-2431.54, -183.12, 35.32, 0, 0', '6.02, -28.34, 1003.55, 10, 0', '6.11, -31.27, 1003.55, 10, 0', '-2429.14, -183.61, 35.32, 0, 0', 0),
(10, 'Parking', '288.81, 167.73, 1007.17, 3, 0', '-1620.31, 689.31, 7.19, 0, 0', '-1619.99, 692.88, 7.19, 0, 0', '288.83, 169.65, 1007.17, 3, 0', 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `smtadb_items`
--

CREATE TABLE `smtadb_items` (
  `id` int(11) NOT NULL,
  `dbid` int(11) NOT NULL,
  `nick` text NOT NULL,
  `nazwa` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `smtadb_items`
--

INSERT INTO `smtadb_items` (`id`, `dbid`, `nick`, `nazwa`) VALUES

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `smtadb_jail`
--

CREATE TABLE `smtadb_jail` (
  `seg` int(11) NOT NULL,
  `Serial` varchar(128) NOT NULL,
  `Termin` datetime NOT NULL,
  `Cela` int(11) NOT NULL COMMENT 'CELA',
  `Powod` varchar(4092) CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `smtadb_jail`
--

INSERT INTO `smtadb_jail` (`seg`, `Serial`, `Termin`, `Cela`, `Powod`) VALUES

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `smtadb_licences`
--

CREATE TABLE `smtadb_licences` (
  `id` int(11) NOT NULL,
  `nick` text CHARACTER SET latin2,
  `serial` text CHARACTER SET latin2,
  `ip` text CHARACTER SET latin2,
  `data` text CHARACTER SET latin7,
  `admin` text CHARACTER SET latin2,
  `powod` text NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `smtadb_licences`
--

INSERT INTO `smtadb_licences` (`id`, `nick`, `serial`, `ip`, `data`, `admin`, `powod`, `ts`) VALUES

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `smtadb_logs`
--

CREATE TABLE `smtadb_logs` (
  `id` int(11) NOT NULL,
  `nick` text CHARACTER SET latin2 NOT NULL,
  `tresc` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `serial` text CHARACTER SET latin2 NOT NULL,
  `data` text CHARACTER SET latin2,
  `typ` text CHARACTER SET latin2 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `smtadb_logs`
--

INSERT INTO `smtadb_logs` (`id`, `nick`, `tresc`, `serial`, `data`, `typ`) VALUES
--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `smtadb_accounts`
--
ALTER TABLE `smtadb_accounts`
  ADD PRIMARY KEY (`dbid`);

--
-- Indexes for table `smtadb_bans`
--
ALTER TABLE `smtadb_bans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smtadb_businesses`
--
ALTER TABLE `smtadb_businesses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smtadb_items`
--
ALTER TABLE `smtadb_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smtadb_jail`
--
ALTER TABLE `smtadb_jail`
  ADD PRIMARY KEY (`seg`);

--
-- Indexes for table `smtadb_licences`
--
ALTER TABLE `smtadb_licences`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smtadb_mute`
--
ALTER TABLE `smtadb_mute`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smtadb_reports`
--
ALTER TABLE `smtadb_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smtadb_updates`
--
ALTER TABLE `smtadb_updates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smtadb_vehicles`
--
ALTER TABLE `smtadb_vehicles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `smtadb_accounts`
--
ALTER TABLE `smtadb_accounts`
  MODIFY `dbid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1041;

--
-- AUTO_INCREMENT dla tabeli `smtadb_bans`
--
ALTER TABLE `smtadb_bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=349;

--
-- AUTO_INCREMENT dla tabeli `smtadb_businesses`
--
ALTER TABLE `smtadb_businesses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT dla tabeli `smtadb_items`
--
ALTER TABLE `smtadb_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74147;

--
-- AUTO_INCREMENT dla tabeli `smtadb_jail`
--
ALTER TABLE `smtadb_jail`
  MODIFY `seg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT dla tabeli `smtadb_licences`
--
ALTER TABLE `smtadb_licences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT dla tabeli `smtadb_mute`
--
ALTER TABLE `smtadb_mute`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT dla tabeli `smtadb_reports`
--
ALTER TABLE `smtadb_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5525;

--
-- AUTO_INCREMENT dla tabeli `smtadb_updates`
--
ALTER TABLE `smtadb_updates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT dla tabeli `smtadb_vehicles`
--
ALTER TABLE `smtadb_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1241;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
