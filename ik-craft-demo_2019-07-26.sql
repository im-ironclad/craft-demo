# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.4.6-MariaDB)
# Database: ik-craft-demo
# Generation Time: 2019-07-27 02:40:08 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table assetindexdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assetindexdata`;

CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assets`;

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;

INSERT INTO `assets` (`id`, `volumeId`, `folderId`, `filename`, `kind`, `width`, `height`, `size`, `focalPoint`, `deletedWithVolume`, `keptFile`, `dateModified`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(3,1,4,'hero-delivery.jpg','image',2082,888,266480,NULL,NULL,NULL,'2019-06-29 22:24:09','2019-06-29 22:23:55','2019-07-21 19:18:09','61d92942-6bbd-4d22-893e-6d258ae8da5f'),
	(21,1,6,'icon-raised-graph.svg','image',50,50,5715,NULL,NULL,NULL,'2019-07-08 22:53:50','2019-07-08 22:53:45','2019-07-08 22:53:50','872fddf5-b946-40b4-b0d5-1c2d9b17b6e4'),
	(22,1,6,'icon-leaf.svg','image',50,50,2054,NULL,NULL,NULL,'2019-07-08 23:30:22','2019-07-08 23:30:22','2019-07-08 23:30:22','956bcd92-1cb7-4514-8be6-d7be0359c58e'),
	(23,1,6,'icon-two-people.svg','image',50,43,3988,NULL,NULL,NULL,'2019-07-08 23:30:41','2019-07-08 23:30:41','2019-07-08 23:30:41','f754873b-be1f-44f1-b3d6-d4a0680ff077'),
	(24,1,6,'icon-ribbon.svg','image',33,50,2747,NULL,NULL,NULL,'2019-07-08 23:30:53','2019-07-08 23:30:53','2019-07-08 23:30:53','efe6aa09-4a6b-47a9-a5be-3d155129c6df'),
	(59,1,4,'computer-focal.jpg','image',1920,1280,150364,NULL,NULL,NULL,'2019-07-12 13:44:28','2019-07-12 13:44:28','2019-07-12 13:44:28','91797a95-5336-4fe1-8f9b-057a1feab75c'),
	(77,1,4,'urban-area.jpg','image',676,380,78695,NULL,NULL,NULL,'2019-07-12 15:34:05','2019-07-12 15:34:05','2019-07-12 15:34:05','6ec747af-f07c-456c-986d-1dcb2c439ce5'),
	(103,1,5,'people-walking-on-painted-streets.jpg','image',1057,500,214323,NULL,NULL,NULL,'2019-07-25 02:36:53','2019-07-25 02:36:53','2019-07-25 02:36:53','429bd47b-3e1d-49da-8797-fcba60993039');

/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table assettransformindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransformindex`;

CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransforms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransforms`;

CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;

INSERT INTO `categories` (`id`, `groupId`, `parentId`, `deletedWithGroup`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(84,1,NULL,NULL,'2019-07-12 15:49:53','2019-07-12 15:49:53','9d6fdcfe-4635-489b-bc9b-4b88253e2ba8'),
	(85,1,NULL,NULL,'2019-07-12 15:49:59','2019-07-12 15:49:59','f951f368-d53f-4b67-8a26-446cd7a28607');

/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categorygroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups`;

CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;

INSERT INTO `categorygroups` (`id`, `structureId`, `fieldLayoutId`, `name`, `handle`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,3,NULL,'Digital Insights','digitalInsights','2019-07-12 15:49:36','2019-07-12 15:49:36',NULL,'85c77f35-48e4-42ff-a631-57f0612aaf53');

/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups_sites`;

CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;

INSERT INTO `categorygroups_sites` (`id`, `groupId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,0,NULL,NULL,'2019-07-12 15:49:36','2019-07-12 15:49:36','098d70b9-0c8a-41bd-bc14-3db73e795433');

/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `content`;

CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_accentColor` varchar(255) DEFAULT NULL,
  `field_blockTitle` text DEFAULT NULL,
  `field_copy` text DEFAULT NULL,
  `field_slideCategory` text DEFAULT NULL,
  `field_ctaCopy` text DEFAULT NULL,
  `field_contactStreetAddress` text DEFAULT NULL,
  `field_contactPhone` text DEFAULT NULL,
  `field_contactState` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_accentColor`, `field_blockTitle`, `field_copy`, `field_slideCategory`, `field_ctaCopy`, `field_contactStreetAddress`, `field_contactPhone`, `field_contactState`)
VALUES
	(1,1,1,NULL,'2019-06-29 17:33:17','2019-07-18 17:05:58','e293b92f-0562-4270-86cf-d62170bbc9ae',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,2,1,'Basic Pages','2019-06-29 22:13:15','2019-06-29 22:15:53','cfd5695b-88f6-4d20-9b28-11f0618bb974',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(3,3,1,'Man deliverying boxes.','2019-06-29 22:23:54','2019-07-21 19:18:09','33207202-663d-4300-82ea-4a2a1f5df97c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(4,4,1,'Test hero slide','2019-06-29 22:24:09','2019-06-29 23:21:53','3499a0bf-b5f3-46af-840d-8f359c8b0c61',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,5,1,'Business & Industries','2019-06-29 22:49:42','2019-07-09 00:37:37','e5606b23-1b82-4e54-9cd8-7a7643f71378','brandBlue','Business & Industries',NULL,NULL,NULL,NULL,NULL,NULL),
	(6,6,1,'Energy & Environmental','2019-06-29 22:50:04','2019-07-09 00:37:54','ac7834d2-13b8-41cd-b143-e3b345898262','brandGreen','Energy & Environmental',NULL,NULL,NULL,NULL,NULL,NULL),
	(7,7,1,'Opportunity & Development','2019-06-29 22:50:32','2019-07-09 00:37:59','f2d75daa-a95e-4a19-8a56-d035cbe4581d','brandOrange','Opportunity & Development',NULL,NULL,NULL,NULL,NULL,NULL),
	(8,8,1,'Philanthropy & Social Enterprise','2019-06-29 22:50:58','2019-07-09 00:38:16','82f1a5d0-7547-484c-bda8-9db3f75be92f','brandRed','Philanthropy & Social Enterprise',NULL,NULL,NULL,NULL,NULL,NULL),
	(9,9,1,'First Herousel','2019-06-29 23:06:49','2019-07-26 22:07:12','87067bec-b7c9-45ee-87f6-e2f4cbaa203c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(10,10,1,'Make the Most of Your Tactile Learning Style','2019-06-29 23:23:24','2019-07-25 14:08:54','409757c3-9193-40a4-96c1-ba2b6d7811d5',NULL,NULL,'According to some educational theorists, there are as many as nine different types of intelligence and multiple styles of learning.','Learning','Learn More',NULL,NULL,NULL),
	(11,11,1,'Programs','2019-06-30 01:47:37','2019-06-30 01:47:37','76bcd916-cca1-4aa8-868d-599a1eaa56a9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(12,12,1,'IDHS Global Leadership Network','2019-06-30 01:47:56','2019-06-30 01:47:56','b7fa36e8-e009-45f4-a30e-cced3bbbc664',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(13,13,1,'Global Innovators Group','2019-06-30 01:48:37','2019-06-30 01:48:42','ff4b7139-a594-49fb-964a-cf6c12286cad',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(14,14,1,'About Us','2019-06-30 01:49:17','2019-06-30 01:49:17','f19f9a39-50da-4d79-bce1-9b44d9535c59',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(15,15,1,'Events','2019-06-30 01:49:24','2019-06-30 01:49:24','cbf2b1ce-f0ff-4b1c-9229-ae16a79cff78',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(16,16,1,'Our People','2019-06-30 01:49:34','2019-06-30 01:49:34','39fb19f1-53e8-401a-b37d-cce1124d727c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(17,17,1,'Emerging Strategy Group','2019-06-30 01:55:01','2019-06-30 01:55:01','fce4b333-dbd3-457d-a276-695d8605e8fa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(18,18,1,'Board of Trustees','2019-06-30 01:55:21','2019-06-30 01:55:21','fea2e776-f51a-4d05-80c0-4a80e0a8efba',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(19,19,1,'New York, NY','2019-06-30 01:55:32','2019-06-30 01:55:32','cf0dd128-4eca-40b4-8cc9-8d4d117b5619',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(20,20,1,'History','2019-06-30 01:55:40','2019-06-30 01:55:40','08f8d497-b0ca-4c95-ad9b-a26ab5b29090',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(21,21,1,'Icon raised graph','2019-07-08 22:53:45','2019-07-08 22:53:50','2d23b873-1ed9-4ee1-bcc7-d83e13e89f38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(22,22,1,'Icon leaf','2019-07-08 23:30:22','2019-07-08 23:30:22','6a37ac81-d591-4c69-93e6-841e4d66727b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(23,23,1,'Icon two people','2019-07-08 23:30:41','2019-07-08 23:30:41','42b0c26e-7b84-4633-8961-98c96bf8d626',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(24,24,1,'Icon ribbon','2019-07-08 23:30:53','2019-07-08 23:30:53','cfd20ff7-fe97-4a5d-883f-d555a8110016',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(25,25,1,'Philanthropy & Social Enterprise','2019-07-12 12:24:07','2019-07-12 12:24:07','5fc19abe-c042-4b6d-b60d-ca167286e23c','brandRed','Philanthropy & Social Enterprise',NULL,NULL,NULL,NULL,NULL,NULL),
	(26,26,1,'Opportunity & Development','2019-07-12 12:24:07','2019-07-12 12:24:07','76a4e5f8-94d2-42ab-be59-44658322dd19','brandOrange','Opportunity & Development',NULL,NULL,NULL,NULL,NULL,NULL),
	(27,27,1,'Energy & Environmental','2019-07-12 12:24:07','2019-07-12 12:24:07','b7e01939-e9c0-45c1-80cd-47931ba0fdac','brandGreen','Energy & Environmental',NULL,NULL,NULL,NULL,NULL,NULL),
	(28,28,1,'Business & Industries','2019-07-12 12:24:07','2019-07-12 12:24:07','1ef1dea6-e737-48c4-a6db-b6512cd9f94a','brandBlue','Business & Industries',NULL,NULL,NULL,NULL,NULL,NULL),
	(29,29,1,'Philanthropy & Social Enterprise','2019-07-12 12:24:07','2019-07-12 12:24:07','16e50a0e-d36f-48a8-944e-9a815429eaf3','#ff2659','Philanthropy & Social Enterprise',NULL,NULL,NULL,NULL,NULL,NULL),
	(30,30,1,'Opportunity & Development','2019-07-12 12:24:07','2019-07-12 12:24:07','815b15ee-3e53-47c3-b6ca-a822f9d05877','#fb8f07','Opportunity & Development',NULL,NULL,NULL,NULL,NULL,NULL),
	(31,31,1,'Energy & Environmental','2019-07-12 12:24:07','2019-07-12 12:24:07','7fa447e0-2ba0-4434-a51c-fb458d833e6d','#00f000','Energy & Environmental',NULL,NULL,NULL,NULL,NULL,NULL),
	(32,32,1,'Business & Industries','2019-07-12 12:24:07','2019-07-12 12:24:07','03f9b87e-661d-45db-bbef-024badadcc19','#375cf5','Business & Industries',NULL,NULL,NULL,NULL,NULL,NULL),
	(33,33,1,'Business & Industries','2019-07-12 12:24:07','2019-07-12 12:24:08','faf39b95-1573-4649-b094-8c635834b47b','#375cf5','Business & Industries',NULL,NULL,NULL,NULL,NULL,NULL),
	(34,34,1,'Business & Industries','2019-07-12 12:24:08','2019-07-12 12:24:08','cd9f84e8-336b-4899-b725-211b1149048e','#375cf5','Business & Industries',NULL,NULL,NULL,NULL,NULL,NULL),
	(35,35,1,'Business & Industries','2019-07-12 12:24:08','2019-07-12 12:24:08','89980274-8c97-43a2-bbbb-6836019b9fad','#eee32f','Business & Industries',NULL,NULL,NULL,NULL,NULL,NULL),
	(36,36,1,'Business & Industries','2019-07-12 12:24:08','2019-07-12 12:24:08','80223eba-3dfa-4f4a-9ab3-619e4f6c48a4','#3a71f4','Business & Industries',NULL,NULL,NULL,NULL,NULL,NULL),
	(37,37,1,'Business & Industries','2019-07-12 12:24:08','2019-07-12 12:24:08','01bc369b-16fd-4684-a75f-5dc322e075ee','#3a71f4','Business & Industries',NULL,NULL,NULL,NULL,NULL,NULL),
	(38,38,1,'History','2019-07-12 12:24:08','2019-07-12 12:24:08','1eff3488-652c-4b9f-963f-adf65633c89d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(39,39,1,'New York, NY','2019-07-12 12:24:08','2019-07-12 12:24:08','6ca57abf-de81-43cf-8f9a-017a90b0a079',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(40,40,1,'Board of Trustees','2019-07-12 12:24:08','2019-07-12 12:24:08','fcc9c4d5-9f10-4b7e-926b-8af21488dfe8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(41,41,1,'Emerging Strategy Group','2019-07-12 12:24:08','2019-07-12 12:24:08','e4b8b829-511e-400c-8bcb-709c4420c51c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(42,42,1,'Our People','2019-07-12 12:24:08','2019-07-12 12:24:08','34195655-e7b8-4ff7-a982-1f6fbe7926bd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(43,43,1,'Events','2019-07-12 12:24:08','2019-07-12 12:24:08','857e1cdd-b392-4f2a-a983-11b6a078a2ad',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(44,44,1,'About Us','2019-07-12 12:24:08','2019-07-12 12:24:08','77cb66b4-2ef4-488c-9bde-8cdd138dfada',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(45,45,1,'Global Innovators Group','2019-07-12 12:24:08','2019-07-12 12:24:08','16d31aaa-43c2-4f54-8944-5eb03544de48',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(46,46,1,'IDHS Global Leadership Network','2019-07-12 12:24:08','2019-07-12 12:24:08','8046ce9d-6c00-400a-9848-1a414bd5c028',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(47,47,1,'Programs','2019-07-12 12:24:08','2019-07-12 12:24:08','6974c34d-a219-4720-ac26-f0be7fd70ccd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(48,48,1,'First Herousel','2019-07-12 12:24:08','2019-07-12 12:24:08','b5018cfb-7249-4c80-92cc-c8f7935d4df2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(49,49,1,'First Hero Slide','2019-07-12 12:24:08','2019-07-12 12:24:08','d78df3c7-8d14-4b7d-946e-c67d74665b9e',NULL,NULL,'This is the copy to my slide. There are going to be two sentences.\nThen there is going to be a break in the lines.','Learning','Learn More',NULL,NULL,NULL),
	(50,50,1,'First Herousel','2019-07-12 12:24:08','2019-07-12 12:24:08','52210c73-5d83-47ca-a712-651cbe2d16bf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(51,51,1,'Business & Industries','2019-07-12 12:24:08','2019-07-12 12:24:09','7538775b-967f-4deb-9598-d7188c465382','#3a71f4','Business & Industries',NULL,NULL,NULL,NULL,NULL,NULL),
	(52,52,1,'Energy & Environmental','2019-07-12 12:24:09','2019-07-12 12:24:09','18d3ee89-b521-40c3-ba11-3edfd1a89eef','#00f000','Energy & Environmental',NULL,NULL,NULL,NULL,NULL,NULL),
	(53,53,1,'Opportunity & Development','2019-07-12 12:24:09','2019-07-12 12:24:09','f589e280-7cbc-4529-9cfb-5397efa56a9e','#fb8f07','Opportunity & Development',NULL,NULL,NULL,NULL,NULL,NULL),
	(54,54,1,'Philanthropy & Social Enterprise','2019-07-12 12:24:09','2019-07-12 12:24:09','2d32e4cc-37c5-48e2-a715-4256b89976ac','#ff2659','Philanthropy & Social Enterprise',NULL,NULL,NULL,NULL,NULL,NULL),
	(55,55,1,'Opportunity & Development','2019-07-12 12:24:09','2019-07-12 12:24:09','1856b657-a0f3-4488-ab10-19c4fc9d33fb','#00f000','Opportunity & Development',NULL,NULL,NULL,NULL,NULL,NULL),
	(56,56,1,'Energy & Environmental','2019-07-12 12:24:09','2019-07-12 12:24:09','1c177d05-9cf2-41f7-aa95-9c5aa182ee6e','#3989f3','Energy & Environmental',NULL,NULL,NULL,NULL,NULL,NULL),
	(57,57,1,'Business & Industries','2019-07-12 12:24:09','2019-07-12 12:24:09','0bb3631b-7b51-4e9e-9ce8-35c727306f03','#e1dfed','Business & Industries',NULL,NULL,NULL,NULL,NULL,NULL),
	(58,58,1,'Do you want to go to outer space? Us too!','2019-07-12 13:42:27','2019-07-25 02:39:34','ec3ebd47-60ce-4744-96b1-aeaa98e2634f',NULL,NULL,'We have a deep desire to head up the great unknown and discover what else is out there.','Space','Learn More',NULL,NULL,NULL),
	(59,59,1,'Computer focal','2019-07-12 13:44:28','2019-07-12 13:44:28','0f309b96-4712-48f1-81d6-df74b71fc599',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(60,60,1,'Space Slide','2019-07-12 13:46:08','2019-07-12 13:46:08','225277a6-e2f5-4a7b-9a19-ef8f70f470be',NULL,NULL,'Do you want to go to outer space? Us too!','Space','Learn More',NULL,NULL,NULL),
	(61,61,1,'First Hero Slide','2019-07-12 13:47:40','2019-07-12 13:47:40','bca23a42-e72b-463d-a563-ec2772b59eb7',NULL,NULL,'This is the copy to my slide. There are going to be two sentences.\nThen there is going to be a break in the lines.','Learning','Learn More',NULL,NULL,NULL),
	(63,63,1,'Make the Most of Your Tactile Learning Style','2019-07-12 13:48:15','2019-07-12 13:48:15','aef32b7c-8a45-499f-be64-73ced5f25ce7',NULL,NULL,'According to some educational theorists, there are as many as nine different types of intelligence and multiple styles of learning.','Learning','Learn More',NULL,NULL,NULL),
	(65,65,1,'Do you want to go to outer space? Us too!','2019-07-12 13:48:58','2019-07-12 13:48:58','df354869-7b83-466d-bf53-306aeeb742dd',NULL,NULL,'We have a deep desire to head up the great unknown and discover what else is out there.','Space','Learn More',NULL,NULL,NULL),
	(67,67,1,'First Herousel','2019-07-12 13:49:06','2019-07-12 13:49:06','5d30aaa5-216f-4523-8e6d-2082b11091c9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(68,68,1,'Header Provision','2019-07-12 15:26:02','2019-07-12 15:26:11','98844017-effb-4a3e-92df-5285a965963c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(69,69,1,NULL,'2019-07-12 15:26:33','2019-07-12 15:26:33','5ddee67a-2637-4fb9-8894-7f451ca44098',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(70,70,1,'Header Provision','2019-07-12 15:27:04','2019-07-12 16:12:48','1ff82464-67ae-4575-be4b-6815d6e7d1b6',NULL,NULL,'I have hinted that I would often jerk poor Queequeg from between the whale.',NULL,NULL,NULL,NULL,NULL),
	(71,71,1,'Header Provision','2019-07-12 15:27:35','2019-07-12 15:27:35','1175829a-6c9e-4b93-b18b-3cad247364b0',NULL,NULL,'I have hinted that I would often jerk poor Queequeg from between the whale.',NULL,NULL,NULL,NULL,NULL),
	(72,72,1,'Image Card 2','2019-07-12 15:31:01','2019-07-12 16:12:48','fa45bf62-d94d-4b03-8202-8a2ed6407c80',NULL,NULL,'This is some good ole\' lorem ipsum dolor sit amet.',NULL,NULL,NULL,NULL,NULL),
	(73,73,1,'Image Card 2','2019-07-12 15:31:20','2019-07-12 15:31:20','fd604123-5f4d-4752-81f5-677cc420eaf6',NULL,NULL,'This is some good ole\' lorem ipsum dolor sit amet.',NULL,NULL,NULL,NULL,NULL),
	(74,74,1,'Image Card 3','2019-07-12 15:32:41','2019-07-12 16:12:48','30f56143-f653-40b1-93bc-bd5fbef7ee33',NULL,NULL,'This is some good ole\' lorem ipsum dolor sit amet.',NULL,NULL,NULL,NULL,NULL),
	(75,75,1,'Image Card 2 copy','2019-07-12 15:32:41','2019-07-12 15:32:41','9960dbfc-5cc0-4275-af22-595015a9168b',NULL,NULL,'This is some good ole\' lorem ipsum dolor sit amet.',NULL,NULL,NULL,NULL,NULL),
	(77,77,1,'Urban area','2019-07-12 15:34:05','2019-07-12 15:34:05','3e3c89dc-9ebe-481b-a619-6b61188068ea',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(78,78,1,'Image Card 3','2019-07-12 15:34:11','2019-07-12 15:34:11','f1318928-69ea-4a58-a39a-290c23dad18c',NULL,NULL,'This is some good ole\' lorem ipsum dolor sit amet.',NULL,NULL,NULL,NULL,NULL),
	(79,79,1,NULL,'2019-07-12 15:44:31','2019-07-12 15:44:31','8348a017-b2c3-472e-a168-94389b009d24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(80,80,1,'Redefining Traditional Learning in the Digital Age','2019-07-12 15:45:10','2019-07-12 16:03:54','52eaefc0-caca-4954-bc06-ab94d77a72b8',NULL,NULL,'Lorem ipsum dolor sit amet...',NULL,NULL,NULL,NULL,NULL),
	(81,81,1,'Redefining Traditional Learning in the Digital Age','2019-07-12 15:45:56','2019-07-12 15:45:56','ba6d6219-65fb-42a5-942e-a5b1a1cdd780',NULL,NULL,'Lorem ipsum dolor sit amet...',NULL,NULL,NULL,NULL,NULL),
	(82,82,1,'Leading the Transformation of Local Infrastructure','2019-07-12 15:46:12','2019-07-12 16:03:54','b185a257-e5db-48d1-ad2f-7c198145f798',NULL,NULL,'Lorem ipsum dolor sit amet...',NULL,NULL,NULL,NULL,NULL),
	(83,83,1,'Leading the Transformation of Local Infrastructure','2019-07-12 15:46:50','2019-07-12 15:46:50','aa5e3b05-876d-4726-b3c5-179c051806c8',NULL,NULL,'Lorem ipsum dolor sit amet...',NULL,NULL,NULL,NULL,NULL),
	(84,84,1,'Development','2019-07-12 15:49:53','2019-07-12 15:50:05','73b9ea51-776b-4252-8f6a-9591204fa5e4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(85,85,1,'Design','2019-07-12 15:49:59','2019-07-12 15:49:59','7999b271-6924-4c9c-aff7-a9cb00e11fa4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(87,87,1,'Leading the Transformation of Local Infrastructure','2019-07-12 15:50:51','2019-07-12 15:50:51','2f02d92c-b234-431c-9e0e-3f02125a7a37',NULL,NULL,'Lorem ipsum dolor sit amet...',NULL,NULL,NULL,NULL,NULL),
	(89,89,1,'Redefining Traditional Learning in the Digital Age','2019-07-12 15:50:58','2019-07-12 15:50:58','e07c2603-a8de-450a-aaa0-8f21d211081c',NULL,NULL,'Lorem ipsum dolor sit amet...',NULL,NULL,NULL,NULL,NULL),
	(90,90,1,NULL,'2019-07-12 16:29:56','2019-07-12 16:36:12','8a7800db-8dda-4a05-a583-8f74e1959dfb',NULL,NULL,NULL,NULL,NULL,'1211 Avenue of the Americas','(212) 580-1000','New York, NY 1001'),
	(91,91,1,'Pages','2019-07-15 20:28:28','2019-07-15 20:29:03','4bb231f4-00b3-4730-95cf-31dc8727f451',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(93,93,1,'Pages','2019-07-15 20:29:03','2019-07-15 20:29:03','a01f65ee-fe68-4608-b1a0-dc52f27ce820',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(94,94,1,'Pages','2019-07-15 20:29:03','2019-07-15 20:29:03','810af0d7-34de-4879-b451-f4acf671bad2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(95,95,1,'Home Page','2019-07-21 18:35:52','2019-07-25 00:41:57','07dee2c3-1708-45d0-977a-ea444d890f90',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(96,96,1,'Home Page','2019-07-25 00:42:15','2019-07-25 00:42:44','5448c332-1ae7-4185-bec9-79f8655de84f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(97,97,1,'Home Page','2019-07-25 00:42:15','2019-07-25 00:42:15','5d4ae9e3-89a7-47b9-8cf3-1dc5b64d71f7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(98,98,1,'Home Page','2019-07-25 00:42:44','2019-07-25 00:42:44','7613b449-0511-4680-b5fd-f4705c788977',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(99,99,1,'Home Page','2019-07-25 00:44:17','2019-07-25 14:15:52','bbf72e55-60e1-477f-a8fc-df44219873ff',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(100,100,1,'Home Page','2019-07-25 00:44:17','2019-07-25 00:44:17','e8b9bf40-d14d-4718-9c08-cc862ab1dbdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(101,101,1,'Home Page','2019-07-25 00:44:33','2019-07-25 00:44:33','64aef51a-5a83-41e5-9df1-3921e6e0fcc6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(102,102,1,'Home Page','2019-07-25 00:44:41','2019-07-25 00:44:41','5c04cac9-2355-4f31-a73c-a6056de6a6d7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(103,103,1,'People walking on painted streets','2019-07-25 02:36:52','2019-07-25 02:36:52','dce00230-b548-4f62-9757-82ef0a7fc536',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(104,104,1,'Make the Most of Your Tactile Learning Style','2019-07-25 02:39:41','2019-07-25 02:39:41','6280b0ed-2156-405f-a688-270e208b7e3f',NULL,NULL,'According to some educational theorists, there are as many as nine different types of intelligence and multiple styles of learning.','Learning','Learn More',NULL,NULL,NULL),
	(105,105,1,'Make the Most of Your Tactile Learning Style','2019-07-25 14:08:54','2019-07-25 14:08:54','0a3337a2-bfed-45c9-ad78-dc5433c450ed',NULL,NULL,'According to some educational theorists, there are as many as nine different types of intelligence and multiple styles of learning.','Learning','Learn More',NULL,NULL,NULL),
	(106,106,1,'Home Page','2019-07-25 14:15:52','2019-07-25 14:15:52','af35e444-e31d-45e7-b169-a259b3eddfc6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(107,107,1,'First Herousel','2019-07-26 22:07:12','2019-07-26 22:07:12','a3b40e5e-bc1f-4237-86c8-493b720807dc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table craftidtokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `craftidtokens`;

CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table deprecationerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deprecationerrors`;

CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table drafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drafts`;

CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;

INSERT INTO `drafts` (`id`, `sourceId`, `creatorId`, `name`, `notes`)
VALUES
	(5,NULL,1,'First draft',''),
	(6,NULL,1,'First draft',NULL),
	(10,NULL,1,'First draft',NULL);

/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elementindexsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elementindexsettings`;

CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;

INSERT INTO `elementindexsettings` (`id`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'craft\\elements\\Entry','{\"sourceOrder\":[[\"key\",\"*\"],[\"heading\",\"Header Navigation\"],[\"key\",\"section:acc864f2-7951-4b85-8639-f771df381a56\"],[\"key\",\"section:3d68d8a0-b786-405c-8b3c-d3ed8c4b93f8\"],[\"heading\",\"Herousel\"],[\"key\",\"section:06021517-c456-4337-a55c-342f170b509e\"],[\"key\",\"section:f4806157-8213-4481-a5ca-4697ca313dfe\"],[\"heading\",\"Emerging Perspectives\"],[\"key\",\"section:85f5118f-dd13-45cc-a0f4-e49d61bab613\"],[\"heading\",\"Digital Insights\"],[\"key\",\"section:66a3cf92-176e-4832-aa38-7dae6e1c0893\"],[\"heading\",\"Pages\"],[\"key\",\"singles\"]],\"sources\":{\"section:f4806157-8213-4481-a5ca-4697ca313dfe\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"link\"}},\"*\":{\"tableAttributes\":{\"1\":\"section\",\"2\":\"postDate\",\"3\":\"expiryDate\",\"4\":\"link\"}},\"section:acc864f2-7951-4b85-8639-f771df381a56\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"link\"}},\"section:06021517-c456-4337-a55c-342f170b509e\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"link\"}},\"section:3d68d8a0-b786-405c-8b3c-d3ed8c4b93f8\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"link\"}},\"section:85f5118f-dd13-45cc-a0f4-e49d61bab613\":{\"tableAttributes\":{\"1\":\"field:8\",\"2\":\"id\"}},\"section:66a3cf92-176e-4832-aa38-7dae6e1c0893\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"link\"}},\"singles\":{\"tableAttributes\":{\"1\":\"author\",\"2\":\"link\",\"3\":\"uri\"}}}}','2019-07-21 19:35:05','2019-07-21 19:35:05','0a4b709d-d13b-4e89-b9e6-9d9f6debff4d');

/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements`;

CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;

INSERT INTO `elements` (`id`, `draftId`, `revisionId`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2019-06-29 17:33:17','2019-07-18 17:05:58',NULL,'be1a2284-fe60-4830-8564-b799382b504c'),
	(2,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-06-29 22:13:15','2019-06-29 22:15:53','2019-06-29 22:15:53','c3278ec5-94d5-40a1-8a04-f1ca04a82586'),
	(3,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2019-06-29 22:23:54','2019-07-21 19:18:09',NULL,'ac8d3164-bcd8-4531-8bb5-770d8ee2cd34'),
	(4,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2019-06-29 22:24:09','2019-06-29 23:21:53','2019-06-29 23:22:25','e93bba1a-e7be-44d8-8677-1c702354950d'),
	(5,NULL,NULL,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:49:42','2019-07-09 00:37:37',NULL,'49e9cd1f-51f2-48df-af1b-36f48d1427e9'),
	(6,NULL,NULL,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:50:04','2019-07-09 00:37:54',NULL,'2a1131aa-7133-495b-afb2-77803ffc74ca'),
	(7,NULL,NULL,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:50:32','2019-07-09 00:37:59',NULL,'05282b44-f464-40d6-9926-9f4514abcd56'),
	(8,NULL,NULL,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:50:58','2019-07-09 00:38:16',NULL,'8cc61ae5-a51a-4a65-b3d9-c4de946f57d3'),
	(9,NULL,NULL,3,'craft\\elements\\Entry',1,0,'2019-06-29 23:06:49','2019-07-26 22:07:12',NULL,'809f519d-55d0-4f92-b79e-1f498542a2d5'),
	(10,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2019-06-29 23:23:24','2019-07-25 14:08:54',NULL,'acdfdb40-fd89-4477-814a-93b800870268'),
	(11,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:47:37','2019-06-30 01:47:37',NULL,'ceb30a59-ce72-4a23-8033-e8c0922b3cb7'),
	(12,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:47:56','2019-06-30 01:47:56',NULL,'f6cb7fac-8922-4268-868a-b8b6e4a2ea46'),
	(13,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:48:37','2019-06-30 01:48:42',NULL,'d50f512d-0eb4-46fa-b177-9720be6a36f5'),
	(14,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:49:17','2019-06-30 01:49:17',NULL,'6680301c-64f4-4e21-9272-ce0737efa1cf'),
	(15,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:49:24','2019-06-30 01:49:24',NULL,'c1a2e394-fd61-4dc3-acd3-433ab95821ce'),
	(16,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:49:34','2019-06-30 01:49:34',NULL,'1f401885-f046-4247-bc7f-cd5b8d8217cb'),
	(17,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:55:01','2019-06-30 01:55:01',NULL,'0e92d0e9-f51b-4380-9f1a-7d11d71e22a0'),
	(18,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:55:21','2019-06-30 01:55:21',NULL,'0ad52a56-df58-4832-80d1-1a0c4d931497'),
	(19,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:55:32','2019-06-30 01:55:32',NULL,'5569b3a7-036e-40bd-b149-a42756a917f3'),
	(20,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:55:40','2019-06-30 01:55:40',NULL,'37319eda-f4ab-4664-9504-c984b149c423'),
	(21,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2019-07-08 22:53:45','2019-07-08 22:53:50',NULL,'8f9cdd9c-2345-416e-841e-0fad32a79e63'),
	(22,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2019-07-08 23:30:22','2019-07-08 23:30:22',NULL,'799ad0b1-1d40-4deb-98eb-485da31fcdcb'),
	(23,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2019-07-08 23:30:41','2019-07-08 23:30:41',NULL,'07d00430-10d3-40ce-84b7-bdddaedc6d15'),
	(24,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2019-07-08 23:30:53','2019-07-08 23:30:53',NULL,'c96c3480-6575-43d4-957c-978cd957f68c'),
	(25,NULL,1,2,'craft\\elements\\Entry',1,0,'2019-07-09 00:38:16','2019-07-12 12:24:07',NULL,'4c6d9e08-fb75-42e3-a863-c6c90decb40d'),
	(26,NULL,2,2,'craft\\elements\\Entry',1,0,'2019-07-09 00:37:59','2019-07-12 12:24:07',NULL,'160bb9bd-910a-4f2c-a9ea-756ad6eea22f'),
	(27,NULL,3,2,'craft\\elements\\Entry',1,0,'2019-07-09 00:37:54','2019-07-12 12:24:07',NULL,'5ce6e608-8695-4034-b767-6c2ab0cd7ff4'),
	(28,NULL,4,2,'craft\\elements\\Entry',1,0,'2019-07-09 00:37:37','2019-07-12 12:24:07',NULL,'705a44c6-6dc8-4a41-abc0-7e27eb9ce2fd'),
	(29,NULL,5,2,'craft\\elements\\Entry',1,0,'2019-07-08 23:31:00','2019-07-12 12:24:07',NULL,'0c0af8e2-1d53-49bd-9782-eb23a656d7d1'),
	(30,NULL,6,2,'craft\\elements\\Entry',1,0,'2019-07-08 23:30:43','2019-07-12 12:24:07',NULL,'2e4a3652-72eb-4686-9f2d-b610d252828d'),
	(31,NULL,7,2,'craft\\elements\\Entry',1,0,'2019-07-08 23:30:26','2019-07-12 12:24:07',NULL,'3d27fb8a-de3e-4013-a9a4-950224329b71'),
	(32,NULL,8,2,'craft\\elements\\Entry',1,0,'2019-07-08 23:30:07','2019-07-12 12:24:07',NULL,'dfac19d2-7404-468c-9593-a8f9f48a94ba'),
	(33,NULL,9,2,'craft\\elements\\Entry',1,0,'2019-07-08 22:53:50','2019-07-12 12:24:08',NULL,'d628f210-fec9-4dbe-ae83-3953d9d450c2'),
	(34,NULL,10,2,'craft\\elements\\Entry',1,0,'2019-06-30 02:59:07','2019-07-12 12:24:08',NULL,'f821d787-349f-4778-88a7-79faf7df10cc'),
	(35,NULL,11,2,'craft\\elements\\Entry',1,0,'2019-06-30 02:58:55','2019-07-12 12:24:08',NULL,'d46c88d4-9b6b-43d7-9e1b-45e0150304ec'),
	(36,NULL,12,2,'craft\\elements\\Entry',1,0,'2019-06-30 02:53:15','2019-07-12 12:24:08',NULL,'51145ff4-9064-47e0-b8b3-93050e31567f'),
	(37,NULL,13,2,'craft\\elements\\Entry',1,0,'2019-06-30 02:47:56','2019-07-12 12:24:08',NULL,'67e7a216-b6d1-432d-be1b-3258c2a4da42'),
	(38,NULL,14,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:55:40','2019-07-12 12:24:08',NULL,'c7d4f773-4d59-46e2-9673-63febe5d8841'),
	(39,NULL,15,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:55:32','2019-07-12 12:24:08',NULL,'b27e4551-4f73-42cf-a1b8-9f2e1aa9c17b'),
	(40,NULL,16,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:55:21','2019-07-12 12:24:08',NULL,'4a4e31f2-44d8-48a6-985e-cac48334e432'),
	(41,NULL,17,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:55:01','2019-07-12 12:24:08',NULL,'5f2fa5e8-f73e-4665-b0b1-b621ea5df10e'),
	(42,NULL,18,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:49:34','2019-07-12 12:24:08',NULL,'e29cc69b-271c-4c1b-9b09-bc180dc08378'),
	(43,NULL,19,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:49:24','2019-07-12 12:24:08',NULL,'845048a6-a20f-4a67-8d78-7b0a10215b04'),
	(44,NULL,20,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:49:18','2019-07-12 12:24:08',NULL,'374fab40-badb-42ec-bd77-8f3dfce60ab8'),
	(45,NULL,21,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:48:37','2019-07-12 12:24:08',NULL,'4f3f2bff-9ff3-4044-8fe8-274998304f67'),
	(46,NULL,22,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:47:56','2019-07-12 12:24:08',NULL,'89d5b74d-fd08-4362-9924-5eb5ffff67e8'),
	(47,NULL,23,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:47:37','2019-07-12 12:24:08',NULL,'e763f487-eb87-4e40-8c80-99e442acb849'),
	(48,NULL,24,3,'craft\\elements\\Entry',1,0,'2019-06-29 23:23:36','2019-07-12 12:24:08',NULL,'3ef6d5ca-5f14-49eb-89a9-b79423085e8f'),
	(49,NULL,25,1,'craft\\elements\\Entry',1,0,'2019-06-29 23:23:24','2019-07-12 12:24:08',NULL,'2e009e14-a89a-4d7e-bfec-3166f5738666'),
	(50,NULL,26,3,'craft\\elements\\Entry',1,0,'2019-06-29 23:06:49','2019-07-12 12:24:08',NULL,'5167e93f-d4d9-4329-b81d-d7bcfb792bf8'),
	(51,NULL,27,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:51:32','2019-07-12 12:24:09',NULL,'4f9cdcca-52c6-4e60-9399-54087f6a926c'),
	(52,NULL,28,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:51:24','2019-07-12 12:24:09',NULL,'3595bdbe-56b6-4928-b3b3-a8dbc8a4c9df'),
	(53,NULL,29,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:51:13','2019-07-12 12:24:09',NULL,'61a5fd05-9a70-487e-87e5-ec78ff32e71e'),
	(54,NULL,30,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:50:58','2019-07-12 12:24:09',NULL,'de7e8af2-1710-4cd3-849c-a3090a2be42f'),
	(55,NULL,31,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:50:32','2019-07-12 12:24:09',NULL,'6852f00f-2ffe-48cb-84ee-d3c5c6280a42'),
	(56,NULL,32,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:50:05','2019-07-12 12:24:09',NULL,'8c6f5251-e7c0-48d4-8f57-5f6ef43f2719'),
	(57,NULL,33,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:49:42','2019-07-12 12:24:09',NULL,'5e4d3bc1-fb16-46a0-b67a-6f4a58d69cb7'),
	(58,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2019-07-12 13:42:27','2019-07-12 13:48:58',NULL,'c1eb77af-517f-413c-af0e-23c35489d01d'),
	(59,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2019-07-12 13:44:28','2019-07-12 13:44:28',NULL,'e6ad2457-87db-4856-ba86-fcad85e417df'),
	(60,NULL,34,1,'craft\\elements\\Entry',1,0,'2019-07-12 13:46:08','2019-07-12 13:46:08',NULL,'361a0a61-be82-4e51-a072-55e653f1f076'),
	(61,NULL,35,1,'craft\\elements\\Entry',1,0,'2019-06-29 23:23:28','2019-06-29 23:23:28',NULL,'4e37c777-7ec0-4c6b-8684-3dbdb98b1ec8'),
	(63,NULL,36,1,'craft\\elements\\Entry',1,0,'2019-07-12 13:48:15','2019-07-12 13:48:15',NULL,'5a394d7c-c7c6-4cc8-96ee-509b43a347cd'),
	(65,NULL,37,1,'craft\\elements\\Entry',1,0,'2019-07-12 13:48:58','2019-07-12 13:48:58',NULL,'5e692606-a05f-43c8-b8f7-4605fa04a276'),
	(67,NULL,38,3,'craft\\elements\\Entry',1,0,'2019-07-12 13:49:06','2019-07-12 13:49:06',NULL,'7f0198b2-ad6d-40dd-804b-8e96c9d98dc5'),
	(68,5,NULL,4,'craft\\elements\\Entry',1,0,'2019-07-12 15:26:02','2019-07-12 15:26:11',NULL,'b8fb1578-5cfb-494b-b947-5d734c571c80'),
	(69,6,NULL,4,'craft\\elements\\Entry',1,0,'2019-07-12 15:26:33','2019-07-12 15:26:33',NULL,'e32e3a64-38be-4aec-9e53-45e34a82fad2'),
	(70,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2019-07-12 15:27:04','2019-07-12 15:27:35',NULL,'e0b42d82-69ca-47cf-83b1-3ec3e58da719'),
	(71,NULL,39,4,'craft\\elements\\Entry',1,0,'2019-07-12 15:27:35','2019-07-12 15:27:35',NULL,'821101f5-cc61-4b6a-b294-02ebaf29e48e'),
	(72,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2019-07-12 15:31:01','2019-07-12 15:31:20',NULL,'fe2e4b79-afaf-4341-a51f-5e0a6fdd667b'),
	(73,NULL,40,4,'craft\\elements\\Entry',1,0,'2019-07-12 15:31:20','2019-07-12 15:31:20',NULL,'c1fcad49-b0c5-4d60-8a90-12b9431a8968'),
	(74,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2019-07-12 15:31:01','2019-07-12 15:34:11',NULL,'07da0378-2c46-4e4a-b276-cd83f235e4c6'),
	(75,NULL,41,4,'craft\\elements\\Entry',1,0,'2019-07-12 15:31:20','2019-07-12 15:31:20',NULL,'e089e92c-ab84-401a-b90e-6c7dfea33026'),
	(77,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2019-07-12 15:34:05','2019-07-12 15:34:05',NULL,'f45a3e49-fbc2-4252-a6e3-1d0fc7f09c4f'),
	(78,NULL,42,4,'craft\\elements\\Entry',1,0,'2019-07-12 15:34:11','2019-07-12 15:34:11',NULL,'d1283089-c258-4c1d-9afb-04107bd6c5c3'),
	(79,10,NULL,5,'craft\\elements\\Entry',1,0,'2019-07-12 15:44:31','2019-07-12 15:44:31',NULL,'e15e693a-a5c1-42c0-afbb-f6be275840ae'),
	(80,NULL,NULL,5,'craft\\elements\\Entry',1,0,'2019-07-12 15:45:10','2019-07-12 15:50:58',NULL,'dee6a8ba-a063-49aa-a473-bd95071af759'),
	(81,NULL,43,5,'craft\\elements\\Entry',1,0,'2019-07-12 15:45:56','2019-07-12 15:45:56',NULL,'acb42fef-800e-48a1-9afa-e75d173f213f'),
	(82,NULL,NULL,5,'craft\\elements\\Entry',1,0,'2019-07-12 15:46:12','2019-07-12 15:50:51',NULL,'245fec3d-0a5c-420f-8fb1-224bfb9cf2e8'),
	(83,NULL,44,5,'craft\\elements\\Entry',1,0,'2019-07-12 15:46:50','2019-07-12 15:46:50',NULL,'41d5fac9-e07d-41b8-8478-eaa9497407f2'),
	(84,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-07-12 15:49:53','2019-07-12 15:50:05',NULL,'448a6e11-e794-44c4-8f92-73795eea5566'),
	(85,NULL,NULL,NULL,'craft\\elements\\Category',1,0,'2019-07-12 15:49:59','2019-07-12 15:49:59',NULL,'09f6436f-6f6c-4a69-a8ac-6c7f35b5a91d'),
	(87,NULL,45,5,'craft\\elements\\Entry',1,0,'2019-07-12 15:50:51','2019-07-12 15:50:51',NULL,'cb7b2e3e-ec3c-4a04-b9bd-3ef0e2153104'),
	(89,NULL,46,5,'craft\\elements\\Entry',1,0,'2019-07-12 15:50:58','2019-07-12 15:50:58',NULL,'72f0d2c3-b52a-46c4-8388-642f7e07b6f0'),
	(90,NULL,NULL,6,'craft\\elements\\GlobalSet',1,0,'2019-07-12 16:29:56','2019-07-12 16:36:12',NULL,'2cdb6263-8e70-47fa-a8d8-e0f7178e1fb6'),
	(91,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-07-15 20:28:28','2019-07-15 20:29:03','2019-07-15 20:29:03','96689ce3-1a08-4fad-8c3c-75b56cb66e1a'),
	(93,NULL,48,NULL,'craft\\elements\\Entry',1,0,'2019-07-15 20:28:28','2019-07-15 20:28:28',NULL,'c7b81ef5-bb8b-4524-b23a-76cfa6eaf3b5'),
	(94,NULL,49,NULL,'craft\\elements\\Entry',1,0,'2019-07-15 20:29:03','2019-07-15 20:29:03',NULL,'c8d8d725-1d5c-44a3-883f-3898e331de79'),
	(95,NULL,NULL,8,'craft\\elements\\Entry',1,0,'2019-07-21 18:35:52','2019-07-25 00:41:57','2019-07-25 00:41:57','54877182-935d-40f7-820a-02d75c2c927f'),
	(96,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-07-25 00:42:15','2019-07-25 00:42:44','2019-07-25 00:42:44','7705a5bc-ba47-451d-b94c-2037e420f82c'),
	(97,NULL,50,NULL,'craft\\elements\\Entry',1,0,'2019-07-25 00:42:15','2019-07-25 00:42:15',NULL,'98431cff-b74b-4de3-9789-2329c6080e14'),
	(98,NULL,51,NULL,'craft\\elements\\Entry',1,0,'2019-07-25 00:42:44','2019-07-25 00:42:44',NULL,'902fa80c-6e33-46d4-84de-d9d8453b95af'),
	(99,NULL,NULL,9,'craft\\elements\\Entry',1,0,'2019-07-25 00:44:17','2019-07-25 14:15:52',NULL,'8003eaaa-394e-4f19-9999-63ad0196f3b1'),
	(100,NULL,52,NULL,'craft\\elements\\Entry',1,0,'2019-07-25 00:44:17','2019-07-25 00:44:17',NULL,'21633e12-8f1c-48c3-b442-769388f0c797'),
	(101,NULL,53,NULL,'craft\\elements\\Entry',1,0,'2019-07-25 00:44:33','2019-07-25 00:44:33',NULL,'0b7690aa-a175-499c-8392-8d001c4c88df'),
	(102,NULL,54,9,'craft\\elements\\Entry',1,0,'2019-07-25 00:44:41','2019-07-25 00:44:41',NULL,'4a627023-4b16-465a-a334-5b9e43779b10'),
	(103,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2019-07-25 02:36:52','2019-07-25 02:36:52',NULL,'00f4da44-5146-4f0b-b914-7a9e78d5f4f9'),
	(104,NULL,55,1,'craft\\elements\\Entry',1,0,'2019-07-25 02:39:41','2019-07-25 02:39:41',NULL,'0859904e-42d1-4895-9d1f-2b16307f2e9d'),
	(105,NULL,56,1,'craft\\elements\\Entry',1,0,'2019-07-25 14:08:54','2019-07-25 14:08:54',NULL,'9ce35f45-c4c2-42f8-98bd-5e63a4fcb90c'),
	(106,NULL,57,9,'craft\\elements\\Entry',1,0,'2019-07-25 14:15:52','2019-07-25 14:15:52',NULL,'c4fb5cf5-5a8c-4d59-899f-96845b625ed2'),
	(107,NULL,58,3,'craft\\elements\\Entry',1,0,'2019-07-26 22:07:12','2019-07-26 22:07:12',NULL,'115f93a6-cce9-4ce2-afee-992f09af3337');

/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements_sites`;

CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;

INSERT INTO `elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,NULL,1,'2019-06-29 17:33:17','2019-06-29 17:33:17','af836eb5-272f-41dd-be27-c39949101e37'),
	(2,2,1,'basic-pages','__home__',1,'2019-06-29 22:13:15','2019-06-29 22:15:53','dae750b9-08dd-45b6-a8b8-47d8b2256a8a'),
	(3,3,1,NULL,NULL,1,'2019-06-29 22:23:54','2019-06-29 22:24:09','50c1f188-1287-4d4a-a691-b463342418c5'),
	(4,4,1,'test-hero-slide',NULL,1,'2019-06-29 22:24:09','2019-06-29 23:21:53','636e078a-3c0d-462c-a692-1215ddcb043e'),
	(5,5,1,'business-industries',NULL,1,'2019-06-29 22:49:42','2019-07-12 13:16:41','e3993d78-506c-4073-90bb-6192b9867344'),
	(6,6,1,'energy-environmental',NULL,1,'2019-06-29 22:50:04','2019-07-12 13:16:31','29e47996-5570-4f7b-970e-7780116d22a5'),
	(7,7,1,'opportunity-development',NULL,1,'2019-06-29 22:50:32','2019-07-09 00:37:59','f1593a4f-50f0-4442-81eb-83ee3a6d1dcb'),
	(8,8,1,'philanthropy-social-enterprise',NULL,1,'2019-06-29 22:50:58','2019-07-09 00:38:16','cffa708f-e0df-4375-b244-5779657b9bc6'),
	(9,9,1,'first-herousel',NULL,1,'2019-06-29 23:06:49','2019-06-29 23:23:36','7ca57260-1963-41e6-8dfa-1ab917d76133'),
	(10,10,1,'first-hero-slide',NULL,1,'2019-06-29 23:23:24','2019-06-29 23:23:28','c759b15c-3b4a-409c-9b67-e66198353d84'),
	(11,11,1,'programs',NULL,1,'2019-06-30 01:47:37','2019-07-12 13:16:14','d8594709-3555-4da5-a81f-9d8f8c8b5ffc'),
	(12,12,1,'idhs-global-leadership-network',NULL,1,'2019-06-30 01:47:56','2019-07-12 13:14:26','ef2a44f2-7eb1-449c-9fdb-501a38458243'),
	(13,13,1,'global-innovators-group',NULL,1,'2019-06-30 01:48:37','2019-07-12 13:14:18','967dd604-41be-4994-839a-7dbb84c72249'),
	(14,14,1,'about-us',NULL,1,'2019-06-30 01:49:17','2019-06-30 01:49:18','6f6c7be1-1067-4f4f-8442-f0ee01efe0e0'),
	(15,15,1,'events',NULL,1,'2019-06-30 01:49:24','2019-06-30 01:49:39','d2090c17-8890-4a85-8e50-89b1459d18bf'),
	(16,16,1,'our-people',NULL,1,'2019-06-30 01:49:34','2019-06-30 01:49:38','5a8d31b7-8310-43a3-aa2b-ab81c6a7d35e'),
	(17,17,1,'emerging-strategy-group',NULL,1,'2019-06-30 01:55:01','2019-06-30 01:55:01','85384048-8e4b-4522-be18-9c1ee640f700'),
	(18,18,1,'board-of-trustees',NULL,1,'2019-06-30 01:55:21','2019-06-30 01:55:22','bdad454a-e1d4-4fcf-ae81-1cbf0934f17d'),
	(19,19,1,'new-york-ny',NULL,1,'2019-06-30 01:55:32','2019-06-30 01:55:32','60ba70c9-ddef-462f-b9e0-a2c4c36893bf'),
	(20,20,1,'history',NULL,1,'2019-06-30 01:55:40','2019-06-30 01:55:40','ffdf89e4-85a6-480e-bf55-b2aa69468e61'),
	(21,21,1,NULL,NULL,1,'2019-07-08 22:53:45','2019-07-08 22:53:50','d3a0eb5e-2bd3-431d-a74d-3f6b31ea3cb2'),
	(22,22,1,NULL,NULL,1,'2019-07-08 23:30:22','2019-07-08 23:30:22','355e79af-2fe3-4c65-899b-6131b94f8a62'),
	(23,23,1,NULL,NULL,1,'2019-07-08 23:30:41','2019-07-08 23:30:41','de527ab1-ec52-4a43-809a-4a1865f164ad'),
	(24,24,1,NULL,NULL,1,'2019-07-08 23:30:53','2019-07-08 23:30:53','fd053c73-83d5-41c4-b1a8-2c0b3826068c'),
	(25,25,1,'philanthropy-social-enterprise',NULL,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','f230b988-e30b-42dd-b125-a02b56ae98f2'),
	(26,26,1,'opportunity-development',NULL,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','12aa2466-863a-4757-9ce7-6b1edc116645'),
	(27,27,1,'energy-environmental',NULL,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','57447e6f-c4cb-4d57-81f8-4bc11bdf8431'),
	(28,28,1,'business-industries',NULL,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','68f119ea-fbe8-416f-893a-8b28275ae94a'),
	(29,29,1,'philanthropy-social-enterprise',NULL,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','1789c2c9-5c5e-4752-aeaa-e4947b1844bb'),
	(30,30,1,'opportunity-development',NULL,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','75991759-9994-42aa-9c6f-31ad37ea1d09'),
	(31,31,1,'energy-environmental',NULL,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','78f4a790-e09a-46ff-95ed-aad412c70dd4'),
	(32,32,1,'business-industries',NULL,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','9af418b4-c70f-4c9c-8f59-60a105757a53'),
	(33,33,1,'business-industries',NULL,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','c213ee30-bc99-4b04-870b-96f4610767a5'),
	(34,34,1,'business-industries',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','b59d67c2-0068-4b02-a81c-03c266bd8125'),
	(35,35,1,'business-industries',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','4ebf936d-6585-43d3-a58b-5c594af948ff'),
	(36,36,1,'business-industries',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','f3f649ee-2835-40b6-8e0b-85460e432d7a'),
	(37,37,1,'business-industries',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','49c264bb-41e3-4e80-8c57-26afae9216e1'),
	(38,38,1,'history',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','0e03167e-061b-408a-ac8e-90b0f16c9069'),
	(39,39,1,'new-york-ny',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','2cb50133-1f7b-4c9b-bee4-7a225e1d0650'),
	(40,40,1,'board-of-trustees',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','adbeb5d5-dd9a-4f1c-90f8-ca6f9193ab38'),
	(41,41,1,'emerging-strategy-group',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','5f09fc5c-5746-49b8-89d1-86d29c8449f8'),
	(42,42,1,'our-people',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','5605f3c1-a7ae-4445-93e2-72fcd2446ce8'),
	(43,43,1,'events',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','82b0c2b4-877e-42aa-8717-e910a3665ae5'),
	(44,44,1,'about-us',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','b42574c6-f27d-4c52-9c26-1194229fa49e'),
	(45,45,1,'global-innovators-group',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','8e114c6a-92cb-462d-b2b7-e7f1eb007644'),
	(46,46,1,'idhs-global-leadership-network',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','c7b389cc-f206-4e08-a231-f65869823e08'),
	(47,47,1,'programs',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','229451c2-9b52-4ebb-bd09-6a9efc8eb12a'),
	(48,48,1,'first-herousel',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','8176b615-3a9b-4b21-ba82-aa4e78ee2387'),
	(49,49,1,'first-hero-slide',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','4757201f-f70b-47f5-b599-d289ead9a950'),
	(50,50,1,'first-herousel',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','68ab4037-d7ca-4d2e-8fa7-83d7babd6fc4'),
	(51,51,1,'business-industries',NULL,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','fc7a1314-b8ff-42f2-8a3e-b76f90435d2a'),
	(52,52,1,'energy-environmental',NULL,1,'2019-07-12 12:24:09','2019-07-12 12:24:09','5c3e7a7d-5b6e-4e83-aaed-ad4d201364d3'),
	(53,53,1,'opportunity-development',NULL,1,'2019-07-12 12:24:09','2019-07-12 12:24:09','84d46ebb-6f07-4ca4-a24e-01f58fe37b06'),
	(54,54,1,'philanthropy-social-enterprise',NULL,1,'2019-07-12 12:24:09','2019-07-12 12:24:09','c9727af0-6f1c-41e1-bc59-3484e5538f53'),
	(55,55,1,'opportunity-development',NULL,1,'2019-07-12 12:24:09','2019-07-12 12:24:09','de6dbb22-e0aa-4aa2-afad-204aebcac41d'),
	(56,56,1,'energy-environmental',NULL,1,'2019-07-12 12:24:09','2019-07-12 12:24:09','6b395edb-f8fa-4531-9c69-b89be7c83a78'),
	(57,57,1,'business-industries',NULL,1,'2019-07-12 12:24:09','2019-07-12 12:24:09','4e3a0927-4ada-4f9d-9c21-b999605fd429'),
	(58,58,1,'space-slide',NULL,1,'2019-07-12 13:42:27','2019-07-12 13:46:08','e6a66871-f532-4338-9924-55f632772630'),
	(59,59,1,NULL,NULL,1,'2019-07-12 13:44:28','2019-07-12 13:44:28','9b72833b-9446-4938-9adb-bd4afb4708be'),
	(60,60,1,'space-slide',NULL,1,'2019-07-12 13:46:08','2019-07-12 13:46:08','17f4b266-1255-441c-be36-89c3bf21df01'),
	(61,61,1,'first-hero-slide',NULL,1,'2019-07-12 13:47:40','2019-07-12 13:47:40','dd4c2472-15f7-40fb-8ac2-97427a42cb27'),
	(63,63,1,'first-hero-slide',NULL,1,'2019-07-12 13:48:15','2019-07-12 13:48:15','47a0dc87-b4c2-4e8d-956d-4eca7a58cb07'),
	(65,65,1,'space-slide',NULL,1,'2019-07-12 13:48:58','2019-07-12 13:48:58','7e6180b3-9a91-4e9c-bf70-b3cc2bf3cf08'),
	(67,67,1,'first-herousel',NULL,1,'2019-07-12 13:49:06','2019-07-12 13:49:06','02fc8d61-6fc2-4720-bf86-a10681f3fd9c'),
	(68,68,1,'header-provision',NULL,1,'2019-07-12 15:26:02','2019-07-12 15:26:11','abdf2e7b-be25-40ee-a027-dfceb89c02ea'),
	(69,69,1,'__temp_vExf9sK9My2uFupT1AZQNVBHQGskBdQmQQBu',NULL,1,'2019-07-12 15:26:33','2019-07-12 15:26:33','e885d648-c26e-4867-b1f6-85550025509f'),
	(70,70,1,'header-provision',NULL,1,'2019-07-12 15:27:04','2019-07-12 16:12:48','a75388ca-c78d-4c10-814d-93744d179433'),
	(71,71,1,'header-provision',NULL,1,'2019-07-12 15:27:35','2019-07-12 15:27:35','be7beefe-42c1-4616-90fc-25c162652748'),
	(72,72,1,'image-card-2',NULL,1,'2019-07-12 15:31:01','2019-07-12 16:12:48','1d8eb8cd-a0a8-416b-8907-b73e6d403716'),
	(73,73,1,'image-card-2',NULL,1,'2019-07-12 15:31:20','2019-07-12 15:31:20','1bd0b9bc-8b33-46ae-929c-615170226ab1'),
	(74,74,1,'image-card-2',NULL,1,'2019-07-12 15:32:41','2019-07-12 16:14:40','9afacac6-f051-412e-a69b-e41766754b38'),
	(75,75,1,'image-card-2',NULL,1,'2019-07-12 15:32:41','2019-07-12 15:32:41','fcf4daee-135e-48ee-a03e-52976c3b7743'),
	(77,77,1,NULL,NULL,1,'2019-07-12 15:34:05','2019-07-12 15:34:05','80b17a13-e51f-43a4-b110-143ead88a2cb'),
	(78,78,1,'image-card-2',NULL,1,'2019-07-12 15:34:11','2019-07-12 15:34:11','cba13c38-5d8c-4a59-b986-3945e4fc5045'),
	(79,79,1,'__temp_vz4tkeQ8s7ku5RPapY4BuTMG8aLiHy9NpNP2',NULL,1,'2019-07-12 15:44:31','2019-07-12 15:44:31','13250e97-ecf0-4514-890d-813264f8041e'),
	(80,80,1,'redefining-traditional-learning-in-the-digital-age',NULL,1,'2019-07-12 15:45:10','2019-07-12 16:03:54','58baa32e-367d-4d26-a779-ea38b8d0f345'),
	(81,81,1,'redefining-traditional-learning-in-the-digital-age',NULL,1,'2019-07-12 15:45:56','2019-07-12 15:45:56','d950f044-31ee-4a5d-8084-c2e15621beff'),
	(82,82,1,'leading-the-transformation-of-local-infrastructure',NULL,1,'2019-07-12 15:46:12','2019-07-12 16:03:54','1e0d8305-00b8-483e-9326-acc41a88869c'),
	(83,83,1,'leading-the-transformation-of-local-infrastructure',NULL,1,'2019-07-12 15:46:50','2019-07-12 15:46:50','463da26f-fc76-495f-b661-2d63a52f30f4'),
	(84,84,1,'tech',NULL,1,'2019-07-12 15:49:53','2019-07-12 15:49:53','c9bbff1e-2363-4f4b-80fa-58b3862b5abb'),
	(85,85,1,'design',NULL,1,'2019-07-12 15:49:59','2019-07-12 15:50:08','55d467e9-e6a5-490a-957a-73902c626985'),
	(87,87,1,'leading-the-transformation-of-local-infrastructure',NULL,1,'2019-07-12 15:50:51','2019-07-12 15:50:51','a31aac51-886a-409a-a764-b97f2865379f'),
	(89,89,1,'redefining-traditional-learning-in-the-digital-age',NULL,1,'2019-07-12 15:50:58','2019-07-12 15:50:58','c1e39e8a-5a5b-48c0-94b1-36e94164eede'),
	(90,90,1,NULL,NULL,1,'2019-07-12 16:29:56','2019-07-12 16:29:56','a9c63412-ae7d-4b74-bab6-aeb76961204d'),
	(91,91,1,'pages','__home__',1,'2019-07-15 20:28:28','2019-07-15 20:28:28','5be8036b-926e-41fa-836d-d3d2ba439bce'),
	(93,93,1,'pages','__home__',1,'2019-07-15 20:29:03','2019-07-15 20:29:03','e57f0f12-514d-466c-bd77-bfbf0e9b7ebf'),
	(94,94,1,'pages','__home__',1,'2019-07-15 20:29:03','2019-07-15 20:29:03','981cab79-3373-4362-8f00-71bcffbe72e8'),
	(95,95,1,'home-page',NULL,1,'2019-07-21 18:35:52','2019-07-25 00:35:01','8f4b5834-f400-4b32-a5e9-d46bc636402e'),
	(96,96,1,'home-page','home-page',1,'2019-07-25 00:42:15','2019-07-25 00:42:15','37190f30-7c76-4c11-9e79-5688d353787b'),
	(97,97,1,'home-page','home-page',1,'2019-07-25 00:42:15','2019-07-25 00:42:15','3c104f26-17a1-4987-b05f-9bfcc43a15f8'),
	(98,98,1,'home-page','home-page',1,'2019-07-25 00:42:44','2019-07-25 00:42:44','2d09e91a-b416-4ffc-9458-adf550287c5c'),
	(99,99,1,'home-page',NULL,1,'2019-07-25 00:44:17','2019-07-25 00:44:17','ded4f36a-0988-4974-a477-bb1de79e1499'),
	(100,100,1,'home-page',NULL,1,'2019-07-25 00:44:17','2019-07-25 00:44:17','5037bfb7-8103-4580-bb7f-f0dc6ff433e7'),
	(101,101,1,'home-page',NULL,1,'2019-07-25 00:44:33','2019-07-25 00:44:33','20cfe538-adfe-46c8-8bf5-67f27ec5c1b4'),
	(102,102,1,'home-page',NULL,1,'2019-07-25 00:44:41','2019-07-25 00:44:41','fe1ad1f8-28f9-419a-a989-d3f0dcf310fd'),
	(103,103,1,NULL,NULL,1,'2019-07-25 02:36:52','2019-07-25 02:36:52','c46658b8-e105-479e-92f1-8cb9185cb361'),
	(104,104,1,'first-hero-slide',NULL,1,'2019-07-25 02:39:41','2019-07-25 02:39:41','1edd71bf-dde6-4e3c-b3f9-464fdffd5842'),
	(105,105,1,'first-hero-slide',NULL,1,'2019-07-25 14:08:54','2019-07-25 14:08:54','12fe653e-9cc7-4763-a947-dab3f4572016'),
	(106,106,1,'home-page',NULL,1,'2019-07-25 14:15:52','2019-07-25 14:15:52','e804e4e1-a67b-4d40-a3c1-d1b47fc23574'),
	(107,107,1,'first-herousel',NULL,1,'2019-07-26 22:07:12','2019-07-26 22:07:12','1a72ff4d-9f5d-4de2-8f07-e8ef62974cf7');

/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entries`;

CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;

INSERT INTO `entries` (`id`, `sectionId`, `parentId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `deletedWithEntryType`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,2,NULL,2,NULL,'2019-06-29 22:13:00',NULL,1,'2019-06-29 22:13:15','2019-06-29 22:15:53','47184dfb-479d-4e7b-be3b-118d1110e097'),
	(4,1,NULL,1,1,'2019-06-29 22:24:00',NULL,0,'2019-06-29 22:24:09','2019-06-29 23:21:53','dd6f337d-3966-48f2-bb98-4b46bd89589e'),
	(5,3,NULL,3,1,'2019-06-29 22:49:00',NULL,NULL,'2019-06-29 22:49:42','2019-07-09 00:37:37','7942cff2-c3ea-46e7-bfd3-20241fff1789'),
	(6,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-06-29 22:50:05','2019-07-09 00:37:54','5a3f2c10-9ca3-4cf1-a589-bae903db41d5'),
	(7,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-06-29 22:50:32','2019-07-09 00:37:59','74262ca7-e482-43fb-ae2e-099c672039c6'),
	(8,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-06-29 22:50:58','2019-07-09 00:38:16','56abec45-d653-4bf7-8f08-62e1824e00d7'),
	(9,4,NULL,4,1,'2019-06-29 23:06:00',NULL,NULL,'2019-06-29 23:06:49','2019-06-29 23:23:36','f115ace0-68ab-40ad-81a8-f1c68667844e'),
	(10,1,NULL,1,1,'2019-06-29 23:23:00',NULL,NULL,'2019-06-29 23:23:24','2019-06-29 23:23:28','ce834867-07dd-45e8-894a-5a30c874916b'),
	(11,5,NULL,5,1,'2019-06-30 01:47:00',NULL,NULL,'2019-06-30 01:47:37','2019-06-30 01:47:37','fb1f6dea-dc5a-46eb-88fd-a01638ec9d35'),
	(12,5,NULL,5,1,'2019-06-30 01:47:00',NULL,NULL,'2019-06-30 01:47:56','2019-06-30 01:47:56','40014bfc-5467-4f56-9d10-737243406d0a'),
	(13,5,NULL,5,1,'2019-06-30 01:48:00',NULL,NULL,'2019-06-30 01:48:37','2019-06-30 01:48:42','9f13cc2b-0cb4-434f-9721-b3f5b5e8cad0'),
	(14,5,NULL,5,1,'2019-06-30 01:49:00',NULL,NULL,'2019-06-30 01:49:18','2019-06-30 01:49:18','48ceb182-fedf-4814-89b5-d23637d57d67'),
	(15,5,NULL,5,1,'2019-06-30 01:49:00',NULL,NULL,'2019-06-30 01:49:24','2019-06-30 01:49:24','4b303889-f1ed-4dcb-bda8-21e5cbc9cdc9'),
	(16,5,NULL,5,1,'2019-06-30 01:49:00',NULL,NULL,'2019-06-30 01:49:34','2019-06-30 01:49:34','c39a6927-9960-4870-ae7b-6cbf0ae5fb9e'),
	(17,5,NULL,5,1,'2019-06-30 01:55:00',NULL,NULL,'2019-06-30 01:55:01','2019-06-30 01:55:01','8f883037-617b-46b0-b407-32b3097100af'),
	(18,5,NULL,5,1,'2019-06-30 01:55:00',NULL,NULL,'2019-06-30 01:55:21','2019-06-30 01:55:21','db789b21-a0fc-4ecf-8977-23b1e3478155'),
	(19,5,NULL,5,1,'2019-06-30 01:55:00',NULL,NULL,'2019-06-30 01:55:32','2019-06-30 01:55:32','068ae3ed-7159-40ed-b3bf-9b7178627393'),
	(20,5,NULL,5,1,'2019-06-30 01:55:00',NULL,NULL,'2019-06-30 01:55:40','2019-06-30 01:55:40','7a80820f-03e8-46b9-bb91-fd12966a5129'),
	(25,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-07-12 12:24:07','2019-07-12 12:24:07','5f85f2c1-d86d-4e48-bd59-9b695b4a3de8'),
	(26,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-07-12 12:24:07','2019-07-12 12:24:07','70dd5df1-7364-43b8-a1b3-aaff22df7d59'),
	(27,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-07-12 12:24:07','2019-07-12 12:24:07','3b73a60c-8f40-40f2-806b-40014f6581cd'),
	(28,3,NULL,3,1,'2019-06-29 22:49:00',NULL,NULL,'2019-07-12 12:24:07','2019-07-12 12:24:07','e6719a27-717a-4668-8685-f28157ac678c'),
	(29,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-07-12 12:24:07','2019-07-12 12:24:07','fef7b7d1-aa5d-45e8-9688-2e6099d6b0df'),
	(30,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-07-12 12:24:07','2019-07-12 12:24:07','491d0000-8127-4109-ac12-36bae16a2a47'),
	(31,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-07-12 12:24:07','2019-07-12 12:24:07','706bd030-eb1d-4a05-bae9-9ba157a4e27b'),
	(32,3,NULL,3,1,'2019-06-29 22:49:00',NULL,NULL,'2019-07-12 12:24:07','2019-07-12 12:24:07','1b94effd-4622-42d6-8862-271ef45abf2e'),
	(33,3,NULL,3,1,'2019-06-29 22:49:00',NULL,NULL,'2019-07-12 12:24:07','2019-07-12 12:24:07','27308177-c4f8-4c86-91a5-1a8533df0161'),
	(34,3,NULL,3,1,'2019-06-29 22:49:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','76e39a47-c4aa-4181-98c0-316f28ef44c5'),
	(35,3,NULL,3,1,'2019-06-29 22:49:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','c3b85a84-e27e-4bea-a374-f270b769d3b3'),
	(36,3,NULL,3,1,'2019-06-29 22:49:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','d92a551d-aaed-4e32-a399-c8d2f40b6be3'),
	(37,3,NULL,3,1,'2019-06-29 22:49:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','a765bf9a-6813-461a-86a3-6e92134d2cfc'),
	(38,5,NULL,5,1,'2019-06-30 01:55:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','113cc599-926d-4a90-b18a-69df3ac801d5'),
	(39,5,NULL,5,1,'2019-06-30 01:55:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','edf702c2-c8ae-4f2f-a242-9b59e55cd5c3'),
	(40,5,NULL,5,1,'2019-06-30 01:55:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','40ea1e9a-0355-4259-9c7a-594f40513bf6'),
	(41,5,NULL,5,1,'2019-06-30 01:55:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','ee70b2e3-7ab2-464c-a2cd-ad8b2e5a89b8'),
	(42,5,NULL,5,1,'2019-06-30 01:49:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','70ed4707-cdb8-4023-8a63-547c531aaddb'),
	(43,5,NULL,5,1,'2019-06-30 01:49:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','55161899-83a8-46a4-b187-4aa86e00a34e'),
	(44,5,NULL,5,1,'2019-06-30 01:49:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','63de31ac-71f1-4e41-ae15-f69541f209db'),
	(45,5,NULL,5,1,'2019-06-30 01:48:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','7bfc4911-7a75-4eb2-b654-6197ff3b7783'),
	(46,5,NULL,5,1,'2019-06-30 01:47:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','bf944451-20fc-423a-ac83-a68b5fc0e44c'),
	(47,5,NULL,5,1,'2019-06-30 01:47:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','ad2f04a4-e0e9-47f2-b638-33b6d3c26e84'),
	(48,4,NULL,4,1,'2019-06-29 23:06:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','71bee909-fdd1-47a8-9583-11bd5085dd00'),
	(49,1,NULL,1,1,'2019-06-29 23:23:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','fe4b68e4-61cc-4279-855a-e17428b337f5'),
	(50,4,NULL,4,1,'2019-06-29 23:06:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','60c9485c-d08e-43a8-ac59-647149611631'),
	(51,3,NULL,3,1,'2019-06-29 22:49:00',NULL,NULL,'2019-07-12 12:24:08','2019-07-12 12:24:08','829f72ba-3506-4c0e-9e89-de8e594e81d1'),
	(52,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-07-12 12:24:09','2019-07-12 12:24:09','5b84575e-8c73-48c6-af21-1e062afff43d'),
	(53,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-07-12 12:24:09','2019-07-12 12:24:09','972be3ed-8d39-46a5-8c2f-4ff5bbdccf4b'),
	(54,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-07-12 12:24:09','2019-07-12 12:24:09','f8c875c9-38d1-4922-a98e-9ec87b4f60fd'),
	(55,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-07-12 12:24:09','2019-07-12 12:24:09','28312894-84be-43e6-9739-64a3e2036e83'),
	(56,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-07-12 12:24:09','2019-07-12 12:24:09','9729d38d-7c04-4cfc-b45a-2d82cb2a2046'),
	(57,3,NULL,3,1,'2019-06-29 22:49:00',NULL,NULL,'2019-07-12 12:24:09','2019-07-12 12:24:09','848ad91f-2a78-4edc-b3cb-b5e1530f1fb8'),
	(58,1,NULL,1,1,'2019-07-12 13:42:00',NULL,NULL,'2019-07-12 13:42:27','2019-07-12 13:42:27','f862db39-1e7a-452f-b544-f1cc47b34c21'),
	(60,1,NULL,1,1,'2019-07-12 13:42:00',NULL,NULL,'2019-07-12 13:46:08','2019-07-12 13:46:08','d7d02737-084c-4505-af4c-434b79a6db7b'),
	(61,1,NULL,1,1,'2019-06-29 23:23:00',NULL,NULL,'2019-07-12 13:47:40','2019-07-12 13:47:40','8f097966-c20a-4e8c-849b-7b5b5e27936d'),
	(63,1,NULL,1,1,'2019-06-29 23:23:00',NULL,NULL,'2019-07-12 13:48:15','2019-07-12 13:48:15','a3c187e9-f095-4c03-ab40-249bc60b9bfa'),
	(65,1,NULL,1,1,'2019-07-12 13:42:00',NULL,NULL,'2019-07-12 13:48:58','2019-07-12 13:48:58','b0e7b4b6-0aa1-4493-b6f1-97e0dbbca2c6'),
	(67,4,NULL,4,1,'2019-06-29 23:06:00',NULL,NULL,'2019-07-12 13:49:06','2019-07-12 13:49:06','4cc44aad-1abc-4873-829f-e241d33d74ae'),
	(68,6,NULL,6,1,'2019-07-12 15:26:00',NULL,NULL,'2019-07-12 15:26:02','2019-07-12 15:26:02','cb772792-a9a1-45a3-8c06-5aea651c419a'),
	(69,6,NULL,6,1,'2019-07-12 15:26:00',NULL,NULL,'2019-07-12 15:26:33','2019-07-12 15:26:33','f702ca92-1ab9-4208-a14f-b605a523fe2d'),
	(70,6,NULL,6,1,'2019-07-12 15:27:00',NULL,NULL,'2019-07-12 15:27:04','2019-07-12 15:27:04','10931d03-b0a5-45eb-9c94-a35006a716a4'),
	(71,6,NULL,6,1,'2019-07-12 15:27:00',NULL,NULL,'2019-07-12 15:27:35','2019-07-12 15:27:35','daa396a0-fc15-46c2-a93e-5697da927e19'),
	(72,6,NULL,6,1,'2019-07-12 15:31:00',NULL,NULL,'2019-07-12 15:31:01','2019-07-12 15:31:01','24012b9e-a00c-4cb4-895c-4f53920c6dc4'),
	(73,6,NULL,6,1,'2019-07-12 15:31:00',NULL,NULL,'2019-07-12 15:31:20','2019-07-12 15:31:20','619262b2-be36-46ae-b0f6-8ca511ce5251'),
	(74,6,NULL,6,1,'2019-07-12 15:31:00',NULL,NULL,'2019-07-12 15:32:41','2019-07-12 15:32:41','e9582dcc-429a-4aa4-a025-40bb522d5728'),
	(75,6,NULL,6,1,'2019-07-12 15:31:00',NULL,NULL,'2019-07-12 15:32:41','2019-07-12 15:32:41','3f9344eb-0437-4956-81ee-a6c88f887e8e'),
	(78,6,NULL,6,1,'2019-07-12 15:31:00',NULL,NULL,'2019-07-12 15:34:11','2019-07-12 15:34:11','b152c116-e108-4274-a74d-e941a3abca3e'),
	(79,7,NULL,7,1,'2019-07-12 15:44:00',NULL,NULL,'2019-07-12 15:44:31','2019-07-12 15:44:31','607a8aa8-0986-4ff3-915d-a0c983c98d6b'),
	(80,7,NULL,7,1,'2019-07-12 15:45:00',NULL,NULL,'2019-07-12 15:45:10','2019-07-12 15:45:10','fe736d2d-9423-47df-b7ea-61085b9df657'),
	(81,7,NULL,7,1,'2019-07-12 15:45:00',NULL,NULL,'2019-07-12 15:45:56','2019-07-12 15:45:56','57d1a199-5e28-4827-82f8-ce68df39eebf'),
	(82,7,NULL,7,1,'2019-07-12 15:46:00',NULL,NULL,'2019-07-12 15:46:12','2019-07-12 15:46:12','ceeaf4e5-f1bb-41fe-b77b-858f5e695a11'),
	(83,7,NULL,7,1,'2019-07-12 15:46:00',NULL,NULL,'2019-07-12 15:46:50','2019-07-12 15:46:50','dbe3bf58-76cf-4027-b09a-0bab11e93d67'),
	(87,7,NULL,7,1,'2019-07-12 15:46:00',NULL,NULL,'2019-07-12 15:50:51','2019-07-12 15:50:51','56cd3980-f151-4c52-a7cd-746e3bd382fb'),
	(89,7,NULL,7,1,'2019-07-12 15:45:00',NULL,NULL,'2019-07-12 15:50:58','2019-07-12 15:50:58','e1b2ecb4-8708-4a14-9d64-44507076e288'),
	(91,8,NULL,8,NULL,'2019-07-15 20:28:00',NULL,1,'2019-07-15 20:28:28','2019-07-15 20:28:28','b7a1ecfa-21f0-4226-a799-d37fd4393222'),
	(93,8,NULL,8,NULL,'2019-07-15 20:28:00',NULL,NULL,'2019-07-15 20:29:03','2019-07-15 20:29:03','c2965cd8-0704-4f63-9f7d-5838bd3eee63'),
	(94,8,NULL,8,NULL,'2019-07-15 20:28:00',NULL,NULL,'2019-07-15 20:29:03','2019-07-15 20:29:03','73ebbf30-7bc9-43b3-bd2a-28ec310aa359'),
	(95,9,NULL,9,NULL,'2019-07-21 18:35:00',NULL,1,'2019-07-21 18:35:52','2019-07-25 00:28:30','a76dc37f-6942-4b7f-bd30-5d23243675cc'),
	(96,10,NULL,10,NULL,'2019-07-25 00:42:00',NULL,1,'2019-07-25 00:42:15','2019-07-25 00:42:15','5d8afc91-3c5d-46e6-9fe0-989707d678f1'),
	(97,10,NULL,10,NULL,'2019-07-25 00:42:00',NULL,NULL,'2019-07-25 00:42:15','2019-07-25 00:42:15','7bb94294-205a-455f-b8dc-a261501bfd6b'),
	(98,10,NULL,10,NULL,'2019-07-25 00:42:00',NULL,NULL,'2019-07-25 00:42:44','2019-07-25 00:42:44','1c750319-a323-43e5-a4df-d5fc9b25d37f'),
	(99,11,NULL,11,NULL,'2019-07-25 00:44:00',NULL,NULL,'2019-07-25 00:44:17','2019-07-25 00:44:17','e4cc9370-e5d5-4640-ad9b-30e01ef6da22'),
	(100,11,NULL,11,NULL,'2019-07-25 00:44:00',NULL,NULL,'2019-07-25 00:44:17','2019-07-25 00:44:17','f3895961-0df6-4149-968a-e3370d9b90f5'),
	(101,11,NULL,11,NULL,'2019-07-25 00:44:00',NULL,NULL,'2019-07-25 00:44:33','2019-07-25 00:44:33','43e61970-be4b-4c52-89f5-4d6a9476ce84'),
	(102,11,NULL,11,NULL,'2019-07-25 00:44:00',NULL,NULL,'2019-07-25 00:44:41','2019-07-25 00:44:41','6538711c-bdf5-47f1-b153-e6a9d85eb515'),
	(104,1,NULL,1,1,'2019-06-29 23:23:00',NULL,NULL,'2019-07-25 02:39:41','2019-07-25 02:39:41','4fd7cc25-3559-4e2f-8aee-f49db44c3e08'),
	(105,1,NULL,1,1,'2019-06-29 23:23:00',NULL,NULL,'2019-07-25 14:08:54','2019-07-25 14:08:54','7859ae65-7b13-4403-9354-cb88a833171f'),
	(106,11,NULL,11,NULL,'2019-07-25 00:44:00',NULL,NULL,'2019-07-25 14:15:52','2019-07-25 14:15:52','26f79b99-6284-4dfb-a881-64b2c5c9c02a'),
	(107,4,NULL,4,1,'2019-06-29 23:06:00',NULL,NULL,'2019-07-26 22:07:12','2019-07-26 22:07:12','d12e417c-a554-4194-96ae-3c875213a424');

/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entrydrafterrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrydrafterrors`;

CREATE TABLE `entrydrafterrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entrydrafterrors_draftId_fk` (`draftId`),
  CONSTRAINT `entrydrafterrors_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `entrydrafts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table entrydrafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrydrafts`;

CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrytypes`;

CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;

INSERT INTO `entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,1,'Herousel Slides','herouselSlides',1,'Title','{slideTitle}',1,'2019-06-29 17:57:44','2019-07-25 02:39:34',NULL,'e07042df-c02d-4b04-a175-e9291e3bee4a'),
	(2,2,NULL,'Basic Pages','basicPages',0,NULL,'{section.name|raw}',1,'2019-06-29 22:13:15','2019-06-29 22:13:15','2019-06-29 22:15:53','ac3ca9d2-9388-41b5-9362-b6db24a7e5bf'),
	(3,3,2,'Header Navigation Blocks','headerNavigationBlocks',0,'Title','{blockTitle}',1,'2019-06-29 22:41:05','2019-07-08 23:29:52',NULL,'6bef59cb-3103-44b4-a193-326a2758ecdf'),
	(4,4,3,'Herousels','herousels',1,'Title','',1,'2019-06-29 23:03:21','2019-06-29 23:05:24',NULL,'7b3aeb3f-1bdf-4cb2-8163-503979b1e13f'),
	(5,5,NULL,'Navigation Links','navigationLinks',1,'Title',NULL,1,'2019-06-30 01:46:32','2019-06-30 01:46:32',NULL,'48c83400-948a-4fe7-befa-a28551d35165'),
	(6,6,4,'Image Cards','imageCards',1,'Title','',1,'2019-07-12 15:04:17','2019-07-12 15:27:01',NULL,'dd0006ba-780b-4588-a52b-af08d9439c9a'),
	(7,7,5,'Insight Blocks','insightBlocks',1,'Title','',1,'2019-07-12 15:37:08','2019-07-12 15:50:20',NULL,'c881ae05-8a22-4968-8734-08b073732300'),
	(8,8,NULL,'Pages','pages',0,NULL,'{section.name|raw}',1,'2019-07-15 20:28:28','2019-07-15 20:28:28','2019-07-15 20:29:03','1a45b96c-01cf-4932-b812-76c468386079'),
	(9,9,8,'Home Page','homePage',0,'','{section.name|raw}',1,'2019-07-21 18:35:52','2019-07-21 18:37:16','2019-07-25 00:41:57','8365b49f-088b-485e-bd3a-172e26ba9bfb'),
	(10,10,NULL,'Home Page','homePage',0,NULL,'{section.name|raw}',1,'2019-07-25 00:42:15','2019-07-25 00:42:15','2019-07-25 00:42:44','be23eaf8-fb21-4af5-a792-7e7b7798c797'),
	(11,11,9,'Home Page','homePage',0,'','{section.name|raw}',1,'2019-07-25 00:44:17','2019-07-25 00:44:33',NULL,'74bc750a-9481-44ba-92d8-d13059d3c272');

/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entryversionerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entryversionerrors`;

CREATE TABLE `entryversionerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `versionId` int(11) DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entryversionerrors_versionId_fk` (`versionId`),
  CONSTRAINT `entryversionerrors_versionId_fk` FOREIGN KEY (`versionId`) REFERENCES `entryversions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table entryversions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entryversions`;

CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table fieldgroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldgroups`;

CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;

INSERT INTO `fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Common','2019-06-29 17:33:17','2019-06-29 17:33:17','9cbd8a73-a772-4caa-acb5-a5a9151ddd55'),
	(2,'Header Navigation','2019-06-29 22:41:51','2019-06-29 22:52:42','2babdf9b-c278-4420-ade7-ab8175bb80d3'),
	(3,'Herousels','2019-06-29 23:04:23','2019-06-29 23:04:23','4b19cdc5-eb0d-43c0-a63b-60bacd175db4');

/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayoutfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayoutfields`;

CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;

INSERT INTO `fieldlayoutfields` (`id`, `layoutId`, `tabId`, `fieldId`, `required`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(13,3,5,6,0,1,'2019-06-29 23:05:24','2019-06-29 23:05:24','fadc3360-2699-4210-b4ef-ae2151073c4f'),
	(27,2,9,2,0,4,'2019-07-08 23:29:52','2019-07-08 23:29:52','786ccd7a-a32e-4935-bd89-d576f7753314'),
	(28,2,9,4,1,3,'2019-07-08 23:29:52','2019-07-08 23:29:52','d2af6c76-a234-4aa4-b51e-5ebb84aff5eb'),
	(29,2,9,5,1,2,'2019-07-08 23:29:52','2019-07-08 23:29:52','b4d667cb-2e6c-4a3b-a68f-d693bcba9533'),
	(30,2,9,3,1,1,'2019-07-08 23:29:52','2019-07-08 23:29:52','750fdc39-1a3f-4fa5-85c9-9442a7a38bab'),
	(38,4,12,8,0,3,'2019-07-12 15:27:01','2019-07-12 15:27:01','7ef7489f-78a3-4d2f-a1bc-0603b937618d'),
	(39,4,12,10,1,1,'2019-07-12 15:27:01','2019-07-12 15:27:01','a17b0ab9-ebe5-4242-ac54-6d8d6a483098'),
	(40,4,12,13,1,2,'2019-07-12 15:27:01','2019-07-12 15:27:01','4ce18db5-1915-4ff9-b6df-c4ea5439ea73'),
	(47,5,15,8,0,4,'2019-07-12 15:50:20','2019-07-12 15:50:20','9f15c931-fb39-442b-b8fc-bed2ec22d778'),
	(48,5,15,14,0,1,'2019-07-12 15:50:20','2019-07-12 15:50:20','055933a6-c6e6-417a-bee6-cd605d43a962'),
	(49,5,15,10,1,2,'2019-07-12 15:50:20','2019-07-12 15:50:20','800a459f-2c20-4320-9d55-bbf7c00e7246'),
	(50,5,15,13,1,3,'2019-07-12 15:50:20','2019-07-12 15:50:20','19ff031a-3daf-4c29-8ba8-b1b6fb579658'),
	(56,6,20,15,0,1,'2019-07-12 16:36:01','2019-07-12 16:36:01','d00c2264-b832-4d95-be39-3a65661e940e'),
	(57,6,20,17,0,2,'2019-07-12 16:36:01','2019-07-12 16:36:01','6670ed6d-48e8-4c70-b949-573742a32caf'),
	(58,6,20,16,0,3,'2019-07-12 16:36:01','2019-07-12 16:36:01','8eca3b8f-0c7b-482e-ba77-22a269e63341'),
	(61,8,23,19,0,1,'2019-07-21 18:37:16','2019-07-21 18:37:16','743756d9-7ae4-4cb7-94f8-ffd522fe7af7'),
	(62,9,24,19,0,1,'2019-07-25 00:44:33','2019-07-25 00:44:33','a0b22071-6aa1-4fa9-80e7-4df93d051bfd'),
	(73,1,27,8,0,5,'2019-07-25 02:39:34','2019-07-25 02:39:34','fbcec4dc-8226-4ba3-b454-b57e4a65dfb6'),
	(74,1,27,12,0,3,'2019-07-25 02:39:34','2019-07-25 02:39:34','a5b8941d-c893-47ca-8982-68400248241f'),
	(75,1,27,10,0,1,'2019-07-25 02:39:34','2019-07-25 02:39:34','7f61ce55-627c-46d0-b093-9ea6e818eb06'),
	(76,1,27,13,0,4,'2019-07-25 02:39:34','2019-07-25 02:39:34','99187007-c1be-4bf8-965e-7ec3c4fdebb4'),
	(77,1,27,11,0,2,'2019-07-25 02:39:34','2019-07-25 02:39:34','0ff1b7f8-ffae-42c3-9a5a-32cf76e4f23e');

/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouts`;

CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;

INSERT INTO `fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'craft\\elements\\Entry','2019-06-29 22:19:43','2019-06-29 23:21:53',NULL,'d56f6f75-29d4-4458-84a1-560f8fa794cd'),
	(2,'craft\\elements\\Entry','2019-06-29 22:47:37','2019-07-08 23:29:52',NULL,'56d520b9-dc62-43e6-8250-56e8a644ecb9'),
	(3,'craft\\elements\\Entry','2019-06-29 23:05:24','2019-06-29 23:05:24',NULL,'08229f3b-f574-4612-9224-d9a27260d924'),
	(4,'craft\\elements\\Entry','2019-07-12 15:18:47','2019-07-12 15:18:47',NULL,'5d453106-4cb6-4f97-8d55-5d8cf00b35fc'),
	(5,'craft\\elements\\Entry','2019-07-12 15:44:23','2019-07-12 15:44:23',NULL,'087dc529-9ea2-4ef6-b449-c87f44493ace'),
	(6,'craft\\elements\\GlobalSet','2019-07-12 16:32:08','2019-07-12 16:32:08',NULL,'cbb838b2-a710-4a92-ba0d-d241b3abbbc3'),
	(7,'craft\\elements\\User','2019-07-18 16:57:47','2019-07-18 16:58:19','2019-07-18 17:02:14','c9208868-66bd-450d-8cbf-f9e186e332d5'),
	(8,'craft\\elements\\Entry','2019-07-21 18:37:16','2019-07-21 18:37:16','2019-07-25 00:41:57','940c7adf-ca2c-4fe3-943f-c6fa1801437c'),
	(9,'craft\\elements\\Entry','2019-07-25 00:44:33','2019-07-25 00:44:33',NULL,'5f057e54-102d-4009-a3da-360012a2e9ff');

/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouttabs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouttabs`;

CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;

INSERT INTO `fieldlayouttabs` (`id`, `layoutId`, `name`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(5,3,'Slides',1,'2019-06-29 23:05:24','2019-06-29 23:05:24','1e2cfe62-ca11-4749-a43a-0d427c942dfe'),
	(9,2,'Content',1,'2019-07-08 23:29:52','2019-07-08 23:29:52','fe7d9ba7-85df-4863-9954-ead93ca78e36'),
	(12,4,'Content',1,'2019-07-12 15:27:01','2019-07-12 15:27:01','a408f79a-ee65-4aea-9a86-f6ca40811eae'),
	(15,5,'Content',1,'2019-07-12 15:50:20','2019-07-12 15:50:20','35da5ad6-d1ea-4ea5-9e72-cdc53783bded'),
	(20,6,'Information',1,'2019-07-12 16:36:01','2019-07-12 16:36:01','de107abf-f439-428b-9a9a-3c948a219a3c'),
	(22,7,'General Info',1,'2019-07-18 16:58:19','2019-07-18 16:58:19','e0b82457-0f72-45ca-9ef2-3df30c766bf5'),
	(23,8,'Content',1,'2019-07-21 18:37:16','2019-07-21 18:37:16','ec30e552-de20-40a8-aa9d-7bee64577b34'),
	(24,9,'Content',1,'2019-07-25 00:44:33','2019-07-25 00:44:33','8ea696c9-4306-4563-9e9b-8c0fc984c080'),
	(27,1,'Content',1,'2019-07-25 02:39:34','2019-07-25 02:39:34','15a35b8b-2233-4985-825b-1394ec2eec58');

/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fields`;

CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 1,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;

INSERT INTO `fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `searchable`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'Hero Image','heroImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"singleUploadLocationSubpath\":\"images\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2019-06-29 22:19:14','2019-06-29 22:23:42','7ca16c4a-c225-4879-b65f-aad29c84a651'),
	(2,2,'Accent Color','accentColor','global','Choose a color for the blocks accent',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Brand Red\",\"value\":\"brandRed\",\"default\":\"1\"},{\"label\":\"Brand Blue\",\"value\":\"brandBlue\",\"default\":\"\"},{\"label\":\"Brand Green\",\"value\":\"brandGreen\",\"default\":\"\"},{\"label\":\"Brand Orange\",\"value\":\"brandOrange\",\"default\":\"\"}]}','2019-06-29 22:42:56','2019-07-09 00:37:25','0a68a217-6bc5-49ac-bdd1-14e540d37976'),
	(3,2,'Block Title','blockTitle','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"1\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-29 22:45:40','2019-06-29 22:45:40','f0ec0c83-08cc-48d0-9a8b-539f73b52bee'),
	(4,2,'Block Icon','blockIcon','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"singleUploadLocationSubpath\":\"images/icons\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add an icon for this block\",\"localizeRelations\":false}','2019-06-29 22:46:30','2019-06-29 22:46:30','77c9f661-7918-4604-9a2d-268172dedf4c'),
	(5,2,'Block Link','blockLink','global','',1,'site',NULL,'craft\\fields\\Entries','{\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"1\",\"selectionLabel\":\"Select another entry to link to\",\"localizeRelations\":false}','2019-06-29 22:49:05','2019-06-29 22:49:05','b86669c7-1f17-4924-8151-b08b5c5e499f'),
	(6,3,'Herousel Slides','herouselSlides','global','Select up to four slides for the herousel.',1,'site',NULL,'craft\\fields\\Entries','{\"sources\":[\"section:f4806157-8213-4481-a5ca-4697ca313dfe\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"4\",\"selectionLabel\":\"Add a slide to the herousel\",\"localizeRelations\":false}','2019-06-29 23:05:04','2019-06-29 23:06:30','8ad551d3-1d49-460d-b73f-7f8b70de3740'),
	(8,1,'Entry Image','entryImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"defaultUploadLocationSubpath\":\"images/\",\"singleUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"}','2019-06-29 23:16:31','2019-07-12 15:40:47','18d5ee1b-53c5-415a-8fd8-b53d9d43f763'),
	(10,1,'Copy','copy','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"Lorem ipsum dolor sit amet...\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"1\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-29 23:17:22','2019-07-25 01:35:23','96cdbd77-6e4d-414a-9b67-56b4900b420c'),
	(11,1,'Slide Category','slideCategory','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-29 23:19:30','2019-07-12 15:41:44','f3d95e24-acd1-44aa-b881-d39395747064'),
	(12,1,'CTA Copy','ctaCopy','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"25\",\"columnType\":\"text\"}','2019-06-29 23:20:11','2019-07-25 01:35:32','2db23733-dff0-4265-a542-6ecad5cb1b9e'),
	(13,1,'CTA Link','ctaLink','global','',1,'site',NULL,'craft\\fields\\Entries','{\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"1\",\"selectionLabel\":\"Select another entry to link to\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"}','2019-06-29 23:20:33','2019-07-25 01:35:38','edacbb61-d979-4e62-bfed-e8425456b1f1'),
	(14,1,'Related Category','relatedCategory','global','',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"branchLimit\":\"1\",\"sources\":\"*\",\"source\":\"group:85c77f35-48e4-42ff-a631-57f0612aaf53\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"}','2019-07-12 15:47:40','2019-07-12 15:50:39','68f23f3b-294a-4e72-ba7e-7ce480addad5'),
	(15,1,'Contact Street Address','contactStreetAddress','global','',0,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-07-12 16:33:07','2019-07-12 16:35:42','038069ec-817a-4271-8329-8800920a9077'),
	(16,1,'Contact Phone','contactPhone','global','',0,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-07-12 16:34:58','2019-07-12 16:34:58','3e14ad63-16b6-4e2c-9006-913712819550'),
	(17,1,'Contact State','contactState','global','',0,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-07-12 16:35:52','2019-07-12 16:35:52','1953e64d-f917-4bce-a0df-82f0221e3e64'),
	(19,3,'Herousel','herousel','global','Select a Herousel to use on the page.',0,'site',NULL,'craft\\fields\\Entries','{\"sources\":[\"section:06021517-c456-4337-a55c-342f170b509e\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"}','2019-07-21 18:37:00','2019-07-21 18:37:00','c0107872-0d5b-4aa9-8369-7a4dae65cc08');

/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table globalsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `globalsets`;

CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;

INSERT INTO `globalsets` (`id`, `name`, `handle`, `fieldLayoutId`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(90,'Contact Info','contactInfo',6,'2019-07-12 16:29:56','2019-07-12 16:36:01','2cdb6263-8e70-47fa-a8d8-e0f7178e1fb6');

/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `info`;

CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `config` mediumtext DEFAULT NULL,
  `configMap` mediumtext DEFAULT NULL,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `maintenance`, `config`, `configMap`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.2.6','3.2.16',0,'{\"fieldGroups\":{\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\":{\"name\":\"Common\"},\"2babdf9b-c278-4420-ade7-ab8175bb80d3\":{\"name\":\"Header Navigation\"},\"4b19cdc5-eb0d-43c0-a63b-60bacd175db4\":{\"name\":\"Herousels\"}},\"siteGroups\":{\"5b0c9095-dbd8-49a8-9f0e-98f12e9c1683\":{\"name\":\"IK Craft Demo\"}},\"sites\":{\"f2559c18-7489-4189-aecc-54995f3bff7a\":{\"siteGroup\":\"5b0c9095-dbd8-49a8-9f0e-98f12e9c1683\",\"name\":\"IK Craft Demo\",\"handle\":\"default\",\"language\":\"en-US\",\"hasUrls\":true,\"baseUrl\":\"$DEFAULT_SITE_URL\",\"sortOrder\":1,\"primary\":true}},\"email\":{\"fromEmail\":\"adam@interactiveknowledge.com\",\"fromName\":\"IK Craft Demo\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"},\"system\":{\"edition\":\"pro\",\"name\":\"IK Craft Demo\",\"live\":true,\"schemaVersion\":\"3.2.16\",\"timeZone\":\"America/New_York\"},\"users\":{\"requireEmailVerification\":true,\"allowPublicRegistration\":false,\"defaultGroup\":null,\"photoVolumeUid\":\"50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"photoSubpath\":\"/images/users\",\"fieldLayouts\":{\"c29ac813-210e-47d7-b9cd-9a6fde4af85b\":null}},\"dateModified\":1564022374,\"sections\":{\"f4806157-8213-4481-a5ca-4697ca313dfe\":{\"name\":\"Herousel Slides\",\"handle\":\"herouselSlides\",\"type\":\"channel\",\"enableVersioning\":true,\"siteSettings\":{\"f2559c18-7489-4189-aecc-54995f3bff7a\":{\"enabledByDefault\":true,\"hasUrls\":false,\"uriFormat\":null,\"template\":null}},\"entryTypes\":{\"e07042df-c02d-4b04-a175-e9291e3bee4a\":{\"name\":\"Herousel Slides\",\"handle\":\"herouselSlides\",\"hasTitleField\":true,\"titleLabel\":\"Title\",\"titleFormat\":\"{slideTitle}\",\"sortOrder\":1,\"fieldLayouts\":{\"d56f6f75-29d4-4458-84a1-560f8fa794cd\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"18d5ee1b-53c5-415a-8fd8-b53d9d43f763\":{\"required\":false,\"sortOrder\":5},\"2db23733-dff0-4265-a542-6ecad5cb1b9e\":{\"required\":false,\"sortOrder\":3},\"96cdbd77-6e4d-414a-9b67-56b4900b420c\":{\"required\":false,\"sortOrder\":1},\"edacbb61-d979-4e62-bfed-e8425456b1f1\":{\"required\":false,\"sortOrder\":4},\"f3d95e24-acd1-44aa-b881-d39395747064\":{\"required\":false,\"sortOrder\":2}}}]}}}},\"propagationMethod\":\"all\"},\"acc864f2-7951-4b85-8639-f771df381a56\":{\"name\":\"Navigation Blocks\",\"handle\":\"navigationBlocks\",\"type\":\"structure\",\"enableVersioning\":true,\"siteSettings\":{\"f2559c18-7489-4189-aecc-54995f3bff7a\":{\"enabledByDefault\":true,\"hasUrls\":false,\"uriFormat\":null,\"template\":null}},\"structure\":{\"uid\":\"711c9b98-5218-4a8c-831e-0b0b70664b65\",\"maxLevels\":1},\"entryTypes\":{\"6bef59cb-3103-44b4-a193-326a2758ecdf\":{\"name\":\"Header Navigation Blocks\",\"handle\":\"headerNavigationBlocks\",\"hasTitleField\":false,\"titleLabel\":\"Title\",\"titleFormat\":\"{blockTitle}\",\"sortOrder\":1,\"fieldLayouts\":{\"56d520b9-dc62-43e6-8250-56e8a644ecb9\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"0a68a217-6bc5-49ac-bdd1-14e540d37976\":{\"required\":false,\"sortOrder\":4},\"77c9f661-7918-4604-9a2d-268172dedf4c\":{\"required\":true,\"sortOrder\":3},\"b86669c7-1f17-4924-8151-b08b5c5e499f\":{\"required\":true,\"sortOrder\":2},\"f0ec0c83-08cc-48d0-9a8b-539f73b52bee\":{\"required\":true,\"sortOrder\":1}}}]}}}},\"propagationMethod\":\"all\"},\"06021517-c456-4337-a55c-342f170b509e\":{\"name\":\"Herousels\",\"handle\":\"herousels\",\"type\":\"channel\",\"enableVersioning\":true,\"siteSettings\":{\"f2559c18-7489-4189-aecc-54995f3bff7a\":{\"enabledByDefault\":true,\"hasUrls\":false,\"uriFormat\":null,\"template\":null}},\"entryTypes\":{\"7b3aeb3f-1bdf-4cb2-8163-503979b1e13f\":{\"name\":\"Herousels\",\"handle\":\"herousels\",\"hasTitleField\":true,\"titleLabel\":\"Title\",\"titleFormat\":\"\",\"sortOrder\":1,\"fieldLayouts\":{\"08229f3b-f574-4612-9224-d9a27260d924\":{\"tabs\":[{\"name\":\"Slides\",\"sortOrder\":1,\"fields\":{\"8ad551d3-1d49-460d-b73f-7f8b70de3740\":{\"required\":false,\"sortOrder\":1}}}]}}}},\"propagationMethod\":\"all\"},\"3d68d8a0-b786-405c-8b3c-d3ed8c4b93f8\":{\"name\":\"Navigation Links\",\"handle\":\"navigationLinks\",\"type\":\"structure\",\"enableVersioning\":true,\"siteSettings\":{\"f2559c18-7489-4189-aecc-54995f3bff7a\":{\"enabledByDefault\":true,\"hasUrls\":false,\"uriFormat\":null,\"template\":null}},\"structure\":{\"uid\":\"f8410eba-e92c-449f-8e2a-183643e1ec4f\",\"maxLevels\":2},\"entryTypes\":{\"48c83400-948a-4fe7-befa-a28551d35165\":{\"name\":\"Navigation Links\",\"handle\":\"navigationLinks\",\"hasTitleField\":true,\"titleLabel\":\"Title\",\"titleFormat\":null,\"sortOrder\":1}},\"propagationMethod\":\"all\"},\"85f5118f-dd13-45cc-a0f4-e49d61bab613\":{\"name\":\"Image Cards\",\"handle\":\"imageCards\",\"type\":\"structure\",\"enableVersioning\":true,\"propagationMethod\":\"all\",\"siteSettings\":{\"f2559c18-7489-4189-aecc-54995f3bff7a\":{\"enabledByDefault\":true,\"hasUrls\":false,\"uriFormat\":null,\"template\":null}},\"structure\":{\"uid\":\"923c838a-a800-44f2-98da-fe775dca1f0d\",\"maxLevels\":1},\"entryTypes\":{\"dd0006ba-780b-4588-a52b-af08d9439c9a\":{\"name\":\"Image Cards\",\"handle\":\"imageCards\",\"hasTitleField\":true,\"titleLabel\":\"Title\",\"titleFormat\":\"\",\"sortOrder\":1,\"fieldLayouts\":{\"5d453106-4cb6-4f97-8d55-5d8cf00b35fc\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"18d5ee1b-53c5-415a-8fd8-b53d9d43f763\":{\"required\":false,\"sortOrder\":3},\"96cdbd77-6e4d-414a-9b67-56b4900b420c\":{\"required\":true,\"sortOrder\":1},\"edacbb61-d979-4e62-bfed-e8425456b1f1\":{\"required\":true,\"sortOrder\":2}}}]}}}}},\"66a3cf92-176e-4832-aa38-7dae6e1c0893\":{\"name\":\"Insight Blocks\",\"handle\":\"insightBlocks\",\"type\":\"structure\",\"enableVersioning\":true,\"propagationMethod\":\"all\",\"siteSettings\":{\"f2559c18-7489-4189-aecc-54995f3bff7a\":{\"enabledByDefault\":true,\"hasUrls\":false,\"uriFormat\":null,\"template\":null}},\"structure\":{\"uid\":\"978bc0b8-ba5a-4010-926e-35f6bf2a817f\",\"maxLevels\":1},\"entryTypes\":{\"c881ae05-8a22-4968-8734-08b073732300\":{\"name\":\"Insight Blocks\",\"handle\":\"insightBlocks\",\"hasTitleField\":true,\"titleLabel\":\"Title\",\"titleFormat\":\"\",\"sortOrder\":1,\"fieldLayouts\":{\"087dc529-9ea2-4ef6-b449-c87f44493ace\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"18d5ee1b-53c5-415a-8fd8-b53d9d43f763\":{\"required\":false,\"sortOrder\":4},\"68f23f3b-294a-4e72-ba7e-7ce480addad5\":{\"required\":false,\"sortOrder\":1},\"96cdbd77-6e4d-414a-9b67-56b4900b420c\":{\"required\":true,\"sortOrder\":2},\"edacbb61-d979-4e62-bfed-e8425456b1f1\":{\"required\":true,\"sortOrder\":3}}}]}}}}},\"e7de7111-7a23-4566-8072-2617f5279d89\":{\"name\":\"Home Page\",\"handle\":\"homePage\",\"type\":\"single\",\"enableVersioning\":true,\"propagationMethod\":\"all\",\"siteSettings\":{\"f2559c18-7489-4189-aecc-54995f3bff7a\":{\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"/\",\"template\":\"index\"}},\"entryTypes\":{\"74bc750a-9481-44ba-92d8-d13059d3c272\":{\"name\":\"Home Page\",\"handle\":\"homePage\",\"hasTitleField\":false,\"titleLabel\":\"\",\"titleFormat\":\"{section.name|raw}\",\"sortOrder\":1,\"fieldLayouts\":{\"5f057e54-102d-4009-a3da-360012a2e9ff\":{\"tabs\":[{\"name\":\"Content\",\"sortOrder\":1,\"fields\":{\"c0107872-0d5b-4aa9-8369-7a4dae65cc08\":{\"required\":false,\"sortOrder\":1}}}]}}}}}},\"fields\":{\"7ca16c4a-c225-4879-b65f-aad29c84a651\":{\"name\":\"Hero Image\",\"handle\":\"heroImage\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Assets\",\"settings\":{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"singleUploadLocationSubpath\":\"images\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false},\"contentColumnType\":\"string\",\"fieldGroup\":\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\"},\"0a68a217-6bc5-49ac-bdd1-14e540d37976\":{\"name\":\"Accent Color\",\"handle\":\"accentColor\",\"instructions\":\"Choose a color for the blocks accent\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Dropdown\",\"settings\":{\"options\":[{\"label\":\"Brand Red\",\"value\":\"brandRed\",\"default\":\"1\"},{\"label\":\"Brand Blue\",\"value\":\"brandBlue\",\"default\":\"\"},{\"label\":\"Brand Green\",\"value\":\"brandGreen\",\"default\":\"\"},{\"label\":\"Brand Orange\",\"value\":\"brandOrange\",\"default\":\"\"}]},\"contentColumnType\":\"string\",\"fieldGroup\":\"2babdf9b-c278-4420-ade7-ab8175bb80d3\"},\"f0ec0c83-08cc-48d0-9a8b-539f73b52bee\":{\"name\":\"Block Title\",\"handle\":\"blockTitle\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"1\",\"charLimit\":\"\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":\"2babdf9b-c278-4420-ade7-ab8175bb80d3\"},\"77c9f661-7918-4604-9a2d-268172dedf4c\":{\"name\":\"Block Icon\",\"handle\":\"blockIcon\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Assets\",\"settings\":{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"singleUploadLocationSubpath\":\"images/icons\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add an icon for this block\",\"localizeRelations\":false},\"contentColumnType\":\"string\",\"fieldGroup\":\"2babdf9b-c278-4420-ade7-ab8175bb80d3\"},\"b86669c7-1f17-4924-8151-b08b5c5e499f\":{\"name\":\"Block Link\",\"handle\":\"blockLink\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Entries\",\"settings\":{\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"1\",\"selectionLabel\":\"Select another entry to link to\",\"localizeRelations\":false},\"contentColumnType\":\"string\",\"fieldGroup\":\"2babdf9b-c278-4420-ade7-ab8175bb80d3\"},\"8ad551d3-1d49-460d-b73f-7f8b70de3740\":{\"name\":\"Herousel Slides\",\"handle\":\"herouselSlides\",\"instructions\":\"Select up to four slides for the herousel.\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Entries\",\"settings\":{\"sources\":[\"section:f4806157-8213-4481-a5ca-4697ca313dfe\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"4\",\"selectionLabel\":\"Add a slide to the herousel\",\"localizeRelations\":false},\"contentColumnType\":\"string\",\"fieldGroup\":\"4b19cdc5-eb0d-43c0-a63b-60bacd175db4\"},\"18d5ee1b-53c5-415a-8fd8-b53d9d43f763\":{\"name\":\"Entry Image\",\"handle\":\"entryImage\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Assets\",\"settings\":{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"defaultUploadLocationSubpath\":\"images/\",\"singleUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"},\"contentColumnType\":\"string\",\"fieldGroup\":\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\"},\"96cdbd77-6e4d-414a-9b67-56b4900b420c\":{\"name\":\"Copy\",\"handle\":\"copy\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"Lorem ipsum dolor sit amet...\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"1\",\"charLimit\":\"\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\"},\"f3d95e24-acd1-44aa-b881-d39395747064\":{\"name\":\"Slide Category\",\"handle\":\"slideCategory\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\"},\"2db23733-dff0-4265-a542-6ecad5cb1b9e\":{\"name\":\"CTA Copy\",\"handle\":\"ctaCopy\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"25\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\"},\"edacbb61-d979-4e62-bfed-e8425456b1f1\":{\"name\":\"CTA Link\",\"handle\":\"ctaLink\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Entries\",\"settings\":{\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"1\",\"selectionLabel\":\"Select another entry to link to\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"},\"contentColumnType\":\"string\",\"fieldGroup\":\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\"},\"68f23f3b-294a-4e72-ba7e-7ce480addad5\":{\"name\":\"Related Category\",\"handle\":\"relatedCategory\",\"instructions\":\"\",\"searchable\":true,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Categories\",\"settings\":{\"allowLimit\":false,\"allowMultipleSources\":false,\"branchLimit\":\"1\",\"sources\":\"*\",\"source\":\"group:85c77f35-48e4-42ff-a631-57f0612aaf53\",\"targetSiteId\":null,\"viewMode\":null,\"limit\":null,\"selectionLabel\":\"\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"},\"contentColumnType\":\"string\",\"fieldGroup\":\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\"},\"038069ec-817a-4271-8329-8800920a9077\":{\"name\":\"Contact Street Address\",\"handle\":\"contactStreetAddress\",\"instructions\":\"\",\"searchable\":false,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\"},\"3e14ad63-16b6-4e2c-9006-913712819550\":{\"name\":\"Contact Phone\",\"handle\":\"contactPhone\",\"instructions\":\"\",\"searchable\":false,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\"},\"1953e64d-f917-4bce-a0df-82f0221e3e64\":{\"name\":\"Contact State\",\"handle\":\"contactState\",\"instructions\":\"\",\"searchable\":false,\"translationMethod\":\"none\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\PlainText\",\"settings\":{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"},\"contentColumnType\":\"text\",\"fieldGroup\":\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\"},\"c0107872-0d5b-4aa9-8369-7a4dae65cc08\":{\"name\":\"Herousel\",\"handle\":\"herousel\",\"instructions\":\"Select a Herousel to use on the page.\",\"searchable\":false,\"translationMethod\":\"site\",\"translationKeyFormat\":null,\"type\":\"craft\\\\fields\\\\Entries\",\"settings\":{\"sources\":[\"section:06021517-c456-4337-a55c-342f170b509e\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"},\"contentColumnType\":\"string\",\"fieldGroup\":\"4b19cdc5-eb0d-43c0-a63b-60bacd175db4\"}},\"volumes\":{\"50afdfd7-6c44-4e96-973a-b03967ec3cac\":{\"name\":\"Uploads\",\"handle\":\"uploads\",\"type\":\"craft\\\\volumes\\\\Local\",\"hasUrls\":true,\"url\":\"@web/uploads\",\"settings\":{\"path\":\"@webroot/uploads/\"},\"sortOrder\":1}},\"categoryGroups\":{\"85c77f35-48e4-42ff-a631-57f0612aaf53\":{\"name\":\"Digital Insights\",\"handle\":\"digitalInsights\",\"structure\":{\"uid\":\"fe8e586c-734e-4d4c-a28a-94addd5bc033\",\"maxLevels\":1},\"siteSettings\":{\"f2559c18-7489-4189-aecc-54995f3bff7a\":{\"hasUrls\":false,\"uriFormat\":null,\"template\":null}}}},\"globalSets\":{\"2cdb6263-8e70-47fa-a8d8-e0f7178e1fb6\":{\"name\":\"Contact Info\",\"handle\":\"contactInfo\",\"fieldLayouts\":{\"cbb838b2-a710-4a92-ba0d-d241b3abbbc3\":{\"tabs\":[{\"name\":\"Information\",\"sortOrder\":1,\"fields\":{\"038069ec-817a-4271-8329-8800920a9077\":{\"required\":false,\"sortOrder\":1},\"1953e64d-f917-4bce-a0df-82f0221e3e64\":{\"required\":false,\"sortOrder\":2},\"3e14ad63-16b6-4e2c-9006-913712819550\":{\"required\":false,\"sortOrder\":3}}}]}}}},\"routes\":[]}','[]','ETBN1mfBR1HN','2019-06-29 17:33:17','2019-07-12 12:23:13','65f5429e-47ff-4db3-9d7d-6a0c17149af6');

/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks`;

CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table matrixblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocktypes`;

CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `pluginId`, `type`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'app','Install','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','30d7850c-32c3-4f47-9581-b88bb45a40ff'),
	(2,NULL,'app','m150403_183908_migrations_table_changes','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','a4c059a8-5f22-4a58-ac16-583ddb5d2292'),
	(3,NULL,'app','m150403_184247_plugins_table_changes','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','235d52b8-9feb-46a4-9f63-4560f25407f1'),
	(4,NULL,'app','m150403_184533_field_version','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','92253ddf-6ee2-4189-89fe-f495117e1907'),
	(5,NULL,'app','m150403_184729_type_columns','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','d8671aeb-4c2c-4735-8e76-0b1de9163883'),
	(6,NULL,'app','m150403_185142_volumes','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','66810651-15cc-4761-a5a4-42a9b904d37d'),
	(7,NULL,'app','m150428_231346_userpreferences','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','3b9e19bf-fcb4-4991-8354-ea587647394d'),
	(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','dd6554a0-e8dc-4c7b-9db9-b0682975257c'),
	(9,NULL,'app','m150617_213829_update_email_settings','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','6b6a598c-26a7-4bcd-943f-ddcef1b3d9ec'),
	(10,NULL,'app','m150721_124739_templatecachequeries','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','4461d0f0-7e30-4099-b844-8895fdb6bded'),
	(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','d9031f7a-f79b-4ea5-8988-2a7ac025b326'),
	(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','4827fd14-8aac-4aea-bf72-6f251270e15e'),
	(13,NULL,'app','m151002_095935_volume_cache_settings','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','f5b2f0c5-6cdf-449c-8f4b-3897b6a6120c'),
	(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','ae3ecf0f-f0f9-4da9-a6fa-9f9204ac0d40'),
	(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','377a7c2d-5c5a-44b0-addb-ecd98a07fff6'),
	(16,NULL,'app','m151209_000000_move_logo','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','7ac4589f-4c40-44f7-b3dc-f5fc88e67f13'),
	(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','74ee0bff-f5bd-4330-a72d-974c554779b8'),
	(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','fedc65d1-0a89-4c6f-851c-904f06e756d9'),
	(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','10a17b21-34af-4e74-a416-e762be2992a3'),
	(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','c2969fee-2594-4f40-97dc-1175abc39efe'),
	(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','e4df9e43-127b-49ac-99e2-8d702cd38f92'),
	(22,NULL,'app','m160727_194637_column_cleanup','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','3b147c19-e6f3-47af-bee5-2633c8f36ac1'),
	(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','82ac0ef8-d2b2-4172-81b0-14438ad413b4'),
	(24,NULL,'app','m160807_144858_sites','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','a8f1d7db-a2dd-4437-97b4-f07d4418611b'),
	(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','3436e201-5680-4509-9100-4017b903ee50'),
	(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','169f9a42-2dc5-4f13-ae05-b0b542138ad0'),
	(27,NULL,'app','m160912_230520_require_entry_type_id','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','c80743a1-85e9-4304-9e3f-82ad48483470'),
	(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','605aa4e8-2265-47b4-8d52-dc183e56ea08'),
	(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','745d2478-ef06-412e-817d-45b00fd2d63a'),
	(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','a031d816-2c79-47b0-8bca-ea7fc0198020'),
	(31,NULL,'app','m160925_113941_route_uri_parts','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','ed495240-bb98-49a4-9cf4-7838f9930e86'),
	(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','c357125a-56e8-46ca-9da8-ff4b5b75c058'),
	(33,NULL,'app','m161007_130653_update_email_settings','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','733d8a17-f588-4d72-a8e2-8c5eb4963f68'),
	(34,NULL,'app','m161013_175052_newParentId','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','a95cf80e-1542-4591-ac35-0e0709091481'),
	(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','1365be7c-324a-4149-afe4-edbcfce8ff5c'),
	(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','116ad5ca-7926-4965-8b52-3b77aa955d6d'),
	(37,NULL,'app','m161025_000000_fix_char_columns','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','7b5a58f9-199a-4d07-a97e-e660cb63b075'),
	(38,NULL,'app','m161029_124145_email_message_languages','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','b7a7a2ac-25db-4df8-b767-e7bd860c3cda'),
	(39,NULL,'app','m161108_000000_new_version_format','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','966b5282-73fe-4750-b0cd-e83e6faa378e'),
	(40,NULL,'app','m161109_000000_index_shuffle','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','73538633-b88b-4f0c-960d-2ea35be4892a'),
	(41,NULL,'app','m161122_185500_no_craft_app','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','9918fa03-a65d-4a1a-a1a8-903ff82e5e5a'),
	(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','82b5007a-59af-4173-b192-a2ee18e54c07'),
	(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','466644d2-eac0-4c1a-96b4-7a1891edc195'),
	(44,NULL,'app','m170114_161144_udates_permission','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','58eb1e50-503b-4611-b1aa-7531b5db1d0e'),
	(45,NULL,'app','m170120_000000_schema_cleanup','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','dc7d4c44-c373-47a0-b228-9a64d3140a6d'),
	(46,NULL,'app','m170126_000000_assets_focal_point','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','1e0a4ea2-5172-4bce-a95f-2295463f804d'),
	(47,NULL,'app','m170206_142126_system_name','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','9950279a-85d2-46e9-8771-7ed781145905'),
	(48,NULL,'app','m170217_044740_category_branch_limits','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','e7f8c248-6543-449b-9206-d1fcc48c1ae3'),
	(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','238aa501-1f0a-4c04-8a35-bcd5eeca1fa4'),
	(50,NULL,'app','m170223_224012_plain_text_settings','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','d2778171-9be8-4b8c-9b75-79ee720caedc'),
	(51,NULL,'app','m170227_120814_focal_point_percentage','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','f568860e-6b96-4a23-b2fa-101d3e7c424a'),
	(52,NULL,'app','m170228_171113_system_messages','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','4cf9e054-26cf-449b-95dc-88380827bd6f'),
	(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','7fed33d7-cbbe-46b4-a505-670eb24fbb3d'),
	(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','3dee8079-f290-42bf-bca2-16cd98a4f131'),
	(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','ca276712-3ebf-4b07-ad6f-c659ec2cb56b'),
	(56,NULL,'app','m170612_000000_route_index_shuffle','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','9a9a73f4-b403-4102-a9be-e9e1f523293d'),
	(57,NULL,'app','m170621_195237_format_plugin_handles','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','e92d8deb-fbd5-422a-8a57-784383c5f270'),
	(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','1352b464-dbee-4c91-93a2-b262aa73c01f'),
	(59,NULL,'app','m170630_161028_deprecation_changes','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','c59fce70-1eb3-4e33-bfe6-d5c13717b072'),
	(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','87de3adf-4a1e-47bf-9607-c4182f0d01cf'),
	(61,NULL,'app','m170704_134916_sites_tables','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','4ed8b2ea-deb0-40b1-a0e3-a904d3e39079'),
	(62,NULL,'app','m170706_183216_rename_sequences','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','eaecc142-73bc-4ade-a2f6-2126878b6934'),
	(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','6a068360-67d5-4f33-9c79-22740ae97bca'),
	(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','2077b29e-38ad-4498-96fe-8f31c9e24557'),
	(65,NULL,'app','m170810_201318_create_queue_table','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','8dc956eb-7d95-484b-aefe-206309ef7bd2'),
	(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','50db017e-1f94-4382-ab9e-1e4cbf2e09b8'),
	(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','7e0ce9d0-085a-405c-81b1-49c223a6eb72'),
	(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','991eaffe-71c3-4bb0-8189-cb103cc736c4'),
	(69,NULL,'app','m171011_214115_site_groups','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','011b3cb7-ff3e-4d36-bd1d-b3e309ef5581'),
	(70,NULL,'app','m171012_151440_primary_site','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','829f8af3-deaf-4b19-a3d5-ed7744132162'),
	(71,NULL,'app','m171013_142500_transform_interlace','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','4375c185-b5fc-43ec-8b64-f6bfc14223ef'),
	(72,NULL,'app','m171016_092553_drop_position_select','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','899c9024-36f2-44d5-90c4-150330564071'),
	(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','429a306e-6b2c-41da-b5cb-516642a06052'),
	(74,NULL,'app','m171107_000000_assign_group_permissions','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','90bcccd7-bdae-4576-abfc-25ab6cd935e4'),
	(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','9e8c17f3-a6d5-42c2-954e-daa711dd74ce'),
	(76,NULL,'app','m171126_105927_disabled_plugins','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','2a6d1461-25e0-4bbc-8c3b-27e4fe0fffb4'),
	(77,NULL,'app','m171130_214407_craftidtokens_table','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','67d2c51b-57f2-442c-bf58-5cb0a5b2e166'),
	(78,NULL,'app','m171202_004225_update_email_settings','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','60f3978b-ddc3-4f9f-8dfa-0405b8965174'),
	(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','83e1e4bd-4aa6-45eb-ad4e-faf1aab57517'),
	(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','2eb39813-e6ab-4873-8e8b-ec9db53b8604'),
	(81,NULL,'app','m171218_143135_longtext_query_column','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','85813df1-fa6f-45f5-8716-9197dfc2cfe1'),
	(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','979e5183-7ce3-44f8-9530-c5f982c4f799'),
	(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','7ea03c7c-bfbc-4042-8084-97f00d8a91d9'),
	(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','32025dec-d31e-451f-b73d-2f1f8396894e'),
	(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','e6fae219-f696-46a3-b167-d3cf3a9515c0'),
	(86,NULL,'app','m180128_235202_set_tag_slugs','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','ceb7a638-9ca2-4cdc-94d8-a102f30bf612'),
	(87,NULL,'app','m180202_185551_fix_focal_points','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','550ef84e-a1d2-48cf-80d2-9cc7a1f815a4'),
	(88,NULL,'app','m180217_172123_tiny_ints','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','1aca0f1b-ef2a-4469-a6d7-ccde755dedc4'),
	(89,NULL,'app','m180321_233505_small_ints','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','a8c9cc40-ec95-4b27-afe3-70311fd72f6d'),
	(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','5a1d09ff-66ef-4fdf-8ab3-696305cc5f74'),
	(91,NULL,'app','m180404_182320_edition_changes','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','13cb36c8-1e37-4084-bce1-88a1ab9104f1'),
	(92,NULL,'app','m180411_102218_fix_db_routes','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','5176fd25-54c2-498b-8119-5c961c1b5c7a'),
	(93,NULL,'app','m180416_205628_resourcepaths_table','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','5cdf2660-c5be-4e33-8f1c-3c844f7357ba'),
	(94,NULL,'app','m180418_205713_widget_cleanup','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','7d291cc9-fe15-4131-b227-2a07b65373f2'),
	(95,NULL,'app','m180425_203349_searchable_fields','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','5f8cc578-0877-488b-8b8d-7fa5a4dbfeeb'),
	(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','ecf73ced-c18d-40a0-afce-133ef31d467d'),
	(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','240e1dd6-62dd-4156-b63f-307c2a32e2ec'),
	(98,NULL,'app','m180518_173000_permissions_to_uid','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','a8798466-6c31-42ef-8bba-d8c08f70d8b0'),
	(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','f087c304-5162-4183-8ce2-bf6df3ebfc1c'),
	(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','d86ca013-6087-4f9b-88f0-4c133d4020ea'),
	(101,NULL,'app','m180731_162030_soft_delete_sites','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','062070ae-1491-488d-a610-f3f798ed3919'),
	(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','81d69dcd-8199-41cb-b460-df19f62979b8'),
	(103,NULL,'app','m180810_214439_soft_delete_elements','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','50648758-1089-4f34-92f8-4936ba2c6b55'),
	(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','bd6d8fe9-2cdd-4b00-b9ae-b5d3f9924563'),
	(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','1fc6e86b-92cc-48e3-9e7c-560a11397989'),
	(106,NULL,'app','m180904_112109_permission_changes','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','69afef1c-1473-4311-82f0-e49cd7b289fd'),
	(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','e8acde08-c785-4608-b4ab-e31f941f26c7'),
	(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','17408946-bfb7-45fe-998e-c79989aa8424'),
	(109,NULL,'app','m181016_183648_set_default_user_settings','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','dde15e15-0a8d-4722-b841-95257d4c9509'),
	(110,NULL,'app','m181017_225222_system_config_settings','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','d25bc263-56d2-450f-a862-fddb84c770a6'),
	(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','69a4f777-2469-49ad-8d6f-1ce3eaf76cbb'),
	(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','fcd5e97f-e4b9-4dd3-8174-b05f9fc9e1f7'),
	(113,NULL,'app','m181112_203955_sequences_table','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','a2e1060c-6f62-4c47-99bb-d26226584841'),
	(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','b9834e50-a6f8-4566-af8d-95c9619d72a0'),
	(115,NULL,'app','m181128_193942_fix_project_config','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','7bf59097-a91f-44f7-940b-481530311e1f'),
	(116,NULL,'app','m181130_143040_fix_schema_version','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','977b50ab-5bd0-4d4f-9814-6b92b75fb667'),
	(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','a660442f-6426-4ce4-8bea-2b905f54e2e2'),
	(118,NULL,'app','m181213_102500_config_map_aliases','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','2316fb49-1fbd-4de1-a8e3-24be35540a25'),
	(119,NULL,'app','m181217_153000_fix_structure_uids','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','624315f8-d989-425e-87bb-63562071e79f'),
	(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','e97a11de-fd4d-4e2f-a89f-7ab58541b9e3'),
	(121,NULL,'app','m190108_110000_cleanup_project_config','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','a067aafd-b170-45c4-9236-f720b9ce9d3e'),
	(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','82b8093d-d827-4e8e-9555-a89add27b860'),
	(123,NULL,'app','m190109_172845_fix_colspan','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','73fa288b-a446-4e89-af75-ba7d7aab76dd'),
	(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','a9ecfad7-ef34-4698-9b82-39f300780d8e'),
	(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','0d3a8682-dfbf-459b-a390-6fa75829aac5'),
	(126,NULL,'app','m190112_124737_fix_user_settings','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','46232b1d-64c5-4310-ad63-7b22680fa4df'),
	(127,NULL,'app','m190112_131225_fix_field_layouts','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','186f6fec-c20c-4c42-bb44-bb3953ff6dcd'),
	(128,NULL,'app','m190112_201010_more_soft_deletes','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','b97bffb9-cd2e-4db8-b1ad-d61722d52318'),
	(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','4fa7b88d-042f-468f-be44-4170547eeb09'),
	(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','3c6f9081-e44f-4ea7-a72e-35510500f363'),
	(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','ecc744c1-3d5d-4433-966d-72915db8c0ea'),
	(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','e4a69c32-1a17-4af7-9edc-86629fb21726'),
	(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','2b14bb8f-9021-4df4-b0e5-b0f9ba3190dd'),
	(134,NULL,'app','m190208_140000_reset_project_config_mapping','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','bb6dcec0-cea1-4a05-b447-31527a3b84d4'),
	(135,NULL,'app','m190218_143000_element_index_settings_uid','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','a21f1326-d8eb-48c9-8b38-e865007ed1a0'),
	(136,NULL,'app','m190401_223843_drop_old_indexes','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','3e80c8ee-8e1c-4eee-a937-c75dbecd7c00'),
	(137,NULL,'app','m190416_014525_drop_unique_global_indexes','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','f7eda665-6cbc-4c6d-b62a-d6f159dd9b03'),
	(138,NULL,'app','m190502_122019_store_default_user_group_uid','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','57bed546-4371-43e1-8e72-b3e2d72035cd'),
	(139,NULL,'app','m190312_152740_element_revisions','2019-07-12 12:24:05','2019-07-12 12:24:05','2019-07-12 12:24:05','8280dd54-20df-49cc-9dae-b22ec8618042'),
	(140,NULL,'app','m190327_235137_propagation_method','2019-07-12 12:24:05','2019-07-12 12:24:05','2019-07-12 12:24:05','f928fe99-01a9-4437-906c-3962c3778966'),
	(141,NULL,'app','m190417_085010_add_image_editor_permissions','2019-07-12 12:24:05','2019-07-12 12:24:05','2019-07-12 12:24:05','f6b56534-da18-4fc5-95df-f2d44c03d982'),
	(142,NULL,'app','m190504_150349_preview_targets','2019-07-12 12:24:05','2019-07-12 12:24:05','2019-07-12 12:24:05','6cb0079e-a1b4-419f-8b22-2d4349cf2f36'),
	(143,NULL,'app','m190516_184711_job_progress_label','2019-07-12 12:24:05','2019-07-12 12:24:05','2019-07-12 12:24:05','e1a6e4d3-659b-4f8e-8c46-571f1e815961'),
	(144,NULL,'app','m190523_190303_optional_revision_creators','2019-07-12 12:24:05','2019-07-12 12:24:05','2019-07-12 12:24:05','d49f8018-0d4e-425b-be39-196be65b59e9'),
	(145,NULL,'app','m190529_204501_fix_duplicate_uids','2019-07-12 12:24:05','2019-07-12 12:24:05','2019-07-12 12:24:05','ee36d4f5-73aa-419b-9361-898c0e8ea77b'),
	(146,NULL,'app','m190605_223807_unsaved_drafts','2019-07-12 12:24:05','2019-07-12 12:24:05','2019-07-12 12:24:05','e91c2cb2-772d-4143-af2d-88742e7e64e8'),
	(147,NULL,'app','m190607_230042_entry_revision_error_tables','2019-07-12 12:24:05','2019-07-12 12:24:05','2019-07-12 12:24:05','93e1638c-8772-4a37-9bb6-c806002086aa'),
	(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2019-07-12 12:24:05','2019-07-12 12:24:05','2019-07-12 12:24:05','42dd538d-07f7-4491-9b64-2f431480e4d4'),
	(149,NULL,'app','m190624_234204_matrix_propagation_method','2019-07-12 12:24:05','2019-07-12 12:24:05','2019-07-12 12:24:05','b3d95ab3-aa8f-45ec-a145-1d3d9843f3f7'),
	(150,NULL,'app','m190709_111144_nullable_revision_id','2019-07-12 12:24:05','2019-07-12 12:24:05','2019-07-12 12:24:05','99bdd1ac-0c4f-4c42-a4c5-43b7353386e6'),
	(151,NULL,'app','m190711_153020_drop_snapshots','2019-07-12 12:24:05','2019-07-12 12:24:05','2019-07-12 12:24:05','e6d4d909-ddbf-447b-8193-8447d5185de7'),
	(152,NULL,'app','m190712_195914_no_draft_revisions','2019-07-18 17:05:06','2019-07-18 17:05:06','2019-07-18 17:05:06','c84f463f-e7c5-4142-8f07-345c7609cf8e'),
	(153,NULL,'app','m190723_140314_fix_preview_targets_column','2019-07-25 00:31:51','2019-07-25 00:31:51','2019-07-25 00:31:51','94f746b4-aa3e-4602-8306-6a69977d9f86');

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table plugins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugins`;

CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relations`;

CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;

INSERT INTO `relations` (`id`, `fieldId`, `sourceId`, `sourceSiteId`, `targetId`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,4,NULL,3,1,'2019-06-29 22:24:09','2019-06-29 22:24:09','3ddcd1a3-057a-410b-ad63-29bfb73dd000'),
	(16,5,5,NULL,18,1,'2019-07-09 00:37:37','2019-07-09 00:37:37','19472324-19c5-479a-b392-731091009b3d'),
	(17,4,5,NULL,21,1,'2019-07-09 00:37:37','2019-07-09 00:37:37','ac9b72e8-11e7-4203-81e0-b0eb65b245fe'),
	(18,5,6,NULL,17,1,'2019-07-09 00:37:54','2019-07-09 00:37:54','d414023f-cf89-4296-996c-83897f917e9b'),
	(19,4,6,NULL,22,1,'2019-07-09 00:37:54','2019-07-09 00:37:54','e94752e6-f505-49be-9f4a-3620df453266'),
	(20,5,7,NULL,18,1,'2019-07-09 00:37:59','2019-07-09 00:37:59','9caa2d29-854f-44fe-9a51-3b78a3bc402d'),
	(21,4,7,NULL,23,1,'2019-07-09 00:37:59','2019-07-09 00:37:59','ffc387bd-4871-4076-836c-af3ff3750692'),
	(22,5,8,NULL,18,1,'2019-07-09 00:38:16','2019-07-09 00:38:16','e2d3639d-177d-4001-97b8-7447585fc629'),
	(23,4,8,NULL,24,1,'2019-07-09 00:38:16','2019-07-09 00:38:16','5cc64eed-036c-47a1-bf05-d6f910538499'),
	(26,5,25,NULL,18,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','3f7cda0e-fa45-4123-b2b4-b0ef220be408'),
	(27,4,25,NULL,24,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','25d22483-e231-4296-b81f-854e96e7d63b'),
	(30,5,26,NULL,18,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','2d0957b4-99fa-43ba-9bce-ad0a7a1e4479'),
	(31,4,26,NULL,23,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','02fb6fc5-87a1-46a6-be97-1421aa90af2d'),
	(34,5,27,NULL,17,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','c1162fc4-1f05-4ec3-8086-770294c41792'),
	(35,4,27,NULL,22,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','82d60bdc-68ad-4f8e-85a4-159e80753978'),
	(38,5,28,NULL,18,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','9d516b9a-27bf-4bd1-a4c9-bad7ca1c4462'),
	(39,4,28,NULL,21,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','940af0a2-fba5-4f0d-b101-64b7a8fcfe23'),
	(42,5,29,NULL,18,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','4dec9d2c-2e02-4cb7-9ecd-5b58dc73edaf'),
	(43,4,29,NULL,24,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','4655eb76-08d7-450d-8689-26badf9cb255'),
	(46,5,30,NULL,18,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','ccc39d26-ee8b-49a2-aa03-ed5b6fd4b8f4'),
	(47,4,30,NULL,23,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','754be3bb-f5bf-4fac-9ffe-8e62a755d505'),
	(50,5,31,NULL,17,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','16154a89-7e98-41ea-9da6-9eedb645dc12'),
	(51,4,31,NULL,22,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','c84ccf77-c86f-40de-8036-b753012011fe'),
	(54,5,32,NULL,18,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','c14f30d6-b5a4-4e8d-9ba4-7fc2e87a01a7'),
	(55,4,32,NULL,21,1,'2019-07-12 12:24:07','2019-07-12 12:24:07','9694cc6c-8213-437c-bf72-de8c827d429d'),
	(58,4,33,NULL,21,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','dcedc6c8-f220-48f9-8a4c-88fb04b81b2d'),
	(67,5,37,NULL,18,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','5667e1c3-0781-436c-9a36-8b8a9233320f'),
	(69,6,48,NULL,10,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','f1e9dde7-b64f-4e6a-9b82-d8a742f62f24'),
	(71,8,49,NULL,3,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','44fa9757-1ad1-42c0-9ff7-2bcb696e8b34'),
	(73,6,50,NULL,4,1,'2019-07-12 12:24:08','2019-07-12 12:24:08','b146e3e0-85f4-4a95-9333-81c4004e5b7c'),
	(93,13,60,NULL,20,1,'2019-07-12 13:46:08','2019-07-12 13:46:08','d3e3d348-3f18-4c6a-bd89-324041dcd490'),
	(94,8,60,NULL,59,1,'2019-07-12 13:46:08','2019-07-12 13:46:08','f10f85a7-1b87-4249-95d2-119b9398653e'),
	(97,8,61,NULL,3,1,'2019-07-12 13:47:40','2019-07-12 13:47:40','e831765c-c63e-40b4-9df3-fb9b3c31ccfa'),
	(109,8,63,NULL,3,1,'2019-07-12 13:48:15','2019-07-12 13:48:15','b1e2a98a-4680-4ffd-9e14-775d2d506b64'),
	(126,13,65,NULL,20,1,'2019-07-12 13:48:58','2019-07-12 13:48:58','62306525-1269-4411-b803-5ed7d89caac3'),
	(127,8,65,NULL,59,1,'2019-07-12 13:48:58','2019-07-12 13:48:58','332afdff-b99c-480f-b280-25d0086d3832'),
	(135,6,67,NULL,10,1,'2019-07-12 13:49:06','2019-07-12 13:49:06','2f2b4403-e117-4b37-befc-9086a7ab7eae'),
	(136,6,67,NULL,58,2,'2019-07-12 13:49:06','2019-07-12 13:49:06','9bedc4b2-0b04-46b1-b717-e9a5a5376d44'),
	(142,13,71,NULL,16,1,'2019-07-12 15:27:35','2019-07-12 15:27:35','2c04fd91-58cf-47e4-bbc2-c6f03324e689'),
	(143,8,71,NULL,59,1,'2019-07-12 15:27:35','2019-07-12 15:27:35','62f7242b-ad7d-40b2-9d87-ce931ffc7f8d'),
	(151,13,73,NULL,19,1,'2019-07-12 15:31:20','2019-07-12 15:31:20','7100a85b-f9e6-431f-b848-7cfc27afd824'),
	(152,8,73,NULL,3,1,'2019-07-12 15:31:20','2019-07-12 15:31:20','448fbade-e714-4357-958e-7b022d961d1d'),
	(157,13,75,NULL,19,1,'2019-07-12 15:32:41','2019-07-12 15:32:41','4813a898-e448-405b-9818-49afc730cc3c'),
	(158,8,75,NULL,3,1,'2019-07-12 15:32:41','2019-07-12 15:32:41','4e542cc2-9f5e-4e8c-9ae7-0b4daf941018'),
	(170,13,78,NULL,19,1,'2019-07-12 15:34:11','2019-07-12 15:34:11','55725833-c2c3-4218-95ae-b13febdd67b6'),
	(171,8,78,NULL,77,1,'2019-07-12 15:34:11','2019-07-12 15:34:11','c3daaef1-6abc-4421-8d0d-931833d5984e'),
	(177,13,81,NULL,17,1,'2019-07-12 15:45:56','2019-07-12 15:45:56','4d6431fb-090a-44d5-a539-e25178f32886'),
	(178,8,81,NULL,59,1,'2019-07-12 15:45:56','2019-07-12 15:45:56','39492395-7a55-484b-a658-6f172d158978'),
	(186,13,83,NULL,18,1,'2019-07-12 15:46:50','2019-07-12 15:46:50','ded288f8-687e-401f-a03e-bddb8b55f92f'),
	(187,8,83,NULL,3,1,'2019-07-12 15:46:50','2019-07-12 15:46:50','aaa18c74-3335-4736-b65e-a0317ca65e48'),
	(201,14,87,NULL,85,1,'2019-07-12 15:50:51','2019-07-12 15:50:51','eca65310-0142-43d1-b5c4-02ac23485d5d'),
	(202,13,87,NULL,18,1,'2019-07-12 15:50:51','2019-07-12 15:50:51','7e43e5e6-a077-4452-8de9-933bdd8691a6'),
	(203,8,87,NULL,3,1,'2019-07-12 15:50:51','2019-07-12 15:50:51','e20c502d-536c-459e-8b00-c160c424bec4'),
	(215,14,89,NULL,84,1,'2019-07-12 15:50:58','2019-07-12 15:50:58','d2227100-1fbd-4c5a-abe2-1c776e262bb1'),
	(216,13,89,NULL,17,1,'2019-07-12 15:50:58','2019-07-12 15:50:58','d5babe20-3975-4f54-855a-15e918d625e3'),
	(217,8,89,NULL,59,1,'2019-07-12 15:50:58','2019-07-12 15:50:58','b1d771d6-f9f3-4fdb-a52c-093abb697397'),
	(218,14,80,NULL,84,1,'2019-07-12 16:03:54','2019-07-12 16:03:54','4100b0d5-8078-4bfc-b68b-33f9f88ca052'),
	(219,13,80,NULL,17,1,'2019-07-12 16:03:54','2019-07-12 16:03:54','4a95f23b-bec5-4628-b63d-d83d5d8c18b6'),
	(220,8,80,NULL,59,1,'2019-07-12 16:03:54','2019-07-12 16:03:54','a38aae84-45a8-4cc0-b669-66f5cad3e325'),
	(221,14,82,NULL,85,1,'2019-07-12 16:03:54','2019-07-12 16:03:54','50c1284c-058b-4b01-8c93-57002a22ae2e'),
	(222,13,82,NULL,18,1,'2019-07-12 16:03:54','2019-07-12 16:03:54','6d5ceeb5-fead-4f5f-b898-22b45124f0e8'),
	(223,8,82,NULL,3,1,'2019-07-12 16:03:54','2019-07-12 16:03:54','5cfe1075-924d-4eea-8aa8-004c0e34c82a'),
	(224,13,70,NULL,16,1,'2019-07-12 16:12:48','2019-07-12 16:12:48','c76599ed-ec3d-4a95-a23c-e2520cb43c4b'),
	(225,8,70,NULL,59,1,'2019-07-12 16:12:48','2019-07-12 16:12:48','caa7230c-b39e-43f9-a830-157b44da90e6'),
	(226,13,72,NULL,19,1,'2019-07-12 16:12:48','2019-07-12 16:12:48','93823d41-3fe6-436f-9a3b-79eababe9aa6'),
	(227,8,72,NULL,3,1,'2019-07-12 16:12:48','2019-07-12 16:12:48','a386d497-ef18-4f52-9881-1f7252b4f243'),
	(228,13,74,NULL,19,1,'2019-07-12 16:12:48','2019-07-12 16:12:48','0ee25e28-fd9d-4561-a005-a5c31a19d397'),
	(229,8,74,NULL,77,1,'2019-07-12 16:12:48','2019-07-12 16:12:48','5aa499ba-cf3b-4a44-bb42-778d02392b8a'),
	(272,19,95,NULL,9,1,'2019-07-25 00:41:57','2019-07-25 00:41:57','5601c1e9-a655-4c66-9c8f-cb14be1a4eff'),
	(274,19,102,NULL,9,1,'2019-07-25 00:44:41','2019-07-25 00:44:41','dcd7f5a3-c68d-4d9f-9634-257796376975'),
	(282,13,58,NULL,20,1,'2019-07-25 02:39:34','2019-07-25 02:39:34','25d072bc-0508-4cf7-9a4d-8baf878b27cf'),
	(283,8,58,NULL,59,1,'2019-07-25 02:39:34','2019-07-25 02:39:34','ad0a545b-717e-4ce8-bebd-029ecbeb3b93'),
	(285,8,104,NULL,103,1,'2019-07-25 02:39:41','2019-07-25 02:39:41','b59c1046-772d-4ba9-8855-b90187b02609'),
	(286,13,10,NULL,99,1,'2019-07-25 14:08:54','2019-07-25 14:08:54','572a1d0c-ab27-469d-9749-bb66214aebcb'),
	(287,8,10,NULL,103,1,'2019-07-25 14:08:54','2019-07-25 14:08:54','51042459-38f0-40a2-813c-0c8d4ad9f264'),
	(288,13,105,NULL,99,1,'2019-07-25 14:08:54','2019-07-25 14:08:54','043c3318-dee3-4545-a6a8-20f89dcac2fc'),
	(289,8,105,NULL,103,1,'2019-07-25 14:08:54','2019-07-25 14:08:54','d110594a-e543-4516-97cc-5dfb99d307f9'),
	(291,19,106,NULL,9,1,'2019-07-25 14:15:52','2019-07-25 14:15:52','effc5ac2-cd27-4f65-ae68-288af3b2d729'),
	(292,19,99,NULL,9,1,'2019-07-25 14:15:52','2019-07-25 14:15:52','cb6b5b69-b5f8-48ef-9226-974744106d65'),
	(293,6,9,NULL,58,1,'2019-07-26 22:07:12','2019-07-26 22:07:12','3fc21754-6d75-48de-8e44-b21737da6296'),
	(294,6,9,NULL,10,2,'2019-07-26 22:07:12','2019-07-26 22:07:12','1897adb5-174b-41d1-98a2-49eb4feb7ae8'),
	(295,6,107,NULL,58,1,'2019-07-26 22:07:12','2019-07-26 22:07:12','c10bf4d0-2dbc-4521-9a59-b0757bb53728'),
	(296,6,107,NULL,10,2,'2019-07-26 22:07:12','2019-07-26 22:07:12','f45a25c4-2fce-4bdd-8e00-e29fe5f24962');

/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table resourcepaths
# ------------------------------------------------------------

DROP TABLE IF EXISTS `resourcepaths`;

CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;

INSERT INTO `resourcepaths` (`hash`, `path`)
VALUES
	('103145d3','@lib/element-resize-detector'),
	('11155747','@app/web/assets/craftsupport/dist'),
	('11880a6b','@lib/velocity'),
	('13b43fac','@app/web/assets/fields/dist'),
	('14d311e2','@app/web/assets/dashboard/dist'),
	('153e6907','@lib/jquery-ui'),
	('17a14a27','@lib/fabric'),
	('18135d49','@app/web/assets/userpermissions/dist'),
	('1d31f8e4','@app/web/assets/updater/dist'),
	('1d977c4f','@app/web/assets/feed/dist'),
	('1f87fb86','@app/web/assets/updateswidget/dist'),
	('213db9e8','@app/web/assets/recententries/dist'),
	('2153190c','@app/web/assets/clearcaches/dist'),
	('221e786c','@app/web/assets/sites/dist'),
	('22316f7f','@app/web/assets/feed/dist'),
	('2717a830','@lib/fileupload'),
	('2748d34e','@app/web/assets/pluginstore/dist'),
	('2c5d2820','@app/web/assets/matrixsettings/dist'),
	('2e2e195b','@lib/velocity'),
	('2e79e19','@lib/garnishjs'),
	('2e93cf38','@app/web/assets/cp/dist'),
	('2f9756e3','@lib/element-resize-detector'),
	('315a899f','@lib/d3'),
	('3209b6b3','@lib/jquery.payment'),
	('3222c58f','@app/web/assets/routes/dist'),
	('3475d3e2','@app/web/assets/editentry/dist'),
	('380271e5','@lib/timepicker'),
	('382d3cee','@lib'),
	('384e8b1b','@app/web/assets/login/dist'),
	('385b950c','@lib/jquery-touch-events'),
	('39516650','@app/web/assets/utilities/dist'),
	('3add9f85','@lib/prismjs'),
	('3c709e65','@app/web/assets/cp/dist'),
	('3fa1ee26','@bower/jquery/dist'),
	('3fffa9ce','@lib/picturefill'),
	('401269ea','@app/web/assets/pluginstore/dist'),
	('41074160','@lib/fileupload'),
	('440e913c','@app/web/assets/sites/dist'),
	('456bd5db','@app/web/assets/feed/dist'),
	('4667034c','@app/web/assets/recententries/dist'),
	('477b5212','@app/web/assets/updateswidget/dist'),
	('47b05d4a','@lib/jquery.payment'),
	('4974a3ff','@lib/velocity'),
	('49e9fed3','@app/web/assets/craftsupport/dist'),
	('49fc5a59','@app/web/assets/assetindexes/dist'),
	('4a1805df','@bower/jquery/dist'),
	('4ce88da9','@app/web/assets/utilities/dist'),
	('52653ab2','@app/web/assets/editentry/dist'),
	('53df3e03','@app/web/assets/generalsettings/dist'),
	('55530c17','@lib/jquery.payment'),
	('5721b2ab','@app/web/assets/tablesettings/dist'),
	('572e002d','@app/web/assets/updater/dist'),
	('574a60cf','@lib/d3'),
	('58fb5482','@bower/jquery/dist'),
	('59ef409e','@lib/picturefill'),
	('5b2a24c1','@app/web/assets/cp/dist'),
	('5b97f2a2','@lib/velocity'),
	('5ccd76d5','@lib/prismjs'),
	('5e0bdcf4','@app/web/assets/utilities/dist'),
	('5e1298b5','@lib/timepicker'),
	('5e4b7c5c','@lib/jquery-touch-events'),
	('5f1431bf','@app/web/assets/login/dist'),
	('5f2191ce','@lib/jquery-ui'),
	('608782fe','@lib/jquery-ui'),
	('60b2228f','@app/web/assets/login/dist'),
	('60d1957a','@lib'),
	('60ef3d40','@app/web/assets/findreplace/dist'),
	('61edc0c0','@lib/xregexp'),
	('648c37f1','@app/web/assets/cp/dist'),
	('64f77749','@lib/garnishjs'),
	('6588ae2a','@lib/element-resize-detector'),
	('6888131d','@app/web/assets/updater/dist'),
	('6ade6c1b','@app/web/assets/routes/dist'),
	('6b81844a','@lib/selectize'),
	('6c792d33','@app/web/assets/generalsettings/dist'),
	('6d3e37c3','@app/web/assets/updates/dist'),
	('6f77560','@app/web/assets/utilities/dist'),
	('71b1a377','@lib/fabric'),
	('72c3f8b2','@app/web/assets/dashboard/dist'),
	('72efed82','@app/web/assets/systemmessages/dist'),
	('74a181b4','@app/web/assets/matrixsettings/dist'),
	('75a4d6fc','@app/web/assets/fields/dist'),
	('764fede3','@app/web/assets/craftsupport/dist'),
	('776bff77','@lib/element-resize-detector'),
	('78b2fde','@lib'),
	('78dd4122','@app/web/assets/updateswidget/dist'),
	('79c1107c','@app/web/assets/recententries/dist'),
	('7c5da131','@app/web/assets/edituser/dist'),
	('7dd385a','@lib/jquery-ui'),
	('7fb47ada','@app/web/assets/pluginstore/dist'),
	('7fd16','@bower/jquery/dist'),
	('7fd2990','@lib/xregexp'),
	('802f4581','@lib/selectize'),
	('8170add0','@app/web/assets/routes/dist'),
	('8208e1c0','@lib/d3'),
	('8727bbbd','@app/web/assets/editentry/dist'),
	('8731d370','@app/web/assets/edittransform/dist'),
	('87daa5fc','@app/web/assets/updates/dist'),
	('898ff7da','@lib/prismjs'),
	('8a43010b','@lib/xregexp'),
	('8a6310c1','@lib/jquery-ui'),
	('8b09fd53','@lib/jquery-touch-events'),
	('8b7f54b1','@lib'),
	('8cadc191','@lib/picturefill'),
	('8e13e576','@lib/garnishjs'),
	('90113be8','@app/web/assets/editcategory/dist'),
	('914c1033','@app/web/assets/sites/dist'),
	('9239d31d','@app/web/assets/updateswidget/dist'),
	('92cc14dc','@lib/selectize'),
	('9445c06f','@lib/fileupload'),
	('98276a8d','@app/web/assets/dashboard/dist'),
	('985bfe8','@app/web/assets/installer/dist'),
	('98a05056','@lib/xregexp'),
	('99bb7888','@app/web/assets/deprecationerrors/dist'),
	('9b553148','@lib/fabric'),
	('9cab7fdc','@app/web/assets/craftsupport/dist'),
	('9cc53ebc','@lib/element-resize-detector'),
	('9f0f407f','@app/web/assets/matrixsettings/dist'),
	('9f4044c3','@app/web/assets/fields/dist'),
	('a0e657f3','@app/web/assets/fields/dist'),
	('a2da6234','@lib/velocity'),
	('a4f32278','@lib/fabric'),
	('a61d6bb8','@app/web/assets/deprecationerrors/dist'),
	('a6cbb972','@yii/debug/assets'),
	('a76fe5ae','@app/web/assets/dbbackup/dist'),
	('a78179bd','@app/web/assets/dashboard/dist'),
	('aaf6fbd5','@app/web/assets/pluginstore/dist'),
	('abe3d35f','@lib/fileupload'),
	('ac839173','@app/web/assets/recententries/dist'),
	('aced3197','@app/web/assets/clearcaches/dist'),
	('aec51410','@app/web/assets/feed/dist'),
	('aeea0303','@app/web/assets/sites/dist'),
	('b1b5f646','@lib/garnishjs'),
	('b1ceb6fe','@app/web/assets/cp/dist'),
	('b2ede93','@app/web/assets/updates/dist'),
	('b30bd2a1','@lib/picturefill'),
	('b3559549','@bower/jquery/dist'),
	('b4afee63','@lib/jquery-touch-events'),
	('b5a51d3f','@app/web/assets/utilities/dist'),
	('b5bc597e','@lib/timepicker'),
	('b5f0a380','@app/web/assets/login/dist'),
	('b629e4ea','@lib/prismjs'),
	('b87cb6cc','@app/web/assets/updates/dist'),
	('bc8f7360','@app/web/assets/tablesettings/dist'),
	('bdaef2f0','@lib/d3'),
	('befdcddc','@lib/jquery.payment'),
	('c116059a','@lib/jquery-touch-events'),
	('c4ca8b64','@lib/velocity'),
	('c6b23958','@lib/picturefill'),
	('c8171909','@lib/d3'),
	('c8d5fd40','@app/web/assets/feed/dist'),
	('ca937823','@app/web/assets/recententries/dist'),
	('cbb78b33','@app/web/assets/clearcaches/dist'),
	('ccb969fb','@lib/fileupload'),
	('cce61285','@app/web/assets/pluginstore/dist'),
	('cf0fc96e','@app/web/assets/edituser/dist'),
	('d1735e4e','@lib/prismjs'),
	('d2bfa89f','@lib/xregexp'),
	('d32f0677','@vendor/yiisoft/yii2/assets'),
	('d3b5f46f','@app/web/assets/utilities/dist'),
	('d3e04ad0','@app/web/assets/login/dist'),
	('d3f554c7','@lib/jquery-touch-events'),
	('d4516805','@lib/picturefill'),
	('d5457c19','@bower/jquery/dist'),
	('d7de5fae','@app/web/assets/cp/dist'),
	('d84d6bf','@app/web/assets/routes/dist'),
	('d8d3ec15','@lib/selectize'),
	('d8ed248c','@lib/jquery.payment'),
	('d916d1a','@lib/selectize'),
	('da9f9a30','@app/web/assets/tablesettings/dist'),
	('daf44854','@lib/d3'),
	('dafa583','@lib/jquery.payment'),
	('de5a38a6','@lib/fileupload'),
	('dfdb1229','@app/web/assets/editentry/dist'),
	('e0801f58','@app/web/assets/updates/dist'),
	('e08d565c','@app/web/assets/generalsettings/dist'),
	('e47c6872','@app/web/assets/updater/dist'),
	('e775ff25','@lib/selectize'),
	('e9495fd2','@lib/garnishjs'),
	('ec73f991','@lib/jquery-ui'),
	('ed19bbaf','@lib/xregexp'),
	('ed40f0ea','@lib/timepicker'),
	('ed6fbde1','@lib'),
	('eeecdab1','@lib/fabric'),
	('f2634e05','@app/web/assets/updates/dist'),
	('f4119803','@app/web/assets/clearcaches/dist'),
	('f4293a4d','@app/web/assets/updateswidget/dist'),
	('f81afe67','@app/web/assets/fields/dist'),
	('f91fa92f','@app/web/assets/matrixsettings/dist'),
	('fabb968c','@app/web/assets/craftsupport/dist'),
	('fad5d7ec','@lib/element-resize-detector'),
	('fbaa0e8f','@lib/garnishjs'),
	('fc0f8bec','@lib/fabric'),
	('fd2a9b9','@app/web/assets/updater/dist'),
	('fdd1b3f','@app/web/assets/tablesettings/dist'),
	('fee1c22c','@app/web/assets/deprecationerrors/dist'),
	('ff7dd029','@app/web/assets/dashboard/dist');

/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table revisions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `revisions`;

CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;

INSERT INTO `revisions` (`id`, `sourceId`, `creatorId`, `num`, `notes`)
VALUES
	(1,8,1,3,NULL),
	(2,7,1,4,NULL),
	(3,6,1,4,NULL),
	(4,5,1,9,NULL),
	(5,8,1,2,NULL),
	(6,7,1,3,NULL),
	(7,6,1,3,NULL),
	(8,5,1,8,NULL),
	(9,5,1,7,NULL),
	(10,5,1,6,NULL),
	(11,5,1,5,NULL),
	(12,5,1,4,NULL),
	(13,5,1,3,NULL),
	(14,20,1,1,NULL),
	(15,19,1,1,NULL),
	(16,18,1,1,NULL),
	(17,17,1,1,NULL),
	(18,16,1,1,NULL),
	(19,15,1,1,NULL),
	(20,14,1,1,NULL),
	(21,13,1,1,NULL),
	(22,12,1,1,NULL),
	(23,11,1,1,NULL),
	(24,9,1,2,NULL),
	(25,10,1,1,NULL),
	(26,9,1,1,NULL),
	(27,5,1,2,NULL),
	(28,6,1,2,NULL),
	(29,7,1,2,NULL),
	(30,8,1,1,NULL),
	(31,7,1,1,NULL),
	(32,6,1,1,NULL),
	(33,5,1,1,NULL),
	(34,58,1,1,'Revision from Jul 12, 2019, 6:46:08 AM'),
	(35,10,1,2,'Created automatically for draft'),
	(36,10,1,3,'Applied “Draft 1”'),
	(37,58,1,2,'Applied “Draft 1”'),
	(38,9,1,3,'Applied “Draft 1”'),
	(39,70,1,1,'Revision from Jul 12, 2019, 8:27:35 AM'),
	(40,72,1,1,'Revision from Jul 12, 2019, 8:31:20 AM'),
	(41,74,1,1,NULL),
	(42,74,1,2,'Applied “Draft 1”'),
	(43,80,1,1,'Revision from Jul 12, 2019, 8:45:56 AM'),
	(44,82,1,1,'Revision from Jul 12, 2019, 8:46:50 AM'),
	(45,82,1,2,'Applied “Draft 1”'),
	(46,80,1,2,'Applied “Draft 1”'),
	(48,91,1,1,'Revision from Jul 15, 2019, 4:28:28 PM'),
	(49,91,1,2,NULL),
	(50,96,1,1,NULL),
	(51,96,1,2,NULL),
	(52,99,1,1,NULL),
	(53,99,1,2,NULL),
	(54,99,1,3,NULL),
	(55,10,1,4,NULL),
	(56,10,1,5,NULL),
	(57,99,1,4,NULL),
	(58,9,1,4,NULL);

/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `searchindex`;

CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;

INSERT INTO `searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`)
VALUES
	(1,'username',0,1,' admin '),
	(1,'firstname',0,1,''),
	(1,'lastname',0,1,''),
	(1,'fullname',0,1,''),
	(1,'email',0,1,' adam interactiveknowledge com '),
	(1,'slug',0,1,''),
	(2,'slug',0,1,' basic pages '),
	(2,'title',0,1,' basic pages '),
	(3,'filename',0,1,' hero delivery jpg '),
	(3,'extension',0,1,' jpg '),
	(3,'kind',0,1,' image '),
	(3,'slug',0,1,''),
	(3,'title',0,1,' man deliverying boxes '),
	(4,'field',1,1,' hero delivery '),
	(4,'slug',0,1,' test hero slide '),
	(4,'title',0,1,''),
	(5,'field',3,1,' business industries '),
	(5,'field',4,1,' icon raised graph '),
	(5,'field',2,1,' brandblue '),
	(5,'slug',0,1,' business industries '),
	(5,'title',0,1,' business industries '),
	(6,'field',3,1,' energy environmental '),
	(6,'field',2,1,' brandgreen '),
	(6,'slug',0,1,' energy environmental '),
	(6,'title',0,1,' energy environmental '),
	(7,'field',3,1,' opportunity development '),
	(7,'field',2,1,' brandorange '),
	(7,'slug',0,1,' opportunity development '),
	(7,'title',0,1,' opportunity development '),
	(8,'field',3,1,' philanthropy social enterprise '),
	(8,'field',2,1,' brandred '),
	(8,'slug',0,1,' philanthropy social enterprise '),
	(8,'title',0,1,' philanthropy social enterprise '),
	(9,'slug',0,1,' first herousel '),
	(9,'title',0,1,' first herousel '),
	(4,'field',9,1,''),
	(4,'field',10,1,''),
	(4,'field',11,1,''),
	(4,'field',12,1,''),
	(4,'field',13,1,''),
	(4,'field',8,1,''),
	(10,'field',9,1,' make the most of your tactile learning style '),
	(10,'field',11,1,' learning '),
	(10,'field',12,1,' learn more '),
	(10,'field',13,1,' home page '),
	(10,'slug',0,1,' first hero slide '),
	(11,'slug',0,1,' programs '),
	(11,'title',0,1,' programs '),
	(12,'slug',0,1,' idhs global leadership network '),
	(12,'title',0,1,' idhs global leadership network '),
	(13,'slug',0,1,' global innovators group '),
	(13,'title',0,1,' global innovators group '),
	(14,'slug',0,1,' about us '),
	(14,'title',0,1,' about us '),
	(15,'slug',0,1,' events '),
	(15,'title',0,1,' events '),
	(16,'slug',0,1,' our people '),
	(16,'title',0,1,' our people '),
	(17,'slug',0,1,' emerging strategy group '),
	(17,'title',0,1,' emerging strategy group '),
	(18,'slug',0,1,' board of trustees '),
	(18,'title',0,1,' board of trustees '),
	(19,'slug',0,1,' new york ny '),
	(19,'title',0,1,' new york ny '),
	(20,'slug',0,1,' history '),
	(20,'title',0,1,' history '),
	(21,'filename',0,1,' icon raised graph svg '),
	(21,'extension',0,1,' svg '),
	(21,'kind',0,1,' image '),
	(21,'slug',0,1,''),
	(21,'title',0,1,' icon raised graph '),
	(5,'field',5,1,' board of trustees '),
	(22,'filename',0,1,' icon leaf svg '),
	(22,'extension',0,1,' svg '),
	(22,'kind',0,1,' image '),
	(22,'slug',0,1,''),
	(22,'title',0,1,' icon leaf '),
	(6,'field',5,1,' emerging strategy group '),
	(6,'field',4,1,' icon leaf '),
	(23,'filename',0,1,' icon two people svg '),
	(23,'extension',0,1,' svg '),
	(23,'kind',0,1,' image '),
	(23,'slug',0,1,''),
	(23,'title',0,1,' icon two people '),
	(7,'field',5,1,' board of trustees '),
	(7,'field',4,1,' icon two people '),
	(24,'filename',0,1,' icon ribbon svg '),
	(24,'extension',0,1,' svg '),
	(24,'kind',0,1,' image '),
	(24,'slug',0,1,''),
	(24,'title',0,1,' icon ribbon '),
	(8,'field',5,1,' board of trustees '),
	(8,'field',4,1,' icon ribbon '),
	(59,'filename',0,1,' computer focal jpg '),
	(59,'extension',0,1,' jpg '),
	(59,'kind',0,1,' image '),
	(59,'slug',0,1,''),
	(59,'title',0,1,' computer focal '),
	(58,'slug',0,1,' space slide '),
	(58,'field',9,1,' do you want to go to outer space us too '),
	(58,'field',11,1,' space '),
	(58,'field',12,1,' learn more '),
	(58,'field',13,1,' history '),
	(58,'field',8,1,' computer focal '),
	(10,'title',0,1,' make the most of your tactile learning style '),
	(10,'field',10,1,' according to some educational theorists there are as many as nine different types of intelligence and multiple styles of learning '),
	(58,'title',0,1,' do you want to go to outer space us too '),
	(58,'field',10,1,' we have a deep desire to head up the great unknown and discover what else is out there '),
	(9,'field',6,1,' do you want to go to outer space us too make the most of your tactile learning style '),
	(70,'slug',0,1,' header provision '),
	(70,'title',0,1,' header provision '),
	(70,'field',10,1,' i have hinted that i would often jerk poor queequeg from between the whale '),
	(70,'field',13,1,' our people '),
	(70,'field',8,1,' computer focal '),
	(72,'slug',0,1,' image card 2 '),
	(72,'title',0,1,' image card 2 '),
	(72,'field',10,1,' this is some good ole lorem ipsum dolor sit amet '),
	(72,'field',13,1,' new york ny '),
	(72,'field',8,1,' hero delivery '),
	(74,'slug',0,1,' image card 2 '),
	(74,'title',0,1,' image card 3 '),
	(74,'field',10,1,' this is some good ole lorem ipsum dolor sit amet '),
	(74,'field',13,1,' new york ny '),
	(74,'field',8,1,' urban area '),
	(77,'filename',0,1,' urban area jpg '),
	(77,'extension',0,1,' jpg '),
	(77,'kind',0,1,' image '),
	(77,'slug',0,1,''),
	(77,'title',0,1,' urban area '),
	(80,'slug',0,1,' redefining traditional learning in the digital age '),
	(80,'title',0,1,' redefining traditional learning in the digital age '),
	(80,'field',10,1,' lorem ipsum dolor sit amet '),
	(80,'field',13,1,' emerging strategy group '),
	(80,'field',8,1,' computer focal '),
	(82,'slug',0,1,' leading the transformation of local infrastructure '),
	(82,'title',0,1,' leading the transformation of local infrastructure '),
	(82,'field',10,1,' lorem ipsum dolor sit amet '),
	(82,'field',13,1,' board of trustees '),
	(82,'field',8,1,' hero delivery '),
	(84,'slug',0,1,' tech '),
	(84,'title',0,1,' development '),
	(85,'slug',0,1,' design '),
	(85,'title',0,1,' design '),
	(82,'field',14,1,' design '),
	(80,'field',14,1,' development '),
	(90,'slug',0,1,''),
	(90,'field',10,1,''),
	(91,'slug',0,1,' pages '),
	(91,'title',0,1,' pages '),
	(95,'slug',0,1,' home page '),
	(95,'title',0,1,' home page '),
	(96,'slug',0,1,' home page '),
	(96,'title',0,1,' home page '),
	(99,'slug',0,1,' home page '),
	(99,'title',0,1,' home page '),
	(103,'filename',0,1,' people walking on painted streets jpg '),
	(103,'extension',0,1,' jpg '),
	(103,'kind',0,1,' image '),
	(103,'slug',0,1,''),
	(103,'title',0,1,' people walking on painted streets '),
	(10,'field',8,1,' people walking on painted streets ');

/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;

INSERT INTO `sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagationMethod`, `previewTargets`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'Herousel Slides','herouselSlides','channel',1,'all',NULL,'2019-06-29 17:57:44','2019-07-25 02:39:34',NULL,'f4806157-8213-4481-a5ca-4697ca313dfe'),
	(2,NULL,'Basic Pages','basicPages','single',1,'all',NULL,'2019-06-29 22:13:15','2019-06-29 22:15:53','2019-06-29 22:15:53','1e1ea071-5025-48d7-af03-57353bb69c52'),
	(3,1,'Navigation Blocks','navigationBlocks','structure',1,'all',NULL,'2019-06-29 22:41:05','2019-07-08 23:29:52',NULL,'acc864f2-7951-4b85-8639-f771df381a56'),
	(4,NULL,'Herousels','herousels','channel',1,'all',NULL,'2019-06-29 23:03:21','2019-06-29 23:05:24',NULL,'06021517-c456-4337-a55c-342f170b509e'),
	(5,2,'Navigation Links','navigationLinks','structure',1,'all',NULL,'2019-06-30 01:46:32','2019-06-30 01:46:32',NULL,'3d68d8a0-b786-405c-8b3c-d3ed8c4b93f8'),
	(6,5,'Image Cards','imageCards','structure',1,'all',NULL,'2019-07-12 15:04:17','2019-07-12 16:14:58',NULL,'85f5118f-dd13-45cc-a0f4-e49d61bab613'),
	(7,4,'Insight Blocks','insightBlocks','structure',1,'all',NULL,'2019-07-12 15:37:08','2019-07-12 16:15:03',NULL,'66a3cf92-176e-4832-aa38-7dae6e1c0893'),
	(8,NULL,'Pages','pages','single',1,'all',NULL,'2019-07-15 20:28:28','2019-07-15 20:29:03','2019-07-15 20:29:03','6d2e2c07-768e-4d68-97bc-3f2d9ac555cc'),
	(9,NULL,'Home Page','homePage','single',0,'all',NULL,'2019-07-21 18:35:52','2019-07-25 00:41:57','2019-07-25 00:41:57','219562fb-ca02-4959-86be-5ca769fc0861'),
	(10,NULL,'Home Page','homePage','single',1,'all',NULL,'2019-07-25 00:42:15','2019-07-25 00:42:44','2019-07-25 00:42:44','d4c5bd63-60b7-4b2f-b5ba-4606d6a95f02'),
	(11,NULL,'Home Page','homePage','single',1,'all',NULL,'2019-07-25 00:44:16','2019-07-25 14:15:52',NULL,'e7de7111-7a23-4566-8072-2617f5279d89');

/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections_sites`;

CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;

INSERT INTO `sections_sites` (`id`, `sectionId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `enabledByDefault`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,0,NULL,NULL,1,'2019-06-29 17:57:44','2019-07-25 02:39:34','f6a393f1-749c-4ce7-b716-a89a26f8f882'),
	(2,2,1,1,'__home__','',1,'2019-06-29 22:13:15','2019-06-29 22:15:53','7be94367-d231-491e-a3cd-07e5639f55c8'),
	(3,3,1,0,NULL,NULL,1,'2019-06-29 22:41:05','2019-07-08 23:29:52','ba7fcd3e-da7b-4a89-914d-e4a2819f1284'),
	(4,4,1,0,NULL,NULL,1,'2019-06-29 23:03:21','2019-06-29 23:05:24','c2d28c24-02b2-4cf9-8232-5c7976aadb0a'),
	(5,5,1,0,NULL,NULL,1,'2019-06-30 01:46:32','2019-06-30 01:46:32','68b7102d-db07-4091-994a-c4b5109bd753'),
	(6,6,1,0,NULL,NULL,1,'2019-07-12 15:04:17','2019-07-12 16:14:58','9775b3e1-542f-453e-8560-d1621730fc53'),
	(7,7,1,0,NULL,NULL,1,'2019-07-12 15:37:08','2019-07-12 16:15:03','cfac9c75-06ee-4927-9efc-108151604a7b'),
	(8,8,1,1,'__home__','',1,'2019-07-15 20:28:28','2019-07-15 20:29:03','aeb872a0-e850-49ed-8999-3c700d02ab95'),
	(9,9,1,1,'/','index',1,'2019-07-21 18:35:52','2019-07-25 00:41:57','9036f823-6890-466d-91d4-65bdc387622d'),
	(10,10,1,1,'home-page','',1,'2019-07-25 00:42:15','2019-07-25 00:42:44','3dd05e29-f168-4d13-bdb8-877f1f50fe07'),
	(11,11,1,1,'/','index',1,'2019-07-25 00:44:16','2019-07-25 14:15:52','c11524aa-bf0f-4367-99e7-7ca6bed6275f');

/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sequences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sequences`;

CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;

INSERT INTO `sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'_Bo-gZF9gcmIun3QIhB89kl7qcsUgMEzfUaq7BgRstDhb2wItxGwwePGCHjMt8pQcwrwjF7wsEzBaBYoPbKI5ZW6xZJgfo3YlAhM','2019-06-29 17:33:42','2019-06-29 22:10:24','0824e68f-c59e-48bf-b105-e4efffa677ce'),
	(2,1,'XDqBBVNauGjbT3Nd5XAMdbdX047N1xlnWmNUMRLjdE8uMYBILA0_5h9wGee5GxO6xJUchFSj09KQjx6mG3iAv6mpaEZVM_p8bU_w','2019-06-29 22:10:30','2019-06-30 01:37:46','019f6705-bdbd-4171-8052-84bd10a822c0'),
	(3,1,'k5rcs2z-_qBndUbeHQEqMdsDtxqu5QSEpSJoMdQWNhKcK2jRoHj18gzhhQ5AhweYKnfBxV6t8-i91lCpoJyoNWHoFlTib9MD17cg','2019-06-30 01:37:59','2019-06-30 17:11:09','000666e8-0610-43ff-876a-e8d3ffaf3955'),
	(4,1,'f3gg86LHtOUVSmoBLv_OhQeOXoxifBXyUbDS-CTLa2F-YhVxPHciew6EZ0IHzRgE_d-i6m4LsCktaWar9h37EIXko2AEkTKPGEhE','2019-06-30 17:11:33','2019-06-30 21:47:01','70ecc2bb-2406-4707-963c-a04b31ee2d89'),
	(5,1,'JEOmAonk8EmyAZMtSF-d20iC2_rFT0EEJm-stCHNk6zP8NIts2AI-hJIn5wek-4RhLODoMQ6CiMLrunJfcXaUELS38FtZybf8cew','2019-06-30 23:53:36','2019-07-01 01:50:11','72ca27cd-8e2b-4d90-a6b1-2ac845aa22a7'),
	(6,1,'1mqJO4OVfMbtONgvHsCs_fRCCgaI7YbprAvPYLV2RspVGQ3sjXR7AGrGUZSZTxiunRRtaP4pmTKwr3lFUtEXr9cJwegwN0Yaj9th','2019-07-01 17:26:19','2019-07-01 20:18:05','8c7fc1fd-935b-407e-b8d8-5b606e20fe9a'),
	(7,1,'7Q7XcFsZ19pfI8bIX62yi6Eur2F4rSxt6FzNxXBWV620wemdWYaKkvh3NQageT7suuMt70mTR7QQFX5Lonay2zh9iBO336Dh10mx','2019-07-05 18:44:50','2019-07-05 19:12:51','1e1c552c-8e81-41c1-8f95-cf2f19a59e39'),
	(8,1,'PB4KIvoiFFPti_M0PMO7prVYh8ae41HxOt_btTEb-9FLeWxDVFfR4cYjRWqB0BZ4kUOIx4rZObx-bQTAJwPeKGE0K7wIN8GPOe4M','2019-07-08 22:52:50','2019-07-09 11:59:12','65e19073-098a-4c90-ab37-e9f8be68794e'),
	(9,1,'Guq8aS-xl65VSDA2SbdwS3-WgQbMOplKKEWztJ4U-qMsUgRP1yjY8V98614BTJ32PpKvamjeZ2E2--U3r7BNi8mcyGI4HmqadWMH','2019-07-09 20:46:01','2019-07-10 12:10:11','fd1fac67-d7b0-4fc6-a093-067ddb59ee90'),
	(10,1,'u52ySPgOWuxZc-AoY-HylsntV8fvQloGzybPQnijCVprfucPmtRn7x_z924HjVoC39MCfI4GjsXZE9UwtFKVbJ7IVvSnkEt4wKp2','2019-07-12 12:18:48','2019-07-12 12:24:25','e19739c7-26e5-49e6-a788-f28682fadf94'),
	(11,1,'qfvXoveAd_26pcvTMfdac6EW3t7X8XJq3uKjN-DxIk6xmRgvIZnByrbkMvvaw8A0xCZz9BAtHylQC4ebzUC7dNhisCD93c-tKR7h','2019-07-12 13:13:43','2019-07-13 17:40:16','03cab00d-bc85-4a60-95cf-ad357240e0f7'),
	(12,1,'BVtUHWJCBtKxS1NbRItXkKGvZzjiEaq12eZPw3E7Tk1Cev5wn5aic-yWjsDYXrt8mEl1EPwCOo0vRiNpELCZF1cUYcz-EvFA3bHM','2019-07-15 12:26:17','2019-07-15 13:29:29','d98e2b0b-b506-46c9-81cf-8f6f0e0e0340'),
	(13,1,'VaB3f7xRyc5W2h0CVNMppDlXSfnbizMZG2Rp5pewXv3cNx7DOzXLHEGKRzWoXQFNCfruCQCUHhxmfjc60ixAUGcqF-GGkn6SOB5F','2019-07-15 20:26:26','2019-07-16 14:19:03','dcb0d09d-0508-4f43-a8f6-b83f0b7a4a23'),
	(14,1,'usawHeMCbeFEq0iZ-jCMNYWht_H71R20FgVXSlbMtjzRtQe2j4Mm1C6Bf8Vvctz1BAdFVHTWRpUlvN9BbV1wt9RPTNcjq4aFO5Bh','2019-07-17 22:44:01','2019-07-17 22:53:12','6515954d-cdef-4154-ba62-be24b0a6b1e7'),
	(15,1,'M_tPWNfWMB7TyWcNcR5YaACUjWTp_FXoValKUD6P1i_oPPMwJXckYBQBcGWgyNv-rGSw7XMCkGeH5FvOxC69YQnnCjZkCGOI6Ebx','2019-07-18 00:10:14','2019-07-18 00:10:14','d6cae0ed-08d7-4af6-a66f-4d6570e43366'),
	(16,1,'LWnTwzfZLu7971siURvmtUdmmCQsStSAd4LrRM0eat4rF2wkutfZnLkERkvKvakMPQV3QuYC1tGJjHCKSYuPfzL86_oTzhiY62nb','2019-07-18 01:27:52','2019-07-18 01:27:52','75d5b80a-24f8-4434-9fae-d8a152f456aa'),
	(17,1,'gKk9THNEFrmM-dpC12Yo4etWgndZkm3gpywI99x6Q3Fpgbnb6NlBhW80-YlgTR5VMA1V1bx_pMqvVurcIsVdd2Co2l4HgYhpccEB','2019-07-18 16:41:03','2019-07-18 17:02:44','760a84cc-9344-4fac-92a0-f278a6f3203b'),
	(18,1,'ZduBv2K7arrew_FcG_qRXNftZSa7b3tc1AdkaK6KDcm7QCI0LADBfRm1_8768_Q-u6eurjxPPi_39xmHjp1rh0iuPVO1VBtldjyw','2019-07-18 17:02:54','2019-07-21 18:02:42','bc3b0703-69d2-4541-b3f1-8f3544c0f287'),
	(19,1,'-j8WNye-F_5Q7nWtZdpdvRby362pMzJ-0HDIOUST6LlJAqpIwUepxq-5XiQFxm6Q6DFt0nQwEXTbV2qs9LnvLKpnzMP7oQnh0Rga','2019-07-21 18:05:03','2019-07-22 12:14:07','d97a41d9-2fd1-486b-b2cb-f4e1333e3620'),
	(20,1,'4VuN59-M6u7VX5TJ1TF1saHixoxQkGEMGCPDVZ_G0TKY4bY86PDsOC541knz1BVxqxPMqWmPcBx0PcvbXaqH2_YCH91AXpVxXyM1','2019-07-22 12:42:07','2019-07-22 13:55:11','909c9f7f-4f0a-4036-94e2-f2315eda0607'),
	(21,1,'S4t5BwqOuRomKYIXY8DpxTkQ7xHq4D86S88Bxwv1VXS4R0BJufYQN8uNOGqOyjplKUbaLGgpzInkXK5s_Ci8gOhzR4NAZBPQp4kB','2019-07-22 17:03:12','2019-07-22 17:06:55','44357645-bee9-4cbf-8786-8d2e722fa796'),
	(22,1,'Xu24j6dMEg-ICnrFx2aNnj26F-cyYhVK0fGk-rLucDGSCd7gRokfZD0ZxXLM8zzxnO42FBNlUi3buPAXKVIWb3SFVDsNO9KNT2_t','2019-07-23 15:28:03','2019-07-23 15:29:09','18058cd2-c0d2-485e-a935-2c8b848d5cf5'),
	(23,1,'3m6npkOWJQDlIBsK00RuTiydvhGucQV1kPkpOouYRM1HwKLOXwZIS8CDzGJ29Y9vHDvDHxRzb2OE7pvCUwufSaVIfumiZekd5wxu','2019-07-23 23:06:03','2019-07-24 12:33:05','69bbed49-664f-4b9e-a6be-c643ce0a6470'),
	(24,1,'wbEH5Auy5vjHHlWXrlVoP34ZncIvoF5IUGdyCEZGkJCBjOmj5NBGVBXtCvd50ft3seqslp4zO2rvh3HiiDYuE59fL2Iala6pBWRn','2019-07-24 22:30:16','2019-07-25 02:40:09','eb225e30-a808-43f0-9f0f-6e0569feb200'),
	(25,1,'5lJ079BQweIXRBguMyGA7eB4x2sHn5VRV0SgcWl1O9tAzXWVo_Lpq4oQuUajsHbGNb3Dt4FHKiQOtU6tao8ABeZzT6eWUwYCKipw','2019-07-25 14:08:36','2019-07-25 17:01:42','d9f4a9b0-7871-403e-becf-698ae054f999'),
	(26,1,'fqXqWkKSSTr6GFgJJrivtM7e0F3ArQbLjpZMz8BaPxSPgKBVfgOdbci_XFjGiDmA4K2P6QbB0S6XGpnpdkcnzuHK6dN0rZXOWhrY','2019-07-26 22:06:27','2019-07-26 22:09:07','816ea2ec-c2ce-447b-81d8-e6ca35557704'),
	(27,1,'el46g_c4pis70N5fepbrUTB16oRXT0SFW62patBFRw1dxlFMY7zDMEU08uUuRDQ9-aiBVrYL1sMvzNjGJoTe0IbCCUb-0LapAhI_','2019-07-26 23:09:13','2019-07-27 02:06:48','e72d00f6-a0aa-4991-b4f0-0caa08202679');

/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shunnedmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shunnedmessages`;

CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sitegroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sitegroups`;

CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;

INSERT INTO `sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'IK Craft Demo','2019-06-29 17:33:17','2019-06-29 17:33:17',NULL,'5b0c9095-dbd8-49a8-9f0e-98f12e9c1683');

/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sites`;

CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;

INSERT INTO `sites` (`id`, `groupId`, `primary`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,1,'IK Craft Demo','default','en-US',1,'$DEFAULT_SITE_URL',1,'2019-06-29 17:33:17','2019-07-24 23:51:17',NULL,'f2559c18-7489-4189-aecc-54995f3bff7a');

/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structureelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structureelements`;

CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;

INSERT INTO `structureelements` (`id`, `structureId`, `elementId`, `root`, `lft`, `rgt`, `level`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,NULL,1,1,50,0,'2019-06-29 22:49:42','2019-07-12 13:16:41','59a02f3a-08ea-49d0-bafc-da708aaa946b'),
	(2,1,5,1,2,3,1,'2019-06-29 22:49:42','2019-07-12 13:16:41','8a284cc9-e3df-40f5-a61c-cd7effcb2e42'),
	(3,1,6,1,4,5,1,'2019-06-29 22:50:05','2019-07-12 13:16:41','8f837f7f-66f1-433e-b7df-f4d0b3e8eabc'),
	(4,1,7,1,6,7,1,'2019-06-29 22:50:32','2019-07-12 13:16:41','834a2286-029d-4a27-9af2-88aca949d2b5'),
	(5,1,8,1,8,9,1,'2019-06-29 22:50:58','2019-07-12 13:16:41','a62981d4-4fa6-4d65-a206-c67478b1431f'),
	(6,2,NULL,6,1,42,0,'2019-06-30 01:47:37','2019-07-12 13:16:14','f2a17592-1f2d-4507-afb2-a79934aff623'),
	(7,2,11,6,2,11,1,'2019-06-30 01:47:37','2019-07-12 13:16:14','1a804059-6edc-4654-a1de-25842b0b4ab2'),
	(8,2,12,6,3,4,2,'2019-06-30 01:47:56','2019-07-12 13:16:14','68380243-5c02-4cc1-aba7-e4f387d378db'),
	(9,2,13,6,5,6,2,'2019-06-30 01:48:37','2019-07-12 13:16:14','ea8bf69b-8e04-4ff6-98a4-e31dac387273'),
	(10,2,14,6,24,29,1,'2019-06-30 01:49:18','2019-07-12 13:16:14','d64d9e44-f9b9-4dee-9937-7e095b334b66'),
	(11,2,15,6,18,23,1,'2019-06-30 01:49:24','2019-07-12 13:16:14','39f7770f-f059-4eac-a15a-674d4963c3d2'),
	(12,2,16,6,12,17,1,'2019-06-30 01:49:34','2019-07-12 13:16:14','e3af22eb-bba7-4e53-9ebb-926523c9ea0c'),
	(13,2,17,6,7,8,2,'2019-06-30 01:55:01','2019-07-12 13:16:14','84a052ee-f0e8-41d6-b9a1-e89e1a5d2dd7'),
	(14,2,18,6,13,14,2,'2019-06-30 01:55:21','2019-07-12 13:16:14','0770c643-e899-4eb7-a210-1a9ef1f3fdcf'),
	(15,2,19,6,19,20,2,'2019-06-30 01:55:32','2019-07-12 13:16:14','68c96265-cff6-4c6a-b9ee-494a94934c8d'),
	(16,2,20,6,25,26,2,'2019-06-30 01:55:40','2019-07-12 13:16:14','7686486c-dadb-44d6-a935-ff7897158e70'),
	(17,1,25,1,10,11,1,'2019-07-12 12:24:07','2019-07-12 13:16:41','2432c0e5-e8e0-456f-a9f5-3cb0fa360df3'),
	(18,1,26,1,12,13,1,'2019-07-12 12:24:07','2019-07-12 13:16:41','11f2a632-a4d5-4d1c-87df-4fe91e8379b8'),
	(19,1,27,1,14,15,1,'2019-07-12 12:24:07','2019-07-12 13:16:41','9cd6d05d-580d-4bd8-9821-bb716165c02a'),
	(20,1,28,1,16,17,1,'2019-07-12 12:24:07','2019-07-12 13:16:41','305f62b6-88ca-4011-a628-205145bad8fd'),
	(21,1,29,1,18,19,1,'2019-07-12 12:24:07','2019-07-12 13:16:41','c749d8a5-f9a3-4a64-97fc-6a97fcb36e73'),
	(22,1,30,1,20,21,1,'2019-07-12 12:24:07','2019-07-12 13:16:41','18fa5dd4-b312-4a81-a632-3c821b3b288b'),
	(23,1,31,1,22,23,1,'2019-07-12 12:24:07','2019-07-12 13:16:41','df30feaa-0a4e-4577-945a-27594001ec64'),
	(24,1,32,1,24,25,1,'2019-07-12 12:24:07','2019-07-12 13:16:41','49efbd08-3197-4e4e-b570-b59ba305e7bd'),
	(25,1,33,1,26,27,1,'2019-07-12 12:24:07','2019-07-12 13:16:41','2af9d9b0-b200-465c-b8e2-761b5bcb30fd'),
	(26,1,34,1,28,29,1,'2019-07-12 12:24:08','2019-07-12 13:16:41','a3323001-0412-4c15-91bd-f6002b141389'),
	(27,1,35,1,30,31,1,'2019-07-12 12:24:08','2019-07-12 13:16:41','afedd743-7164-41ff-b458-b7fe98b35ced'),
	(28,1,36,1,32,33,1,'2019-07-12 12:24:08','2019-07-12 13:16:41','07ff0924-6643-4c72-a846-f4030626d5bf'),
	(29,1,37,1,34,35,1,'2019-07-12 12:24:08','2019-07-12 13:16:41','b0027d1f-abd6-42b5-8ed3-be0d668ce951'),
	(30,2,38,6,27,28,2,'2019-07-12 12:24:08','2019-07-12 13:16:14','62b9e068-60f9-42e2-89ee-6ce5c83a8f57'),
	(31,2,39,6,21,22,2,'2019-07-12 12:24:08','2019-07-12 13:16:14','b1627a4a-2507-4e96-9d56-cb334ebde904'),
	(32,2,40,6,15,16,2,'2019-07-12 12:24:08','2019-07-12 13:16:14','9d69133e-a98d-4a1a-b115-68fddbe89492'),
	(33,2,41,6,9,10,2,'2019-07-12 12:24:08','2019-07-12 13:16:14','7597ef04-26c5-41b1-8fcf-b76f9febf1b4'),
	(34,2,42,6,30,31,1,'2019-07-12 12:24:08','2019-07-12 13:16:14','7e0c67c4-bf25-46a2-9b95-d5f0af0c48b8'),
	(35,2,43,6,32,33,1,'2019-07-12 12:24:08','2019-07-12 13:16:14','bd00a551-30ab-4578-b5be-af23cf71c6ea'),
	(36,2,44,6,34,35,1,'2019-07-12 12:24:08','2019-07-12 13:16:14','05e910d4-919d-4b9b-9a6e-cf477b45d89b'),
	(37,2,45,6,36,37,1,'2019-07-12 12:24:08','2019-07-12 13:16:14','179b9bd6-4483-4c7b-85e0-5f60588c5a9c'),
	(38,2,46,6,38,39,1,'2019-07-12 12:24:08','2019-07-12 13:16:14','dd687243-1002-4c9b-8df9-fab82c47c386'),
	(39,2,47,6,40,41,1,'2019-07-12 12:24:08','2019-07-12 13:16:14','eb927c79-62f4-4496-aae7-2d9f94ed77c2'),
	(40,1,51,1,36,37,1,'2019-07-12 12:24:08','2019-07-12 13:16:41','315e0e4f-7778-4b58-97de-08c465922478'),
	(41,1,52,1,38,39,1,'2019-07-12 12:24:09','2019-07-12 13:16:41','17517e2c-0c2c-497b-8efe-1e1063f35ef9'),
	(42,1,53,1,40,41,1,'2019-07-12 12:24:09','2019-07-12 13:16:41','433c015d-36f4-4c68-a29f-3eebb6d08ec5'),
	(43,1,54,1,42,43,1,'2019-07-12 12:24:09','2019-07-12 13:16:41','682d888a-e168-4d94-b9ce-9c2bf8989919'),
	(44,1,55,1,44,45,1,'2019-07-12 12:24:09','2019-07-12 13:16:41','f8ad15d9-9f6a-4d5c-91eb-bda1cf67cf32'),
	(45,1,56,1,46,47,1,'2019-07-12 12:24:09','2019-07-12 13:16:41','ad24f5b1-156e-4938-b2fd-29e4d4d39b67'),
	(46,1,57,1,48,49,1,'2019-07-12 12:24:09','2019-07-12 13:16:41','8e8d469c-13c4-419b-af42-27e3b38d3174'),
	(47,3,NULL,47,1,6,0,'2019-07-12 15:49:53','2019-07-12 15:50:08','a3346283-9b0a-4f89-a38b-1eb87e6f1bed'),
	(48,3,84,47,4,5,1,'2019-07-12 15:49:53','2019-07-12 15:50:08','517c295f-0790-4e07-8161-76ff8ca1ad78'),
	(49,3,85,47,2,3,1,'2019-07-12 15:49:59','2019-07-12 15:50:08','c462f605-9d51-44db-82bd-543b42eddd6f'),
	(50,4,NULL,50,1,6,0,'2019-07-12 16:03:53','2019-07-12 16:03:54','27db8022-ad60-48f7-8390-2d9f8c6bf4b3'),
	(51,4,80,50,2,3,1,'2019-07-12 16:03:53','2019-07-12 16:03:53','03a80309-58bd-43fd-a9b1-e3b8f45d859a'),
	(52,4,82,50,4,5,1,'2019-07-12 16:03:53','2019-07-12 16:03:53','09c11652-7b79-4761-97b1-480013a7b0d9'),
	(53,5,NULL,53,1,8,0,'2019-07-12 16:12:47','2019-07-12 16:14:40','1e304438-a351-415f-a31d-319143692d49'),
	(54,5,70,53,2,3,1,'2019-07-12 16:12:47','2019-07-12 16:12:47','c892528d-83eb-476e-a907-31b243a1db00'),
	(55,5,72,53,4,5,1,'2019-07-12 16:12:47','2019-07-12 16:14:40','8c9c6c82-9714-4ac4-a0c1-6cfeefd98a3f'),
	(56,5,74,53,6,7,1,'2019-07-12 16:12:47','2019-07-12 16:14:40','da6000e2-e936-4b32-a062-b1e4873dae55');

/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structures`;

CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;

INSERT INTO `structures` (`id`, `maxLevels`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,'2019-06-29 22:41:05','2019-07-08 23:29:52',NULL,'711c9b98-5218-4a8c-831e-0b0b70664b65'),
	(2,2,'2019-06-30 01:46:32','2019-06-30 01:46:32',NULL,'f8410eba-e92c-449f-8e2a-183643e1ec4f'),
	(3,1,'2019-07-12 15:49:36','2019-07-12 15:49:36',NULL,'fe8e586c-734e-4d4c-a28a-94addd5bc033'),
	(4,1,'2019-07-12 16:03:53','2019-07-12 16:15:03',NULL,'978bc0b8-ba5a-4010-926e-35f6bf2a817f'),
	(5,1,'2019-07-12 16:12:47','2019-07-12 16:14:58',NULL,'923c838a-a800-44f2-98da-fe775dca1f0d');

/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table systemmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemmessages`;

CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table taggroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taggroups`;

CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecacheelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecacheelements`;

CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecachequeries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecachequeries`;

CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecaches`;

CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups`;

CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups_users`;

CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions`;

CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;

INSERT INTO `userpermissions` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'editimagesinvolume:50afdfd7-6c44-4e96-973a-b03967ec3cac','2019-07-12 12:24:05','2019-07-12 12:24:05','541f8733-b520-426b-8e3f-efa7ac1c912e');

/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table userpermissions_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_usergroups`;

CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_users`;

CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpreferences`;

CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;

INSERT INTO `userpreferences` (`userId`, `preferences`)
VALUES
	(1,'{\"language\":\"en-US\",\"weekStartDay\":\"1\",\"enableDebugToolbarForSite\":true,\"enableDebugToolbarForCp\":true}');

/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'admin',NULL,'','','adam@interactiveknowledge.com','$2y$13$x47uvOgiocaDUiTwGp5Hf.Zqz2nu1AVX.V1YWerabcMD15pyUeduG',1,0,0,0,'2019-07-26 23:09:13',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-06-29 17:33:17','2019-06-29 17:33:17','2019-07-26 23:09:13','86ec60f7-6339-49b3-b904-bdb6e677eb40');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumefolders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumefolders`;

CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;

INSERT INTO `volumefolders` (`id`, `parentId`, `volumeId`, `name`, `path`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,1,'Uploads','','2019-06-29 22:23:20','2019-07-22 12:43:51','94d6abc8-c88f-4cf6-969a-23c0cb08cc17'),
	(2,NULL,NULL,'Temporary source',NULL,'2019-06-29 22:23:44','2019-06-29 22:23:44','181c4959-1b19-49c0-a8fa-32ee90c5aa45'),
	(3,2,NULL,'user_1','user_1/','2019-06-29 22:23:44','2019-06-29 22:23:44','b8b382b7-76b9-4988-985c-d0659cdc0cf2'),
	(4,1,1,'images','images/','2019-06-29 22:24:09','2019-06-29 22:24:09','3ef8dae8-d51f-48a2-b7c7-005d829df445'),
	(5,4,1,'slides','images/slides/','2019-06-29 23:23:24','2019-06-29 23:23:24','edf631da-3691-4ef7-b9fe-0416f109d681'),
	(6,4,1,'icons','images/icons/','2019-07-08 22:53:50','2019-07-08 22:53:50','675e7d75-d3c1-4ac4-98a9-3af14fddf135');

/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumes`;

CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;

INSERT INTO `volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'Uploads','uploads','craft\\volumes\\Local',1,'@web/uploads','{\"path\":\"@webroot/uploads/\"}',1,'2019-06-29 22:23:20','2019-07-22 12:43:51',NULL,'50afdfd7-6c44-4e96-973a-b03967ec3cac');

/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widgets`;

CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'craft\\widgets\\RecentEntries',1,3,'{\"section\":\"4\",\"siteId\":\"1\",\"limit\":\"5\"}',1,'2019-06-29 17:33:42','2019-07-12 13:26:47','7b9306a5-1ae6-4b43-b12d-c790242e3b04'),
	(2,1,'craft\\widgets\\CraftSupport',4,NULL,'[]',1,'2019-06-29 17:33:42','2019-07-09 20:47:06','7e9762c4-c961-4114-a906-705dc340bd31'),
	(3,1,'craft\\widgets\\Updates',2,3,'[]',1,'2019-06-29 17:33:42','2019-07-09 20:47:10','0ec70712-5bee-4cba-9a30-e0c4c2099eff'),
	(4,1,'craft\\widgets\\Feed',3,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-06-29 17:33:42','2019-07-09 20:47:06','8dd6b047-02fb-464c-8ccd-1d7ae46c8ffb');

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
