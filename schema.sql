# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.6.16-log)
# Database: sse
# Generation Time: 2017-10-12 23:11:41 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table cluster
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cluster`;

CREATE TABLE `cluster` (
  `cluster_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `harvest_id` int(11) NOT NULL,
  `dirty` tinyint(1) DEFAULT NULL,
  `anchor` longtext COLLATE utf8mb4_unicode_ci,
  `classifier` enum('default','rule') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  PRIMARY KEY (`cluster_id`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table clustered_page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `clustered_page`;

CREATE TABLE `clustered_page` (
  `project_id` int(11) NOT NULL,
  `cluster_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `page_type` enum('other','test','train') COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`project_id`,`cluster_id`,`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table extraction
# ------------------------------------------------------------

DROP TABLE IF EXISTS `extraction`;

CREATE TABLE `extraction` (
  `project_id` int(11) NOT NULL,
  `cluster_id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `extraction_json` longtext COLLATE utf8mb4_unicode_ci,
  `extraction_json_with_validation` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`project_id`,`cluster_id`,`template_id`,`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table harvest
# ------------------------------------------------------------

DROP TABLE IF EXISTS `harvest`;

CREATE TABLE `harvest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `crawl_id` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('completed_success','completed_errors','not_started','running','unable_to_start') COLLATE utf8mb4_unicode_ci NOT NULL,
  `pages_failed` int(11) DEFAULT NULL,
  `pages_fetched` int(11) DEFAULT NULL,
  `jl_file_location` text COLLATE utf8mb4_unicode_ci,
  `url` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `concurrent_requests` int(11) DEFAULT NULL,
  `concurrent_requests_per_domain` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `error_page_percentage` int(11) DEFAULT NULL,
  `error_page_percentage_period` int(11) DEFAULT NULL,
  `started_ms` bigint(20) DEFAULT NULL,
  `completed_ms` bigint(20) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `prefer_pagination` tinyint(1) DEFAULT NULL,
  `multi_urls` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `page`;

CREATE TABLE `page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crawl_id` int(11) NOT NULL,
  `crawl_page_id` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `html` longtext COLLATE utf8mb4_unicode_ci,
  `live_url` text COLLATE utf8mb4_unicode_ci,
  `small_thumbnail_url` text COLLATE utf8mb4_unicode_ci,
  `thumbnail_url` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cid_cpid_uix_1` (`crawl_id`,`crawl_page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table project
# ------------------------------------------------------------

DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(175) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('clustering','deleted','error','harvesting','learning','new','published','ready') COLLATE utf8mb4_unicode_ci NOT NULL,
  `selected_cluster_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table template
# ------------------------------------------------------------

DROP TABLE IF EXISTS `template`;

CREATE TABLE `template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `cluster_id` int(11) DEFAULT NULL,
  `supervised` tinyint(1) DEFAULT NULL,
  `markup` longtext COLLATE utf8mb4_unicode_ci,
  `stripes` longtext COLLATE utf8mb4_unicode_ci,
  `rules` longtext COLLATE utf8mb4_unicode_ci,
  `schema` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pid_cid_sup_uix_1` (`project_id`,`cluster_id`,`supervised`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table template_debug
# ------------------------------------------------------------

DROP TABLE IF EXISTS `template_debug`;

CREATE TABLE `template_debug` (
  `project_id` int(11) NOT NULL,
  `cluster_id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `debug_html` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`project_id`,`cluster_id`,`template_id`,`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table validation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `validation`;

CREATE TABLE `validation` (
  `project_id` int(11) NOT NULL,
  `cluster_id` int(11) NOT NULL,
  `field_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `validation_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `validation_param` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`project_id`,`cluster_id`,`field_id`,`validation_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
