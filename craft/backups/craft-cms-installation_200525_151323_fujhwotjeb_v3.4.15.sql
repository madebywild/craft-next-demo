-- MySQL dump 10.16  Distrib 10.1.41-MariaDB, for Linux (x86_64)
--
-- Host: mariadb    Database: craft
-- ------------------------------------------------------
-- Server version	10.1.45-MariaDB-1~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ut_assetindexdata`
--

DROP TABLE IF EXISTS `ut_assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `ut_assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `ut_assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `ut_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_assets`
--

DROP TABLE IF EXISTS `ut_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `uploaderId` int(11) DEFAULT NULL,
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
  KEY `ut_assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `ut_assets_folderId_idx` (`folderId`),
  KEY `ut_assets_volumeId_idx` (`volumeId`),
  KEY `ut_assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `ut_assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `ut_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_assets_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `ut_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ut_assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `ut_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_assettransformindex`
--

DROP TABLE IF EXISTS `ut_assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_assettransforms`
--

DROP TABLE IF EXISTS `ut_assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_assettransforms` (
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
  UNIQUE KEY `ut_assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `ut_assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_categories`
--

DROP TABLE IF EXISTS `ut_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_categories_groupId_idx` (`groupId`),
  KEY `ut_categories_parentId_fk` (`parentId`),
  CONSTRAINT `ut_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `ut_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_categorygroups`
--

DROP TABLE IF EXISTS `ut_categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_categorygroups` (
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
  KEY `ut_categorygroups_name_idx` (`name`),
  KEY `ut_categorygroups_handle_idx` (`handle`),
  KEY `ut_categorygroups_structureId_idx` (`structureId`),
  KEY `ut_categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `ut_categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `ut_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ut_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `ut_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_categorygroups_sites`
--

DROP TABLE IF EXISTS `ut_categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `ut_categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `ut_categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_changedattributes`
--

DROP TABLE IF EXISTS `ut_changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_changedattributes` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `ut_changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `ut_changedattributes_siteId_fk` (`siteId`),
  KEY `ut_changedattributes_userId_fk` (`userId`),
  CONSTRAINT `ut_changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ut_changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ut_changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_changedfields`
--

DROP TABLE IF EXISTS `ut_changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_changedfields` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `ut_changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `ut_changedfields_siteId_fk` (`siteId`),
  KEY `ut_changedfields_fieldId_fk` (`fieldId`),
  KEY `ut_changedfields_userId_fk` (`userId`),
  CONSTRAINT `ut_changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ut_changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `ut_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ut_changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ut_changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_content`
--

DROP TABLE IF EXISTS `ut_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `ut_content_siteId_idx` (`siteId`),
  KEY `ut_content_title_idx` (`title`),
  CONSTRAINT `ut_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_craftidtokens`
--

DROP TABLE IF EXISTS `ut_craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `ut_craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_deprecationerrors`
--

DROP TABLE IF EXISTS `ut_deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_drafts`
--

DROP TABLE IF EXISTS `ut_drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ut_drafts_creatorId_fk` (`creatorId`),
  KEY `ut_drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `ut_drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `ut_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ut_drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_elementindexsettings`
--

DROP TABLE IF EXISTS `ut_elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_elements`
--

DROP TABLE IF EXISTS `ut_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_elements_dateDeleted_idx` (`dateDeleted`),
  KEY `ut_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `ut_elements_type_idx` (`type`),
  KEY `ut_elements_enabled_idx` (`enabled`),
  KEY `ut_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `ut_elements_archived_dateDeleted_draftId_revisionId_idx` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  KEY `ut_elements_draftId_fk` (`draftId`),
  KEY `ut_elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `ut_elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `ut_drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ut_elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `ut_revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_elements_sites`
--

DROP TABLE IF EXISTS `ut_elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `ut_elements_sites_siteId_idx` (`siteId`),
  KEY `ut_elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `ut_elements_sites_enabled_idx` (`enabled`),
  KEY `ut_elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `ut_elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_entries`
--

DROP TABLE IF EXISTS `ut_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_entries` (
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
  KEY `ut_entries_postDate_idx` (`postDate`),
  KEY `ut_entries_expiryDate_idx` (`expiryDate`),
  KEY `ut_entries_authorId_idx` (`authorId`),
  KEY `ut_entries_sectionId_idx` (`sectionId`),
  KEY `ut_entries_typeId_idx` (`typeId`),
  KEY `ut_entries_parentId_fk` (`parentId`),
  CONSTRAINT `ut_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `ut_entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ut_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `ut_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `ut_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_entrytypes`
--

DROP TABLE IF EXISTS `ut_entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `ut_entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `ut_entrytypes_sectionId_idx` (`sectionId`),
  KEY `ut_entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `ut_entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `ut_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ut_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `ut_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_fieldgroups`
--

DROP TABLE IF EXISTS `ut_fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_fieldlayoutfields`
--

DROP TABLE IF EXISTS `ut_fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `ut_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `ut_fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `ut_fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `ut_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `ut_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `ut_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_fieldlayouts`
--

DROP TABLE IF EXISTS `ut_fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `ut_fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_fieldlayouttabs`
--

DROP TABLE IF EXISTS `ut_fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `ut_fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `ut_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_fields`
--

DROP TABLE IF EXISTS `ut_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `ut_fields_groupId_idx` (`groupId`),
  KEY `ut_fields_context_idx` (`context`),
  CONSTRAINT `ut_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_globalsets`
--

DROP TABLE IF EXISTS `ut_globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_globalsets_name_idx` (`name`),
  KEY `ut_globalsets_handle_idx` (`handle`),
  KEY `ut_globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `ut_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ut_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_gqlschemas`
--

DROP TABLE IF EXISTS `ut_gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_gqltokens`
--

DROP TABLE IF EXISTS `ut_gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_gqltokens_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `ut_gqltokens_name_unq_idx` (`name`),
  KEY `ut_gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `ut_gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `ut_gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_info`
--

DROP TABLE IF EXISTS `ut_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_matrixblocks`
--

DROP TABLE IF EXISTS `ut_matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_matrixblocks` (
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
  KEY `ut_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `ut_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `ut_matrixblocks_typeId_idx` (`typeId`),
  KEY `ut_matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `ut_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `ut_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `ut_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_matrixblocktypes`
--

DROP TABLE IF EXISTS `ut_matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_matrixblocktypes` (
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
  UNIQUE KEY `ut_matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `ut_matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `ut_matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `ut_matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `ut_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `ut_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_matrixcontent_pageblocks`
--

DROP TABLE IF EXISTS `ut_matrixcontent_pageblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_matrixcontent_pageblocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_textBlock_textBlockContent` text,
  `field_textBlock_textBlockHeadline` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_matrixcontent_pageblocks_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `ut_matrixcontent_pageblocks_siteId_fk` (`siteId`),
  CONSTRAINT `ut_matrixcontent_pageblocks_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_matrixcontent_pageblocks_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_migrations`
--

DROP TABLE IF EXISTS `ut_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_migrations_pluginId_idx` (`pluginId`),
  KEY `ut_migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `ut_migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `ut_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_plugins`
--

DROP TABLE IF EXISTS `ut_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_plugins` (
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
  UNIQUE KEY `ut_plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_projectconfig`
--

DROP TABLE IF EXISTS `ut_projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_queue`
--

DROP TABLE IF EXISTS `ut_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `ut_queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `ut_queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_relations`
--

DROP TABLE IF EXISTS `ut_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_relations` (
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
  UNIQUE KEY `ut_relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `ut_relations_sourceId_idx` (`sourceId`),
  KEY `ut_relations_targetId_idx` (`targetId`),
  KEY `ut_relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `ut_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `ut_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ut_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_resourcepaths`
--

DROP TABLE IF EXISTS `ut_resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_revisions`
--

DROP TABLE IF EXISTS `ut_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `ut_revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `ut_revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `ut_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ut_revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_searchindex`
--

DROP TABLE IF EXISTS `ut_searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `ut_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_sections`
--

DROP TABLE IF EXISTS `ut_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_sections_handle_idx` (`handle`),
  KEY `ut_sections_name_idx` (`name`),
  KEY `ut_sections_structureId_idx` (`structureId`),
  KEY `ut_sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `ut_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `ut_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_sections_sites`
--

DROP TABLE IF EXISTS `ut_sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `ut_sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `ut_sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `ut_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_sequences`
--

DROP TABLE IF EXISTS `ut_sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_sessions`
--

DROP TABLE IF EXISTS `ut_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_sessions_uid_idx` (`uid`),
  KEY `ut_sessions_token_idx` (`token`),
  KEY `ut_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `ut_sessions_userId_idx` (`userId`),
  CONSTRAINT `ut_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_shunnedmessages`
--

DROP TABLE IF EXISTS `ut_shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `ut_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_sitegroups`
--

DROP TABLE IF EXISTS `ut_sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_sites`
--

DROP TABLE IF EXISTS `ut_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_sites_dateDeleted_idx` (`dateDeleted`),
  KEY `ut_sites_handle_idx` (`handle`),
  KEY `ut_sites_sortOrder_idx` (`sortOrder`),
  KEY `ut_sites_groupId_fk` (`groupId`),
  CONSTRAINT `ut_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_structureelements`
--

DROP TABLE IF EXISTS `ut_structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_structureelements` (
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
  UNIQUE KEY `ut_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `ut_structureelements_root_idx` (`root`),
  KEY `ut_structureelements_lft_idx` (`lft`),
  KEY `ut_structureelements_rgt_idx` (`rgt`),
  KEY `ut_structureelements_level_idx` (`level`),
  KEY `ut_structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `ut_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `ut_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_structures`
--

DROP TABLE IF EXISTS `ut_structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_systemmessages`
--

DROP TABLE IF EXISTS `ut_systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `ut_systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_taggroups`
--

DROP TABLE IF EXISTS `ut_taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_taggroups_name_idx` (`name`),
  KEY `ut_taggroups_handle_idx` (`handle`),
  KEY `ut_taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `ut_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `ut_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_tags`
--

DROP TABLE IF EXISTS `ut_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_tags_groupId_idx` (`groupId`),
  CONSTRAINT `ut_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_templatecacheelements`
--

DROP TABLE IF EXISTS `ut_templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `ut_templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `ut_templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `ut_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `ut_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_templatecachequeries`
--

DROP TABLE IF EXISTS `ut_templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ut_templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `ut_templatecachequeries_type_idx` (`type`),
  CONSTRAINT `ut_templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `ut_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_templatecaches`
--

DROP TABLE IF EXISTS `ut_templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ut_templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `ut_templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `ut_templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `ut_templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `ut_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_tokens`
--

DROP TABLE IF EXISTS `ut_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_tokens_token_unq_idx` (`token`),
  KEY `ut_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_usergroups`
--

DROP TABLE IF EXISTS `ut_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `ut_usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_usergroups_users`
--

DROP TABLE IF EXISTS `ut_usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `ut_usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `ut_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_userpermissions`
--

DROP TABLE IF EXISTS `ut_userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_userpermissions_usergroups`
--

DROP TABLE IF EXISTS `ut_userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `ut_userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `ut_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `ut_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `ut_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_userpermissions_users`
--

DROP TABLE IF EXISTS `ut_userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `ut_userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `ut_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `ut_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_userpreferences`
--

DROP TABLE IF EXISTS `ut_userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `ut_userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_users`
--

DROP TABLE IF EXISTS `ut_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_users_uid_idx` (`uid`),
  KEY `ut_users_verificationCode_idx` (`verificationCode`),
  KEY `ut_users_email_idx` (`email`),
  KEY `ut_users_username_idx` (`username`),
  KEY `ut_users_photoId_fk` (`photoId`),
  CONSTRAINT `ut_users_id_fk` FOREIGN KEY (`id`) REFERENCES `ut_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `ut_assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_volumefolders`
--

DROP TABLE IF EXISTS `ut_volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ut_volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `ut_volumefolders_parentId_idx` (`parentId`),
  KEY `ut_volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `ut_volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `ut_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ut_volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `ut_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_volumes`
--

DROP TABLE IF EXISTS `ut_volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_volumes_name_idx` (`name`),
  KEY `ut_volumes_handle_idx` (`handle`),
  KEY `ut_volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `ut_volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `ut_volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `ut_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ut_widgets`
--

DROP TABLE IF EXISTS `ut_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ut_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ut_widgets_userId_idx` (`userId`),
  CONSTRAINT `ut_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `ut_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'craft'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-25 15:13:24
-- MySQL dump 10.16  Distrib 10.1.41-MariaDB, for Linux (x86_64)
--
-- Host: mariadb    Database: craft
-- ------------------------------------------------------
-- Server version	10.1.45-MariaDB-1~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `ut_assets`
--

LOCK TABLES `ut_assets` WRITE;
/*!40000 ALTER TABLE `ut_assets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_assettransforms`
--

LOCK TABLES `ut_assettransforms` WRITE;
/*!40000 ALTER TABLE `ut_assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_categories`
--

LOCK TABLES `ut_categories` WRITE;
/*!40000 ALTER TABLE `ut_categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_categorygroups`
--

LOCK TABLES `ut_categorygroups` WRITE;
/*!40000 ALTER TABLE `ut_categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_categorygroups_sites`
--

LOCK TABLES `ut_categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `ut_categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_changedattributes`
--

LOCK TABLES `ut_changedattributes` WRITE;
/*!40000 ALTER TABLE `ut_changedattributes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_changedfields`
--

LOCK TABLES `ut_changedfields` WRITE;
/*!40000 ALTER TABLE `ut_changedfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_changedfields` VALUES (9,1,1,'2020-05-25 14:55:36',0,1);
/*!40000 ALTER TABLE `ut_changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_content`
--

LOCK TABLES `ut_content` WRITE;
/*!40000 ALTER TABLE `ut_content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_content` VALUES (1,1,1,NULL,'2020-05-25 14:28:45','2020-05-25 14:28:45','6b7faa71-85fa-491c-8bab-a663124635f3'),(3,9,1,'Test Page','2020-05-25 14:53:45','2020-05-25 14:55:26','5d253875-000f-4d14-8ed0-5de2a959e1e1'),(4,11,1,'Test Page','2020-05-25 14:53:48','2020-05-25 14:53:48','0bf65c75-36b0-42f2-9bdf-e525b5e39ba5'),(5,13,1,'Test Page','2020-05-25 14:55:02','2020-05-25 14:55:02','b597114f-3511-4c2a-952a-9acd47b963be'),(6,15,1,'Test Page','2020-05-25 14:55:28','2020-05-25 14:55:28','7e2553bd-96cd-4e07-91e4-e4775aa44f42');
/*!40000 ALTER TABLE `ut_content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_craftidtokens`
--

LOCK TABLES `ut_craftidtokens` WRITE;
/*!40000 ALTER TABLE `ut_craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_deprecationerrors`
--

LOCK TABLES `ut_deprecationerrors` WRITE;
/*!40000 ALTER TABLE `ut_deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_drafts`
--

LOCK TABLES `ut_drafts` WRITE;
/*!40000 ALTER TABLE `ut_drafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_elementindexsettings`
--

LOCK TABLES `ut_elementindexsettings` WRITE;
/*!40000 ALTER TABLE `ut_elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_elements`
--

LOCK TABLES `ut_elements` WRITE;
/*!40000 ALTER TABLE `ut_elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-05-25 14:28:44','2020-05-25 14:28:44',NULL,'23297ca7-6e31-4d01-9668-0a937a2179d3'),(3,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-25 14:53:32','2020-05-25 14:53:32','2020-05-25 14:53:35','ebe7d1e3-7e1c-4e0e-a9ec-2121e20581a4'),(4,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-25 14:53:34','2020-05-25 14:53:34','2020-05-25 14:53:37','67dbdf55-86ab-41f1-a89a-e98886eed114'),(5,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-25 14:53:37','2020-05-25 14:53:37','2020-05-25 14:53:38','7b892d30-3523-4feb-a156-a2240a510e22'),(6,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-25 14:53:38','2020-05-25 14:53:38','2020-05-25 14:53:42','7ac8c97e-8b93-4ecc-be3b-525709d1a6d1'),(7,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-25 14:53:42','2020-05-25 14:53:42','2020-05-25 14:53:45','cf496a80-74ce-49d8-b019-3f1bb91e6125'),(9,NULL,NULL,2,'craft\\elements\\Entry',1,0,'2020-05-25 14:53:45','2020-05-25 14:55:26',NULL,'ab59cb8f-9ba2-4ec9-8d7d-e80031c01e9a'),(10,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-25 14:53:45','2020-05-25 14:55:26',NULL,'d2ac4c3c-e9df-4869-8d78-abb922aaefd0'),(11,NULL,1,2,'craft\\elements\\Entry',1,0,'2020-05-25 14:53:45','2020-05-25 14:53:45',NULL,'c815e32a-2262-4937-a37c-8ee10a72e469'),(12,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-25 14:53:48','2020-05-25 14:53:45',NULL,'6516428a-d4f5-46a9-8ee4-8f372806d844'),(13,NULL,2,2,'craft\\elements\\Entry',1,0,'2020-05-25 14:54:58','2020-05-25 14:54:58',NULL,'7a119cc5-bc31-4f4f-bc1d-dda059d5dd60'),(14,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-25 14:55:03','2020-05-25 14:54:58',NULL,'162105d3-33e9-4edd-b860-99c6e9466c36'),(15,NULL,3,2,'craft\\elements\\Entry',1,0,'2020-05-25 14:55:26','2020-05-25 14:55:26',NULL,'3dc42de6-c39c-4d10-be08-2f4dc7a15388'),(16,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-25 14:55:30','2020-05-25 14:55:26',NULL,'f81386f1-5773-4c9e-bbd7-a48cf98a17d8');
/*!40000 ALTER TABLE `ut_elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_elements_sites`
--

LOCK TABLES `ut_elements_sites` WRITE;
/*!40000 ALTER TABLE `ut_elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_elements_sites` VALUES (1,1,1,NULL,NULL,1,'2020-05-25 14:28:45','2020-05-25 14:28:45','4bc426e1-f749-4328-8ae7-61a2613e1673'),(3,3,1,NULL,NULL,1,'2020-05-25 14:53:32','2020-05-25 14:53:32','867463ed-f1d5-4fc5-8814-bff29cbda8ca'),(4,4,1,NULL,NULL,1,'2020-05-25 14:53:34','2020-05-25 14:53:34','14617dce-96e5-4927-8401-b2b36e60c9cf'),(5,5,1,NULL,NULL,1,'2020-05-25 14:53:37','2020-05-25 14:53:37','e9fae038-8d40-4c86-b020-913313d5aa09'),(6,6,1,NULL,NULL,1,'2020-05-25 14:53:38','2020-05-25 14:53:38','7da3dbcb-e247-4fa2-a68f-30e102683e81'),(7,7,1,NULL,NULL,1,'2020-05-25 14:53:42','2020-05-25 14:53:42','32e81423-9a7c-4a36-b40d-4ea2eab0a97b'),(9,9,1,'test-page','test-page',1,'2020-05-25 14:53:45','2020-05-25 14:53:45','206939e3-b577-4209-b9b2-dc3ce020e946'),(10,10,1,NULL,NULL,1,'2020-05-25 14:53:47','2020-05-25 14:53:47','30c069db-abfe-415d-b18c-105452069128'),(11,11,1,'test-page','test-page',1,'2020-05-25 14:53:48','2020-05-25 14:53:48','4d1665ec-d43d-4477-a52b-37d08b5288dc'),(12,12,1,NULL,NULL,1,'2020-05-25 14:53:48','2020-05-25 14:53:48','c8dd9823-e9a3-4a19-9b23-f246b1c829fa'),(13,13,1,'test-page','test-page',1,'2020-05-25 14:54:59','2020-05-25 14:54:59','54940937-e1ce-47f3-a594-0bb5fdfc853d'),(14,14,1,NULL,NULL,1,'2020-05-25 14:55:03','2020-05-25 14:55:03','ac619cdf-f73c-4557-b9aa-74722b2314fa'),(15,15,1,'test-page','test-page',1,'2020-05-25 14:55:26','2020-05-25 14:55:26','39d3d07d-4f08-422a-b267-82e0341e8bd6'),(16,16,1,NULL,NULL,1,'2020-05-25 14:55:33','2020-05-25 14:55:33','55c69ef9-fd72-4012-871e-bc3109fb17f7');
/*!40000 ALTER TABLE `ut_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_entries`
--

LOCK TABLES `ut_entries` WRITE;
/*!40000 ALTER TABLE `ut_entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_entries` VALUES (9,1,NULL,1,1,'2020-05-25 14:53:00',NULL,NULL,'2020-05-25 14:53:45','2020-05-25 14:53:45','f08d996e-99cf-452b-b6ce-9658e0ad19c4'),(11,1,NULL,1,1,'2020-05-25 14:53:00',NULL,NULL,'2020-05-25 14:53:48','2020-05-25 14:53:48','14c73713-75b4-4044-b80e-9b2c68337c2a'),(13,1,NULL,1,1,'2020-05-25 14:53:00',NULL,NULL,'2020-05-25 14:55:02','2020-05-25 14:55:02','62a26042-2ddb-40ee-8e44-004f0d2f0755'),(15,1,NULL,1,1,'2020-05-25 14:53:00',NULL,NULL,'2020-05-25 14:55:28','2020-05-25 14:55:28','64640570-3ed0-4c5a-be94-a5c09a229ff5');
/*!40000 ALTER TABLE `ut_entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_entrytypes`
--

LOCK TABLES `ut_entrytypes` WRITE;
/*!40000 ALTER TABLE `ut_entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_entrytypes` VALUES (1,1,2,'Page','page',1,'Title','',1,'2020-05-25 14:48:58','2020-05-25 14:52:51',NULL,'ae419057-2604-4122-a5ce-9c87e25aacba');
/*!40000 ALTER TABLE `ut_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_fieldgroups`
--

LOCK TABLES `ut_fieldgroups` WRITE;
/*!40000 ALTER TABLE `ut_fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_fieldgroups` VALUES (1,'Common','2020-05-25 14:28:43','2020-05-25 14:28:43','4b05c067-85a7-4666-ba3b-b2242d20b26c'),(2,'Page','2020-05-25 14:49:32','2020-05-25 14:49:32','0ecf5ec5-0b3d-414f-876e-76df9908e8a3');
/*!40000 ALTER TABLE `ut_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_fieldlayoutfields`
--

LOCK TABLES `ut_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `ut_fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_fieldlayoutfields` VALUES (3,2,2,1,0,1,'2020-05-25 14:52:51','2020-05-25 14:52:51','ca02f671-6447-4d4a-90d4-3f4286a071dc'),(4,1,3,2,0,2,'2020-05-25 14:54:19','2020-05-25 14:54:19','2800a65d-e628-4a8d-865c-604fc455937c'),(5,1,3,3,1,1,'2020-05-25 14:54:20','2020-05-25 14:54:20','7ad6bb0e-c513-4376-98d4-5623b3d7b235');
/*!40000 ALTER TABLE `ut_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_fieldlayouts`
--

LOCK TABLES `ut_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `ut_fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_fieldlayouts` VALUES (1,'craft\\elements\\MatrixBlock','2020-05-25 14:52:11','2020-05-25 14:52:11',NULL,'55e1b59c-9293-4ddc-bdb4-a86b53b5ba48'),(2,'craft\\elements\\Entry','2020-05-25 14:52:50','2020-05-25 14:52:50',NULL,'5fc56c9d-3756-4100-b8b5-d33a62d73ca9');
/*!40000 ALTER TABLE `ut_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_fieldlayouttabs`
--

LOCK TABLES `ut_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `ut_fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_fieldlayouttabs` VALUES (2,2,'Tab 1',1,'2020-05-25 14:52:50','2020-05-25 14:52:50','972184f6-49ff-46a7-ae73-42e1702e79cc'),(3,1,'Content',1,'2020-05-25 14:54:18','2020-05-25 14:54:18','bb56dd1b-f418-4431-b39e-a1a933070323');
/*!40000 ALTER TABLE `ut_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_fields`
--

LOCK TABLES `ut_fields` WRITE;
/*!40000 ALTER TABLE `ut_fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_fields` VALUES (1,2,'Page Blocks','pageBlocks','global','',0,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_pageblocks}}\",\"maxBlocks\":\"\",\"minBlocks\":\"\",\"propagationMethod\":\"all\"}','2020-05-25 14:50:46','2020-05-25 14:50:46','0a4ec643-1d46-4238-b9ae-d88ca0f8820a'),(2,NULL,'Content','textBlockContent','matrixBlockType:41a6fa1a-18b6-4218-8701-062112fa18b0','',0,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":\"1\",\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\"}','2020-05-25 14:51:48','2020-05-25 14:54:16','3496828f-c91b-4780-b666-c01af4f626ee'),(3,NULL,'Headline','textBlockHeadline','matrixBlockType:41a6fa1a-18b6-4218-8701-062112fa18b0','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-05-25 14:52:09','2020-05-25 14:52:09','dd4c93bc-056e-4663-9f14-69980caa0416');
/*!40000 ALTER TABLE `ut_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_globalsets`
--

LOCK TABLES `ut_globalsets` WRITE;
/*!40000 ALTER TABLE `ut_globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_gqlschemas`
--

LOCK TABLES `ut_gqlschemas` WRITE;
/*!40000 ALTER TABLE `ut_gqlschemas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_gqlschemas` VALUES (1,'Public Schema','[\"sections.48457350-2ca6-4e7e-865a-9c0604db508e:read\",\"entrytypes.ae419057-2604-4122-a5ce-9c87e25aacba:read\"]',1,'2020-05-25 14:48:31','2020-05-25 15:01:02','961cca94-d8b0-4607-8cd8-3b77f81b21cc');
/*!40000 ALTER TABLE `ut_gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_gqltokens`
--

LOCK TABLES `ut_gqltokens` WRITE;
/*!40000 ALTER TABLE `ut_gqltokens` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_gqltokens` VALUES (1,'Public Token','__PUBLIC__',1,NULL,'2020-05-25 15:12:31',1,'2020-05-25 14:48:32','2020-05-25 15:12:31','9ce8613d-0ce2-4953-a632-90d6b996a2ae');
/*!40000 ALTER TABLE `ut_gqltokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_info`
--

LOCK TABLES `ut_info` WRITE;
/*!40000 ALTER TABLE `ut_info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_info` VALUES (1,'3.4.15','3.4.10',0,'[]','VMJwKx9nMJmm','2020-05-25 14:28:42','2020-05-25 14:54:17','afbdee48-af3c-47ad-a547-3b6c3894eaec');
/*!40000 ALTER TABLE `ut_info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_matrixblocks`
--

LOCK TABLES `ut_matrixblocks` WRITE;
/*!40000 ALTER TABLE `ut_matrixblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_matrixblocks` VALUES (10,9,1,1,1,NULL,'2020-05-25 14:53:47','2020-05-25 14:53:47','77fbb895-b302-425b-b041-9ee77750a8dd'),(12,11,1,1,1,NULL,'2020-05-25 14:53:48','2020-05-25 14:53:48','6ee40cd6-3d41-40de-86e5-f564ee7f3231'),(14,13,1,1,1,NULL,'2020-05-25 14:55:03','2020-05-25 14:55:03','cee70dfe-ee4f-46ad-86fa-8f59612250ab'),(16,15,1,1,1,NULL,'2020-05-25 14:55:33','2020-05-25 14:55:33','3986cfd9-11e1-497f-9a97-a8ffd106b7ac');
/*!40000 ALTER TABLE `ut_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_matrixblocktypes`
--

LOCK TABLES `ut_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `ut_matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_matrixblocktypes` VALUES (1,1,1,'Text Block','textBlock',1,'2020-05-25 14:52:16','2020-05-25 14:52:16','41a6fa1a-18b6-4218-8701-062112fa18b0');
/*!40000 ALTER TABLE `ut_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_matrixcontent_pageblocks`
--

LOCK TABLES `ut_matrixcontent_pageblocks` WRITE;
/*!40000 ALTER TABLE `ut_matrixcontent_pageblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_matrixcontent_pageblocks` VALUES (1,3,1,'2020-05-25 14:53:33','2020-05-25 14:53:33','fe7fc35d-0c30-4864-8b03-f422757d1aa8',NULL,NULL),(2,4,1,'2020-05-25 14:53:34','2020-05-25 14:53:34','58a08294-a0bb-4b24-8639-685f328025f0',NULL,'Lore'),(3,5,1,'2020-05-25 14:53:37','2020-05-25 14:53:37','092128dd-b524-4f5b-be97-2f82803362ac',NULL,'Lorem Amet D'),(4,6,1,'2020-05-25 14:53:38','2020-05-25 14:53:38','7ecfd23a-59c8-4b81-863c-ed3864ba861f','Lorem','Lorem Amet Dolor Est'),(5,7,1,'2020-05-25 14:53:42','2020-05-25 14:53:42','7f037827-c5a8-4b15-b36b-8c91fef278b7','Lorem sit dolor est tus.','Lorem Amet Dolor Est'),(7,10,1,'2020-05-25 14:53:47','2020-05-25 14:55:26','a278d1e6-39bc-41ca-bae6-9341ce779e58','<p>Lorem ipsum dolor sit amet, consectetur <strong>adipisicing</strong> elit, sed do eiusmod\n tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim \nveniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea \ncommodo consequat. Lorem ipsum dolor sit amet, consectetur <strong>adipisicing</strong> elit, sed do eiusmod\n tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim \nveniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea \ncommodo consequat. Ut enim ad minim \nveniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea \ncommodo consequat.</p>','Lorem Amet Dolor Est'),(8,12,1,'2020-05-25 14:53:48','2020-05-25 14:53:48','f329b899-c10b-4126-8245-3c0f7a9cb73f','Lorem sit dolor est tus.','Lorem Amet Dolor Est'),(9,14,1,'2020-05-25 14:55:03','2020-05-25 14:55:03','061505e4-f515-4342-ad89-a9b306b8e8ed','<p>Lorem ipsum dolor sit amet, consectetur <strong>adipisicing</strong> elit, sed do eiusmod\n tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim \nveniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea \ncommodo consequat.</p>','Lorem Amet Dolor Est'),(10,16,1,'2020-05-25 14:55:33','2020-05-25 14:55:33','f4db7272-dac3-4ff6-91fb-a6e4f4a0115c','<p>Lorem ipsum dolor sit amet, consectetur <strong>adipisicing</strong> elit, sed do eiusmod\n tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim \nveniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea \ncommodo consequat. Lorem ipsum dolor sit amet, consectetur <strong>adipisicing</strong> elit, sed do eiusmod\n tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim \nveniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea \ncommodo consequat. Ut enim ad minim \nveniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea \ncommodo consequat.</p>','Lorem Amet Dolor Est');
/*!40000 ALTER TABLE `ut_matrixcontent_pageblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_migrations`
--

LOCK TABLES `ut_migrations` WRITE;
/*!40000 ALTER TABLE `ut_migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_migrations` VALUES (1,NULL,'app','Install','2020-05-25 14:28:47','2020-05-25 14:28:47','2020-05-25 14:28:47','c44881ff-7b97-480b-9e11-dc74f3518f36'),(2,NULL,'app','m150403_183908_migrations_table_changes','2020-05-25 14:28:47','2020-05-25 14:28:47','2020-05-25 14:28:47','8db7ad57-c163-4668-89bd-98bdcb7bf06e'),(3,NULL,'app','m150403_184247_plugins_table_changes','2020-05-25 14:28:48','2020-05-25 14:28:48','2020-05-25 14:28:48','986d143c-3208-4701-9b5d-68c7b2b33e1e'),(4,NULL,'app','m150403_184533_field_version','2020-05-25 14:28:49','2020-05-25 14:28:49','2020-05-25 14:28:49','196fb771-7be4-4d52-a177-c13159620694'),(5,NULL,'app','m150403_184729_type_columns','2020-05-25 14:28:50','2020-05-25 14:28:50','2020-05-25 14:28:50','223a086f-c835-47ba-8ef1-e350892e5d26'),(6,NULL,'app','m150403_185142_volumes','2020-05-25 14:28:50','2020-05-25 14:28:50','2020-05-25 14:28:50','18c6a730-e531-4768-b02f-9d0e7b132309'),(7,NULL,'app','m150428_231346_userpreferences','2020-05-25 14:28:50','2020-05-25 14:28:50','2020-05-25 14:28:50','0bcad3b4-6b96-45ff-8289-0765af0730ef'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2020-05-25 14:28:51','2020-05-25 14:28:51','2020-05-25 14:28:51','2902ba29-6a8f-4a01-91ba-1e7160937160'),(9,NULL,'app','m150617_213829_update_email_settings','2020-05-25 14:28:51','2020-05-25 14:28:51','2020-05-25 14:28:51','cd9b9277-f52b-4911-92eb-58a369b7445f'),(10,NULL,'app','m150721_124739_templatecachequeries','2020-05-25 14:28:52','2020-05-25 14:28:52','2020-05-25 14:28:52','6502a44d-90f7-4d6f-adb5-574a36f86c87'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2020-05-25 14:28:52','2020-05-25 14:28:52','2020-05-25 14:28:52','c811384f-6fa3-4000-af2a-ea76be27371e'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2020-05-25 14:28:53','2020-05-25 14:28:53','2020-05-25 14:28:53','33acabfa-b9ec-4edf-b832-6834e864ea2b'),(13,NULL,'app','m151002_095935_volume_cache_settings','2020-05-25 14:28:53','2020-05-25 14:28:53','2020-05-25 14:28:53','b8be6364-c9f5-4a13-8eb7-51994af7ccec'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2020-05-25 14:28:54','2020-05-25 14:28:54','2020-05-25 14:28:54','d9efefd5-9f83-495c-8240-21d4a680dd5f'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2020-05-25 14:28:54','2020-05-25 14:28:54','2020-05-25 14:28:54','06161441-1431-489e-9297-129007ac1062'),(16,NULL,'app','m151209_000000_move_logo','2020-05-25 14:28:55','2020-05-25 14:28:55','2020-05-25 14:28:55','301c17a4-f518-4146-92f8-44d1138928d9'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2020-05-25 14:28:55','2020-05-25 14:28:55','2020-05-25 14:28:55','d5552dbb-1402-4a93-8b3b-7e4b29024121'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2020-05-25 14:28:55','2020-05-25 14:28:55','2020-05-25 14:28:55','6807ca3a-6208-4dd6-8b00-23c56a6d97f1'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2020-05-25 14:28:56','2020-05-25 14:28:56','2020-05-25 14:28:56','17f6285a-485b-4c2b-bce8-88bec98b3fc6'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2020-05-25 14:28:56','2020-05-25 14:28:56','2020-05-25 14:28:56','b14adb3c-4e5a-4e20-9108-35742e48dec3'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2020-05-25 14:28:57','2020-05-25 14:28:57','2020-05-25 14:28:57','d451231d-eba1-4f7b-9f8d-17e1699849dc'),(22,NULL,'app','m160727_194637_column_cleanup','2020-05-25 14:28:57','2020-05-25 14:28:57','2020-05-25 14:28:57','2b1d4eb7-70fd-45fc-a077-78f124433ada'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2020-05-25 14:28:58','2020-05-25 14:28:58','2020-05-25 14:28:58','f851c6e2-bbb8-43a5-994c-af6f0b9f9b71'),(24,NULL,'app','m160807_144858_sites','2020-05-25 14:28:58','2020-05-25 14:28:58','2020-05-25 14:28:58','adb8cd3b-5e96-4bf1-901c-96186449f93d'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2020-05-25 14:28:59','2020-05-25 14:28:59','2020-05-25 14:28:59','7ed51e60-f5a1-462d-9232-97057e4b3798'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2020-05-25 14:28:59','2020-05-25 14:28:59','2020-05-25 14:28:59','a8417fbd-e12d-4764-9eff-3fd143d5d57d'),(27,NULL,'app','m160912_230520_require_entry_type_id','2020-05-25 14:29:00','2020-05-25 14:29:00','2020-05-25 14:29:00','a28bb13c-a3ad-4e24-aa6d-11a173795a73'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2020-05-25 14:29:02','2020-05-25 14:29:02','2020-05-25 14:29:02','d38e78d5-afa0-4906-b4ea-835210d76be1'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2020-05-25 14:29:02','2020-05-25 14:29:02','2020-05-25 14:29:02','37610b36-01e0-4c9a-9dca-b7231002cfa9'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2020-05-25 14:29:03','2020-05-25 14:29:03','2020-05-25 14:29:03','20a509fa-59e1-4946-a34a-3b94a46174ac'),(31,NULL,'app','m160925_113941_route_uri_parts','2020-05-25 14:29:03','2020-05-25 14:29:03','2020-05-25 14:29:03','e4357591-0531-49b0-ab9d-125642fbe691'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2020-05-25 14:29:04','2020-05-25 14:29:04','2020-05-25 14:29:04','eb55d1d1-aec2-4ad0-966c-6ae52d5f47a6'),(33,NULL,'app','m161007_130653_update_email_settings','2020-05-25 14:29:05','2020-05-25 14:29:05','2020-05-25 14:29:05','c34b6a06-f1d0-43e5-bff2-bffd9e1190b3'),(34,NULL,'app','m161013_175052_newParentId','2020-05-25 14:29:05','2020-05-25 14:29:05','2020-05-25 14:29:05','afef1c42-7b42-4d3c-bdfe-2ff744e9a458'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2020-05-25 14:29:06','2020-05-25 14:29:06','2020-05-25 14:29:06','3f62bb04-1b05-46ce-94ef-3560e2dbea49'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2020-05-25 14:29:06','2020-05-25 14:29:06','2020-05-25 14:29:06','3e79cdd1-f5fe-43bb-a10c-edcec61392b3'),(37,NULL,'app','m161025_000000_fix_char_columns','2020-05-25 14:29:07','2020-05-25 14:29:07','2020-05-25 14:29:07','80e4a28d-654a-4f10-a7bd-55866c35a0a1'),(38,NULL,'app','m161029_124145_email_message_languages','2020-05-25 14:29:07','2020-05-25 14:29:07','2020-05-25 14:29:07','5d7eb313-d501-43ca-ae5e-f25779f26c76'),(39,NULL,'app','m161108_000000_new_version_format','2020-05-25 14:29:08','2020-05-25 14:29:08','2020-05-25 14:29:08','ee84135c-6e06-489d-a3b2-f67dcbc2a455'),(40,NULL,'app','m161109_000000_index_shuffle','2020-05-25 14:29:08','2020-05-25 14:29:08','2020-05-25 14:29:08','baab03ff-9f37-4b24-9515-76cde0317263'),(41,NULL,'app','m161122_185500_no_craft_app','2020-05-25 14:29:09','2020-05-25 14:29:09','2020-05-25 14:29:09','b98458bb-442a-4da8-b5ad-1463e2667451'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2020-05-25 14:29:10','2020-05-25 14:29:10','2020-05-25 14:29:10','5097411a-6cd4-4a1a-a0a9-509f178c1c55'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2020-05-25 14:29:10','2020-05-25 14:29:10','2020-05-25 14:29:10','d663bb62-a0a1-4e21-9b5c-4ef007d4a858'),(44,NULL,'app','m170114_161144_udates_permission','2020-05-25 14:29:11','2020-05-25 14:29:11','2020-05-25 14:29:11','22647ccb-2284-4c10-8c65-3b89ee3b1497'),(45,NULL,'app','m170120_000000_schema_cleanup','2020-05-25 14:29:11','2020-05-25 14:29:11','2020-05-25 14:29:11','8bd4128a-3941-4cd3-9dab-8d8d5f179b06'),(46,NULL,'app','m170126_000000_assets_focal_point','2020-05-25 14:29:12','2020-05-25 14:29:12','2020-05-25 14:29:12','0c218c97-f8ae-4aef-a563-336faf51187f'),(47,NULL,'app','m170206_142126_system_name','2020-05-25 14:29:12','2020-05-25 14:29:12','2020-05-25 14:29:12','e31ded5e-f420-436e-8c88-be71b4937ef9'),(48,NULL,'app','m170217_044740_category_branch_limits','2020-05-25 14:29:13','2020-05-25 14:29:13','2020-05-25 14:29:13','256155c4-7725-4a3e-8b87-af57aaaba076'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2020-05-25 14:29:13','2020-05-25 14:29:13','2020-05-25 14:29:13','2fdfa481-c362-405f-984d-976954fcc13a'),(50,NULL,'app','m170223_224012_plain_text_settings','2020-05-25 14:29:15','2020-05-25 14:29:15','2020-05-25 14:29:15','acc375db-cf47-4488-b358-37a97b8d9166'),(51,NULL,'app','m170227_120814_focal_point_percentage','2020-05-25 14:29:16','2020-05-25 14:29:16','2020-05-25 14:29:16','6aabbb49-d5c6-4dc7-a828-e57216edad40'),(52,NULL,'app','m170228_171113_system_messages','2020-05-25 14:29:16','2020-05-25 14:29:16','2020-05-25 14:29:16','bac02971-8f8b-40f7-8684-0f367c1cb54a'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2020-05-25 14:29:17','2020-05-25 14:29:17','2020-05-25 14:29:17','004fb95e-d7da-4c2d-9146-742a2a19ba74'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2020-05-25 14:29:17','2020-05-25 14:29:17','2020-05-25 14:29:17','cb742d9e-0498-4975-ab79-e8e9eef888b1'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2020-05-25 14:29:18','2020-05-25 14:29:18','2020-05-25 14:29:18','4b901b0a-f7c1-4c03-a3d2-c09d0d2b84ef'),(56,NULL,'app','m170612_000000_route_index_shuffle','2020-05-25 14:29:18','2020-05-25 14:29:18','2020-05-25 14:29:18','08ff4412-6ebe-4e22-b330-1d0a074fc334'),(57,NULL,'app','m170621_195237_format_plugin_handles','2020-05-25 14:29:18','2020-05-25 14:29:18','2020-05-25 14:29:18','fe27f339-039f-4d1f-909f-7921cf775a69'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2020-05-25 14:29:19','2020-05-25 14:29:19','2020-05-25 14:29:19','7def3639-79c1-49d2-b06c-99bc396e753d'),(59,NULL,'app','m170630_161028_deprecation_changes','2020-05-25 14:29:19','2020-05-25 14:29:19','2020-05-25 14:29:19','132b3dc4-aac9-4203-a7bd-83442525ae3d'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2020-05-25 14:29:20','2020-05-25 14:29:20','2020-05-25 14:29:20','2020e158-7787-49cd-a9c6-fe7626acab0d'),(61,NULL,'app','m170704_134916_sites_tables','2020-05-25 14:29:20','2020-05-25 14:29:20','2020-05-25 14:29:20','a7b86067-6e9b-4054-9ca8-f66e03a6a759'),(62,NULL,'app','m170706_183216_rename_sequences','2020-05-25 14:29:21','2020-05-25 14:29:21','2020-05-25 14:29:21','e4d21f3d-dd6c-4851-934e-a70b80bbddb5'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2020-05-25 14:29:21','2020-05-25 14:29:21','2020-05-25 14:29:21','7c88f98a-a3d2-48fe-a99b-9d3508b59437'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2020-05-25 14:29:21','2020-05-25 14:29:21','2020-05-25 14:29:21','a85ebe92-11c1-409c-a809-d3dcd77bf479'),(65,NULL,'app','m170810_201318_create_queue_table','2020-05-25 14:29:22','2020-05-25 14:29:22','2020-05-25 14:29:22','15187415-93c0-4e29-87e5-5f89aff8fb29'),(66,NULL,'app','m170903_192801_longblob_for_queue_jobs','2020-05-25 14:29:22','2020-05-25 14:29:22','2020-05-25 14:29:22','28fa4ab2-a20b-4f50-b346-f8325d268c6f'),(67,NULL,'app','m170914_204621_asset_cache_shuffle','2020-05-25 14:29:23','2020-05-25 14:29:23','2020-05-25 14:29:23','22913672-f983-4e74-8cf5-59b6a772edfd'),(68,NULL,'app','m171011_214115_site_groups','2020-05-25 14:29:23','2020-05-25 14:29:23','2020-05-25 14:29:23','a52ecbf1-2442-405a-930d-bf0a3509f68c'),(69,NULL,'app','m171012_151440_primary_site','2020-05-25 14:29:24','2020-05-25 14:29:24','2020-05-25 14:29:24','73f4d1a5-860d-4ce5-b91b-7d01e06c3688'),(70,NULL,'app','m171013_142500_transform_interlace','2020-05-25 14:29:24','2020-05-25 14:29:24','2020-05-25 14:29:24','52a0f73e-980e-4610-9a7d-9e832572f024'),(71,NULL,'app','m171016_092553_drop_position_select','2020-05-25 14:29:24','2020-05-25 14:29:24','2020-05-25 14:29:24','3af05f9f-e8f8-4f13-b9a9-9485cb318056'),(72,NULL,'app','m171016_221244_less_strict_translation_method','2020-05-25 14:29:25','2020-05-25 14:29:25','2020-05-25 14:29:25','7b0c5026-c4f4-4419-a117-d5618586a857'),(73,NULL,'app','m171107_000000_assign_group_permissions','2020-05-25 14:29:25','2020-05-25 14:29:25','2020-05-25 14:29:25','4fc67530-ca4c-43d5-bbef-3c643781f690'),(74,NULL,'app','m171117_000001_templatecache_index_tune','2020-05-25 14:29:26','2020-05-25 14:29:26','2020-05-25 14:29:26','7459f666-b36d-4984-9cc3-b5dbffb49b38'),(75,NULL,'app','m171126_105927_disabled_plugins','2020-05-25 14:29:26','2020-05-25 14:29:26','2020-05-25 14:29:26','ee5bc10f-3eb5-41ea-a495-01b9efcbbe41'),(76,NULL,'app','m171130_214407_craftidtokens_table','2020-05-25 14:29:27','2020-05-25 14:29:27','2020-05-25 14:29:27','4503473c-7cdd-42c5-9ba9-3f41166e0def'),(77,NULL,'app','m171202_004225_update_email_settings','2020-05-25 14:29:27','2020-05-25 14:29:27','2020-05-25 14:29:27','8cee7cae-a1ce-4d31-8061-0ffc9deaa215'),(78,NULL,'app','m171204_000001_templatecache_index_tune_deux','2020-05-25 14:29:28','2020-05-25 14:29:28','2020-05-25 14:29:28','3eff5705-a9d2-4246-80ad-58845e91b0fc'),(79,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-05-25 14:29:29','2020-05-25 14:29:29','2020-05-25 14:29:29','a1077cd2-708e-4117-9aad-3b7f220f0e5d'),(80,NULL,'app','m171218_143135_longtext_query_column','2020-05-25 14:29:30','2020-05-25 14:29:30','2020-05-25 14:29:30','70db099b-7f71-4535-bc7b-47225f7fc4a8'),(81,NULL,'app','m171231_055546_environment_variables_to_aliases','2020-05-25 14:29:31','2020-05-25 14:29:31','2020-05-25 14:29:31','34a95afa-1f07-4600-a563-d168dc8bd1d1'),(82,NULL,'app','m180113_153740_drop_users_archived_column','2020-05-25 14:29:33','2020-05-25 14:29:33','2020-05-25 14:29:33','83a7e5b3-8aca-4d41-aa03-970849d69632'),(83,NULL,'app','m180122_213433_propagate_entries_setting','2020-05-25 14:29:34','2020-05-25 14:29:34','2020-05-25 14:29:34','7e085592-6da8-41f0-804c-828c60287c6a'),(84,NULL,'app','m180124_230459_fix_propagate_entries_values','2020-05-25 14:29:35','2020-05-25 14:29:35','2020-05-25 14:29:35','fffa17aa-bebd-4fec-bbb4-99cd47bc9ac5'),(85,NULL,'app','m180128_235202_set_tag_slugs','2020-05-25 14:29:36','2020-05-25 14:29:36','2020-05-25 14:29:36','bceb7d40-d744-4db4-aafa-272972d32ed1'),(86,NULL,'app','m180202_185551_fix_focal_points','2020-05-25 14:29:37','2020-05-25 14:29:37','2020-05-25 14:29:37','db382b5d-080c-4a15-8276-2c6405897e3b'),(87,NULL,'app','m180217_172123_tiny_ints','2020-05-25 14:29:38','2020-05-25 14:29:38','2020-05-25 14:29:38','da5b5b7f-c2e2-4e60-83eb-e2ae8d6fbd56'),(88,NULL,'app','m180321_233505_small_ints','2020-05-25 14:29:39','2020-05-25 14:29:39','2020-05-25 14:29:39','a8395744-2fb7-458b-91f3-f4bbb163edfa'),(89,NULL,'app','m180328_115523_new_license_key_statuses','2020-05-25 14:29:41','2020-05-25 14:29:41','2020-05-25 14:29:41','8468a334-e308-4398-a392-e199f59a3b4c'),(90,NULL,'app','m180404_182320_edition_changes','2020-05-25 14:29:42','2020-05-25 14:29:42','2020-05-25 14:29:42','dcea3dca-4d26-4dd4-a685-76120d72cd3d'),(91,NULL,'app','m180411_102218_fix_db_routes','2020-05-25 14:29:44','2020-05-25 14:29:44','2020-05-25 14:29:44','36f925a2-5053-43dc-a62b-4d56f51fa543'),(92,NULL,'app','m180416_205628_resourcepaths_table','2020-05-25 14:29:44','2020-05-25 14:29:44','2020-05-25 14:29:44','4a8fabfb-0825-4227-b810-e7f577ab2055'),(93,NULL,'app','m180418_205713_widget_cleanup','2020-05-25 14:29:45','2020-05-25 14:29:45','2020-05-25 14:29:45','c6416088-3e3d-4494-8a26-ed7e98b18267'),(94,NULL,'app','m180425_203349_searchable_fields','2020-05-25 14:29:46','2020-05-25 14:29:46','2020-05-25 14:29:46','82ee51fc-dd2c-45f1-958e-72d7f6924e74'),(95,NULL,'app','m180516_153000_uids_in_field_settings','2020-05-25 14:29:47','2020-05-25 14:29:47','2020-05-25 14:29:47','f205c857-59d4-412a-a6a0-8441c6990a5e'),(96,NULL,'app','m180517_173000_user_photo_volume_to_uid','2020-05-25 14:29:47','2020-05-25 14:29:47','2020-05-25 14:29:47','678a7079-9b68-420e-bf9d-841705126350'),(97,NULL,'app','m180518_173000_permissions_to_uid','2020-05-25 14:29:48','2020-05-25 14:29:48','2020-05-25 14:29:48','e6f1a264-2dc4-4cbd-a249-01b518157c89'),(98,NULL,'app','m180520_173000_matrix_context_to_uids','2020-05-25 14:29:48','2020-05-25 14:29:48','2020-05-25 14:29:48','dfe9a814-4cbb-4860-9c3f-10a2ab611027'),(99,NULL,'app','m180521_172900_project_config_table','2020-05-25 14:29:49','2020-05-25 14:29:49','2020-05-25 14:29:49','7aff6326-60ea-40ad-b4a8-52deaad2a6b2'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2020-05-25 14:29:52','2020-05-25 14:29:52','2020-05-25 14:29:52','a01f9a6b-af79-4eac-83ea-4a4e969711ac'),(101,NULL,'app','m180731_162030_soft_delete_sites','2020-05-25 14:29:53','2020-05-25 14:29:53','2020-05-25 14:29:53','16f50877-801d-4305-8aab-47c82f6e9032'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2020-05-25 14:29:54','2020-05-25 14:29:54','2020-05-25 14:29:54','b727e0aa-49ce-4e34-be11-66f3fafc39eb'),(103,NULL,'app','m180810_214439_soft_delete_elements','2020-05-25 14:29:55','2020-05-25 14:29:55','2020-05-25 14:29:55','23cfce6a-3be0-43c6-895f-3fd7cace275b'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2020-05-25 14:29:55','2020-05-25 14:29:55','2020-05-25 14:29:55','9cfab806-d706-4a3c-80d3-b6b114f76295'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2020-05-25 14:29:56','2020-05-25 14:29:56','2020-05-25 14:29:56','f72cf0e7-7591-4e0f-be5f-cf4859b9a2c3'),(106,NULL,'app','m180904_112109_permission_changes','2020-05-25 14:29:57','2020-05-25 14:29:57','2020-05-25 14:29:57','fb290cbd-6c9c-4721-8558-f5612dd81d2d'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2020-05-25 14:29:58','2020-05-25 14:29:58','2020-05-25 14:29:58','ffb8618d-5dba-4806-8707-6dfb7d337e81'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2020-05-25 14:29:58','2020-05-25 14:29:58','2020-05-25 14:29:58','42d590eb-0dad-4491-a5da-6936e0240866'),(109,NULL,'app','m181016_183648_set_default_user_settings','2020-05-25 14:29:59','2020-05-25 14:29:59','2020-05-25 14:29:59','bb6edfcc-316b-45ca-8285-ef54e7019098'),(110,NULL,'app','m181017_225222_system_config_settings','2020-05-25 14:29:59','2020-05-25 14:29:59','2020-05-25 14:29:59','6631deb2-988e-4a57-8491-66bef1a75ed3'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2020-05-25 14:30:00','2020-05-25 14:30:00','2020-05-25 14:30:00','6312a8a8-6e87-484c-b7f3-657a682317b1'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2020-05-25 14:30:01','2020-05-25 14:30:01','2020-05-25 14:30:01','f46fb462-e4ee-42dc-8e6a-bd7c10f4136c'),(113,NULL,'app','m181112_203955_sequences_table','2020-05-25 14:30:03','2020-05-25 14:30:03','2020-05-25 14:30:03','6143bda5-753c-42f5-921a-801252ff53ad'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2020-05-25 14:30:03','2020-05-25 14:30:03','2020-05-25 14:30:03','035c08da-676c-4510-8f8d-a73a53f24c4b'),(115,NULL,'app','m181128_193942_fix_project_config','2020-05-25 14:30:04','2020-05-25 14:30:04','2020-05-25 14:30:04','322289e9-adae-48a6-8256-a31ae982794c'),(116,NULL,'app','m181130_143040_fix_schema_version','2020-05-25 14:30:05','2020-05-25 14:30:05','2020-05-25 14:30:05','1690d915-dbf6-4fee-82ec-bb3d1b68b926'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2020-05-25 14:30:06','2020-05-25 14:30:06','2020-05-25 14:30:06','24872a59-2f6c-4f23-acd1-dbf2f52b94a3'),(118,NULL,'app','m181213_102500_config_map_aliases','2020-05-25 14:30:07','2020-05-25 14:30:07','2020-05-25 14:30:07','b8aea36e-8cd2-407f-a55b-1be8aaa87733'),(119,NULL,'app','m181217_153000_fix_structure_uids','2020-05-25 14:30:08','2020-05-25 14:30:08','2020-05-25 14:30:08','1fc7c4ab-8485-486a-b950-46e28bd5d3f3'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2020-05-25 14:30:09','2020-05-25 14:30:09','2020-05-25 14:30:09','b0ae7b47-ac73-4ad3-b27b-5f4a5abb44a7'),(121,NULL,'app','m190108_110000_cleanup_project_config','2020-05-25 14:30:09','2020-05-25 14:30:09','2020-05-25 14:30:09','a8131020-80e5-494e-8ef4-ca130109733c'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2020-05-25 14:30:10','2020-05-25 14:30:10','2020-05-25 14:30:10','1eb06a53-b4a0-48d5-a6f2-e6bba8a294f5'),(123,NULL,'app','m190109_172845_fix_colspan','2020-05-25 14:30:11','2020-05-25 14:30:11','2020-05-25 14:30:11','be08f271-246a-4dec-869c-9c89ae6b9a90'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2020-05-25 14:30:12','2020-05-25 14:30:12','2020-05-25 14:30:12','a7b3f67e-f083-41ec-b5b4-2f0f6679494a'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2020-05-25 14:30:12','2020-05-25 14:30:12','2020-05-25 14:30:12','497c3cfa-256e-49b0-896d-c12bdc2be9a2'),(126,NULL,'app','m190112_124737_fix_user_settings','2020-05-25 14:30:13','2020-05-25 14:30:13','2020-05-25 14:30:13','e9a32e05-5194-46af-99b6-978d6b322443'),(127,NULL,'app','m190112_131225_fix_field_layouts','2020-05-25 14:30:14','2020-05-25 14:30:14','2020-05-25 14:30:14','9818abbd-8669-47cb-85a5-d9fc18619699'),(128,NULL,'app','m190112_201010_more_soft_deletes','2020-05-25 14:30:15','2020-05-25 14:30:15','2020-05-25 14:30:15','c062f29c-c901-4774-a695-7ff1bd09f070'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2020-05-25 14:30:16','2020-05-25 14:30:16','2020-05-25 14:30:16','a29780c2-335e-4902-ab16-7db6846458d9'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2020-05-25 14:30:16','2020-05-25 14:30:16','2020-05-25 14:30:16','bee62b2b-181f-4f4e-8c9e-d115ec957193'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2020-05-25 14:30:17','2020-05-25 14:30:17','2020-05-25 14:30:17','482ae63b-fbed-4476-b467-74ecefe88c95'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2020-05-25 14:30:17','2020-05-25 14:30:17','2020-05-25 14:30:17','7cbb8098-1d60-4ed8-b47f-7b124424e0eb'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2020-05-25 14:30:18','2020-05-25 14:30:18','2020-05-25 14:30:18','88c8aded-023f-4374-acc9-32fea1545895'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2020-05-25 14:30:18','2020-05-25 14:30:18','2020-05-25 14:30:18','181ea74e-5eeb-46d2-b15c-bedf917db4b8'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2020-05-25 14:30:18','2020-05-25 14:30:18','2020-05-25 14:30:18','74ff1bdc-e92b-4230-8610-cfd2fcd6e63d'),(136,NULL,'app','m190312_152740_element_revisions','2020-05-25 14:30:19','2020-05-25 14:30:19','2020-05-25 14:30:19','5f11509e-6291-43dc-8e4f-6a219acb7f90'),(137,NULL,'app','m190327_235137_propagation_method','2020-05-25 14:30:20','2020-05-25 14:30:20','2020-05-25 14:30:20','16897d61-42f0-48c2-872d-72205fcbdac7'),(138,NULL,'app','m190401_223843_drop_old_indexes','2020-05-25 14:30:21','2020-05-25 14:30:21','2020-05-25 14:30:21','a1df383e-b21e-4a0a-bd8a-d603598b24d3'),(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2020-05-25 14:30:21','2020-05-25 14:30:21','2020-05-25 14:30:21','0229f927-672d-4104-aacd-5f0b70fddac1'),(140,NULL,'app','m190417_085010_add_image_editor_permissions','2020-05-25 14:30:22','2020-05-25 14:30:22','2020-05-25 14:30:22','920e338a-1e19-4f8f-9835-76449ff8e213'),(141,NULL,'app','m190502_122019_store_default_user_group_uid','2020-05-25 14:30:22','2020-05-25 14:30:22','2020-05-25 14:30:22','cebb044a-1fa5-4b80-8593-57ec42c10bc6'),(142,NULL,'app','m190504_150349_preview_targets','2020-05-25 14:30:22','2020-05-25 14:30:22','2020-05-25 14:30:22','dc757bf6-61f2-416f-961f-d21d0d2ac6b5'),(143,NULL,'app','m190516_184711_job_progress_label','2020-05-25 14:30:25','2020-05-25 14:30:25','2020-05-25 14:30:25','619c5fca-edac-4ce6-8c77-164ab111b2fa'),(144,NULL,'app','m190523_190303_optional_revision_creators','2020-05-25 14:30:26','2020-05-25 14:30:26','2020-05-25 14:30:26','1c4721c2-c465-4ea5-9160-ee6118b0f596'),(145,NULL,'app','m190529_204501_fix_duplicate_uids','2020-05-25 14:30:26','2020-05-25 14:30:26','2020-05-25 14:30:26','dd9ab991-f8e4-451d-a01a-4244dbf8bd05'),(146,NULL,'app','m190605_223807_unsaved_drafts','2020-05-25 14:30:27','2020-05-25 14:30:27','2020-05-25 14:30:27','a70797bd-56ae-40d4-8d87-f41bb2e4897a'),(147,NULL,'app','m190607_230042_entry_revision_error_tables','2020-05-25 14:30:28','2020-05-25 14:30:28','2020-05-25 14:30:28','03c49250-d341-4fe5-ad20-5858c44dddd8'),(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2020-05-25 14:30:29','2020-05-25 14:30:29','2020-05-25 14:30:29','f98f1bec-2c50-4cb1-a9a5-e194b6d74256'),(149,NULL,'app','m190617_164400_add_gqlschemas_table','2020-05-25 14:30:30','2020-05-25 14:30:30','2020-05-25 14:30:30','026e15f8-3652-47d5-bf28-04c47c00bfc9'),(150,NULL,'app','m190624_234204_matrix_propagation_method','2020-05-25 14:30:31','2020-05-25 14:30:31','2020-05-25 14:30:31','40c8d5db-f01f-4404-9fce-87b7fbf5782d'),(151,NULL,'app','m190711_153020_drop_snapshots','2020-05-25 14:30:31','2020-05-25 14:30:31','2020-05-25 14:30:31','d372f43c-c5ee-4848-ba5f-4109268232b5'),(152,NULL,'app','m190712_195914_no_draft_revisions','2020-05-25 14:30:32','2020-05-25 14:30:32','2020-05-25 14:30:32','4cd8e704-1609-45ef-b578-f6efa0d24950'),(153,NULL,'app','m190723_140314_fix_preview_targets_column','2020-05-25 14:30:33','2020-05-25 14:30:33','2020-05-25 14:30:33','9a3030c0-811e-4acc-9e81-9db00f464ba6'),(154,NULL,'app','m190820_003519_flush_compiled_templates','2020-05-25 14:30:33','2020-05-25 14:30:33','2020-05-25 14:30:33','ee253dd9-0938-451a-96e4-ce047bf24ad6'),(155,NULL,'app','m190823_020339_optional_draft_creators','2020-05-25 14:30:34','2020-05-25 14:30:34','2020-05-25 14:30:34','8426a8ed-bf74-41f7-b63e-83651c3b56d5'),(156,NULL,'app','m190913_152146_update_preview_targets','2020-05-25 14:30:34','2020-05-25 14:30:34','2020-05-25 14:30:34','4991fa8b-9b5a-4601-9728-3abac91ed7e9'),(157,NULL,'app','m191107_122000_add_gql_project_config_support','2020-05-25 14:30:34','2020-05-25 14:30:34','2020-05-25 14:30:34','dc9c195f-948c-4f93-b725-c602a48140b3'),(158,NULL,'app','m191204_085100_pack_savable_component_settings','2020-05-25 14:30:35','2020-05-25 14:30:35','2020-05-25 14:30:35','5c0a14da-e193-4023-aff6-17fab399b976'),(159,NULL,'app','m191206_001148_change_tracking','2020-05-25 14:30:35','2020-05-25 14:30:35','2020-05-25 14:30:35','99c32fde-d551-468e-b429-6d05c817a655'),(160,NULL,'app','m191216_191635_asset_upload_tracking','2020-05-25 14:30:38','2020-05-25 14:30:38','2020-05-25 14:30:38','094b15a3-a6f6-43d3-8265-603740f66201'),(161,NULL,'app','m191222_002848_peer_asset_permissions','2020-05-25 14:30:40','2020-05-25 14:30:40','2020-05-25 14:30:40','0b5e26d1-aee7-471a-9e32-f39ea4970a13'),(162,NULL,'app','m200127_172522_queue_channels','2020-05-25 14:30:40','2020-05-25 14:30:40','2020-05-25 14:30:40','fa1710d5-e243-4b94-abbb-6e8a03388005'),(163,NULL,'app','m200211_175048_truncate_element_query_cache','2020-05-25 14:30:43','2020-05-25 14:30:43','2020-05-25 14:30:43','8cc382eb-775e-427e-b3cb-03ddd4d099c0'),(164,NULL,'app','m200213_172522_new_elements_index','2020-05-25 14:30:44','2020-05-25 14:30:44','2020-05-25 14:30:44','74871861-957e-48c3-80cd-5dde3f419948'),(165,NULL,'app','m200228_195211_long_deprecation_messages','2020-05-25 14:30:46','2020-05-25 14:30:46','2020-05-25 14:30:46','a36bcd02-7f00-4ba1-8951-217981569a5f'),(166,1,'plugin','m180430_204710_remove_old_plugins','2020-05-25 14:30:51','2020-05-25 14:30:51','2020-05-25 14:30:51','55a87da3-9f7d-4579-a1c8-9b61bde94538'),(167,1,'plugin','Install','2020-05-25 14:30:51','2020-05-25 14:30:51','2020-05-25 14:30:51','5f23edb1-7793-462b-8b26-c3dbd3f4ab57');
/*!40000 ALTER TABLE `ut_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_plugins`
--

LOCK TABLES `ut_plugins` WRITE;
/*!40000 ALTER TABLE `ut_plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_plugins` VALUES (1,'redactor','2.0.1','2.0.0','unknown',NULL,'2020-05-25 14:30:51','2020-05-25 14:30:51','2020-05-25 14:33:25','e8728738-401a-47c4-9f1d-79586c28ad29');
/*!40000 ALTER TABLE `ut_plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_projectconfig`
--

LOCK TABLES `ut_projectconfig` WRITE;
/*!40000 ALTER TABLE `ut_projectconfig` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_projectconfig` VALUES ('dateModified','1590418862'),('email.fromEmail','\"admin@company.com\"'),('email.fromName','\"Craft CMS Installation\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('fieldGroups.0ecf5ec5-0b3d-414f-876e-76df9908e8a3.name','\"Page\"'),('fieldGroups.4b05c067-85a7-4666-ba3b-b2242d20b26c.name','\"Common\"'),('fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.contentColumnType','\"string\"'),('fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.fieldGroup','\"0ecf5ec5-0b3d-414f-876e-76df9908e8a3\"'),('fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.handle','\"pageBlocks\"'),('fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.instructions','\"\"'),('fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.name','\"Page Blocks\"'),('fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.searchable','false'),('fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.settings.contentTable','\"{{%matrixcontent_pageblocks}}\"'),('fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.settings.maxBlocks','\"\"'),('fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.settings.minBlocks','\"\"'),('fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.settings.propagationMethod','\"all\"'),('fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.translationKeyFormat','null'),('fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.translationMethod','\"site\"'),('fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.type','\"craft\\\\fields\\\\Matrix\"'),('graphql.schemas.961cca94-d8b0-4607-8cd8-3b77f81b21cc.isPublic','\"1\"'),('graphql.schemas.961cca94-d8b0-4607-8cd8-3b77f81b21cc.name','\"Public Schema\"'),('graphql.schemas.961cca94-d8b0-4607-8cd8-3b77f81b21cc.scope.0','\"sections.48457350-2ca6-4e7e-865a-9c0604db508e:read\"'),('graphql.schemas.961cca94-d8b0-4607-8cd8-3b77f81b21cc.scope.1','\"entrytypes.ae419057-2604-4122-a5ce-9c87e25aacba:read\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.field','\"0a4ec643-1d46-4238-b9ae-d88ca0f8820a\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fieldLayouts.55e1b59c-9293-4ddc-bdb4-a86b53b5ba48.tabs.0.fields.3496828f-c91b-4780-b666-c01af4f626ee.required','false'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fieldLayouts.55e1b59c-9293-4ddc-bdb4-a86b53b5ba48.tabs.0.fields.3496828f-c91b-4780-b666-c01af4f626ee.sortOrder','2'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fieldLayouts.55e1b59c-9293-4ddc-bdb4-a86b53b5ba48.tabs.0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.required','true'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fieldLayouts.55e1b59c-9293-4ddc-bdb4-a86b53b5ba48.tabs.0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.sortOrder','1'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fieldLayouts.55e1b59c-9293-4ddc-bdb4-a86b53b5ba48.tabs.0.name','\"Content\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fieldLayouts.55e1b59c-9293-4ddc-bdb4-a86b53b5ba48.tabs.0.sortOrder','1'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.contentColumnType','\"text\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.fieldGroup','null'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.handle','\"textBlockContent\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.instructions','\"\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.name','\"Content\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.searchable','false'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.settings.availableTransforms','\"*\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.settings.availableVolumes','\"*\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.settings.cleanupHtml','\"1\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.settings.columnType','\"text\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.settings.purifierConfig','\"\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.settings.purifyHtml','\"1\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.settings.redactorConfig','\"Simple.json\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.translationKeyFormat','null'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.translationMethod','\"none\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.3496828f-c91b-4780-b666-c01af4f626ee.type','\"craft\\\\redactor\\\\Field\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.contentColumnType','\"text\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.fieldGroup','null'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.handle','\"textBlockHeadline\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.instructions','\"\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.name','\"Headline\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.searchable','true'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.settings.byteLimit','null'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.settings.charLimit','null'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.settings.code','\"\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.settings.columnType','null'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.settings.initialRows','\"4\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.settings.multiline','\"\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.settings.placeholder','\"\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.translationKeyFormat','null'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.translationMethod','\"none\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.fields.dd4c93bc-056e-4663-9f14-69980caa0416.type','\"craft\\\\fields\\\\PlainText\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.handle','\"textBlock\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.name','\"Text Block\"'),('matrixBlockTypes.41a6fa1a-18b6-4218-8701-062112fa18b0.sortOrder','1'),('plugins.redactor.edition','\"standard\"'),('plugins.redactor.enabled','true'),('plugins.redactor.schemaVersion','\"2.0.0\"'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.enableVersioning','true'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.entryTypes.ae419057-2604-4122-a5ce-9c87e25aacba.fieldLayouts.5fc56c9d-3756-4100-b8b5-d33a62d73ca9.tabs.0.fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.required','false'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.entryTypes.ae419057-2604-4122-a5ce-9c87e25aacba.fieldLayouts.5fc56c9d-3756-4100-b8b5-d33a62d73ca9.tabs.0.fields.0a4ec643-1d46-4238-b9ae-d88ca0f8820a.sortOrder','1'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.entryTypes.ae419057-2604-4122-a5ce-9c87e25aacba.fieldLayouts.5fc56c9d-3756-4100-b8b5-d33a62d73ca9.tabs.0.name','\"Tab 1\"'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.entryTypes.ae419057-2604-4122-a5ce-9c87e25aacba.fieldLayouts.5fc56c9d-3756-4100-b8b5-d33a62d73ca9.tabs.0.sortOrder','1'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.entryTypes.ae419057-2604-4122-a5ce-9c87e25aacba.handle','\"page\"'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.entryTypes.ae419057-2604-4122-a5ce-9c87e25aacba.hasTitleField','true'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.entryTypes.ae419057-2604-4122-a5ce-9c87e25aacba.name','\"Page\"'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.entryTypes.ae419057-2604-4122-a5ce-9c87e25aacba.sortOrder','1'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.entryTypes.ae419057-2604-4122-a5ce-9c87e25aacba.titleFormat','\"\"'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.entryTypes.ae419057-2604-4122-a5ce-9c87e25aacba.titleLabel','\"Title\"'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.handle','\"page\"'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.name','\"Page\"'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.propagationMethod','\"all\"'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.siteSettings.9d6262ec-bdfc-4d8a-b9c2-0d9af6ef00f3.enabledByDefault','true'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.siteSettings.9d6262ec-bdfc-4d8a-b9c2-0d9af6ef00f3.hasUrls','true'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.siteSettings.9d6262ec-bdfc-4d8a-b9c2-0d9af6ef00f3.template','\"\"'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.siteSettings.9d6262ec-bdfc-4d8a-b9c2-0d9af6ef00f3.uriFormat','\"{slug}\"'),('sections.48457350-2ca6-4e7e-865a-9c0604db508e.type','\"channel\"'),('siteGroups.9031ec13-d62a-4866-b7e3-a7af59d2c151.name','\"Craft CMS Installation\"'),('sites.9d6262ec-bdfc-4d8a-b9c2-0d9af6ef00f3.baseUrl','\"$DEFAULT_SITE_URL\"'),('sites.9d6262ec-bdfc-4d8a-b9c2-0d9af6ef00f3.handle','\"default\"'),('sites.9d6262ec-bdfc-4d8a-b9c2-0d9af6ef00f3.hasUrls','true'),('sites.9d6262ec-bdfc-4d8a-b9c2-0d9af6ef00f3.language','\"en-US\"'),('sites.9d6262ec-bdfc-4d8a-b9c2-0d9af6ef00f3.name','\"Craft CMS Installation\"'),('sites.9d6262ec-bdfc-4d8a-b9c2-0d9af6ef00f3.primary','true'),('sites.9d6262ec-bdfc-4d8a-b9c2-0d9af6ef00f3.siteGroup','\"9031ec13-d62a-4866-b7e3-a7af59d2c151\"'),('sites.9d6262ec-bdfc-4d8a-b9c2-0d9af6ef00f3.sortOrder','1'),('system.edition','\"pro\"'),('system.live','true'),('system.name','\"Craft CMS Installation\"'),('system.schemaVersion','\"3.4.10\"'),('system.timeZone','\"America/Los_Angeles\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','\"\"'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true');
/*!40000 ALTER TABLE `ut_projectconfig` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_queue`
--

LOCK TABLES `ut_queue` WRITE;
/*!40000 ALTER TABLE `ut_queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_relations`
--

LOCK TABLES `ut_relations` WRITE;
/*!40000 ALTER TABLE `ut_relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_resourcepaths`
--

LOCK TABLES `ut_resourcepaths` WRITE;
/*!40000 ALTER TABLE `ut_resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_resourcepaths` VALUES ('114d555b','@app/web/assets/cp/dist'),('15734025','@app/web/assets/login/dist'),('2037b32d','@lib/axios'),('20a49f0f','@app/web/assets/graphiql/dist'),('261e5ca9','@app/web/assets/generalsettings/dist'),('2ae0f364','@lib/jquery-ui'),('32ba30b8','@app/web/assets/updateswidget/dist'),('3c289c79','@app/web/assets/craftsupport/dist'),('599c4a8a','@app/web/assets/matrixsettings/dist'),('5a563449','@lib/element-resize-detector'),('644968c1','@lib/velocity'),('68561ee5','@app/web/assets/feed/dist'),('6dd23fe3','@app/web/assets/userpermissions/dist'),('733617ca','@app/web/assets/utilities/dist'),('75c69fbc','@bower/jquery/dist'),('786ec729','@lib/jquery.payment'),('7a1c7995','@app/web/assets/tablesettings/dist'),('8c85df47','@app/web/assets/admintable/dist'),('97363def','@craft/redactor/assets/field/dist'),('98819240','@lib/timepicker'),('9ab49d3c','@app/web/assets/editsection/dist'),('a751870','@app/web/assets/pluginstore/dist'),('a77eca35','@lib/xregexp'),('ad128ebf','@lib/selectize'),('c0072d6','@app/web/assets/recententries/dist'),('c47494ec','@lib/garnishjs'),('d13240d2','@lib/fabric'),('d2401b17','@app/web/assets/dashboard/dist'),('d5273559','@app/web/assets/fields/dist'),('ddc1058','@lib/vue'),('e184a2c5','@lib/fileupload'),('ea6ca06f','@vendor/craftcms/redactor/lib/redactor'),('ed089434','@app/web/assets/dbbackup/dist'),('f2e6d917','@app/web/assets/editentry/dist'),('f7c9836a','@lib/d3'),('f96ca33b','@lib/picturefill'),('fdc4fb23','@app/web/assets/matrix/dist'),('fec89ff9','@lib/jquery-touch-events');
/*!40000 ALTER TABLE `ut_resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_revisions`
--

LOCK TABLES `ut_revisions` WRITE;
/*!40000 ALTER TABLE `ut_revisions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_revisions` VALUES (1,9,1,1,NULL),(2,9,1,2,NULL),(3,9,1,3,NULL);
/*!40000 ALTER TABLE `ut_revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_searchindex`
--

LOCK TABLES `ut_searchindex` WRITE;
/*!40000 ALTER TABLE `ut_searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' admin company com '),(1,'slug',0,1,''),(9,'slug',0,1,' test page '),(10,'slug',0,1,''),(10,'field',3,1,' lorem amet dolor est '),(9,'title',0,1,' test page ');
/*!40000 ALTER TABLE `ut_searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_sections`
--

LOCK TABLES `ut_sections` WRITE;
/*!40000 ALTER TABLE `ut_sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_sections` VALUES (1,NULL,'Page','page','channel',1,'all',NULL,'2020-05-25 14:48:58','2020-05-25 14:48:58',NULL,'48457350-2ca6-4e7e-865a-9c0604db508e');
/*!40000 ALTER TABLE `ut_sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_sections_sites`
--

LOCK TABLES `ut_sections_sites` WRITE;
/*!40000 ALTER TABLE `ut_sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_sections_sites` VALUES (1,1,1,1,'{slug}','',1,'2020-05-25 14:48:58','2020-05-25 14:48:58','e6f81411-f8d6-455d-a435-a9c3b456961f');
/*!40000 ALTER TABLE `ut_sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_sequences`
--

LOCK TABLES `ut_sequences` WRITE;
/*!40000 ALTER TABLE `ut_sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_shunnedmessages`
--

LOCK TABLES `ut_shunnedmessages` WRITE;
/*!40000 ALTER TABLE `ut_shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_sitegroups`
--

LOCK TABLES `ut_sitegroups` WRITE;
/*!40000 ALTER TABLE `ut_sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_sitegroups` VALUES (1,'Craft CMS Installation','2020-05-25 14:28:43','2020-05-25 14:28:43',NULL,'9031ec13-d62a-4866-b7e3-a7af59d2c151');
/*!40000 ALTER TABLE `ut_sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_sites`
--

LOCK TABLES `ut_sites` WRITE;
/*!40000 ALTER TABLE `ut_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_sites` VALUES (1,1,1,'Craft CMS Installation','default','en-US',1,'$DEFAULT_SITE_URL',1,'2020-05-25 14:28:44','2020-05-25 14:28:44',NULL,'9d6262ec-bdfc-4d8a-b9c2-0d9af6ef00f3');
/*!40000 ALTER TABLE `ut_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_structureelements`
--

LOCK TABLES `ut_structureelements` WRITE;
/*!40000 ALTER TABLE `ut_structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_structures`
--

LOCK TABLES `ut_structures` WRITE;
/*!40000 ALTER TABLE `ut_structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_systemmessages`
--

LOCK TABLES `ut_systemmessages` WRITE;
/*!40000 ALTER TABLE `ut_systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_taggroups`
--

LOCK TABLES `ut_taggroups` WRITE;
/*!40000 ALTER TABLE `ut_taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_tags`
--

LOCK TABLES `ut_tags` WRITE;
/*!40000 ALTER TABLE `ut_tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_tokens`
--

LOCK TABLES `ut_tokens` WRITE;
/*!40000 ALTER TABLE `ut_tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_usergroups`
--

LOCK TABLES `ut_usergroups` WRITE;
/*!40000 ALTER TABLE `ut_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_usergroups_users`
--

LOCK TABLES `ut_usergroups_users` WRITE;
/*!40000 ALTER TABLE `ut_usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_userpermissions`
--

LOCK TABLES `ut_userpermissions` WRITE;
/*!40000 ALTER TABLE `ut_userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_userpermissions_usergroups`
--

LOCK TABLES `ut_userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `ut_userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_userpermissions_users`
--

LOCK TABLES `ut_userpermissions_users` WRITE;
/*!40000 ALTER TABLE `ut_userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_userpreferences`
--

LOCK TABLES `ut_userpreferences` WRITE;
/*!40000 ALTER TABLE `ut_userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `ut_userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_users`
--

LOCK TABLES `ut_users` WRITE;
/*!40000 ALTER TABLE `ut_users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_users` VALUES (1,'admin',NULL,NULL,NULL,'admin@company.com','$2y$13$S0bCXpd3U9.hPYA1bb1wP.Q6P/cIs6gwb5DwfJDVD1C46jiNBtJ3a',1,0,0,0,'2020-05-25 14:48:22',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2020-05-25 14:28:46','2020-05-25 14:28:46','2020-05-25 14:48:22','c2e6885a-0e1b-40a8-b209-5089aa98488f');
/*!40000 ALTER TABLE `ut_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_volumefolders`
--

LOCK TABLES `ut_volumefolders` WRITE;
/*!40000 ALTER TABLE `ut_volumefolders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_volumes`
--

LOCK TABLES `ut_volumes` WRITE;
/*!40000 ALTER TABLE `ut_volumes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `ut_volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `ut_widgets`
--

LOCK TABLES `ut_widgets` WRITE;
/*!40000 ALTER TABLE `ut_widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ut_widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2020-05-25 14:31:38','2020-05-25 14:31:38','f9498811-9380-4d0f-83ee-44c0375c054b'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-05-25 14:31:38','2020-05-25 14:31:38','85b56595-a61a-4a4a-ab77-97a5f9433e23'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-05-25 14:31:39','2020-05-25 14:31:39','bc47dbf6-4f20-4e08-a082-f14e8395fd72'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-05-25 14:31:39','2020-05-25 14:31:39','a078827b-e227-43ac-8c7f-fc954738301d');
/*!40000 ALTER TABLE `ut_widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'craft'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-25 15:13:24
