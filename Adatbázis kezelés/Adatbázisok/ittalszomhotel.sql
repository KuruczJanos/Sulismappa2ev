-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Sze 09. 12:47
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `ittalszomhotel`
--
CREATE DATABASE IF NOT EXISTS `ittalszomhotel` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `ittalszomhotel`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `foglalasok`
--

CREATE TABLE `foglalasok` (
  `szobaszam` smallint(5) UNSIGNED NOT NULL,
  `kezdete` date NOT NULL,
  `vege` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szobak`
--

CREATE TABLE `szobak` (
  `szobaszam` smallint(5) UNSIGNED NOT NULL,
  `ferohely` tinyint(3) UNSIGNED NOT NULL,
  `ar` mediumint(8) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `foglalasok`
--
ALTER TABLE `foglalasok`
  ADD KEY `idegenkulcs` (`szobaszam`);

--
-- A tábla indexei `szobak`
--
ALTER TABLE `szobak`
  ADD PRIMARY KEY (`szobaszam`);

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `foglalasok`
--
ALTER TABLE `foglalasok`
  ADD CONSTRAINT `foglalasok_ibfk_1` FOREIGN KEY (`szobaszam`) REFERENCES `szobak` (`szobaszam`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `foglalasok`
  ADD CONSTRAINT `datumok` CHECK (kezdete<=vege);
  
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
