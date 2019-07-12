# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.4.6-MariaDB)
# Database: ik-craft-demo
# Generation Time: 2019-07-01 20:21:58 +0000
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
	(3,1,4,'hero-delivery.jpg','image',2082,888,266480,NULL,NULL,NULL,'2019-06-29 22:24:09','2019-06-29 22:23:55','2019-06-29 22:24:09','61d92942-6bbd-4d22-893e-6d258ae8da5f');

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
  `field_accentColor` varchar(7) DEFAULT NULL,
  `field_blockTitle` text DEFAULT NULL,
  `field_slideTitle` text DEFAULT NULL,
  `field_slideCopy` text DEFAULT NULL,
  `field_slideCategory` text DEFAULT NULL,
  `field_slideCtaCopy` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_accentColor`, `field_blockTitle`, `field_slideTitle`, `field_slideCopy`, `field_slideCategory`, `field_slideCtaCopy`)
VALUES
	(1,1,1,NULL,'2019-06-29 17:33:17','2019-06-29 17:33:17','e293b92f-0562-4270-86cf-d62170bbc9ae',NULL,NULL,NULL,NULL,NULL,NULL),
	(2,2,1,'Basic Pages','2019-06-29 22:13:15','2019-06-29 22:15:53','cfd5695b-88f6-4d20-9b28-11f0618bb974',NULL,NULL,NULL,NULL,NULL,NULL),
	(3,3,1,'Hero delivery','2019-06-29 22:23:54','2019-06-29 22:24:09','33207202-663d-4300-82ea-4a2a1f5df97c',NULL,NULL,NULL,NULL,NULL,NULL),
	(4,4,1,'Test hero slide','2019-06-29 22:24:09','2019-06-29 23:21:53','3499a0bf-b5f3-46af-840d-8f359c8b0c61',NULL,NULL,NULL,NULL,NULL,NULL),
	(5,5,1,'Business & Industries','2019-06-29 22:49:42','2019-06-30 02:59:07','e5606b23-1b82-4e54-9cd8-7a7643f71378','#375cf5','Business & Industries',NULL,NULL,NULL,NULL),
	(6,6,1,'Energy & Environmental','2019-06-29 22:50:04','2019-06-30 02:40:33','ac7834d2-13b8-41cd-b143-e3b345898262','#00f000','Energy & Environmental',NULL,NULL,NULL,NULL),
	(7,7,1,'Opportunity & Development','2019-06-29 22:50:32','2019-06-30 02:40:33','f2d75daa-a95e-4a19-8a56-d035cbe4581d','#fb8f07','Opportunity & Development',NULL,NULL,NULL,NULL),
	(8,8,1,'Philanthropy & Social Enterprise','2019-06-29 22:50:58','2019-06-30 02:40:33','82f1a5d0-7547-484c-bda8-9db3f75be92f','#ff2659','Philanthropy & Social Enterprise',NULL,NULL,NULL,NULL),
	(9,9,1,'First Herousel','2019-06-29 23:06:49','2019-06-29 23:23:36','87067bec-b7c9-45ee-87f6-e2f4cbaa203c',NULL,NULL,NULL,NULL,NULL,NULL),
	(10,10,1,'First Hero Slide','2019-06-29 23:23:24','2019-06-29 23:23:28','409757c3-9193-40a4-96c1-ba2b6d7811d5',NULL,NULL,'First Hero Slide','This is the copy to my slide. There are going to be two sentences.\nThen there is going to be a break in the lines.','Learning','Learn More'),
	(11,11,1,'Programs','2019-06-30 01:47:37','2019-06-30 01:47:37','76bcd916-cca1-4aa8-868d-599a1eaa56a9',NULL,NULL,NULL,NULL,NULL,NULL),
	(12,12,1,'IDHS Global Leadership Network','2019-06-30 01:47:56','2019-06-30 01:47:56','b7fa36e8-e009-45f4-a30e-cced3bbbc664',NULL,NULL,NULL,NULL,NULL,NULL),
	(13,13,1,'Global Innovators Group','2019-06-30 01:48:37','2019-06-30 01:48:42','ff4b7139-a594-49fb-964a-cf6c12286cad',NULL,NULL,NULL,NULL,NULL,NULL),
	(14,14,1,'About Us','2019-06-30 01:49:17','2019-06-30 01:49:17','f19f9a39-50da-4d79-bce1-9b44d9535c59',NULL,NULL,NULL,NULL,NULL,NULL),
	(15,15,1,'Events','2019-06-30 01:49:24','2019-06-30 01:49:24','cbf2b1ce-f0ff-4b1c-9229-ae16a79cff78',NULL,NULL,NULL,NULL,NULL,NULL),
	(16,16,1,'Our People','2019-06-30 01:49:34','2019-06-30 01:49:34','39fb19f1-53e8-401a-b37d-cce1124d727c',NULL,NULL,NULL,NULL,NULL,NULL),
	(17,17,1,'Emerging Strategy Group','2019-06-30 01:55:01','2019-06-30 01:55:01','fce4b333-dbd3-457d-a276-695d8605e8fa',NULL,NULL,NULL,NULL,NULL,NULL),
	(18,18,1,'Board of Trustees','2019-06-30 01:55:21','2019-06-30 01:55:21','fea2e776-f51a-4d05-80c0-4a80e0a8efba',NULL,NULL,NULL,NULL,NULL,NULL),
	(19,19,1,'New York, NY','2019-06-30 01:55:32','2019-06-30 01:55:32','cf0dd128-4eca-40b4-8cc9-8d4d117b5619',NULL,NULL,NULL,NULL,NULL,NULL),
	(20,20,1,'History','2019-06-30 01:55:40','2019-06-30 01:55:40','08f8d497-b0ca-4c95-ad9b-a26ab5b29090',NULL,NULL,NULL,NULL,NULL,NULL);

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

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;

INSERT INTO `deprecationerrors` (`id`, `key`, `fingerprint`, `lastOccurrence`, `file`, `line`, `message`, `traces`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'ElementQuery::getIterator()','/Users/adamwells/Sites/_IK/ik-craft-demo/templates/index.twig:20','2019-06-30 17:17:01','/Users/adamwells/Sites/_IK/ik-craft-demo/templates/index.twig',20,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/storage/runtime/compiled_templates/a0/a03b4c7bd3f46b936e039fa8b66afaa82a587a58d315bd2d09095ed90b171bab.php\",\"line\":70,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"method\":\"doDisplay\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], []\"},{\"objectClass\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], []\"},{\"objectClass\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], []\"},{\"objectClass\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[], []\"},{\"objectClass\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/Template.php\",\"line\":392,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[]\"},{\"objectClass\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/Environment.php\",\"line\":318,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":null,\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"\\\", []]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null}]','2019-06-30 17:17:01','2019-06-30 17:17:01','aa7240c1-9f75-46aa-ab04-3d64e3c4ad31'),
	(33,'ElementQuery::getIterator()','/Users/adamwells/Sites/_IK/ik-craft-demo/templates/components/layout/header.twig:33','2019-06-30 18:37:25','/Users/adamwells/Sites/_IK/ik-craft-demo/templates/components/layout/header.twig',33,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/storage/runtime/compiled_templates/f0/f0d3eb414832283c50380e7d64fa2adff6d80ae052d5389eb700bc3be752e6e3.php\",\"line\":112,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_f02f5106833f2f55ff1a485ffc09627deedbf2988a7c433f926e5a805f08af09\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_f02f5106833f2f55ff1a485ffc09627deedbf2988a7c433f926e5a805f08af09\",\"method\":\"doDisplay\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], []\"},{\"objectClass\":\"__TwigTemplate_f02f5106833f2f55ff1a485ffc09627deedbf2988a7c433f926e5a805f08af09\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], []\"},{\"objectClass\":\"__TwigTemplate_f02f5106833f2f55ff1a485ffc09627deedbf2988a7c433f926e5a805f08af09\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], []\"},{\"objectClass\":\"__TwigTemplate_f02f5106833f2f55ff1a485ffc09627deedbf2988a7c433f926e5a805f08af09\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], []\"},{\"objectClass\":\"__TwigTemplate_f02f5106833f2f55ff1a485ffc09627deedbf2988a7c433f926e5a805f08af09\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/storage/runtime/compiled_templates/d5/d59c95f4d73d2b7fb356f1acff853c66017791095ea6f1c4e1c19dd92849cb1f.php\",\"line\":59,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...]\"},{\"objectClass\":\"__TwigTemplate_4951e5b79bbc474d0ac1fbb0995877ad9786ab288e088eb03287f02ab22f9587\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_4951e5b79bbc474d0ac1fbb0995877ad9786ab288e088eb03287f02ab22f9587\",\"method\":\"doDisplay\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], [\\\"content\\\" => [__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_4951e5b79bbc474d0ac1fbb0995877ad9786ab288e088eb03287f02ab22f9587\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], [\\\"content\\\" => [__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_4951e5b79bbc474d0ac1fbb0995877ad9786ab288e088eb03287f02ab22f9587\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], [\\\"content\\\" => [__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_4951e5b79bbc474d0ac1fbb0995877ad9786ab288e088eb03287f02ab22f9587\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], [\\\"content\\\" => [__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_4951e5b79bbc474d0ac1fbb0995877ad9786ab288e088eb03287f02ab22f9587\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/storage/runtime/compiled_templates/a0/a03b4c7bd3f46b936e039fa8b66afaa82a587a58d315bd2d09095ed90b171bab.php\",\"line\":45,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], [\\\"content\\\" => [__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"method\":\"doDisplay\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], [\\\"content\\\" => [__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], [\\\"content\\\" => [__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], [\\\"content\\\" => [__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331, \\\"block_content\\\"]]\"},{\"objectClass\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[], []\"},{\"objectClass\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/Template.php\",\"line\":392,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[]\"},{\"objectClass\":\"__TwigTemplate_cdcc2109fde45357f3d2e30d134a90d0c7c60f65b8ee0d25499bc1586e235331\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/twig/twig/src/Environment.php\",\"line\":318,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"\\\", []\"},{\"objectClass\":null,\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"\\\", []]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/adamwells/Sites/_IK/ik-craft-demo/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null}]','2019-06-30 18:37:25','2019-06-30 18:37:25','5d2567e0-2867-4a11-a688-28aa221746ea');

/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
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
	(1,'craft\\elements\\Entry','{\"sourceOrder\":[[\"key\",\"*\"],[\"heading\",\"Header Navigation\"],[\"key\",\"section:acc864f2-7951-4b85-8639-f771df381a56\"],[\"key\",\"section:3d68d8a0-b786-405c-8b3c-d3ed8c4b93f8\"],[\"heading\",\"Herousel\"],[\"key\",\"section:06021517-c456-4337-a55c-342f170b509e\"],[\"key\",\"section:f4806157-8213-4481-a5ca-4697ca313dfe\"]],\"sources\":{\"section:f4806157-8213-4481-a5ca-4697ca313dfe\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"link\"}},\"*\":{\"tableAttributes\":{\"1\":\"section\",\"2\":\"postDate\",\"3\":\"expiryDate\",\"4\":\"link\"}},\"section:acc864f2-7951-4b85-8639-f771df381a56\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"link\"}},\"section:06021517-c456-4337-a55c-342f170b509e\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"link\"}}}}','2019-06-30 01:47:26','2019-06-30 01:47:26','36d00495-30df-4210-b375-eeae200ffc8b');

/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements`;

CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;

INSERT INTO `elements` (`id`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'craft\\elements\\User',1,0,'2019-06-29 17:33:17','2019-06-29 17:33:17',NULL,'be1a2284-fe60-4830-8564-b799382b504c'),
	(2,NULL,'craft\\elements\\Entry',1,0,'2019-06-29 22:13:15','2019-06-29 22:15:53','2019-06-29 22:15:53','c3278ec5-94d5-40a1-8a04-f1ca04a82586'),
	(3,NULL,'craft\\elements\\Asset',1,0,'2019-06-29 22:23:54','2019-06-29 22:24:09',NULL,'ac8d3164-bcd8-4531-8bb5-770d8ee2cd34'),
	(4,1,'craft\\elements\\Entry',1,0,'2019-06-29 22:24:09','2019-06-29 23:21:53','2019-06-29 23:22:25','e93bba1a-e7be-44d8-8677-1c702354950d'),
	(5,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:49:42','2019-06-30 02:59:07',NULL,'49e9cd1f-51f2-48df-af1b-36f48d1427e9'),
	(6,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:50:04','2019-06-30 02:40:33',NULL,'2a1131aa-7133-495b-afb2-77803ffc74ca'),
	(7,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:50:32','2019-06-30 02:40:33',NULL,'05282b44-f464-40d6-9926-9f4514abcd56'),
	(8,2,'craft\\elements\\Entry',1,0,'2019-06-29 22:50:58','2019-06-30 02:40:33',NULL,'8cc61ae5-a51a-4a65-b3d9-c4de946f57d3'),
	(9,3,'craft\\elements\\Entry',1,0,'2019-06-29 23:06:49','2019-06-29 23:23:36',NULL,'809f519d-55d0-4f92-b79e-1f498542a2d5'),
	(10,1,'craft\\elements\\Entry',1,0,'2019-06-29 23:23:24','2019-06-29 23:23:28',NULL,'acdfdb40-fd89-4477-814a-93b800870268'),
	(11,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:47:37','2019-06-30 01:47:37',NULL,'ceb30a59-ce72-4a23-8033-e8c0922b3cb7'),
	(12,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:47:56','2019-06-30 01:47:56',NULL,'f6cb7fac-8922-4268-868a-b8b6e4a2ea46'),
	(13,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:48:37','2019-06-30 01:48:42',NULL,'d50f512d-0eb4-46fa-b177-9720be6a36f5'),
	(14,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:49:17','2019-06-30 01:49:17',NULL,'6680301c-64f4-4e21-9272-ce0737efa1cf'),
	(15,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:49:24','2019-06-30 01:49:24',NULL,'c1a2e394-fd61-4dc3-acd3-433ab95821ce'),
	(16,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:49:34','2019-06-30 01:49:34',NULL,'1f401885-f046-4247-bc7f-cd5b8d8217cb'),
	(17,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:55:01','2019-06-30 01:55:01',NULL,'0e92d0e9-f51b-4380-9f1a-7d11d71e22a0'),
	(18,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:55:21','2019-06-30 01:55:21',NULL,'0ad52a56-df58-4832-80d1-1a0c4d931497'),
	(19,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:55:32','2019-06-30 01:55:32',NULL,'5569b3a7-036e-40bd-b149-a42756a917f3'),
	(20,NULL,'craft\\elements\\Entry',1,0,'2019-06-30 01:55:40','2019-06-30 01:55:40',NULL,'37319eda-f4ab-4664-9504-c984b149c423');

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
	(5,5,1,'business-industries',NULL,1,'2019-06-29 22:49:42','2019-06-30 02:59:07','e3993d78-506c-4073-90bb-6192b9867344'),
	(6,6,1,'energy-environmental',NULL,1,'2019-06-29 22:50:04','2019-06-30 02:40:33','29e47996-5570-4f7b-970e-7780116d22a5'),
	(7,7,1,'opportunity-development',NULL,1,'2019-06-29 22:50:32','2019-06-30 02:40:33','f1593a4f-50f0-4442-81eb-83ee3a6d1dcb'),
	(8,8,1,'philanthropy-social-enterprise',NULL,1,'2019-06-29 22:50:58','2019-06-30 02:40:33','cffa708f-e0df-4375-b244-5779657b9bc6'),
	(9,9,1,'first-herousel',NULL,1,'2019-06-29 23:06:49','2019-06-29 23:23:36','7ca57260-1963-41e6-8dfa-1ab917d76133'),
	(10,10,1,'first-hero-slide',NULL,1,'2019-06-29 23:23:24','2019-06-29 23:23:28','c759b15c-3b4a-409c-9b67-e66198353d84'),
	(11,11,1,'programs',NULL,1,'2019-06-30 01:47:37','2019-06-30 01:47:37','d8594709-3555-4da5-a81f-9d8f8c8b5ffc'),
	(12,12,1,'idhs-global-leadership-network',NULL,1,'2019-06-30 01:47:56','2019-06-30 01:47:58','ef2a44f2-7eb1-449c-9fdb-501a38458243'),
	(13,13,1,'global-innovators-group',NULL,1,'2019-06-30 01:48:37','2019-06-30 01:48:47','967dd604-41be-4994-839a-7dbb84c72249'),
	(14,14,1,'about-us',NULL,1,'2019-06-30 01:49:17','2019-06-30 01:49:18','6f6c7be1-1067-4f4f-8442-f0ee01efe0e0'),
	(15,15,1,'events',NULL,1,'2019-06-30 01:49:24','2019-06-30 01:49:39','d2090c17-8890-4a85-8e50-89b1459d18bf'),
	(16,16,1,'our-people',NULL,1,'2019-06-30 01:49:34','2019-06-30 01:49:38','5a8d31b7-8310-43a3-aa2b-ab81c6a7d35e'),
	(17,17,1,'emerging-strategy-group',NULL,1,'2019-06-30 01:55:01','2019-06-30 01:55:01','85384048-8e4b-4522-be18-9c1ee640f700'),
	(18,18,1,'board-of-trustees',NULL,1,'2019-06-30 01:55:21','2019-06-30 01:55:22','bdad454a-e1d4-4fcf-ae81-1cbf0934f17d'),
	(19,19,1,'new-york-ny',NULL,1,'2019-06-30 01:55:32','2019-06-30 01:55:32','60ba70c9-ddef-462f-b9e0-a2c4c36893bf'),
	(20,20,1,'history',NULL,1,'2019-06-30 01:55:40','2019-06-30 01:55:40','ffdf89e4-85a6-480e-bf55-b2aa69468e61');

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
	(5,3,NULL,3,1,'2019-06-29 22:49:00',NULL,NULL,'2019-06-29 22:49:42','2019-06-30 02:59:07','7942cff2-c3ea-46e7-bfd3-20241fff1789'),
	(6,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-06-29 22:50:05','2019-06-30 02:40:33','5a3f2c10-9ca3-4cf1-a589-bae903db41d5'),
	(7,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-06-29 22:50:32','2019-06-30 02:40:33','74262ca7-e482-43fb-ae2e-099c672039c6'),
	(8,3,NULL,3,1,'2019-06-29 22:50:00',NULL,NULL,'2019-06-29 22:50:58','2019-06-30 02:40:33','56abec45-d653-4bf7-8f08-62e1824e00d7'),
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
	(20,5,NULL,5,1,'2019-06-30 01:55:00',NULL,NULL,'2019-06-30 01:55:40','2019-06-30 01:55:40','7a80820f-03e8-46b9-bb91-fd12966a5129');

/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;


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
	(1,1,1,'Herousel Slides','herouselSlides',0,'Title','{slideTitle}',1,'2019-06-29 17:57:44','2019-06-29 23:21:53',NULL,'e07042df-c02d-4b04-a175-e9291e3bee4a'),
	(2,2,NULL,'Basic Pages','basicPages',0,NULL,'{section.name|raw}',1,'2019-06-29 22:13:15','2019-06-29 22:13:15','2019-06-29 22:15:53','ac3ca9d2-9388-41b5-9362-b6db24a7e5bf'),
	(3,3,2,'Header Navigation Blocks','headerNavigationBlocks',0,'Title','{blockTitle}',1,'2019-06-29 22:41:05','2019-06-29 22:52:13',NULL,'6bef59cb-3103-44b4-a193-326a2758ecdf'),
	(4,4,3,'Herousels','herousels',1,'Title','',1,'2019-06-29 23:03:21','2019-06-29 23:05:24',NULL,'7b3aeb3f-1bdf-4cb2-8163-503979b1e13f'),
	(5,5,NULL,'Navigation Links','navigationLinks',1,'Title',NULL,1,'2019-06-30 01:46:32','2019-06-30 01:46:32',NULL,'48c83400-948a-4fe7-befa-a28551d35165');

/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;

INSERT INTO `entryversions` (`id`, `entryId`, `sectionId`, `creatorId`, `siteId`, `num`, `notes`, `data`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,2,1,1,1,NULL,'{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Basic Pages\",\"slug\":\"basic-pages\",\"postDate\":1561846380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2019-06-29 22:13:15','2019-06-29 22:13:15','522a034d-cf5e-4b2e-82e4-4e847cab8db2'),
	(2,2,2,1,1,2,NULL,'{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Basic Pages\",\"slug\":\"basic-pages\",\"postDate\":1561846380,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":[]}','2019-06-29 22:13:15','2019-06-29 22:13:15','097b39ba-b0e8-4488-8d3a-561694031e90'),
	(3,4,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Test hero slide\",\"slug\":\"test-hero-slide\",\"postDate\":1561847040,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":[\"3\"]}}','2019-06-29 22:24:09','2019-06-29 22:24:09','b9ac1f29-f29e-4ce2-a443-30d798018831'),
	(4,5,3,1,1,1,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Business & Industries\",\"slug\":\"business-industries\",\"postDate\":1561848540,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"#e1dfed\",\"4\":[],\"5\":[],\"3\":\"Business & Industries\"}}','2019-06-29 22:49:42','2019-06-29 22:49:42','9fc41d57-f448-4eba-9b8c-135220bc9043'),
	(5,6,3,1,1,1,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Energy & Environmental\",\"slug\":\"energy-environmental\",\"postDate\":1561848600,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"#3989f3\",\"4\":[],\"5\":[],\"3\":\"Energy & Environmental\"}}','2019-06-29 22:50:05','2019-06-29 22:50:05','c9d155d1-1545-4039-979b-b9a64de878a8'),
	(6,7,3,1,1,1,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Opportunity & Development\",\"slug\":\"opportunity-development\",\"postDate\":1561848600,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"#00f000\",\"4\":[],\"5\":[],\"3\":\"Opportunity & Development\"}}','2019-06-29 22:50:32','2019-06-29 22:50:32','e393eb50-fbd9-47d5-84f3-bb888ffbaa71'),
	(7,8,3,1,1,1,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Philanthropy & Social Enterprise\",\"slug\":\"philanthropy-social-enterprise\",\"postDate\":1561848600,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"#ff2659\",\"4\":[],\"5\":[],\"3\":\"Philanthropy & Social Enterprise\"}}','2019-06-29 22:50:58','2019-06-29 22:50:58','049628f3-f303-4523-9a37-d41b3efdc69a'),
	(8,7,3,1,1,2,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Opportunity & Development\",\"slug\":\"opportunity-development\",\"postDate\":1561848600,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"#fb8f07\",\"4\":[],\"5\":[],\"3\":\"Opportunity & Development\"}}','2019-06-29 22:51:13','2019-06-29 22:51:13','b55b93d1-223c-4870-a5ba-8d63928cf375'),
	(9,6,3,1,1,2,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Energy & Environmental\",\"slug\":\"energy-environmental\",\"postDate\":1561848600,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"#00f000\",\"4\":[],\"5\":[],\"3\":\"Energy & Environmental\"}}','2019-06-29 22:51:24','2019-06-29 22:51:24','10d39eaf-4e99-473e-8919-335aca08a3c8'),
	(10,5,3,1,1,2,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Business & Industries\",\"slug\":\"business-industries\",\"postDate\":1561848540,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"#3a71f4\",\"4\":[],\"5\":[],\"3\":\"Business & Industries\"}}','2019-06-29 22:51:32','2019-06-29 22:51:32','7a566c36-5a00-4ec5-ad91-0e3076701b4c'),
	(11,9,4,1,1,1,'','{\"typeId\":\"4\",\"authorId\":\"1\",\"title\":\"First Herousel\",\"slug\":\"first-herousel\",\"postDate\":1561849560,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"6\":[\"4\"]}}','2019-06-29 23:06:49','2019-06-29 23:06:49','66505cf6-948b-498d-826b-c4a000bb8dec'),
	(12,10,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"First Hero Slide\",\"slug\":\"first-hero-slide\",\"postDate\":1561850580,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"11\":\"Learning\",\"10\":\"This is the copy to my slide. There are going to be two sentences.\\nThen there is going to be a break in the lines.\",\"12\":\"Learn More\",\"13\":[],\"8\":[\"3\"],\"9\":\"First Hero Slide\"}}','2019-06-29 23:23:24','2019-06-29 23:23:24','c36967da-92af-4af0-9ad8-6a5cefdf99a6'),
	(13,9,4,1,1,2,'','{\"typeId\":\"4\",\"authorId\":\"1\",\"title\":\"First Herousel\",\"slug\":\"first-herousel\",\"postDate\":1561849560,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"6\":[\"10\"]}}','2019-06-29 23:23:36','2019-06-29 23:23:36','457c7e4d-5d3c-4f0d-9e7f-46ee088775f3'),
	(14,11,5,1,1,1,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Programs\",\"slug\":\"programs\",\"postDate\":1561859220,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2019-06-30 01:47:37','2019-06-30 01:47:37','f8a36560-6ccb-4532-8ac6-4fe78c7da04d'),
	(15,12,5,1,1,1,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"IDHS Global Leadership Network\",\"slug\":\"idhs-global-leadership-network\",\"postDate\":1561859220,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2019-06-30 01:47:56','2019-06-30 01:47:56','72e9fdf3-321c-43f3-a118-57640370a455'),
	(16,13,5,1,1,1,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Global Innovators Group\",\"slug\":\"global-innovators-group\",\"postDate\":1561859280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2019-06-30 01:48:37','2019-06-30 01:48:37','cde2b382-fde7-49eb-a75f-79260fd7477a'),
	(17,14,5,1,1,1,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"About Us\",\"slug\":\"about-us\",\"postDate\":1561859340,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2019-06-30 01:49:18','2019-06-30 01:49:18','eb2886d6-d4a1-4e6e-bcbd-30c650c5520f'),
	(18,15,5,1,1,1,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Events\",\"slug\":\"events\",\"postDate\":1561859340,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2019-06-30 01:49:24','2019-06-30 01:49:24','f6f4f1b1-20aa-438d-9891-0c52d763684e'),
	(19,16,5,1,1,1,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Our People\",\"slug\":\"our-people\",\"postDate\":1561859340,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2019-06-30 01:49:34','2019-06-30 01:49:34','f6ba8041-ad8b-4363-8314-958db5bd38b5'),
	(20,17,5,1,1,1,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Emerging Strategy Group\",\"slug\":\"emerging-strategy-group\",\"postDate\":1561859700,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"11\",\"fields\":[]}','2019-06-30 01:55:01','2019-06-30 01:55:01','6eb4d1c9-a542-4444-aeef-9485f90b1289'),
	(21,18,5,1,1,1,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Board of Trustees\",\"slug\":\"board-of-trustees\",\"postDate\":1561859700,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"16\",\"fields\":[]}','2019-06-30 01:55:21','2019-06-30 01:55:21','5c39d7fc-f5e0-4389-b8d6-de28fba7ff17'),
	(22,19,5,1,1,1,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"New York, NY\",\"slug\":\"new-york-ny\",\"postDate\":1561859700,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"15\",\"fields\":[]}','2019-06-30 01:55:32','2019-06-30 01:55:32','db20767b-180b-456d-b34a-e718f80ba3f8'),
	(23,20,5,1,1,1,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"History\",\"slug\":\"history\",\"postDate\":1561859700,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"14\",\"fields\":[]}','2019-06-30 01:55:40','2019-06-30 01:55:40','abc0b28d-3a49-4cde-9d2b-d5a769a2415a'),
	(24,5,3,1,1,3,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Business & Industries\",\"slug\":\"business-industries\",\"postDate\":1561848540,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"#3a71f4\",\"4\":[],\"5\":[\"18\"],\"3\":\"Business & Industries\"}}','2019-06-30 02:47:56','2019-06-30 02:47:56','c168d08d-87af-4db2-b660-48c241faef76'),
	(25,5,3,1,1,4,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Business & Industries\",\"slug\":\"business-industries\",\"postDate\":1561848540,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"#3a71f4\",\"4\":[],\"5\":[],\"3\":\"Business & Industries\"}}','2019-06-30 02:53:15','2019-06-30 02:53:15','6d8ee937-f854-4641-a9f9-4fe0ac21bc41'),
	(26,5,3,1,1,5,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Business & Industries\",\"slug\":\"business-industries\",\"postDate\":1561848540,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"#eee32f\",\"4\":[],\"5\":[],\"3\":\"Business & Industries\"}}','2019-06-30 02:58:55','2019-06-30 02:58:55','6f733e91-ee49-4ddf-9f7f-db26bacf5e7c'),
	(27,5,3,1,1,6,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Business & Industries\",\"slug\":\"business-industries\",\"postDate\":1561848540,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"2\":\"#375cf5\",\"4\":[],\"5\":[],\"3\":\"Business & Industries\"}}','2019-06-30 02:59:07','2019-06-30 02:59:07','f32e8d3c-2f68-4145-a526-a6a86fb04f46');

/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;


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
	(9,2,4,2,0,4,'2019-06-29 22:52:13','2019-06-29 22:52:13','8093453f-1542-4b53-85b7-56ec8efa3ca1'),
	(10,2,4,4,0,3,'2019-06-29 22:52:13','2019-06-29 22:52:13','e361201c-bf36-4cc4-b46e-75e3de85eb13'),
	(11,2,4,5,0,2,'2019-06-29 22:52:13','2019-06-29 22:52:13','c4cbd502-720f-45a6-af32-7dc62c724cfc'),
	(12,2,4,3,0,1,'2019-06-29 22:52:13','2019-06-29 22:52:13','5e3202f0-3aa1-403f-b5e0-3349b5563046'),
	(13,3,5,6,0,1,'2019-06-29 23:05:24','2019-06-29 23:05:24','fadc3360-2699-4210-b4ef-ae2151073c4f'),
	(21,1,8,8,0,6,'2019-06-29 23:21:53','2019-06-29 23:21:53','e0f23be2-3aed-47a5-b8a2-38dea273e7b6'),
	(22,1,8,9,0,1,'2019-06-29 23:21:53','2019-06-29 23:21:53','e779706d-2c84-4014-87cf-627c41f89c97'),
	(23,1,8,12,0,4,'2019-06-29 23:21:53','2019-06-29 23:21:53','7cc44d9b-476c-4711-b5dd-93552dd57e1a'),
	(24,1,8,10,0,2,'2019-06-29 23:21:53','2019-06-29 23:21:53','7e56f3f0-fb51-4b68-801d-8a40d51d4e95'),
	(25,1,8,13,0,5,'2019-06-29 23:21:53','2019-06-29 23:21:53','27395a1a-c606-40bb-83bb-942f9ccca725'),
	(26,1,8,11,0,3,'2019-06-29 23:21:53','2019-06-29 23:21:53','ab4d3437-d7bd-49ed-867d-0dcf053750f3');

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
	(2,'craft\\elements\\Entry','2019-06-29 22:47:37','2019-06-29 22:52:13',NULL,'56d520b9-dc62-43e6-8250-56e8a644ecb9'),
	(3,'craft\\elements\\Entry','2019-06-29 23:05:24','2019-06-29 23:05:24',NULL,'08229f3b-f574-4612-9224-d9a27260d924');

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
	(4,2,'Content',1,'2019-06-29 22:52:13','2019-06-29 22:52:13','4e13eb50-68d5-416b-b814-59b6a4a46e4e'),
	(5,3,'Slides',1,'2019-06-29 23:05:24','2019-06-29 23:05:24','1e2cfe62-ca11-4749-a43a-0d427c942dfe'),
	(8,1,'Content',1,'2019-06-29 23:21:53','2019-06-29 23:21:53','fc0da13b-fb1a-40d9-8a14-8f6448bd6608');

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
	(2,2,'Accent Color','accentColor','global','Choose a color for the blocks accent',1,'none',NULL,'craft\\fields\\Color','{\"defaultColor\":\"#e1dfed\"}','2019-06-29 22:42:56','2019-06-29 22:42:56','0a68a217-6bc5-49ac-bdd1-14e540d37976'),
	(3,2,'Block Title','blockTitle','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"1\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-29 22:45:40','2019-06-29 22:45:40','f0ec0c83-08cc-48d0-9a8b-539f73b52bee'),
	(4,2,'Block Icon','blockIcon','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"singleUploadLocationSubpath\":\"images/icons\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add an icon for this block\",\"localizeRelations\":false}','2019-06-29 22:46:30','2019-06-29 22:46:30','77c9f661-7918-4604-9a2d-268172dedf4c'),
	(5,2,'Block Link','blockLink','global','',1,'site',NULL,'craft\\fields\\Entries','{\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"1\",\"selectionLabel\":\"Select another entry to link to\",\"localizeRelations\":false}','2019-06-29 22:49:05','2019-06-29 22:49:05','b86669c7-1f17-4924-8151-b08b5c5e499f'),
	(6,3,'Herousel Slides','herouselSlides','global','Select up to four slides for the herousel.',1,'site',NULL,'craft\\fields\\Entries','{\"sources\":[\"section:f4806157-8213-4481-a5ca-4697ca313dfe\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"4\",\"selectionLabel\":\"Add a slide to the herousel\",\"localizeRelations\":false}','2019-06-29 23:05:04','2019-06-29 23:06:30','8ad551d3-1d49-460d-b73f-7f8b70de3740'),
	(8,1,'Slide Image','slideImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"defaultUploadLocationSubpath\":\"images/slides\",\"singleUploadLocationSource\":\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2019-06-29 23:16:31','2019-06-29 23:16:31','18d5ee1b-53c5-415a-8fd8-b53d9d43f763'),
	(9,1,'Slide Title','slideTitle','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"1\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-29 23:17:03','2019-06-29 23:17:33','24a5c67a-8506-4038-9417-3273d63bb6d1'),
	(10,1,'Slide Copy','slideCopy','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"Lorem ipsum dolor sit amet...\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"1\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-29 23:17:22','2019-06-29 23:17:22','96cdbd77-6e4d-414a-9b67-56b4900b420c'),
	(11,1,'Slide Category','slideCategory','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-29 23:19:30','2019-06-29 23:19:30','f3d95e24-acd1-44aa-b881-d39395747064'),
	(12,1,'Slide CTA Copy','slideCtaCopy','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"25\",\"columnType\":\"text\"}','2019-06-29 23:20:11','2019-06-29 23:20:11','2db23733-dff0-4265-a542-6ecad5cb1b9e'),
	(13,1,'Slide CTA Link','slideCtaLink','global','',1,'site',NULL,'craft\\fields\\Entries','{\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"1\",\"selectionLabel\":\"Select another entry to link to\",\"localizeRelations\":false}','2019-06-29 23:20:33','2019-06-29 23:20:33','edacbb61-d979-4e62-bfed-e8425456b1f1');

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
	(1,'3.1.32.1','3.1.28',0,'a:10:{s:11:\"fieldGroups\";a:3:{s:36:\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\";a:1:{s:4:\"name\";s:6:\"Common\";}s:36:\"2babdf9b-c278-4420-ade7-ab8175bb80d3\";a:1:{s:4:\"name\";s:17:\"Header Navigation\";}s:36:\"4b19cdc5-eb0d-43c0-a63b-60bacd175db4\";a:1:{s:4:\"name\";s:9:\"Herousels\";}}s:10:\"siteGroups\";a:1:{s:36:\"5b0c9095-dbd8-49a8-9f0e-98f12e9c1683\";a:1:{s:4:\"name\";s:13:\"IK Craft Demo\";}}s:5:\"sites\";a:1:{s:36:\"f2559c18-7489-4189-aecc-54995f3bff7a\";a:8:{s:7:\"baseUrl\";s:17:\"$DEFAULT_SITE_URL\";s:6:\"handle\";s:7:\"default\";s:7:\"hasUrls\";b:1;s:8:\"language\";s:5:\"en-US\";s:4:\"name\";s:13:\"IK Craft Demo\";s:7:\"primary\";b:1;s:9:\"siteGroup\";s:36:\"5b0c9095-dbd8-49a8-9f0e-98f12e9c1683\";s:9:\"sortOrder\";i:1;}}s:5:\"email\";a:3:{s:9:\"fromEmail\";s:29:\"adam@interactiveknowledge.com\";s:8:\"fromName\";s:13:\"IK Craft Demo\";s:13:\"transportType\";s:37:\"craft\\mail\\transportadapters\\Sendmail\";}s:6:\"system\";a:5:{s:7:\"edition\";s:4:\"solo\";s:4:\"name\";s:13:\"IK Craft Demo\";s:4:\"live\";b:1;s:13:\"schemaVersion\";s:6:\"3.1.28\";s:8:\"timeZone\";s:19:\"America/Los_Angeles\";}s:5:\"users\";a:5:{s:24:\"requireEmailVerification\";b:1;s:23:\"allowPublicRegistration\";b:0;s:12:\"defaultGroup\";N;s:14:\"photoVolumeUid\";N;s:12:\"photoSubpath\";s:0:\"\";}s:12:\"dateModified\";i:1561862432;s:8:\"sections\";a:4:{s:36:\"f4806157-8213-4481-a5ca-4697ca313dfe\";a:7:{s:4:\"name\";s:15:\"Herousel Slides\";s:6:\"handle\";s:14:\"herouselSlides\";s:4:\"type\";s:7:\"channel\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"f2559c18-7489-4189-aecc-54995f3bff7a\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:0;s:9:\"uriFormat\";N;s:8:\"template\";N;}}s:10:\"entryTypes\";a:1:{s:36:\"e07042df-c02d-4b04-a175-e9291e3bee4a\";a:7:{s:4:\"name\";s:15:\"Herousel Slides\";s:6:\"handle\";s:14:\"herouselSlides\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";s:12:\"{slideTitle}\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"d56f6f75-29d4-4458-84a1-560f8fa794cd\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:6:{s:36:\"18d5ee1b-53c5-415a-8fd8-b53d9d43f763\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:6;}s:36:\"24a5c67a-8506-4038-9417-3273d63bb6d1\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"2db23733-dff0-4265-a542-6ecad5cb1b9e\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"96cdbd77-6e4d-414a-9b67-56b4900b420c\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"edacbb61-d979-4e62-bfed-e8425456b1f1\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:5;}s:36:\"f3d95e24-acd1-44aa-b881-d39395747064\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}}}}}}}}}s:36:\"acc864f2-7951-4b85-8639-f771df381a56\";a:8:{s:4:\"name\";s:17:\"Navigation Blocks\";s:6:\"handle\";s:16:\"navigationBlocks\";s:4:\"type\";s:9:\"structure\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"f2559c18-7489-4189-aecc-54995f3bff7a\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:0;s:9:\"uriFormat\";N;s:8:\"template\";N;}}s:9:\"structure\";a:2:{s:3:\"uid\";s:36:\"711c9b98-5218-4a8c-831e-0b0b70664b65\";s:9:\"maxLevels\";i:1;}s:10:\"entryTypes\";a:1:{s:36:\"6bef59cb-3103-44b4-a193-326a2758ecdf\";a:7:{s:4:\"name\";s:24:\"Header Navigation Blocks\";s:6:\"handle\";s:22:\"headerNavigationBlocks\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";s:12:\"{blockTitle}\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"56d520b9-dc62-43e6-8250-56e8a644ecb9\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:4:{s:36:\"0a68a217-6bc5-49ac-bdd1-14e540d37976\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"77c9f661-7918-4604-9a2d-268172dedf4c\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"b86669c7-1f17-4924-8151-b08b5c5e499f\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"f0ec0c83-08cc-48d0-9a8b-539f73b52bee\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}}}}}}}}s:36:\"06021517-c456-4337-a55c-342f170b509e\";a:7:{s:4:\"name\";s:9:\"Herousels\";s:6:\"handle\";s:9:\"herousels\";s:4:\"type\";s:7:\"channel\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"f2559c18-7489-4189-aecc-54995f3bff7a\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:0;s:9:\"uriFormat\";N;s:8:\"template\";N;}}s:10:\"entryTypes\";a:1:{s:36:\"7b3aeb3f-1bdf-4cb2-8163-503979b1e13f\";a:7:{s:4:\"name\";s:9:\"Herousels\";s:6:\"handle\";s:9:\"herousels\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";s:0:\"\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"08229f3b-f574-4612-9224-d9a27260d924\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:6:\"Slides\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"8ad551d3-1d49-460d-b73f-7f8b70de3740\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}}}}}}}}s:36:\"3d68d8a0-b786-405c-8b3c-d3ed8c4b93f8\";a:8:{s:4:\"name\";s:16:\"Navigation Links\";s:6:\"handle\";s:15:\"navigationLinks\";s:4:\"type\";s:9:\"structure\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"f2559c18-7489-4189-aecc-54995f3bff7a\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:0;s:9:\"uriFormat\";N;s:8:\"template\";N;}}s:9:\"structure\";a:2:{s:3:\"uid\";s:36:\"f8410eba-e92c-449f-8e2a-183643e1ec4f\";s:9:\"maxLevels\";i:2;}s:10:\"entryTypes\";a:1:{s:36:\"48c83400-948a-4fe7-befa-a28551d35165\";a:6:{s:4:\"name\";s:16:\"Navigation Links\";s:6:\"handle\";s:15:\"navigationLinks\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";N;s:9:\"sortOrder\";i:1;}}}}s:6:\"fields\";a:12:{s:36:\"7ca16c4a-c225-4879-b65f-aad29c84a651\";a:10:{s:4:\"name\";s:10:\"Hero Image\";s:6:\"handle\";s:9:\"heroImage\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:1:\"1\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\";s:27:\"singleUploadLocationSubpath\";s:6:\"images\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:0:\"\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\";}s:36:\"0a68a217-6bc5-49ac-bdd1-14e540d37976\";a:10:{s:4:\"name\";s:12:\"Accent Color\";s:6:\"handle\";s:11:\"accentColor\";s:12:\"instructions\";s:36:\"Choose a color for the blocks accent\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:18:\"craft\\fields\\Color\";s:8:\"settings\";a:1:{s:12:\"defaultColor\";s:7:\"#e1dfed\";}s:17:\"contentColumnType\";s:9:\"string(7)\";s:10:\"fieldGroup\";s:36:\"2babdf9b-c278-4420-ade7-ab8175bb80d3\";}s:36:\"f0ec0c83-08cc-48d0-9a8b-539f73b52bee\";a:10:{s:4:\"name\";s:11:\"Block Title\";s:6:\"handle\";s:10:\"blockTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:1:\"1\";s:11:\"initialRows\";s:1:\"1\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"2babdf9b-c278-4420-ade7-ab8175bb80d3\";}s:36:\"77c9f661-7918-4604-9a2d-268172dedf4c\";a:10:{s:4:\"name\";s:10:\"Block Icon\";s:6:\"handle\";s:9:\"blockIcon\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:1:\"1\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\";s:27:\"singleUploadLocationSubpath\";s:12:\"images/icons\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:26:\"Add an icon for this block\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"2babdf9b-c278-4420-ade7-ab8175bb80d3\";}s:36:\"b86669c7-1f17-4924-8151-b08b5c5e499f\";a:10:{s:4:\"name\";s:10:\"Block Link\";s:6:\"handle\";s:9:\"blockLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\fields\\Entries\";s:8:\"settings\";a:7:{s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";N;s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:31:\"Select another entry to link to\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"2babdf9b-c278-4420-ade7-ab8175bb80d3\";}s:36:\"8ad551d3-1d49-460d-b73f-7f8b70de3740\";a:10:{s:4:\"name\";s:15:\"Herousel Slides\";s:6:\"handle\";s:14:\"herouselSlides\";s:12:\"instructions\";s:42:\"Select up to four slides for the herousel.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\fields\\Entries\";s:8:\"settings\";a:7:{s:7:\"sources\";a:1:{i:0;s:44:\"section:f4806157-8213-4481-a5ca-4697ca313dfe\";}s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";N;s:5:\"limit\";s:1:\"4\";s:14:\"selectionLabel\";s:27:\"Add a slide to the herousel\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"4b19cdc5-eb0d-43c0-a63b-60bacd175db4\";}s:36:\"18d5ee1b-53c5-415a-8fd8-b53d9d43f763\";a:10:{s:4:\"name\";s:11:\"Slide Image\";s:6:\"handle\";s:10:\"slideImage\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\";s:28:\"defaultUploadLocationSubpath\";s:13:\"images/slides\";s:26:\"singleUploadLocationSource\";s:43:\"volume:50afdfd7-6c44-4e96-973a-b03967ec3cac\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:5:\"large\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:0:\"\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\";}s:36:\"24a5c67a-8506-4038-9417-3273d63bb6d1\";a:10:{s:4:\"name\";s:11:\"Slide Title\";s:6:\"handle\";s:10:\"slideTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"1\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\";}s:36:\"96cdbd77-6e4d-414a-9b67-56b4900b420c\";a:10:{s:4:\"name\";s:10:\"Slide Copy\";s:6:\"handle\";s:9:\"slideCopy\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:29:\"Lorem ipsum dolor sit amet...\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:1:\"1\";s:11:\"initialRows\";s:1:\"1\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\";}s:36:\"f3d95e24-acd1-44aa-b881-d39395747064\";a:10:{s:4:\"name\";s:14:\"Slide Category\";s:6:\"handle\";s:13:\"slideCategory\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\";}s:36:\"2db23733-dff0-4265-a542-6ecad5cb1b9e\";a:10:{s:4:\"name\";s:14:\"Slide CTA Copy\";s:6:\"handle\";s:12:\"slideCtaCopy\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:2:\"25\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\";}s:36:\"edacbb61-d979-4e62-bfed-e8425456b1f1\";a:10:{s:4:\"name\";s:14:\"Slide CTA Link\";s:6:\"handle\";s:12:\"slideCtaLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\fields\\Entries\";s:8:\"settings\";a:7:{s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";N;s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:31:\"Select another entry to link to\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"9cbd8a73-a772-4caa-acb5-a5a9151ddd55\";}}s:7:\"volumes\";a:1:{s:36:\"50afdfd7-6c44-4e96-973a-b03967ec3cac\";a:7:{s:4:\"name\";s:7:\"Uploads\";s:6:\"handle\";s:7:\"uploads\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:7:\"hasUrls\";b:0;s:3:\"url\";s:0:\"\";s:8:\"settings\";a:1:{s:4:\"path\";s:17:\"@webroot/uploads/\";}s:9:\"sortOrder\";i:1;}}}','[]','GHoZBkXpPlq7','2019-06-29 17:33:17','2019-06-30 02:40:32','65f5429e-47ff-4db3-9d7d-6a0c17149af6');

/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks`;

CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
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
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
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
	(138,NULL,'app','m190502_122019_store_default_user_group_uid','2019-06-29 17:33:17','2019-06-29 17:33:17','2019-06-29 17:33:17','57bed546-4371-43e1-8e72-b3e2d72035cd');

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
	(4,8,10,NULL,3,1,'2019-06-29 23:23:28','2019-06-29 23:23:28','86679729-1f4c-43e5-a097-78d6b6c37071'),
	(5,6,9,NULL,10,1,'2019-06-29 23:23:36','2019-06-29 23:23:36','51566c8b-8812-4d63-a237-fbd6822daf94');

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
	('11155747','@app/web/assets/craftsupport/dist'),
	('1f87fb86','@app/web/assets/updateswidget/dist'),
	('213db9e8','@app/web/assets/recententries/dist'),
	('2748d34e','@app/web/assets/pluginstore/dist'),
	('384e8b1b','@app/web/assets/login/dist'),
	('3c709e65','@app/web/assets/cp/dist'),
	('456bd5db','@app/web/assets/feed/dist'),
	('4974a3ff','@lib/velocity'),
	('55530c17','@lib/jquery.payment'),
	('5721b2ab','@app/web/assets/tablesettings/dist'),
	('58fb5482','@bower/jquery/dist'),
	('5e0bdcf4','@app/web/assets/utilities/dist'),
	('60d1957a','@lib'),
	('6ade6c1b','@app/web/assets/routes/dist'),
	('74a181b4','@app/web/assets/matrixsettings/dist'),
	('776bff77','@lib/element-resize-detector'),
	('7dd385a','@lib/jquery-ui'),
	('802f4581','@lib/selectize'),
	('8731d370','@app/web/assets/edittransform/dist'),
	('8a43010b','@lib/xregexp'),
	('985bfe8','@app/web/assets/installer/dist'),
	('aced3197','@app/web/assets/clearcaches/dist'),
	('b5bc597e','@lib/timepicker'),
	('ccb969fb','@lib/fileupload'),
	('d1735e4e','@lib/prismjs'),
	('d3f554c7','@lib/jquery-touch-events'),
	('d4516805','@lib/picturefill'),
	('daf44854','@lib/d3'),
	('dfdb1229','@app/web/assets/editentry/dist'),
	('e9495fd2','@lib/garnishjs'),
	('f81afe67','@app/web/assets/fields/dist'),
	('fc0f8bec','@lib/fabric'),
	('ff7dd029','@app/web/assets/dashboard/dist');

/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
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
	(3,'title',0,1,' hero delivery '),
	(4,'field',1,1,' hero delivery '),
	(4,'slug',0,1,' test hero slide '),
	(4,'title',0,1,''),
	(5,'field',3,1,' business industries '),
	(5,'field',4,1,''),
	(5,'field',2,1,' 375cf5 '),
	(5,'slug',0,1,' business industries '),
	(5,'title',0,1,' business industries '),
	(6,'field',3,1,' energy environmental '),
	(6,'field',5,1,''),
	(6,'field',4,1,''),
	(6,'field',2,1,' 00f000 '),
	(6,'slug',0,1,' energy environmental '),
	(6,'title',0,1,' energy environmental '),
	(7,'field',3,1,' opportunity development '),
	(7,'field',5,1,''),
	(7,'field',4,1,''),
	(7,'field',2,1,' fb8f07 '),
	(7,'slug',0,1,' opportunity development '),
	(7,'title',0,1,' opportunity development '),
	(8,'field',3,1,' philanthropy social enterprise '),
	(8,'field',5,1,''),
	(8,'field',4,1,''),
	(8,'field',2,1,' ff2659 '),
	(8,'slug',0,1,' philanthropy social enterprise '),
	(8,'title',0,1,' philanthropy social enterprise '),
	(9,'field',6,1,' first hero slide '),
	(9,'slug',0,1,' first herousel '),
	(9,'title',0,1,' first herousel '),
	(4,'field',9,1,''),
	(4,'field',10,1,''),
	(4,'field',11,1,''),
	(4,'field',12,1,''),
	(4,'field',13,1,''),
	(4,'field',8,1,''),
	(10,'field',9,1,' first hero slide '),
	(10,'field',10,1,' this is the copy to my slide there are going to be two sentences then there is going to be a break in the lines '),
	(10,'field',11,1,' learning '),
	(10,'field',12,1,' learn more '),
	(10,'field',13,1,''),
	(10,'field',8,1,' hero delivery '),
	(10,'slug',0,1,' first hero slide '),
	(10,'title',0,1,' first hero slide '),
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
	(5,'field',5,1,'');

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
  `propagateEntries` tinyint(1) NOT NULL DEFAULT 1,
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

INSERT INTO `sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagateEntries`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'Herousel Slides','herouselSlides','channel',1,1,'2019-06-29 17:57:44','2019-06-29 23:21:53',NULL,'f4806157-8213-4481-a5ca-4697ca313dfe'),
	(2,NULL,'Basic Pages','basicPages','single',1,1,'2019-06-29 22:13:15','2019-06-29 22:15:53','2019-06-29 22:15:53','1e1ea071-5025-48d7-af03-57353bb69c52'),
	(3,1,'Navigation Blocks','navigationBlocks','structure',1,1,'2019-06-29 22:41:05','2019-06-30 02:40:32',NULL,'acc864f2-7951-4b85-8639-f771df381a56'),
	(4,NULL,'Herousels','herousels','channel',1,1,'2019-06-29 23:03:21','2019-06-29 23:05:24',NULL,'06021517-c456-4337-a55c-342f170b509e'),
	(5,2,'Navigation Links','navigationLinks','structure',1,1,'2019-06-30 01:46:32','2019-06-30 01:46:32',NULL,'3d68d8a0-b786-405c-8b3c-d3ed8c4b93f8');

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
	(1,1,1,0,NULL,NULL,1,'2019-06-29 17:57:44','2019-06-29 23:21:53','f6a393f1-749c-4ce7-b716-a89a26f8f882'),
	(2,2,1,1,'__home__','',1,'2019-06-29 22:13:15','2019-06-29 22:15:53','7be94367-d231-491e-a3cd-07e5639f55c8'),
	(3,3,1,0,NULL,NULL,1,'2019-06-29 22:41:05','2019-06-30 02:40:32','ba7fcd3e-da7b-4a89-914d-e4a2819f1284'),
	(4,4,1,0,NULL,NULL,1,'2019-06-29 23:03:21','2019-06-29 23:05:24','c2d28c24-02b2-4cf9-8232-5c7976aadb0a'),
	(5,5,1,0,NULL,NULL,1,'2019-06-30 01:46:32','2019-06-30 01:46:32','68b7102d-db07-4091-994a-c4b5109bd753');

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
	(6,1,'1mqJO4OVfMbtONgvHsCs_fRCCgaI7YbprAvPYLV2RspVGQ3sjXR7AGrGUZSZTxiunRRtaP4pmTKwr3lFUtEXr9cJwegwN0Yaj9th','2019-07-01 17:26:19','2019-07-01 20:18:05','8c7fc1fd-935b-407e-b8d8-5b606e20fe9a');

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
	(1,1,1,'IK Craft Demo','default','en-US',1,'$DEFAULT_SITE_URL',1,'2019-06-29 17:33:17','2019-06-29 17:33:17',NULL,'f2559c18-7489-4189-aecc-54995f3bff7a');

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
	(1,1,NULL,1,1,10,0,'2019-06-29 22:49:42','2019-06-29 22:50:58','59a02f3a-08ea-49d0-bafc-da708aaa946b'),
	(2,1,5,1,2,3,1,'2019-06-29 22:49:42','2019-06-29 22:49:42','8a284cc9-e3df-40f5-a61c-cd7effcb2e42'),
	(3,1,6,1,4,5,1,'2019-06-29 22:50:05','2019-06-29 22:50:05','8f837f7f-66f1-433e-b7df-f4d0b3e8eabc'),
	(4,1,7,1,6,7,1,'2019-06-29 22:50:32','2019-06-29 22:50:32','834a2286-029d-4a27-9af2-88aca949d2b5'),
	(5,1,8,1,8,9,1,'2019-06-29 22:50:58','2019-06-29 22:50:58','a62981d4-4fa6-4d65-a206-c67478b1431f'),
	(6,2,NULL,6,1,22,0,'2019-06-30 01:47:37','2019-06-30 01:55:40','f2a17592-1f2d-4507-afb2-a79934aff623'),
	(7,2,11,6,2,9,1,'2019-06-30 01:47:37','2019-06-30 01:55:01','1a804059-6edc-4654-a1de-25842b0b4ab2'),
	(8,2,12,6,3,4,2,'2019-06-30 01:47:56','2019-06-30 01:48:47','68380243-5c02-4cc1-aba7-e4f387d378db'),
	(9,2,13,6,5,6,2,'2019-06-30 01:48:37','2019-06-30 01:48:47','ea8bf69b-8e04-4ff6-98a4-e31dac387273'),
	(10,2,14,6,18,21,1,'2019-06-30 01:49:18','2019-06-30 01:55:40','d64d9e44-f9b9-4dee-9937-7e095b334b66'),
	(11,2,15,6,14,17,1,'2019-06-30 01:49:24','2019-06-30 01:55:32','39f7770f-f059-4eac-a15a-674d4963c3d2'),
	(12,2,16,6,10,13,1,'2019-06-30 01:49:34','2019-06-30 01:55:21','e3af22eb-bba7-4e53-9ebb-926523c9ea0c'),
	(13,2,17,6,7,8,2,'2019-06-30 01:55:01','2019-06-30 01:55:01','84a052ee-f0e8-41d6-b9a1-e89e1a5d2dd7'),
	(14,2,18,6,11,12,2,'2019-06-30 01:55:21','2019-06-30 01:55:21','0770c643-e899-4eb7-a210-1a9ef1f3fdcf'),
	(15,2,19,6,15,16,2,'2019-06-30 01:55:32','2019-06-30 01:55:32','68c96265-cff6-4c6a-b9ee-494a94934c8d'),
	(16,2,20,6,19,20,2,'2019-06-30 01:55:40','2019-06-30 01:55:40','7686486c-dadb-44d6-a935-ff7897158e70');

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
	(1,1,'2019-06-29 22:41:05','2019-06-30 02:40:32',NULL,'711c9b98-5218-4a8c-831e-0b0b70664b65'),
	(2,2,'2019-06-30 01:46:32','2019-06-30 01:46:32',NULL,'f8410eba-e92c-449f-8e2a-183643e1ec4f');

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
	(1,'{\"language\":\"en-US\"}');

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
	(1,'admin',NULL,NULL,NULL,'adam@interactiveknowledge.com','$2y$13$x47uvOgiocaDUiTwGp5Hf.Zqz2nu1AVX.V1YWerabcMD15pyUeduG',1,0,0,0,'2019-07-01 17:26:19',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-06-29 17:33:17','2019-06-29 17:33:17','2019-07-01 17:26:19','86ec60f7-6339-49b3-b904-bdb6e677eb40');

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
	(1,NULL,1,'Uploads','','2019-06-29 22:23:20','2019-06-29 22:23:20','94d6abc8-c88f-4cf6-969a-23c0cb08cc17'),
	(2,NULL,NULL,'Temporary source',NULL,'2019-06-29 22:23:44','2019-06-29 22:23:44','181c4959-1b19-49c0-a8fa-32ee90c5aa45'),
	(3,2,NULL,'user_1','user_1/','2019-06-29 22:23:44','2019-06-29 22:23:44','b8b382b7-76b9-4988-985c-d0659cdc0cf2'),
	(4,1,1,'images','images/','2019-06-29 22:24:09','2019-06-29 22:24:09','3ef8dae8-d51f-48a2-b7c7-005d829df445'),
	(5,4,1,'slides','images/slides/','2019-06-29 23:23:24','2019-06-29 23:23:24','edf631da-3691-4ef7-b9fe-0416f109d681');

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
	(1,NULL,'Uploads','uploads','craft\\volumes\\Local',0,NULL,'{\"path\":\"@webroot/uploads/\"}',1,'2019-06-29 22:23:20','2019-06-29 22:23:20',NULL,'50afdfd7-6c44-4e96-973a-b03967ec3cac');

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
	(1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-06-29 17:33:42','2019-06-29 17:33:42','7b9306a5-1ae6-4b43-b12d-c790242e3b04'),
	(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-06-29 17:33:42','2019-06-29 17:33:42','7e9762c4-c961-4114-a906-705dc340bd31'),
	(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-06-29 17:33:42','2019-06-29 17:33:42','0ec70712-5bee-4cba-9a30-e0c4c2099eff'),
	(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-06-29 17:33:42','2019-06-29 17:33:42','8dd6b047-02fb-464c-8ccd-1d7ae46c8ffb');

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
