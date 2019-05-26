-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  Dim 26 mai 2019 à 16:50
-- Version du serveur :  8.0.16
-- Version de PHP :  7.2.17-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `db_ephec`
--
CREATE DATABASE IF NOT EXISTS `db_ephec` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `db_ephec`;

-- --------------------------------------------------------

--
-- Structure de la table `CLIENT`
--

CREATE TABLE `CLIENT` (
  `NCLI` char(4) NOT NULL,
  `NOM` varchar(12) NOT NULL,
  `ADRESSE` varchar(20) NOT NULL,
  `LOCALITE` varchar(12) NOT NULL,
  `CAT` char(2) DEFAULT NULL,
  `COMPTE` decimal(9,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `CLIENT`
--

INSERT INTO `CLIENT` (`NCLI`, `NOM`, `ADRESSE`, `LOCALITE`, `CAT`, `COMPTE`) VALUES
('B062', 'GOFFIN', '72, r. de la Gare', 'Namur', 'B2', '-3200.00'),
('B112', 'HANSENNE', '23, a. Dumont', 'Poitiers', 'C1', '1250.00'),
('B332', 'MONTI', '112, r. Neuve', 'Geneve', 'B2', '0.00'),
('B512', 'GILLET', '14, r. de l\'Ete', 'Toulouse', 'B1', '-8700.00'),
('C003', 'AVRON', '8, ch. de la Cure', 'Toulouse', 'B1', '-1700.00'),
('C123', 'MERCIER', '25, r. Lemaitre', 'Namur', 'C1', '-2300.00'),
('C400', 'FERARD', '65, r. du Tertre', 'Poitiers', 'B2', '350.00'),
('D063', 'MERCIER', '201, bvd du Nord', 'Toulouse', NULL, '-2250.00'),
('F010', 'TOUSSAINT', '5, r. Godefroid', 'Poitiers', 'C1', '0.00'),
('F011', 'PONCELET', '17, Clos des Erables', 'Toulouse', 'B2', '0.00'),
('F400', 'JACOB', '78, ch. du Moulin', 'Bruxelles', 'C2', '0.00'),
('K111', 'VANBIST', '180, r. Florimont', 'Lille', 'B1', '720.00'),
('K729', 'NEUMAN', '40, r. Bransart', 'Toulouse', NULL, '0.00'),
('L422', 'FRANCK', '60, r. de Wepion', 'Namur', 'C1', '0.00'),
('S127', 'VANDERKA', '3, av. des Roses', 'Namur', 'C1', '-4580.00'),
('S712', 'GUILLAUME', '14a, ch. des Roses', 'Paris', 'B1', '0.00');

-- --------------------------------------------------------

--
-- Structure de la table `COMMANDE`
--

CREATE TABLE `COMMANDE` (
  `NCOM` char(5) NOT NULL,
  `NCLI` char(4) NOT NULL,
  `DATECOM` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `COMMANDE`
--

INSERT INTO `COMMANDE` (`NCOM`, `NCLI`, `DATECOM`) VALUES
('30178', 'K111', '2008-12-21 00:00:00'),
('30179', 'C400', '2008-12-22 00:00:00'),
('30182', 'S127', '2008-12-23 00:00:00'),
('30184', 'C400', '2008-12-23 00:00:00'),
('30185', 'F011', '2009-01-02 00:00:00'),
('30186', 'C400', '2009-01-02 00:00:00'),
('30188', 'B512', '2009-01-03 00:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `DETAIL`
--

CREATE TABLE `DETAIL` (
  `NCOM` char(5) NOT NULL,
  `NPRO` char(5) NOT NULL,
  `QCOM` decimal(4,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `DETAIL`
--

INSERT INTO `DETAIL` (`NCOM`, `NPRO`, `QCOM`) VALUES
('30178', 'CS464', '25'),
('30179', 'CS262', '60'),
('30179', 'PA60', '20'),
('30182', 'PA60', '30'),
('30184', 'CS464', '120'),
('30184', 'PA45', '20'),
('30185', 'CS464', '260'),
('30185', 'PA60', '15'),
('30185', 'PS222', '600'),
('30186', 'PA45', '3'),
('30188', 'CS464', '180'),
('30188', 'PA45', '22'),
('30188', 'PA60', '70'),
('30188', 'PH222', '92');

-- --------------------------------------------------------

--
-- Structure de la table `PRODUIT`
--

CREATE TABLE `PRODUIT` (
  `NPRO` char(5) NOT NULL,
  `LIBELLE` varchar(20) NOT NULL,
  `PRIX` decimal(5,0) NOT NULL,
  `QSTOCK` decimal(6,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `PRODUIT`
--

INSERT INTO `PRODUIT` (`NPRO`, `LIBELLE`, `PRIX`, `QSTOCK`) VALUES
('CS262', 'CHEV. SAPIN 200x6x2', '75', '45'),
('CS264', 'CHEV. SAPIN 200x6x4', '120', '2690'),
('CS464', 'CHEV. SAPIN 400x6x4', '220', '450'),
('PA45', 'POINTE ACIER 45 (1K)', '105', '580'),
('PA60', 'POINTE ACIER 60 (1K)', '95', '134'),
('PH222', 'PL. HETRE 200x20x2', '230', '782'),
('PS222', 'PL. SAPIN 200x20x2', '185', '1220');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `CLIENT`
--
ALTER TABLE `CLIENT`
  ADD PRIMARY KEY (`NCLI`);

--
-- Index pour la table `COMMANDE`
--
ALTER TABLE `COMMANDE`
  ADD PRIMARY KEY (`NCOM`),
  ADD KEY `NCLI` (`NCLI`);

--
-- Index pour la table `DETAIL`
--
ALTER TABLE `DETAIL`
  ADD PRIMARY KEY (`NCOM`,`NPRO`),
  ADD KEY `NPRO` (`NPRO`);

--
-- Index pour la table `PRODUIT`
--
ALTER TABLE `PRODUIT`
  ADD PRIMARY KEY (`NPRO`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `COMMANDE`
--
ALTER TABLE `COMMANDE`
  ADD CONSTRAINT `COMMANDE_ibfk_1` FOREIGN KEY (`NCLI`) REFERENCES `CLIENT` (`NCLI`);

--
-- Contraintes pour la table `DETAIL`
--
ALTER TABLE `DETAIL`
  ADD CONSTRAINT `DETAIL_ibfk_1` FOREIGN KEY (`NCOM`) REFERENCES `COMMANDE` (`NCOM`),
  ADD CONSTRAINT `DETAIL_ibfk_2` FOREIGN KEY (`NPRO`) REFERENCES `PRODUIT` (`NPRO`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
