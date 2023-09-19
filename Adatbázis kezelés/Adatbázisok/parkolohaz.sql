-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Sze 12. 20:10
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
-- Adatbázis: `parkolohaz`
--
CREATE DATABASE IF NOT EXISTS `parkolohaz` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `parkolohaz`;

DELIMITER $$
--
-- Eljárások
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `veletlen_rendszam` ()   BEGIN
	DECLARE kod INT;
	DECLARE rendszam VARCHAR(6) DEFAULT "";
	DECLARE i INT DEFAULT 1;
	DECLARE db INT;
	DECLARE vege INT DEFAULT 0;
	DECLARE rsz VARCHAR(6);
	DECLARE mutato CURSOR FOR SELECT rendszam FROM tmp;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET vege=1;
	CREATE TABLE IF NOT EXISTS tmp(rendszam VARCHAR(6));
	SET db=(SELECT COUNT(*) FROM tmp);
	WHILE db<=10 DO
		WHILE i<=3 DO
			SET rendszam=CONCAT(rendszam,CHAR(FLOOR(RAND()*26+65)));
			SET i=i+1;
		END WHILE;
		SET i=1;
		WHILE i<=3 DO
			SET rendszam=CONCAT(rendszam,CHAR(FLOOR(RAND()*10+48)));
			SET i=i+1;
		END WHILE;
		OPEN mutato;
		ciklus: LOOP
			FETCH mutato INTO rsz;
			IF vege THEN
				LEAVE ciklus;
			END IF;
			IF rendszam=rsz THEN
				LEAVE ciklus;
			END IF;
		END LOOP ciklus;
		CLOSE mutato;
		IF vege THEN
			INSERT INTO tmp(rendszam) VALUES(rendszam);
			SET db=db+1;
		END IF;
		SET rendszam="";
		SET i=1;
	END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `autok`
--

CREATE TABLE `autok` (
  `rendszam` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `parkolasok`
--

CREATE TABLE `parkolasok` (
  `sorszam` int(10) UNSIGNED NOT NULL,
  `kezdete` datetime NOT NULL,
  `vege` datetime DEFAULT NULL,
  `rendszam` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tmp`
--

CREATE TABLE `tmp` (
  `rendszam` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- A tábla adatainak kiíratása `tmp`
--

INSERT INTO `tmp` (`rendszam`) VALUES
('FMT361'),
('ULV752'),
('MUO435'),
('OEH831'),
('THG433'),
('XJC357'),
('FTB094'),
('RAZ832'),
('EBV892'),
('FHX674'),
('DHC544');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `autok`
--
ALTER TABLE `autok`
  ADD PRIMARY KEY (`rendszam`);

--
-- A tábla indexei `parkolasok`
--
ALTER TABLE `parkolasok`
  ADD PRIMARY KEY (`sorszam`),
  ADD KEY `rendszam` (`rendszam`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `parkolasok`
--
ALTER TABLE `parkolasok`
  MODIFY `sorszam` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `parkolasok`
--
ALTER TABLE `parkolasok`
  ADD CONSTRAINT `parkolasok_ibfk_1` FOREIGN KEY (`rendszam`) REFERENCES `autok` (`rendszam`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
