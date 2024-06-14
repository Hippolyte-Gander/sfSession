-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour session_hippo
DROP DATABASE IF EXISTS `session_hippo`;
CREATE DATABASE IF NOT EXISTS `session_hippo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `session_hippo`;

-- Listage de la structure de table session_hippo. categorie
DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table session_hippo.categorie : ~3 rows (environ)
INSERT IGNORE INTO `categorie` (`id`, `titre`) VALUES
	(1, 'Excel'),
	(2, 'dev web front'),
	(3, 'dev web back'),
	(4, 'fullstack');

-- Listage de la structure de table session_hippo. doctrine_migration_versions
DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Listage des données de la table session_hippo.doctrine_migration_versions : ~1 rows (environ)
INSERT IGNORE INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
	('DoctrineMigrations\\Version20240613124123', '2024-06-13 12:42:02', 493),
	('DoctrineMigrations\\Version20240613141309', '2024-06-13 14:13:19', 18),
	('DoctrineMigrations\\Version20240614092220', '2024-06-14 09:22:36', 169);

-- Listage de la structure de table session_hippo. formateur
DROP TABLE IF EXISTS `formateur`;
CREATE TABLE IF NOT EXISTS `formateur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prenom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table session_hippo.formateur : ~1 rows (environ)
INSERT IGNORE INTO `formateur` (`id`, `prenom`, `nom`, `email`) VALUES
	(1, 'Stéphane', 'SMAIL', 'stephane.smail@exemple.com');

-- Listage de la structure de table session_hippo. messenger_messages
DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table session_hippo.messenger_messages : ~0 rows (environ)

-- Listage de la structure de table session_hippo. module
DROP TABLE IF EXISTS `module`;
CREATE TABLE IF NOT EXISTS `module` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categorie_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C242628BCF5E72D` (`categorie_id`),
  CONSTRAINT `FK_C242628BCF5E72D` FOREIGN KEY (`categorie_id`) REFERENCES `categorie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table session_hippo.module : ~5 rows (environ)
INSERT IGNORE INTO `module` (`id`, `titre`, `categorie_id`) VALUES
	(1, 'HTML CSS', 2),
	(2, 'JS', 2),
	(3, 'PHP', 3),
	(4, 'Excel avancé', 1),
	(5, 'Symfony', 4);

-- Listage de la structure de table session_hippo. programme
DROP TABLE IF EXISTS `programme`;
CREATE TABLE IF NOT EXISTS `programme` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_id` int NOT NULL,
  `module_id` int DEFAULT NULL,
  `duree` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3DDCB9FF613FECDF` (`session_id`),
  KEY `IDX_3DDCB9FFAFC2B591` (`module_id`),
  CONSTRAINT `FK_3DDCB9FF613FECDF` FOREIGN KEY (`session_id`) REFERENCES `session` (`id`),
  CONSTRAINT `FK_3DDCB9FFAFC2B591` FOREIGN KEY (`module_id`) REFERENCES `module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table session_hippo.programme : ~1 rows (environ)
INSERT IGNORE INTO `programme` (`id`, `session_id`, `module_id`, `duree`) VALUES
	(1, 1, 4, 3);

-- Listage de la structure de table session_hippo. session
DROP TABLE IF EXISTS `session`;
CREATE TABLE IF NOT EXISTS `session` (
  `id` int NOT NULL AUTO_INCREMENT,
  `formateur_id` int DEFAULT NULL,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nbr_places` int NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D044D5D4155D8F51` (`formateur_id`),
  CONSTRAINT `FK_D044D5D4155D8F51` FOREIGN KEY (`formateur_id`) REFERENCES `formateur` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table session_hippo.session : ~2 rows (environ)
INSERT IGNORE INTO `session` (`id`, `formateur_id`, `titre`, `nbr_places`, `date_debut`, `date_fin`) VALUES
	(1, NULL, 'Formation Excel', 15, '2024-08-14', '2024-12-14'),
	(2, NULL, 'Front basics', 11, '2024-06-17', '2024-08-02');

-- Listage de la structure de table session_hippo. stagiaire
DROP TABLE IF EXISTS `stagiaire`;
CREATE TABLE IF NOT EXISTS `stagiaire` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prenom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sexe` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_naissance` date NOT NULL,
  `ville` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `num_tel` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table session_hippo.stagiaire : ~3 rows (environ)
INSERT IGNORE INTO `stagiaire` (`id`, `prenom`, `nom`, `sexe`, `date_naissance`, `ville`, `email`, `num_tel`) VALUES
	(1, 'Jiji', 'Duval', 'M', '2002-06-13', 'STRASBOURG', 'jiji@exemple.com', '0666554433'),
	(2, 'Jojo', 'Goldwind', 'M', '1999-06-13', 'NAPOLI', 'jojo@exemple.com', '0666666666'),
	(3, 'Toto', 'Toto', 'F', '2017-05-17', 'MULHOUSE', 'toto@exemple.com', '0333333333');

-- Listage de la structure de table session_hippo. stagiaire_session
DROP TABLE IF EXISTS `stagiaire_session`;
CREATE TABLE IF NOT EXISTS `stagiaire_session` (
  `stagiaire_id` int NOT NULL,
  `session_id` int NOT NULL,
  PRIMARY KEY (`stagiaire_id`,`session_id`),
  KEY `IDX_D32D02D4BBA93DD6` (`stagiaire_id`),
  KEY `IDX_D32D02D4613FECDF` (`session_id`),
  CONSTRAINT `FK_D32D02D4613FECDF` FOREIGN KEY (`session_id`) REFERENCES `session` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_D32D02D4BBA93DD6` FOREIGN KEY (`stagiaire_id`) REFERENCES `stagiaire` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table session_hippo.stagiaire_session : ~1 rows (environ)
INSERT IGNORE INTO `stagiaire_session` (`stagiaire_id`, `session_id`) VALUES
	(2, 1);

-- Listage de la structure de table session_hippo. user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table session_hippo.user : ~0 rows (environ)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
