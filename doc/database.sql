-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Loomise aeg: Jaan 28, 2016 kell 10:29 EL
-- Serveri versioon: 5.6.24
-- PHP versioon: 5.6.8

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Andmebaas: `meliss`
--

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `broneering`
--

DROP TABLE IF EXISTS `broneering`;
CREATE TABLE IF NOT EXISTS `broneering` (
  `Bron_id` int(11) NOT NULL,
  `Bron_nimi` varchar(50) DEFAULT NULL,
  `Bron_kuup` date DEFAULT NULL,
  `Bron_aeg` time NOT NULL,
  `Bron_tel_nr` int(11) DEFAULT NULL,
  `Bron_email` varchar(50) NOT NULL,
  `Bron_in_Arv` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Andmete tõmmistamine tabelile `broneering`
--

INSERT INTO `broneering` (`Bron_id`, `Bron_nimi`, `Bron_kuup`, `Bron_aeg`, `Bron_tel_nr`, `Bron_email`, `Bron_in_Arv`) VALUES
  (2, 'Steve Lewis', '2016-02-02', '11:30:00', 54122312, 'steve.lewis@gmail.com', 15);

--
-- Päästikud `broneering`
--
DROP TRIGGER IF EXISTS `deleteTeavitus`;
DELIMITER $$
CREATE TRIGGER `deleteTeavitus` AFTER DELETE ON `broneering`
FOR EACH ROW DELETE FROM Teavitus WHERE Email_bron_id=old.Bron_id
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `prepTeavitus`;
DELIMITER $$
CREATE TRIGGER `prepTeavitus` AFTER INSERT ON `broneering`
FOR EACH ROW INSERT INTO Teavitus(Email, Email_bron_id, sonum, staatus) VALUES (NEW.Bron_email, NEW.Bron_id, CONCAT('Tere, ', new.Bron_nimi,'! Teavitame, et teil on broneering kuupäevaks', new.Bron_kuup, ' kella ', new.Bron_aeg, '. Tervitusega, Teie Meliss!'), 'saatmata')
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `updateTeavitus`;
DELIMITER $$
CREATE TRIGGER `updateTeavitus` AFTER UPDATE ON `broneering`
FOR EACH ROW UPDATE Teavitus SET
  Email=NEW.Bron_email,
  sonum=CONCAT('Tere! Teavitame, et teil on broneering kuupäevaks', NEW.Bron_kuup, ' kella ', new.Bron_aeg, '. Tervitusega, Teie Meliss!'),
  staatus='saatmata' WHERE Email_bron_id=NEW.Bron_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `bron_tellimus`
--

DROP TABLE IF EXISTS `bron_tellimus`;
CREATE TABLE IF NOT EXISTS `bron_tellimus` (
  `Bron_tellimus_id` int(11) NOT NULL,
  `Bron_tellimus_roog` int(11) NOT NULL,
  `Bron_tellimuse_hulk` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Andmete tõmmistamine tabelile `bron_tellimus`
--

INSERT INTO `bron_tellimus` (`Bron_tellimus_id`, `Bron_tellimus_roog`, `Bron_tellimuse_hulk`) VALUES
  (2, 1, 2),
  (2, 2, 13);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `kasutajad`
--

DROP TABLE IF EXISTS `kasutajad`;
CREATE TABLE IF NOT EXISTS `kasutajad` (
  `kasutaja_id` int(11) NOT NULL,
  `kasutaja_nimi` varchar(25) DEFAULT NULL,
  `kasutaja_parool` varchar(25) DEFAULT NULL,
  `kasutaja_roll` varchar(10) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Andmete tõmmistamine tabelile `kasutajad`
--

INSERT INTO `kasutajad` (`kasutaja_id`, `kasutaja_nimi`, `kasutaja_parool`, `kasutaja_roll`) VALUES
  (1, 'administrato', 'nimdastrato', 'admin');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `roog`
--

DROP TABLE IF EXISTS `roog`;
CREATE TABLE IF NOT EXISTS `roog` (
  `Roa_id` int(11) NOT NULL,
  `Roa_nimetus` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Andmete tõmmistamine tabelile `roog`
--

INSERT INTO `roog` (`Roa_id`, `Roa_nimetus`) VALUES
  (1, 'Eelroog'),
  (2, 'Pearoog'),
  (3, 'Järelroog');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `teavitus`
--

DROP TABLE IF EXISTS `teavitus`;
CREATE TABLE IF NOT EXISTS `teavitus` (
  `Email` varchar(100) NOT NULL,
  `Email_bron_id` int(11) NOT NULL,
  `sonum` varchar(255) NOT NULL,
  `staatus` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Andmete tõmmistamine tabelile `teavitus`
--

INSERT INTO `teavitus` (`Email`, `Email_bron_id`, `sonum`, `staatus`) VALUES
  ('steve.lewis@gmail.com', 2, 'Tere, Steve Lewis! Teavitame, et teil on broneering kuupäevaks2016-02-02 kella 11:30:00. Tervitusega, Teie Meliss!', 'saatmata');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(10) unsigned NOT NULL,
  `username` varchar(25) NOT NULL,
  `is_admin` tinyint(4) NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL,
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Andmete tõmmistamine tabelile `users`
--

INSERT INTO `users` (`user_id`, `username`, `is_admin`, `password`, `active`, `email`, `deleted`) VALUES
  (1, 'demo', 0, 'demo', 1, '', 0),
  (2, 'admin', 1, 'admin', 1, '', 0);

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `broneering`
--
ALTER TABLE `broneering`
ADD PRIMARY KEY (`Bron_id`);

--
-- Indeksid tabelile `bron_tellimus`
--
ALTER TABLE `bron_tellimus`
ADD KEY `fk_BronTelli` (`Bron_tellimus_id`), ADD KEY `fk_BronTRoog` (`Bron_tellimus_roog`);

--
-- Indeksid tabelile `kasutajad`
--
ALTER TABLE `kasutajad`
ADD PRIMARY KEY (`kasutaja_id`);

--
-- Indeksid tabelile `roog`
--
ALTER TABLE `roog`
ADD PRIMARY KEY (`Roa_id`);

--
-- Indeksid tabelile `users`
--
ALTER TABLE `users`
ADD PRIMARY KEY (`user_id`), ADD UNIQUE KEY `UNIQUE` (`username`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `broneering`
--
ALTER TABLE `broneering`
MODIFY `Bron_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT tabelile `kasutajad`
--
ALTER TABLE `kasutajad`
MODIFY `kasutaja_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT tabelile `roog`
--
ALTER TABLE `roog`
MODIFY `Roa_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT tabelile `users`
--
ALTER TABLE `users`
MODIFY `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `bron_tellimus`
--
ALTER TABLE `bron_tellimus`
ADD CONSTRAINT `fk_BronTRoog` FOREIGN KEY (`Bron_tellimus_roog`) REFERENCES `roog` (`Roa_id`),
ADD CONSTRAINT `fk_BronTelli` FOREIGN KEY (`Bron_tellimus_id`) REFERENCES `broneering` (`Bron_id`);
SET FOREIGN_KEY_CHECKS=1;
