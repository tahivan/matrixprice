/*
Navicat MySQL Data Transfer

Source Server         : Localhost
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : project_base_db

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2015-08-06 14:16:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for adminnotification_inbox
-- ----------------------------
DROP TABLE IF EXISTS `adminnotification_inbox`;
CREATE TABLE `adminnotification_inbox` (
  `notification_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Notification id',
  `severity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Problem type',
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Create date',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `description` text COMMENT 'Description',
  `url` varchar(255) DEFAULT NULL COMMENT 'Url',
  `is_read` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification read',
  `is_remove` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification might be removed',
  PRIMARY KEY (`notification_id`),
  KEY `IDX_ADMINNOTIFICATION_INBOX_SEVERITY` (`severity`),
  KEY `IDX_ADMINNOTIFICATION_INBOX_IS_READ` (`is_read`),
  KEY `IDX_ADMINNOTIFICATION_INBOX_IS_REMOVE` (`is_remove`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Adminnotification Inbox';

-- ----------------------------
-- Records of adminnotification_inbox
-- ----------------------------

-- ----------------------------
-- Table structure for admin_assert
-- ----------------------------
DROP TABLE IF EXISTS `admin_assert`;
CREATE TABLE `admin_assert` (
  `assert_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Assert ID',
  `assert_type` varchar(20) DEFAULT NULL COMMENT 'Assert Type',
  `assert_data` text COMMENT 'Assert Data',
  PRIMARY KEY (`assert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Assert Table';

-- ----------------------------
-- Records of admin_assert
-- ----------------------------

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Role ID',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Tree Level',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Sort Order',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role Type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User ID',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role Name',
  PRIMARY KEY (`role_id`),
  KEY `IDX_ADMIN_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `IDX_ADMIN_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Admin Role Table';

-- ----------------------------
-- Records of admin_role
-- ----------------------------
INSERT INTO `admin_role` VALUES ('1', '0', '1', '1', 'G', '0', 'Administrators');
INSERT INTO `admin_role` VALUES ('2', '1', '2', '0', 'U', '1', 'Admin');

-- ----------------------------
-- Table structure for admin_rule
-- ----------------------------
DROP TABLE IF EXISTS `admin_rule`;
CREATE TABLE `admin_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule ID',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Role ID',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Resource ID',
  `privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `assert_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Assert ID',
  `role_type` varchar(1) DEFAULT NULL COMMENT 'Role Type',
  `permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_ADMIN_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `IDX_ADMIN_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`),
  CONSTRAINT `FK_ADMIN_RULE_ROLE_ID_ADMIN_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `admin_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Admin Rule Table';

-- ----------------------------
-- Records of admin_rule
-- ----------------------------
INSERT INTO `admin_rule` VALUES ('1', '1', 'all', null, '0', 'G', 'allow');

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User ID',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'User First Name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'User Last Name',
  `email` varchar(128) DEFAULT NULL COMMENT 'User Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'User Login',
  `password` varchar(100) DEFAULT NULL COMMENT 'User Password',
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'User Created Time',
  `modified` timestamp NULL DEFAULT NULL COMMENT 'User Modified Time',
  `logdate` timestamp NULL DEFAULT NULL COMMENT 'User Last Login Time',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'User Login Number',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Reload ACL',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'User Is Active',
  `extra` text COMMENT 'User Extra Data',
  `rp_token` text COMMENT 'Reset Password Link Token',
  `rp_token_created_at` timestamp NULL DEFAULT NULL COMMENT 'Reset Password Link Token Creation Date',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UNQ_ADMIN_USER_USERNAME` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Admin User Table';

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES ('1', 'Admin', 'Admin', 'admin@gmail.com', 'admin', 'a8de20df2ffdb918d97726df06927a8d:UKj5s8Qxujdn6KPI0zfp7pmBTiAG7YE0', '2015-08-06 05:58:07', '2015-08-06 05:58:07', '2015-08-06 05:58:32', '1', '0', '1', 'N;', null, null);

-- ----------------------------
-- Table structure for api2_acl_attribute
-- ----------------------------
DROP TABLE IF EXISTS `api2_acl_attribute`;
CREATE TABLE `api2_acl_attribute` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `user_type` varchar(20) NOT NULL COMMENT 'Type of user',
  `resource_id` varchar(255) NOT NULL COMMENT 'Resource ID',
  `operation` varchar(20) NOT NULL COMMENT 'Operation',
  `allowed_attributes` text COMMENT 'Allowed attributes',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_API2_ACL_ATTRIBUTE_USER_TYPE_RESOURCE_ID_OPERATION` (`user_type`,`resource_id`,`operation`),
  KEY `IDX_API2_ACL_ATTRIBUTE_USER_TYPE` (`user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Filter ACL Attributes';

-- ----------------------------
-- Records of api2_acl_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for api2_acl_role
-- ----------------------------
DROP TABLE IF EXISTS `api2_acl_role`;
CREATE TABLE `api2_acl_role` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `role_name` varchar(255) NOT NULL COMMENT 'Name of role',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_API2_ACL_ROLE_CREATED_AT` (`created_at`),
  KEY `IDX_API2_ACL_ROLE_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Roles';

-- ----------------------------
-- Records of api2_acl_role
-- ----------------------------
INSERT INTO `api2_acl_role` VALUES ('1', '2015-08-06 12:56:00', null, 'Guest');
INSERT INTO `api2_acl_role` VALUES ('2', '2015-08-06 12:56:00', null, 'Customer');

-- ----------------------------
-- Table structure for api2_acl_rule
-- ----------------------------
DROP TABLE IF EXISTS `api2_acl_rule`;
CREATE TABLE `api2_acl_rule` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `role_id` int(10) unsigned NOT NULL COMMENT 'Role ID',
  `resource_id` varchar(255) NOT NULL COMMENT 'Resource ID',
  `privilege` varchar(20) DEFAULT NULL COMMENT 'ACL Privilege',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_API2_ACL_RULE_ROLE_ID_RESOURCE_ID_PRIVILEGE` (`role_id`,`resource_id`,`privilege`),
  CONSTRAINT `FK_API2_ACL_RULE_ROLE_ID_API2_ACL_ROLE_ENTITY_ID` FOREIGN KEY (`role_id`) REFERENCES `api2_acl_role` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Rules';

-- ----------------------------
-- Records of api2_acl_rule
-- ----------------------------

-- ----------------------------
-- Table structure for api2_acl_user
-- ----------------------------
DROP TABLE IF EXISTS `api2_acl_user`;
CREATE TABLE `api2_acl_user` (
  `admin_id` int(10) unsigned NOT NULL COMMENT 'Admin ID',
  `role_id` int(10) unsigned NOT NULL COMMENT 'Role ID',
  UNIQUE KEY `UNQ_API2_ACL_USER_ADMIN_ID` (`admin_id`),
  KEY `FK_API2_ACL_USER_ROLE_ID_API2_ACL_ROLE_ENTITY_ID` (`role_id`),
  CONSTRAINT `FK_API2_ACL_USER_ADMIN_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_API2_ACL_USER_ROLE_ID_API2_ACL_ROLE_ENTITY_ID` FOREIGN KEY (`role_id`) REFERENCES `api2_acl_role` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Users';

-- ----------------------------
-- Records of api2_acl_user
-- ----------------------------

-- ----------------------------
-- Table structure for api_assert
-- ----------------------------
DROP TABLE IF EXISTS `api_assert`;
CREATE TABLE `api_assert` (
  `assert_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Assert id',
  `assert_type` varchar(20) DEFAULT NULL COMMENT 'Assert type',
  `assert_data` text COMMENT 'Assert additional data',
  PRIMARY KEY (`assert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Asserts';

-- ----------------------------
-- Records of api_assert
-- ----------------------------

-- ----------------------------
-- Table structure for api_role
-- ----------------------------
DROP TABLE IF EXISTS `api_role`;
CREATE TABLE `api_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent role id',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role level in tree',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order to display on admin area',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User id',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role name',
  PRIMARY KEY (`role_id`),
  KEY `IDX_API_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `IDX_API_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Roles';

-- ----------------------------
-- Records of api_role
-- ----------------------------

-- ----------------------------
-- Table structure for api_rule
-- ----------------------------
DROP TABLE IF EXISTS `api_rule`;
CREATE TABLE `api_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Api rule Id',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Api role Id',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Module code',
  `api_privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `assert_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Assert id',
  `role_type` varchar(1) DEFAULT NULL COMMENT 'Role type',
  `api_permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_API_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `IDX_API_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`),
  CONSTRAINT `FK_API_RULE_ROLE_ID_API_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `api_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Rules';

-- ----------------------------
-- Records of api_rule
-- ----------------------------

-- ----------------------------
-- Table structure for api_session
-- ----------------------------
DROP TABLE IF EXISTS `api_session`;
CREATE TABLE `api_session` (
  `user_id` int(10) unsigned NOT NULL COMMENT 'User id',
  `logdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Login date',
  `sessid` varchar(40) DEFAULT NULL COMMENT 'Sessioin id',
  KEY `IDX_API_SESSION_USER_ID` (`user_id`),
  KEY `IDX_API_SESSION_SESSID` (`sessid`),
  CONSTRAINT `FK_API_SESSION_USER_ID_API_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `api_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api Sessions';

-- ----------------------------
-- Records of api_session
-- ----------------------------

-- ----------------------------
-- Table structure for api_user
-- ----------------------------
DROP TABLE IF EXISTS `api_user`;
CREATE TABLE `api_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User id',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'First name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'Last name',
  `email` varchar(128) DEFAULT NULL COMMENT 'Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'Nickname',
  `api_key` varchar(100) DEFAULT NULL COMMENT 'Api key',
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'User record create date',
  `modified` timestamp NULL DEFAULT NULL COMMENT 'User record modify date',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Quantity of log ins',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Refresh ACL flag',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Account status',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api Users';

-- ----------------------------
-- Records of api_user
-- ----------------------------

-- ----------------------------
-- Table structure for captcha_log
-- ----------------------------
DROP TABLE IF EXISTS `captcha_log`;
CREATE TABLE `captcha_log` (
  `type` varchar(32) NOT NULL COMMENT 'Type',
  `value` varchar(32) NOT NULL COMMENT 'Value',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Count',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Count Login Attempts';

-- ----------------------------
-- Records of captcha_log
-- ----------------------------

-- ----------------------------
-- Table structure for cataloginventory_stock
-- ----------------------------
DROP TABLE IF EXISTS `cataloginventory_stock`;
CREATE TABLE `cataloginventory_stock` (
  `stock_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Stock Id',
  `stock_name` varchar(255) DEFAULT NULL COMMENT 'Stock Name',
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock';

-- ----------------------------
-- Records of cataloginventory_stock
-- ----------------------------
INSERT INTO `cataloginventory_stock` VALUES ('1', 'Default');

-- ----------------------------
-- Table structure for cataloginventory_stock_item
-- ----------------------------
DROP TABLE IF EXISTS `cataloginventory_stock_item`;
CREATE TABLE `cataloginventory_stock_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `stock_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `min_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Min Qty',
  `use_config_min_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Qty',
  `is_qty_decimal` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Qty Decimal',
  `backorders` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Backorders',
  `use_config_backorders` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Backorders',
  `min_sale_qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'Min Sale Qty',
  `use_config_min_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Sale Qty',
  `max_sale_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Max Sale Qty',
  `use_config_max_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Max Sale Qty',
  `is_in_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is In Stock',
  `low_stock_date` timestamp NULL DEFAULT NULL COMMENT 'Low Stock Date',
  `notify_stock_qty` decimal(12,4) DEFAULT NULL COMMENT 'Notify Stock Qty',
  `use_config_notify_stock_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Notify Stock Qty',
  `manage_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Manage Stock',
  `use_config_manage_stock` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Manage Stock',
  `stock_status_changed_auto` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Status Changed Automatically',
  `use_config_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Qty Increments',
  `qty_increments` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Increments',
  `use_config_enable_qty_inc` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Enable Qty Increments',
  `enable_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Enable Qty Increments',
  `is_decimal_divided` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Divided into Multiple Boxes for Shipping',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `UNQ_CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID_STOCK_ID` (`product_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_ITEM_STOCK_ID` (`stock_id`),
  CONSTRAINT `FK_CATINV_STOCK_ITEM_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATINV_STOCK_ITEM_STOCK_ID_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `cataloginventory_stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Item';

-- ----------------------------
-- Records of cataloginventory_stock_item
-- ----------------------------

-- ----------------------------
-- Table structure for cataloginventory_stock_status
-- ----------------------------
DROP TABLE IF EXISTS `cataloginventory_stock_status`;
CREATE TABLE `cataloginventory_stock_status` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_STOCK_ID` (`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CATINV_STOCK_STS_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATINV_STOCK_STS_STOCK_ID_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `cataloginventory_stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATINV_STOCK_STS_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status';

-- ----------------------------
-- Records of cataloginventory_stock_status
-- ----------------------------

-- ----------------------------
-- Table structure for cataloginventory_stock_status_idx
-- ----------------------------
DROP TABLE IF EXISTS `cataloginventory_stock_status_idx`;
CREATE TABLE `cataloginventory_stock_status_idx` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_IDX_STOCK_ID` (`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_IDX_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Idx';

-- ----------------------------
-- Records of cataloginventory_stock_status_idx
-- ----------------------------

-- ----------------------------
-- Table structure for cataloginventory_stock_status_tmp
-- ----------------------------
DROP TABLE IF EXISTS `cataloginventory_stock_status_tmp`;
CREATE TABLE `cataloginventory_stock_status_tmp` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_TMP_STOCK_ID` (`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_TMP_WEBSITE_ID` (`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Tmp';

-- ----------------------------
-- Records of cataloginventory_stock_status_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalogsearch_fulltext
-- ----------------------------
DROP TABLE IF EXISTS `catalogsearch_fulltext`;
CREATE TABLE `catalogsearch_fulltext` (
  `fulltext_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `data_index` longtext COMMENT 'Data index',
  PRIMARY KEY (`fulltext_id`),
  UNIQUE KEY `UNQ_CATALOGSEARCH_FULLTEXT_PRODUCT_ID_STORE_ID` (`product_id`,`store_id`),
  FULLTEXT KEY `FTI_CATALOGSEARCH_FULLTEXT_DATA_INDEX` (`data_index`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Catalog search result table';

-- ----------------------------
-- Records of catalogsearch_fulltext
-- ----------------------------

-- ----------------------------
-- Table structure for catalogsearch_query
-- ----------------------------
DROP TABLE IF EXISTS `catalogsearch_query`;
CREATE TABLE `catalogsearch_query` (
  `query_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Query ID',
  `query_text` varchar(255) DEFAULT NULL COMMENT 'Query text',
  `num_results` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Num results',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `redirect` varchar(255) DEFAULT NULL COMMENT 'Redirect',
  `synonym_for` varchar(255) DEFAULT NULL COMMENT 'Synonym for',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `display_in_terms` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Display in terms',
  `is_active` smallint(6) DEFAULT '1' COMMENT 'Active status',
  `is_processed` smallint(6) DEFAULT '0' COMMENT 'Processed status',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated at',
  PRIMARY KEY (`query_id`),
  KEY `IDX_CATALOGSEARCH_QUERY_QUERY_TEXT_STORE_ID_POPULARITY` (`query_text`,`store_id`,`popularity`),
  KEY `IDX_CATALOGSEARCH_QUERY_STORE_ID` (`store_id`),
  KEY `IDX_CATALOGSEARCH_QUERY_SYNONYM_FOR` (`synonym_for`),
  CONSTRAINT `FK_CATALOGSEARCH_QUERY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog search query table';

-- ----------------------------
-- Records of catalogsearch_query
-- ----------------------------

-- ----------------------------
-- Table structure for catalogsearch_result
-- ----------------------------
DROP TABLE IF EXISTS `catalogsearch_result`;
CREATE TABLE `catalogsearch_result` (
  `query_id` int(10) unsigned NOT NULL COMMENT 'Query ID',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `relevance` decimal(20,4) NOT NULL DEFAULT '0.0000' COMMENT 'Relevance',
  PRIMARY KEY (`query_id`,`product_id`),
  KEY `IDX_CATALOGSEARCH_RESULT_QUERY_ID` (`query_id`),
  KEY `IDX_CATALOGSEARCH_RESULT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CATALOGSEARCH_RESULT_QUERY_ID_CATALOGSEARCH_QUERY_QUERY_ID` FOREIGN KEY (`query_id`) REFERENCES `catalogsearch_query` (`query_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATSRCH_RESULT_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog search result table';

-- ----------------------------
-- Records of catalogsearch_result
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_category_anc_categs_index_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_anc_categs_index_idx`;
CREATE TABLE `catalog_category_anc_categs_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_IDX_CATEGORY_ID` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Indexer Index Table';

-- ----------------------------
-- Records of catalog_category_anc_categs_index_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_category_anc_categs_index_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_anc_categs_index_tmp`;
CREATE TABLE `catalog_category_anc_categs_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_TMP_CATEGORY_ID` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Indexer Temp Table';

-- ----------------------------
-- Records of catalog_category_anc_categs_index_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_category_anc_products_index_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_anc_products_index_idx`;
CREATE TABLE `catalog_category_anc_products_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Product Indexer Index Table';

-- ----------------------------
-- Records of catalog_category_anc_products_index_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_category_anc_products_index_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_anc_products_index_tmp`;
CREATE TABLE `catalog_category_anc_products_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Product Indexer Temp Table';

-- ----------------------------
-- Records of catalog_category_anc_products_index_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_category_entity
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_entity`;
CREATE TABLE `catalog_category_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attriute Set ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Category ID',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  `path` varchar(255) NOT NULL COMMENT 'Tree Path',
  `position` int(11) NOT NULL COMMENT 'Position',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT 'Tree Level',
  `children_count` int(11) NOT NULL COMMENT 'Child Count',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_LEVEL` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Table';

-- ----------------------------
-- Records of catalog_category_entity
-- ----------------------------
INSERT INTO `catalog_category_entity` VALUES ('1', '3', '0', '0', '2015-08-06 05:57:03', '2015-08-06 05:57:03', '1', '0', '0', '1');
INSERT INTO `catalog_category_entity` VALUES ('2', '3', '3', '1', '2015-08-06 05:57:05', '2015-08-06 05:57:05', '1/2', '1', '1', '0');

-- ----------------------------
-- Table structure for catalog_category_entity_datetime
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_entity_datetime`;
CREATE TABLE `catalog_category_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_DTIME_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_DTIME_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Datetime Attribute Backend Table';

-- ----------------------------
-- Records of catalog_category_entity_datetime
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_category_entity_decimal
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_entity_decimal`;
CREATE TABLE `catalog_category_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_DEC_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_DEC_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Decimal Attribute Backend Table';

-- ----------------------------
-- Records of catalog_category_entity_decimal
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_category_entity_int
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_entity_int`;
CREATE TABLE `catalog_category_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_INT_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_INT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_INT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_INT_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Integer Attribute Backend Table';

-- ----------------------------
-- Records of catalog_category_entity_int
-- ----------------------------
INSERT INTO `catalog_category_entity_int` VALUES ('1', '3', '67', '0', '1', '1');
INSERT INTO `catalog_category_entity_int` VALUES ('2', '3', '67', '1', '1', '1');
INSERT INTO `catalog_category_entity_int` VALUES ('3', '3', '42', '0', '2', '1');
INSERT INTO `catalog_category_entity_int` VALUES ('4', '3', '67', '0', '2', '1');
INSERT INTO `catalog_category_entity_int` VALUES ('5', '3', '42', '1', '2', '1');
INSERT INTO `catalog_category_entity_int` VALUES ('6', '3', '67', '1', '2', '1');

-- ----------------------------
-- Table structure for catalog_category_entity_text
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_entity_text`;
CREATE TABLE `catalog_category_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_TEXT_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_TEXT_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Text Attribute Backend Table';

-- ----------------------------
-- Records of catalog_category_entity_text
-- ----------------------------
INSERT INTO `catalog_category_entity_text` VALUES ('1', '3', '65', '0', '1', null);
INSERT INTO `catalog_category_entity_text` VALUES ('2', '3', '65', '1', '1', null);
INSERT INTO `catalog_category_entity_text` VALUES ('3', '3', '65', '0', '2', null);
INSERT INTO `catalog_category_entity_text` VALUES ('4', '3', '65', '1', '2', null);

-- ----------------------------
-- Table structure for catalog_category_entity_varchar
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_entity_varchar`;
CREATE TABLE `catalog_category_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_VCHR_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_VCHR_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Varchar Attribute Backend Table';

-- ----------------------------
-- Records of catalog_category_entity_varchar
-- ----------------------------
INSERT INTO `catalog_category_entity_varchar` VALUES ('1', '3', '41', '0', '1', 'Root Catalog');
INSERT INTO `catalog_category_entity_varchar` VALUES ('2', '3', '41', '1', '1', 'Root Catalog');
INSERT INTO `catalog_category_entity_varchar` VALUES ('3', '3', '43', '1', '1', 'root-catalog');
INSERT INTO `catalog_category_entity_varchar` VALUES ('4', '3', '41', '0', '2', 'Default Category');
INSERT INTO `catalog_category_entity_varchar` VALUES ('5', '3', '41', '1', '2', 'Default Category');
INSERT INTO `catalog_category_entity_varchar` VALUES ('6', '3', '49', '1', '2', 'PRODUCTS');
INSERT INTO `catalog_category_entity_varchar` VALUES ('7', '3', '43', '1', '2', 'default-category');

-- ----------------------------
-- Table structure for catalog_category_product
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_product`;
CREATE TABLE `catalog_category_product` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`category_id`,`product_id`),
  KEY `IDX_CATALOG_CATEGORY_PRODUCT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_CTGR_PRD_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_PRD_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Category Linkage Table';

-- ----------------------------
-- Records of catalog_category_product
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_category_product_index
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_product_index`;
CREATE TABLE `catalog_category_product_index` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  PRIMARY KEY (`category_id`,`product_id`,`store_id`),
  KEY `IDX_CAT_CTGR_PRD_IDX_PRD_ID_STORE_ID_CTGR_ID_VISIBILITY` (`product_id`,`store_id`,`category_id`,`visibility`),
  KEY `15D3C269665C74C2219037D534F4B0DC` (`store_id`,`category_id`,`visibility`,`is_parent`,`position`),
  CONSTRAINT `FK_CATALOG_CATEGORY_PRODUCT_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_PRD_IDX_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Index';

-- ----------------------------
-- Records of catalog_category_product_index
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_category_product_index_enbl_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_product_index_enbl_idx`;
CREATE TABLE `catalog_category_product_index_enbl_idx` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `visibility` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  KEY `IDX_CATALOG_CATEGORY_PRODUCT_INDEX_ENBL_IDX_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Enabled Indexer Index Table';

-- ----------------------------
-- Records of catalog_category_product_index_enbl_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_category_product_index_enbl_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_product_index_enbl_tmp`;
CREATE TABLE `catalog_category_product_index_enbl_tmp` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `visibility` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  KEY `IDX_CATALOG_CATEGORY_PRODUCT_INDEX_ENBL_TMP_PRODUCT_ID` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Enabled Indexer Temp Table';

-- ----------------------------
-- Records of catalog_category_product_index_enbl_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_category_product_index_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_product_index_idx`;
CREATE TABLE `catalog_category_product_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  KEY `IDX_CAT_CTGR_PRD_IDX_IDX_PRD_ID_CTGR_ID_STORE_ID` (`product_id`,`category_id`,`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Indexer Index Table';

-- ----------------------------
-- Records of catalog_category_product_index_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_category_product_index_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_category_product_index_tmp`;
CREATE TABLE `catalog_category_product_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Indexer Temp Table';

-- ----------------------------
-- Records of catalog_category_product_index_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_compare_item
-- ----------------------------
DROP TABLE IF EXISTS `catalog_compare_item`;
CREATE TABLE `catalog_compare_item` (
  `catalog_compare_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Compare Item ID',
  `visitor_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`catalog_compare_item_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_COMPARE_ITEM_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_COMPARE_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CMP_ITEM_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Compare Table';

-- ----------------------------
-- Records of catalog_compare_item
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_eav_attribute
-- ----------------------------
DROP TABLE IF EXISTS `catalog_eav_attribute`;
CREATE TABLE `catalog_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `frontend_input_renderer` varchar(255) DEFAULT NULL COMMENT 'Frontend Input Renderer',
  `is_global` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Global',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `is_searchable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Searchable',
  `is_filterable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable',
  `is_comparable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Comparable',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `is_html_allowed_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is HTML Allowed On Front',
  `is_used_for_price_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Price Rules',
  `is_filterable_in_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable In Search',
  `used_in_product_listing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used In Product Listing',
  `used_for_sort_by` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Sorting',
  `is_configurable` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Configurable',
  `apply_to` varchar(255) DEFAULT NULL COMMENT 'Apply To',
  `is_visible_in_advanced_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible In Advanced Search',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_wysiwyg_enabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is WYSIWYG Enabled',
  `is_used_for_promo_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Promo Rules',
  PRIMARY KEY (`attribute_id`),
  KEY `IDX_CATALOG_EAV_ATTRIBUTE_USED_FOR_SORT_BY` (`used_for_sort_by`),
  KEY `IDX_CATALOG_EAV_ATTRIBUTE_USED_IN_PRODUCT_LISTING` (`used_in_product_listing`),
  CONSTRAINT `FK_CATALOG_EAV_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog EAV Attribute Table';

-- ----------------------------
-- Records of catalog_eav_attribute
-- ----------------------------
INSERT INTO `catalog_eav_attribute` VALUES ('41', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('42', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('43', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('44', null, '0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '0', '1', null, '0', '0', '1', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('45', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('46', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('47', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('48', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('49', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('50', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('51', null, '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('52', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('53', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('54', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('55', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('56', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('57', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('58', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('59', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('60', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('61', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('62', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('63', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('64', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('65', 'adminhtml/catalog_category_helper_sortby_available', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('66', 'adminhtml/catalog_category_helper_sortby_default', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('67', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('68', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('69', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('70', 'adminhtml/catalog_category_helper_pricestep', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('71', null, '0', '1', '1', '0', '0', '0', '0', '0', '0', '1', '1', '1', null, '1', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('72', null, '0', '1', '1', '0', '1', '0', '1', '0', '0', '0', '0', '1', null, '1', '0', '1', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('73', null, '0', '1', '1', '0', '1', '0', '1', '0', '0', '1', '0', '1', null, '1', '0', '1', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('74', null, '1', '1', '1', '0', '1', '0', '0', '0', '0', '0', '0', '1', null, '1', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('75', null, '2', '1', '1', '1', '0', '0', '0', '0', '0', '1', '1', '1', 'simple,configurable,virtual,bundle,downloadable', '1', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('76', null, '2', '1', '0', '0', '0', '0', '0', '0', '0', '1', '0', '1', 'simple,configurable,virtual,bundle,downloadable', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('77', null, '2', '1', '0', '0', '0', '0', '0', '0', '0', '1', '0', '1', 'simple,configurable,virtual,bundle,downloadable', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('78', null, '2', '1', '0', '0', '0', '0', '0', '0', '0', '1', '0', '1', 'simple,configurable,virtual,bundle,downloadable', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('79', null, '2', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', 'virtual,downloadable', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('80', null, '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', 'simple,bundle', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('81', null, '1', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1', 'simple', '1', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('82', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('83', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('84', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('85', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('86', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '1', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('87', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '1', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('88', null, '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('89', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('90', null, '2', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', 'simple,configurable,virtual,bundle,downloadable', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('91', null, '2', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', 'simple,configurable,virtual,bundle,downloadable', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('92', null, '1', '1', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1', 'simple', '1', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('93', null, '2', '1', '0', '0', '0', '0', '0', '0', '0', '1', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('94', null, '2', '1', '0', '0', '0', '0', '0', '0', '0', '1', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('95', null, '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('96', null, '2', '1', '1', '0', '0', '0', '0', '0', '0', '1', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('97', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '1', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('98', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('99', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', 'simple,configurable,virtual,bundle,downloadable', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('100', null, '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'simple,virtual', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('101', null, '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'simple,virtual', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('102', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('103', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('104', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('105', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('106', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('107', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('108', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('109', null, '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('110', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('111', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('112', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('113', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('114', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('115', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('116', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('117', null, '2', '1', '1', '0', '0', '0', '0', '0', '0', '1', '0', '1', 'simple,configurable,virtual,downloadable,bundle', '1', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('118', 'giftmessage/adminhtml_product_helper_form_config', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', null, '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('119', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', 'bundle', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('120', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'bundle', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('121', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', 'bundle', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('122', null, '1', '1', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', 'bundle', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('123', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', 'bundle', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('124', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', 'downloadable', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('125', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'downloadable', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('126', null, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'downloadable', '0', '0', '0', '0');
INSERT INTO `catalog_eav_attribute` VALUES ('127', null, '1', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', 'downloadable', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for catalog_product_bundle_option
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_bundle_option`;
CREATE TABLE `catalog_product_bundle_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `type` varchar(255) DEFAULT NULL COMMENT 'Type',
  PRIMARY KEY (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_OPTION_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_OPT_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option';

-- ----------------------------
-- Records of catalog_product_bundle_option
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_bundle_option_value
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_bundle_option_value`;
CREATE TABLE `catalog_product_bundle_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_BUNDLE_OPTION_VALUE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_OPT_VAL_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option Value';

-- ----------------------------
-- Records of catalog_product_bundle_option_value
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_bundle_price_index
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_bundle_price_index`;
CREATE TABLE `catalog_product_bundle_price_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `min_price` decimal(12,4) NOT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) NOT NULL COMMENT 'Max Price',
  PRIMARY KEY (`entity_id`,`website_id`,`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_PRICE_IDX_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_BNDL_PRICE_IDX_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_BNDL_PRICE_IDX_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Price Index';

-- ----------------------------
-- Records of catalog_product_bundle_price_index
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_bundle_selection
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_bundle_selection`;
CREATE TABLE `catalog_product_bundle_selection` (
  `selection_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Selection Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `parent_product_id` int(10) unsigned NOT NULL COMMENT 'Parent Product Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  `selection_qty` decimal(12,4) DEFAULT NULL COMMENT 'Selection Qty',
  `selection_can_change_qty` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Selection Can Change Qty',
  PRIMARY KEY (`selection_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_SELECTION_OPTION_ID` (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_SELECTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_SELECTION_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_BNDL_SELECTION_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection';

-- ----------------------------
-- Records of catalog_product_bundle_selection
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_bundle_selection_price
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_bundle_selection_price`;
CREATE TABLE `catalog_product_bundle_selection_price` (
  `selection_id` int(10) unsigned NOT NULL COMMENT 'Selection Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  PRIMARY KEY (`selection_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_SELECTION_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_SELECTION_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DCF37523AA05D770A70AA4ED7C2616E4` FOREIGN KEY (`selection_id`) REFERENCES `catalog_product_bundle_selection` (`selection_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection Price';

-- ----------------------------
-- Records of catalog_product_bundle_selection_price
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_bundle_stock_index
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_bundle_stock_index`;
CREATE TABLE `catalog_product_bundle_stock_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `stock_status` smallint(6) DEFAULT '0' COMMENT 'Stock Status',
  PRIMARY KEY (`entity_id`,`website_id`,`stock_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Stock Index';

-- ----------------------------
-- Records of catalog_product_bundle_stock_index
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_enabled_index
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_enabled_index`;
CREATE TABLE `catalog_product_enabled_index` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  PRIMARY KEY (`product_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENABLED_INDEX_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENABLED_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENABLED_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Visibility Index Table';

-- ----------------------------
-- Records of catalog_product_enabled_index
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_entity
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_entity`;
CREATE TABLE `catalog_product_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set ID',
  `type_id` varchar(32) NOT NULL DEFAULT 'simple' COMMENT 'Type ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `has_options` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Has Options',
  `required_options` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required Options',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_ATTRIBUTE_SET_ID` (`attribute_set_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_SKU` (`sku`),
  CONSTRAINT `FK_CAT_PRD_ENTT_ATTR_SET_ID_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Table';

-- ----------------------------
-- Records of catalog_product_entity
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_entity_datetime
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_entity_datetime`;
CREATE TABLE `catalog_product_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_DTIME_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_DTIME_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Datetime Attribute Backend Table';

-- ----------------------------
-- Records of catalog_product_entity_datetime
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_entity_decimal
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_entity_decimal`;
CREATE TABLE `catalog_product_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_DEC_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_DEC_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Decimal Attribute Backend Table';

-- ----------------------------
-- Records of catalog_product_entity_decimal
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_entity_gallery
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_entity_gallery`;
CREATE TABLE `catalog_product_entity_gallery` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_GLR_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_GLR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_GLR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Gallery Attribute Backend Table';

-- ----------------------------
-- Records of catalog_product_entity_gallery
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_entity_int
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_entity_int`;
CREATE TABLE `catalog_product_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_INT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_INT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Integer Attribute Backend Table';

-- ----------------------------
-- Records of catalog_product_entity_int
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_entity_media_gallery
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_entity_media_gallery`;
CREATE TABLE `catalog_product_entity_media_gallery` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Backend Table';

-- ----------------------------
-- Records of catalog_product_entity_media_gallery
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_entity_media_gallery_value
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_entity_media_gallery_value`;
CREATE TABLE `catalog_product_entity_media_gallery_value` (
  `value_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Value ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  `disabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Disabled',
  PRIMARY KEY (`value_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_VAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_VAL_VAL_ID_CAT_PRD_ENTT_MDA_GLR_VAL_ID` FOREIGN KEY (`value_id`) REFERENCES `catalog_product_entity_media_gallery` (`value_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Value Table';

-- ----------------------------
-- Records of catalog_product_entity_media_gallery_value
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_entity_text
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_entity_text`;
CREATE TABLE `catalog_product_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_TEXT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Text Attribute Backend Table';

-- ----------------------------
-- Records of catalog_product_entity_text
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_entity_tier_price
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_entity_tier_price`;
CREATE TABLE `catalog_product_entity_tier_price` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `all_groups` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Applicable To All Customer Groups',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'QTY',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `E8AB433B9ACB00343ABB312AD2FAB087` (`entity_id`,`all_groups`,`customer_group_id`,`qty`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TIER_PRICE_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_6E08D719F0501DD1D8E6D4EFF2511C85` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_TIER_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_TIER_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Attribute Backend Table';

-- ----------------------------
-- Records of catalog_product_entity_tier_price
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_entity_varchar
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_entity_varchar`;
CREATE TABLE `catalog_product_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_VCHR_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_VCHR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Varchar Attribute Backend Table';

-- ----------------------------
-- Records of catalog_product_entity_varchar
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_eav
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_eav`;
CREATE TABLE `catalog_product_index_eav` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_VALUE` (`value`),
  CONSTRAINT `FK_CATALOG_PRODUCT_INDEX_EAV_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Index Table';

-- ----------------------------
-- Records of catalog_product_index_eav
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_eav_decimal
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_eav_decimal`;
CREATE TABLE `catalog_product_index_eav_decimal` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_VALUE` (`value`),
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_DEC_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_DEC_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Index Table';

-- ----------------------------
-- Records of catalog_product_index_eav_decimal
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_eav_decimal_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_eav_decimal_idx`;
CREATE TABLE `catalog_product_index_eav_decimal_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Index Table';

-- ----------------------------
-- Records of catalog_product_index_eav_decimal_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_eav_decimal_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_eav_decimal_tmp`;
CREATE TABLE `catalog_product_index_eav_decimal_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Temp Table';

-- ----------------------------
-- Records of catalog_product_index_eav_decimal_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_eav_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_eav_idx`;
CREATE TABLE `catalog_product_index_eav_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Index Table';

-- ----------------------------
-- Records of catalog_product_index_eav_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_eav_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_eav_tmp`;
CREATE TABLE `catalog_product_index_eav_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Temp Table';

-- ----------------------------
-- Records of catalog_product_index_eav_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price`;
CREATE TABLE `catalog_product_index_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_MIN_PRICE` (`min_price`),
  CONSTRAINT `FK_CAT_PRD_IDX_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Index Table';

-- ----------------------------
-- Records of catalog_product_index_price
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_bundle_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_bundle_idx`;
CREATE TABLE `catalog_product_index_price_bundle_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  `group_price_percent` decimal(12,4) DEFAULT NULL COMMENT 'Group Price Percent',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Idx';

-- ----------------------------
-- Records of catalog_product_index_price_bundle_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_bundle_opt_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_bundle_opt_idx`;
CREATE TABLE `catalog_product_index_price_bundle_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `alt_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Idx';

-- ----------------------------
-- Records of catalog_product_index_price_bundle_opt_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_bundle_opt_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_bundle_opt_tmp`;
CREATE TABLE `catalog_product_index_price_bundle_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `alt_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Tmp';

-- ----------------------------
-- Records of catalog_product_index_price_bundle_opt_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_bundle_sel_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_bundle_sel_idx`;
CREATE TABLE `catalog_product_index_price_bundle_sel_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Idx';

-- ----------------------------
-- Records of catalog_product_index_price_bundle_sel_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_bundle_sel_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_bundle_sel_tmp`;
CREATE TABLE `catalog_product_index_price_bundle_sel_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Tmp';

-- ----------------------------
-- Records of catalog_product_index_price_bundle_sel_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_bundle_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_bundle_tmp`;
CREATE TABLE `catalog_product_index_price_bundle_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  `group_price_percent` decimal(12,4) DEFAULT NULL COMMENT 'Group Price Percent',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Tmp';

-- ----------------------------
-- Records of catalog_product_index_price_bundle_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_cfg_opt_agr_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_agr_idx`;
CREATE TABLE `catalog_product_index_price_cfg_opt_agr_idx` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Index Table';

-- ----------------------------
-- Records of catalog_product_index_price_cfg_opt_agr_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_cfg_opt_agr_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_agr_tmp`;
CREATE TABLE `catalog_product_index_price_cfg_opt_agr_tmp` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Temp Table';

-- ----------------------------
-- Records of catalog_product_index_price_cfg_opt_agr_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_cfg_opt_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_idx`;
CREATE TABLE `catalog_product_index_price_cfg_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Index Table';

-- ----------------------------
-- Records of catalog_product_index_price_cfg_opt_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_cfg_opt_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_tmp`;
CREATE TABLE `catalog_product_index_price_cfg_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Temp Table';

-- ----------------------------
-- Records of catalog_product_index_price_cfg_opt_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_downlod_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_downlod_idx`;
CREATE TABLE `catalog_product_index_price_downlod_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indexer Table for price of downloadable products';

-- ----------------------------
-- Records of catalog_product_index_price_downlod_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_downlod_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_downlod_tmp`;
CREATE TABLE `catalog_product_index_price_downlod_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Temporary Indexer Table for price of downloadable products';

-- ----------------------------
-- Records of catalog_product_index_price_downlod_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_final_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_final_idx`;
CREATE TABLE `catalog_product_index_price_final_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Index Table';

-- ----------------------------
-- Records of catalog_product_index_price_final_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_final_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_final_tmp`;
CREATE TABLE `catalog_product_index_price_final_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Temp Table';

-- ----------------------------
-- Records of catalog_product_index_price_final_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_idx`;
CREATE TABLE `catalog_product_index_price_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_IDX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_IDX_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_IDX_MIN_PRICE` (`min_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Index Table';

-- ----------------------------
-- Records of catalog_product_index_price_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_opt_agr_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_opt_agr_idx`;
CREATE TABLE `catalog_product_index_price_opt_agr_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Index Table';

-- ----------------------------
-- Records of catalog_product_index_price_opt_agr_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_opt_agr_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_opt_agr_tmp`;
CREATE TABLE `catalog_product_index_price_opt_agr_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Temp Table';

-- ----------------------------
-- Records of catalog_product_index_price_opt_agr_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_opt_idx
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_opt_idx`;
CREATE TABLE `catalog_product_index_price_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Index Table';

-- ----------------------------
-- Records of catalog_product_index_price_opt_idx
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_opt_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_opt_tmp`;
CREATE TABLE `catalog_product_index_price_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Temp Table';

-- ----------------------------
-- Records of catalog_product_index_price_opt_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_price_tmp
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_price_tmp`;
CREATE TABLE `catalog_product_index_price_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_TMP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_TMP_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_TMP_MIN_PRICE` (`min_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Temp Table';

-- ----------------------------
-- Records of catalog_product_index_price_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_tier_price
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_tier_price`;
CREATE TABLE `catalog_product_index_tier_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CAT_PRD_IDX_TIER_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_TIER_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_TIER_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Index Table';

-- ----------------------------
-- Records of catalog_product_index_tier_price
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_index_website
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_index_website`;
CREATE TABLE `catalog_product_index_website` (
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `website_date` date DEFAULT NULL COMMENT 'Website Date',
  `rate` float DEFAULT '1' COMMENT 'Rate',
  PRIMARY KEY (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_WEBSITE_WEBSITE_DATE` (`website_date`),
  CONSTRAINT `FK_CAT_PRD_IDX_WS_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Website Index Table';

-- ----------------------------
-- Records of catalog_product_index_website
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_link
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_link`;
CREATE TABLE `catalog_product_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `linked_product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Linked Product ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_LNK_TYPE_ID_PRD_ID_LNKED_PRD_ID` (`link_type_id`,`product_id`,`linked_product_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_PRODUCT_ID` (`product_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_LINKED_PRODUCT_ID` (`linked_product_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_LINK_TYPE_ID` (`link_type_id`),
  CONSTRAINT `FK_CAT_PRD_LNK_LNKED_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`linked_product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_LNK_LNK_TYPE_ID_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_LNK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Product Linkage Table';

-- ----------------------------
-- Records of catalog_product_link
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_link_attribute
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_link_attribute`;
CREATE TABLE `catalog_product_link_attribute` (
  `product_link_attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Link Attribute ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  `product_link_attribute_code` varchar(32) DEFAULT NULL COMMENT 'Product Link Attribute Code',
  `data_type` varchar(32) DEFAULT NULL COMMENT 'Data Type',
  PRIMARY KEY (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_LINK_TYPE_ID` (`link_type_id`),
  CONSTRAINT `FK_CAT_PRD_LNK_ATTR_LNK_TYPE_ID_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Attribute Table';

-- ----------------------------
-- Records of catalog_product_link_attribute
-- ----------------------------
INSERT INTO `catalog_product_link_attribute` VALUES ('1', '1', 'position', 'int');
INSERT INTO `catalog_product_link_attribute` VALUES ('2', '3', 'position', 'int');
INSERT INTO `catalog_product_link_attribute` VALUES ('3', '3', 'qty', 'decimal');
INSERT INTO `catalog_product_link_attribute` VALUES ('4', '4', 'position', 'int');
INSERT INTO `catalog_product_link_attribute` VALUES ('5', '5', 'position', 'int');

-- ----------------------------
-- Table structure for catalog_product_link_attribute_decimal
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_link_attribute_decimal`;
CREATE TABLE `catalog_product_link_attribute_decimal` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_DECIMAL_LINK_ID` (`link_id`),
  CONSTRAINT `FK_AB2EFA9A14F7BCF1D5400056203D14B6` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_LNK_ATTR_DEC_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Decimal Attribute Table';

-- ----------------------------
-- Records of catalog_product_link_attribute_decimal
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_link_attribute_int
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_link_attribute_int`;
CREATE TABLE `catalog_product_link_attribute_int` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_ATTR_INT_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_INT_PRODUCT_LINK_ATTRIBUTE_ID` (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_INT_LINK_ID` (`link_id`),
  CONSTRAINT `FK_CAT_PRD_LNK_ATTR_INT_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_D6D878F8BA2A4282F8DDED7E6E3DE35C` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Integer Attribute Table';

-- ----------------------------
-- Records of catalog_product_link_attribute_int
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_link_attribute_varchar
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_link_attribute_varchar`;
CREATE TABLE `catalog_product_link_attribute_varchar` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_VARCHAR_LINK_ID` (`link_id`),
  CONSTRAINT `FK_CAT_PRD_LNK_ATTR_VCHR_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DEE9C4DA61CFCC01DFCF50F0D79CEA51` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Varchar Attribute Table';

-- ----------------------------
-- Records of catalog_product_link_attribute_varchar
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_link_type
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_link_type`;
CREATE TABLE `catalog_product_link_type` (
  `link_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Type ID',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  PRIMARY KEY (`link_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Type Table';

-- ----------------------------
-- Records of catalog_product_link_type
-- ----------------------------
INSERT INTO `catalog_product_link_type` VALUES ('1', 'relation');
INSERT INTO `catalog_product_link_type` VALUES ('3', 'super');
INSERT INTO `catalog_product_link_type` VALUES ('4', 'up_sell');
INSERT INTO `catalog_product_link_type` VALUES ('5', 'cross_sell');

-- ----------------------------
-- Table structure for catalog_product_option
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_option`;
CREATE TABLE `catalog_product_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `type` varchar(50) DEFAULT NULL COMMENT 'Type',
  `is_require` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Required',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `max_characters` int(10) unsigned DEFAULT NULL COMMENT 'Max Characters',
  `file_extension` varchar(50) DEFAULT NULL COMMENT 'File Extension',
  `image_size_x` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size X',
  `image_size_y` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size Y',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_PRD_OPT_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Table';

-- ----------------------------
-- Records of catalog_product_option
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_option_price
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_option_price`;
CREATE TABLE `catalog_product_option_price` (
  `option_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Price ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_price_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID` (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_OPTION_PRICE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_OPT_PRICE_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Price Table';

-- ----------------------------
-- Records of catalog_product_option_price
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_option_title
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_option_title`;
CREATE TABLE `catalog_product_option_title` (
  `option_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Title ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_title_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID` (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_OPTION_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_OPT_TTL_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Title Table';

-- ----------------------------
-- Records of catalog_product_option_title
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_option_type_price
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_option_type_price`;
CREATE TABLE `catalog_product_option_type_price` (
  `option_type_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Price ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_type_price_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_TYPE_PRICE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_PRICE_OPTION_TYPE_ID` (`option_type_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_B523E3378E8602F376CC415825576B7F` FOREIGN KEY (`option_type_id`) REFERENCES `catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_OPT_TYPE_PRICE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Price Table';

-- ----------------------------
-- Records of catalog_product_option_type_price
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_option_type_title
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_option_type_title`;
CREATE TABLE `catalog_product_option_type_title` (
  `option_type_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Title ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_type_title_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_TYPE_TITLE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_TITLE_OPTION_TYPE_ID` (`option_type_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_C085B9CF2C2A302E8043FDEA1937D6A2` FOREIGN KEY (`option_type_id`) REFERENCES `catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_OPT_TYPE_TTL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Title Table';

-- ----------------------------
-- Records of catalog_product_option_type_title
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_option_type_value
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_option_type_value`;
CREATE TABLE `catalog_product_option_type_value` (
  `option_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_type_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_VALUE_OPTION_ID` (`option_id`),
  CONSTRAINT `FK_CAT_PRD_OPT_TYPE_VAL_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Value Table';

-- ----------------------------
-- Records of catalog_product_option_type_value
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_relation
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_relation`;
CREATE TABLE `catalog_product_relation` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  PRIMARY KEY (`parent_id`,`child_id`),
  KEY `IDX_CATALOG_PRODUCT_RELATION_CHILD_ID` (`child_id`),
  CONSTRAINT `FK_CAT_PRD_RELATION_CHILD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`child_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_RELATION_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Relation Table';

-- ----------------------------
-- Records of catalog_product_relation
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_super_attribute
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_super_attribute`;
CREATE TABLE `catalog_product_super_attribute` (
  `product_super_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Super Attribute ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`product_super_attribute_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID_ATTRIBUTE_ID` (`product_id`,`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_PRD_SPR_ATTR_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Table';

-- ----------------------------
-- Records of catalog_product_super_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_super_attribute_label
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_super_attribute_label`;
CREATE TABLE `catalog_product_super_attribute_label` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `use_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Use Default Value',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID_STORE_ID` (`product_super_attribute_id`,`store_id`),
  KEY `IDX_CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID` (`product_super_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_309442281DF7784210ED82B2CC51E5D5` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_SPR_ATTR_LBL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Label Table';

-- ----------------------------
-- Records of catalog_product_super_attribute_label
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_super_attribute_pricing
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_super_attribute_pricing`;
CREATE TABLE `catalog_product_super_attribute_pricing` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `value_index` varchar(255) DEFAULT NULL COMMENT 'Value Index',
  `is_percent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Percent',
  `pricing_value` decimal(12,4) DEFAULT NULL COMMENT 'Pricing Value',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_SPR_ATTR_PRICING_PRD_SPR_ATTR_ID_VAL_IDX_WS_ID` (`product_super_attribute_id`,`value_index`,`website_id`),
  KEY `IDX_CAT_PRD_SPR_ATTR_PRICING_PRD_SPR_ATTR_ID` (`product_super_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRICING_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CAT_PRD_SPR_ATTR_PRICING_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CDE8813117106CFAA3AD209358F66332` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Pricing Table';

-- ----------------------------
-- Records of catalog_product_super_attribute_pricing
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_super_link
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_super_link`;
CREATE TABLE `catalog_product_super_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID_PARENT_ID` (`product_id`,`parent_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_LINK_PARENT_ID` (`parent_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_PRD_SPR_LNK_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_SPR_LNK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Link Table';

-- ----------------------------
-- Records of catalog_product_super_link
-- ----------------------------

-- ----------------------------
-- Table structure for catalog_product_website
-- ----------------------------
DROP TABLE IF EXISTS `catalog_product_website`;
CREATE TABLE `catalog_product_website` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`product_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_WS_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Website Linkage Table';

-- ----------------------------
-- Records of catalog_product_website
-- ----------------------------

-- ----------------------------
-- Table structure for checkout_agreement
-- ----------------------------
DROP TABLE IF EXISTS `checkout_agreement`;
CREATE TABLE `checkout_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `content` text COMMENT 'Content',
  `content_height` varchar(25) DEFAULT NULL COMMENT 'Content Height',
  `checkbox_text` text COMMENT 'Checkbox Text',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `is_html` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Html',
  PRIMARY KEY (`agreement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement';

-- ----------------------------
-- Records of checkout_agreement
-- ----------------------------

-- ----------------------------
-- Table structure for checkout_agreement_store
-- ----------------------------
DROP TABLE IF EXISTS `checkout_agreement_store`;
CREATE TABLE `checkout_agreement_store` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`agreement_id`,`store_id`),
  KEY `FK_CHECKOUT_AGREEMENT_STORE_STORE_ID_CORE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CHECKOUT_AGREEMENT_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CHKT_AGRT_STORE_AGRT_ID_CHKT_AGRT_AGRT_ID` FOREIGN KEY (`agreement_id`) REFERENCES `checkout_agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement Store';

-- ----------------------------
-- Records of checkout_agreement_store
-- ----------------------------

-- ----------------------------
-- Table structure for cms_block
-- ----------------------------
DROP TABLE IF EXISTS `cms_block`;
CREATE TABLE `cms_block` (
  `block_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Block ID',
  `title` varchar(255) NOT NULL COMMENT 'Block Title',
  `identifier` varchar(255) NOT NULL COMMENT 'Block String Identifier',
  `content` mediumtext COMMENT 'Block Content',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Block Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Block Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Block Active',
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='CMS Block Table';

-- ----------------------------
-- Records of cms_block
-- ----------------------------
INSERT INTO `cms_block` VALUES ('1', 'Footer Links', 'footer_links', '\n<ul>\n    <li><a href=\"{{store direct_url=\"about-magento-demo-store\"}}\">About Us</a></li>\n    <li><a href=\"{{store direct_url=\"customer-service\"}}\">Customer Service</a></li>\n<li class=\"last privacy\"><a href=\"{{store direct_url=\"privacy-policy-cookie-restriction-mode\"}}\">Privacy Policy</a></li>\r\n</ul>', '2015-08-06 05:56:54', '2015-08-06 05:56:55', '1');
INSERT INTO `cms_block` VALUES ('2', 'Footer Links Company', 'footer_links_company', '\n<div class=\"links\">\n    <div class=\"block-title\">\n        <strong><span>Company</span></strong>\n    </div>\n    <ul>\n        <li><a href=\"{{store url=\"\"}}about-magento-demo-store/\">About Us</a></li>\n        <li><a href=\"{{store url=\"\"}}contacts/\">Contact Us</a></li>\n        <li><a href=\"{{store url=\"\"}}customer-service/\">Customer Service</a></li>\n        <li><a href=\"{{store url=\"\"}}privacy-policy-cookie-restriction-mode/\">Privacy Policy</a></li>\n    </ul>\n</div>', '2015-08-06 05:56:54', '2015-08-06 05:56:54', '1');
INSERT INTO `cms_block` VALUES ('3', 'Cookie restriction notice', 'cookie_restriction_notice_block', '<p>This website requires cookies to provide all of its features. For more information on what data is contained in the cookies, please see our <a href=\"{{store direct_url=\"privacy-policy-cookie-restriction-mode\"}}\">Privacy Policy page</a>. To accept cookies from this site, please click the Allow button below.</p>', '2015-08-06 05:56:55', '2015-08-06 05:56:55', '1');

-- ----------------------------
-- Table structure for cms_block_store
-- ----------------------------
DROP TABLE IF EXISTS `cms_block_store`;
CREATE TABLE `cms_block_store` (
  `block_id` smallint(6) NOT NULL COMMENT 'Block ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`block_id`,`store_id`),
  KEY `IDX_CMS_BLOCK_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CMS_BLOCK_STORE_BLOCK_ID_CMS_BLOCK_BLOCK_ID` FOREIGN KEY (`block_id`) REFERENCES `cms_block` (`block_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CMS_BLOCK_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Block To Store Linkage Table';

-- ----------------------------
-- Records of cms_block_store
-- ----------------------------
INSERT INTO `cms_block_store` VALUES ('1', '0');
INSERT INTO `cms_block_store` VALUES ('2', '0');
INSERT INTO `cms_block_store` VALUES ('3', '0');

-- ----------------------------
-- Table structure for cms_page
-- ----------------------------
DROP TABLE IF EXISTS `cms_page`;
CREATE TABLE `cms_page` (
  `page_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Page ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Page Title',
  `root_template` varchar(255) DEFAULT NULL COMMENT 'Page Template',
  `meta_keywords` text COMMENT 'Page Meta Keywords',
  `meta_description` text COMMENT 'Page Meta Description',
  `identifier` varchar(100) DEFAULT NULL COMMENT 'Page String Identifier',
  `content_heading` varchar(255) DEFAULT NULL COMMENT 'Page Content Heading',
  `content` mediumtext COMMENT 'Page Content',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Page Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Page Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Page Active',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Page Sort Order',
  `layout_update_xml` text COMMENT 'Page Layout Update Content',
  `custom_theme` varchar(100) DEFAULT NULL COMMENT 'Page Custom Theme',
  `custom_root_template` varchar(255) DEFAULT NULL COMMENT 'Page Custom Template',
  `custom_layout_update_xml` text COMMENT 'Page Custom Layout Update Content',
  `custom_theme_from` date DEFAULT NULL COMMENT 'Page Custom Theme Active From Date',
  `custom_theme_to` date DEFAULT NULL COMMENT 'Page Custom Theme Active To Date',
  PRIMARY KEY (`page_id`),
  KEY `IDX_CMS_PAGE_IDENTIFIER` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='CMS Page Table';

-- ----------------------------
-- Records of cms_page
-- ----------------------------
INSERT INTO `cms_page` VALUES ('1', '404 Not Found 1', 'two_columns_right', 'Page keywords', 'Page description', 'no-route', null, '\n<div class=\"page-title\"><h1>Whoops, our bad...</h1></div>\n<dl>\n    <dt>The page you requested was not found, and we have a fine guess why.</dt>\n    <dd>\n        <ul class=\"disc\">\n            <li>If you typed the URL directly, please make sure the spelling is correct.</li>\n            <li>If you clicked on a link to get here, the link is outdated.</li>\n        </ul>\n    </dd>\n</dl>\n<dl>\n    <dt>What can you do?</dt>\n    <dd>Have no fear, help is near! There are many ways you can get back on track with Magento Store.</dd>\n    <dd>\n        <ul class=\"disc\">\n            <li><a href=\"#\" onclick=\"history.go(-1); return false;\">Go back</a> to the previous page.</li>\n            <li>Use the search bar at the top of the page to search for your products.</li>\n            <li>Follow these links to get you back on track!<br /><a href=\"{{store url=\"\"}}\">Store Home</a>\n            <span class=\"separator\">|</span> <a href=\"{{store url=\"customer/account\"}}\">My Account</a></li>\n        </ul>\n    </dd>\n</dl>\n', '2015-08-06 05:56:54', '2015-08-06 05:56:54', '1', '0', null, null, null, null, null, null);
INSERT INTO `cms_page` VALUES ('2', 'Home page', 'two_columns_right', null, null, 'home', null, '<div class=\"page-title\"><h2>Home Page</h2></div>', '2015-08-06 05:56:54', '2015-08-06 05:57:11', '1', '0', '<!--<reference name=\"content\">\n        <block type=\"catalog/product_new\" name=\"home.catalog.product.new\" alias=\"product_new\" template=\"catalog/product/new.phtml\" after=\"cms_page\">\n            <action method=\"addPriceBlockType\">\n                <type>bundle</type>\n                <block>bundle/catalog_product_price</block>\n                <template>bundle/catalog/product/price.phtml</template>\n            </action>\n        </block>\n        <block type=\"reports/product_viewed\" name=\"home.reports.product.viewed\" alias=\"product_viewed\" template=\"reports/home_product_viewed.phtml\" after=\"product_new\">\n            <action method=\"addPriceBlockType\">\n                <type>bundle</type>\n                <block>bundle/catalog_product_price</block>\n                <template>bundle/catalog/product/price.phtml</template>\n            </action>\n        </block>\n        <block type=\"reports/product_compared\" name=\"home.reports.product.compared\" template=\"reports/home_product_compared.phtml\" after=\"product_viewed\">\n            <action method=\"addPriceBlockType\">\n                <type>bundle</type>\n                <block>bundle/catalog_product_price</block>\n                <template>bundle/catalog/product/price.phtml</template>\n            </action>\n        </block>\n    </reference>\n    <reference name=\"right\">\n        <action method=\"unsetChild\"><alias>right.reports.product.viewed</alias></action>\n        <action method=\"unsetChild\"><alias>right.reports.product.compared</alias></action>\n    </reference>-->', null, null, null, null, null);
INSERT INTO `cms_page` VALUES ('3', 'About Us', 'two_columns_right', null, null, 'about-magento-demo-store', null, '\n<div class=\"page-title\">\n    <h1>About Magento Store</h1>\n</div>\n<div class=\"col3-set\">\n<div class=\"col-1\"><p style=\"line-height:1.2em;\"><small>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\nMorbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec,\ntempus vitae, iaculis semper, pede.</small></p>\n<p style=\"color:#888; font:1.2em/1.4em georgia, serif;\">Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\nMorbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis,\nporta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta.</p></div>\n<div class=\"col-2\">\n<p><strong style=\"color:#de036f;\">Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus.\nDuis lobortis. Nulla nec velit.</strong></p>\n<p>Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper.\nPhasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada\nfames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac,\ntempus nec, tempor nec, justo. </p>\n<p>Maecenas ullamcorper, odio vel tempus egestas, dui orci faucibus orci, sit amet aliquet lectus dolor et quam.\nPellentesque consequat luctus purus. Nunc et risus. Etiam a nibh. Phasellus dignissim metus eget nisi.\nVestibulum sapien dolor, aliquet nec, porta ac, malesuada a, libero. Praesent feugiat purus eget est.\nNulla facilisi. Vestibulum tincidunt sapien eu velit. Mauris purus. Maecenas eget mauris eu orci accumsan feugiat.\nPellentesque eget velit. Nunc tincidunt.</p></div>\n<div class=\"col-3\">\n<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper </p>\n<p><strong style=\"color:#de036f;\">Maecenas ullamcorper, odio vel tempus egestas, dui orci faucibus orci,\nsit amet aliquet lectus dolor et quam. Pellentesque consequat luctus purus.</strong></p>\n<p>Nunc et risus. Etiam a nibh. Phasellus dignissim metus eget nisi.</p>\n<div class=\"divider\"></div>\n<p>To all of you, from all of us at Magento Store - Thank you and Happy eCommerce!</p>\n<p style=\"line-height:1.2em;\"><strong style=\"font:italic 2em Georgia, serif;\">John Doe</strong><br />\n<small>Some important guy</small></p></div>\n</div>', '2015-08-06 05:56:54', '2015-08-06 05:56:54', '1', '0', null, null, null, null, null, null);
INSERT INTO `cms_page` VALUES ('4', 'Customer Service', 'three_columns', null, null, 'customer-service', null, '<div class=\"page-title\">\n<h1>Customer Service</h1>\n</div>\n<ul class=\"disc\">\n<li><a href=\"#answer1\">Shipping &amp; Delivery</a></li>\n<li><a href=\"#answer2\">Privacy &amp; Security</a></li>\n<li><a href=\"#answer3\">Returns &amp; Replacements</a></li>\n<li><a href=\"#answer4\">Ordering</a></li>\n<li><a href=\"#answer5\">Payment, Pricing &amp; Promotions</a></li>\n<li><a href=\"#answer6\">Viewing Orders</a></li>\n<li><a href=\"#answer7\">Updating Account Information</a></li>\n</ul>\n<dl>\n<dt id=\"answer1\">Shipping &amp; Delivery</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer2\">Privacy &amp; Security</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer3\">Returns &amp; Replacements</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer4\">Ordering</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer5\">Payment, Pricing &amp; Promotions</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer6\">Viewing Orders</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\n Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\n Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\n justo.</dd>\n<dt id=\"answer7\">Updating Account Information</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\n Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\n Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\n faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\n Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\n Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\n justo.</dd>\n</dl>', '2015-08-06 05:56:54', '2015-08-06 05:56:54', '1', '0', null, null, null, null, null, null);
INSERT INTO `cms_page` VALUES ('5', 'Enable Cookies', 'one_column', null, null, 'enable-cookies', null, '<div class=\"std\">\n    <ul class=\"messages\">\n        <li class=\"notice-msg\">\n            <ul>\n                <li>Please enable cookies in your web browser to continue.</li>\n            </ul>\n        </li>\n    </ul>\n    <div class=\"page-title\">\n        <h1><a name=\"top\"></a>What are Cookies?</h1>\n    </div>\n    <p>Cookies are short pieces of data that are sent to your computer when you visit a website.\n    On later visits, this data is then returned to that website. Cookies allow us to recognize you automatically\n    whenever you visit our site so that we can personalize your experience and provide you with better service.\n    We also use cookies (and similar browser data, such as Flash cookies) for fraud prevention and other purposes.\n     If your web browser is set to refuse cookies from our website, you will not be able to complete a purchase\n     or take advantage of certain features of our website, such as storing items in your Shopping Cart or\n     receiving personalized recommendations. As a result, we strongly encourage you to configure your web\n     browser to accept cookies from our website.</p>\n    <h2 class=\"subtitle\">Enabling Cookies</h2>\n    <ul class=\"disc\">\n        <li><a href=\"#ie7\">Internet Explorer 7.x</a></li>\n        <li><a href=\"#ie6\">Internet Explorer 6.x</a></li>\n        <li><a href=\"#firefox\">Mozilla/Firefox</a></li>\n        <li><a href=\"#opera\">Opera 7.x</a></li>\n    </ul>\n    <h3><a name=\"ie7\"></a>Internet Explorer 7.x</h3>\n    <ol>\n        <li>\n            <p>Start Internet Explorer</p>\n        </li>\n        <li>\n            <p>Under the <strong>Tools</strong> menu, click <strong>Internet Options</strong></p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-1.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click the <strong>Privacy</strong> tab</p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-2.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click the <strong>Advanced</strong> button</p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-3.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Put a check mark in the box for <strong>Override Automatic Cookie Handling</strong>,\n            put another check mark in the <strong>Always accept session cookies </strong>box</p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-4.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click <strong>OK</strong></p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-5.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click <strong>OK</strong></p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-6.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Restart Internet Explore</p>\n        </li>\n    </ol>\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\n    <h3><a name=\"ie6\"></a>Internet Explorer 6.x</h3>\n    <ol>\n        <li>\n            <p>Select <strong>Internet Options</strong> from the Tools menu</p>\n            <p><img src=\"{{skin url=\"images/cookies/ie6-1.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click on the <strong>Privacy</strong> tab</p>\n        </li>\n        <li>\n            <p>Click the <strong>Default</strong> button (or manually slide the bar down to <strong>Medium</strong>)\n            under <strong>Settings</strong>. Click <strong>OK</strong></p>\n            <p><img src=\"{{skin url=\"images/cookies/ie6-2.gif\"}}\" alt=\"\" /></p>\n        </li>\n    </ol>\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\n    <h3><a name=\"firefox\"></a>Mozilla/Firefox</h3>\n    <ol>\n        <li>\n            <p>Click on the <strong>Tools</strong>-menu in Mozilla</p>\n        </li>\n        <li>\n            <p>Click on the <strong>Options...</strong> item in the menu - a new window open</p>\n        </li>\n        <li>\n            <p>Click on the <strong>Privacy</strong> selection in the left part of the window. (See image below)</p>\n            <p><img src=\"{{skin url=\"images/cookies/firefox.png\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Expand the <strong>Cookies</strong> section</p>\n        </li>\n        <li>\n            <p>Check the <strong>Enable cookies</strong> and <strong>Accept cookies normally</strong> checkboxes</p>\n        </li>\n        <li>\n            <p>Save changes by clicking <strong>Ok</strong>.</p>\n        </li>\n    </ol>\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\n    <h3><a name=\"opera\"></a>Opera 7.x</h3>\n    <ol>\n        <li>\n            <p>Click on the <strong>Tools</strong> menu in Opera</p>\n        </li>\n        <li>\n            <p>Click on the <strong>Preferences...</strong> item in the menu - a new window open</p>\n        </li>\n        <li>\n            <p>Click on the <strong>Privacy</strong> selection near the bottom left of the window. (See image below)</p>\n            <p><img src=\"{{skin url=\"images/cookies/opera.png\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>The <strong>Enable cookies</strong> checkbox must be checked, and <strong>Accept all cookies</strong>\n            should be selected in the &quot;<strong>Normal cookies</strong>&quot; drop-down</p>\n        </li>\n        <li>\n            <p>Save changes by clicking <strong>Ok</strong></p>\n        </li>\n    </ol>\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\n</div>\n', '2015-08-06 05:56:54', '2015-08-06 05:56:54', '1', '0', null, null, null, null, null, null);
INSERT INTO `cms_page` VALUES ('6', 'Privacy Policy', 'one_column', null, null, 'privacy-policy-cookie-restriction-mode', 'Privacy Policy', '<p style=\"color: #ff0000; font-weight: bold; font-size: 13px\">\n    Please replace this text with you Privacy Policy.\n    Please add any additional cookies your website uses below (e.g., Google Analytics)\n</p>\n<p>\n    This privacy policy sets out how {{config path=\"general/store_information/name\"}} uses and protects any information\n    that you give {{config path=\"general/store_information/name\"}} when you use this website.\n    {{config path=\"general/store_information/name\"}} is committed to ensuring that your privacy is protected.\n    Should we ask you to provide certain information by which you can be identified when using this website,\n    then you can be assured that it will only be used in accordance with this privacy statement.\n    {{config path=\"general/store_information/name\"}} may change this policy from time to time by updating this page.\n    You should check this page from time to time to ensure that you are happy with any changes.\n</p>\n<h2>What we collect</h2>\n<p>We may collect the following information:</p>\n<ul>\n    <li>name</li>\n    <li>contact information including email address</li>\n    <li>demographic information such as postcode, preferences and interests</li>\n    <li>other information relevant to customer surveys and/or offers</li>\n</ul>\n<p>\n    For the exhaustive list of cookies we collect see the <a href=\"#list\">List of cookies we collect</a> section.\n</p>\n<h2>What we do with the information we gather</h2>\n<p>\n    We require this information to understand your needs and provide you with a better service,\n    and in particular for the following reasons:\n</p>\n<ul>\n    <li>Internal record keeping.</li>\n    <li>We may use the information to improve our products and services.</li>\n    <li>\n        We may periodically send promotional emails about new products, special offers or other information which we\n        think you may find interesting using the email address which you have provided.\n    </li>\n    <li>\n        From time to time, we may also use your information to contact you for market research purposes.\n        We may contact you by email, phone, fax or mail. We may use the information to customise the website\n        according to your interests.\n    </li>\n</ul>\n<h2>Security</h2>\n<p>\n    We are committed to ensuring that your information is secure. In order to prevent unauthorised access or disclosure,\n    we have put in place suitable physical, electronic and managerial procedures to safeguard and secure\n    the information we collect online.\n</p>\n<h2>How we use cookies</h2>\n<p>\n    A cookie is a small file which asks permission to be placed on your computer\'s hard drive.\n    Once you agree, the file is added and the cookie helps analyse web traffic or lets you know when you visit\n    a particular site. Cookies allow web applications to respond to you as an individual. The web application\n    can tailor its operations to your needs, likes and dislikes by gathering and remembering information about\n    your preferences.\n</p>\n<p>\n    We use traffic log cookies to identify which pages are being used. This helps us analyse data about web page traffic\n    and improve our website in order to tailor it to customer needs. We only use this information for statistical\n    analysis purposes and then the data is removed from the system.\n</p>\n<p>\n    Overall, cookies help us provide you with a better website, by enabling us to monitor which pages you find useful\n    and which you do not. A cookie in no way gives us access to your computer or any information about you,\n    other than the data you choose to share with us. You can choose to accept or decline cookies.\n    Most web browsers automatically accept cookies, but you can usually modify your browser setting\n    to decline cookies if you prefer. This may prevent you from taking full advantage of the website.\n</p>\n<h2>Links to other websites</h2>\n<p>\n    Our website may contain links to other websites of interest. However, once you have used these links\n    to leave our site, you should note that we do not have any control over that other website.\n    Therefore, we cannot be responsible for the protection and privacy of any information which you provide whilst\n    visiting such sites and such sites are not governed by this privacy statement.\n    You should exercise caution and look at the privacy statement applicable to the website in question.\n</p>\n<h2>Controlling your personal information</h2>\n<p>You may choose to restrict the collection or use of your personal information in the following ways:</p>\n<ul>\n    <li>\n        whenever you are asked to fill in a form on the website, look for the box that you can click to indicate\n        that you do not want the information to be used by anybody for direct marketing purposes\n    </li>\n    <li>\n        if you have previously agreed to us using your personal information for direct marketing purposes,\n        you may change your mind at any time by writing to or emailing us at\n        {{config path=\"trans_email/ident_general/email\"}}\n    </li>\n</ul>\n<p>\n    We will not sell, distribute or lease your personal information to third parties unless we have your permission\n    or are required by law to do so. We may use your personal information to send you promotional information\n    about third parties which we think you may find interesting if you tell us that you wish this to happen.\n</p>\n<p>\n    You may request details of personal information which we hold about you under the Data Protection Act 1998.\n    A small fee will be payable. If you would like a copy of the information held on you please write to\n    {{config path=\"general/store_information/address\"}}.\n</p>\n<p>\n    If you believe that any information we are holding on you is incorrect or incomplete,\n    please write to or email us as soon as possible, at the above address.\n    We will promptly correct any information found to be incorrect.\n</p>\n<h2><a name=\"list\"></a>List of cookies we collect</h2>\n<p>The table below lists the cookies we collect and what information they store.</p>\n<table class=\"data-table\">\n    <thead>\n        <tr>\n            <th>COOKIE name</th>\n            <th>COOKIE Description</th>\n        </tr>\n    </thead>\n    <tbody>\n        <tr>\n            <th>CART</th>\n            <td>The association with your shopping cart.</td>\n        </tr>\n        <tr>\n            <th>CATEGORY_INFO</th>\n            <td>Stores the category info on the page, that allows to display pages more quickly.</td>\n        </tr>\n        <tr>\n            <th>COMPARE</th>\n            <td>The items that you have in the Compare Products list.</td>\n        </tr>\n        <tr>\n            <th>CURRENCY</th>\n            <td>Your preferred currency</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER</th>\n            <td>An encrypted version of your customer id with the store.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_AUTH</th>\n            <td>An indicator if you are currently logged into the store.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_INFO</th>\n            <td>An encrypted version of the customer group you belong to.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_SEGMENT_IDS</th>\n            <td>Stores the Customer Segment ID</td>\n        </tr>\n        <tr>\n            <th>EXTERNAL_NO_CACHE</th>\n            <td>A flag, which indicates whether caching is disabled or not.</td>\n        </tr>\n        <tr>\n            <th>FRONTEND</th>\n            <td>You sesssion ID on the server.</td>\n        </tr>\n        <tr>\n            <th>GUEST-VIEW</th>\n            <td>Allows guests to edit their orders.</td>\n        </tr>\n        <tr>\n            <th>LAST_CATEGORY</th>\n            <td>The last category you visited.</td>\n        </tr>\n        <tr>\n            <th>LAST_PRODUCT</th>\n            <td>The most recent product you have viewed.</td>\n        </tr>\n        <tr>\n            <th>NEWMESSAGE</th>\n            <td>Indicates whether a new message has been received.</td>\n        </tr>\n        <tr>\n            <th>NO_CACHE</th>\n            <td>Indicates whether it is allowed to use cache.</td>\n        </tr>\n        <tr>\n            <th>PERSISTENT_SHOPPING_CART</th>\n            <td>A link to information about your cart and viewing history if you have asked the site.</td>\n        </tr>\n        <tr>\n            <th>POLL</th>\n            <td>The ID of any polls you have recently voted in.</td>\n        </tr>\n        <tr>\n            <th>POLLN</th>\n            <td>Information on what polls you have voted on.</td>\n        </tr>\n        <tr>\n            <th>RECENTLYCOMPARED</th>\n            <td>The items that you have recently compared.            </td>\n        </tr>\n        <tr>\n            <th>STF</th>\n            <td>Information on products you have emailed to friends.</td>\n        </tr>\n        <tr>\n            <th>STORE</th>\n            <td>The store view or language you have selected.</td>\n        </tr>\n        <tr>\n            <th>USER_ALLOWED_SAVE_COOKIE</th>\n            <td>Indicates whether a customer allowed to use cookies.</td>\n        </tr>\n        <tr>\n            <th>VIEWED_PRODUCT_IDS</th>\n            <td>The products that you have recently viewed.</td>\n        </tr>\n        <tr>\n            <th>WISHLIST</th>\n            <td>An encrypted list of products added to your Wishlist.</td>\n        </tr>\n        <tr>\n            <th>WISHLIST_CNT</th>\n            <td>The number of items in your Wishlist.</td>\n        </tr>\n    </tbody>\n</table>', '2015-08-06 05:56:55', '2015-08-06 05:56:55', '1', '0', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for cms_page_store
-- ----------------------------
DROP TABLE IF EXISTS `cms_page_store`;
CREATE TABLE `cms_page_store` (
  `page_id` smallint(6) NOT NULL COMMENT 'Page ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`page_id`,`store_id`),
  KEY `IDX_CMS_PAGE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CMS_PAGE_STORE_PAGE_ID_CMS_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `cms_page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CMS_PAGE_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Page To Store Linkage Table';

-- ----------------------------
-- Records of cms_page_store
-- ----------------------------
INSERT INTO `cms_page_store` VALUES ('1', '0');
INSERT INTO `cms_page_store` VALUES ('2', '0');
INSERT INTO `cms_page_store` VALUES ('3', '0');
INSERT INTO `cms_page_store` VALUES ('4', '0');
INSERT INTO `cms_page_store` VALUES ('5', '0');
INSERT INTO `cms_page_store` VALUES ('6', '0');

-- ----------------------------
-- Table structure for core_cache
-- ----------------------------
DROP TABLE IF EXISTS `core_cache`;
CREATE TABLE `core_cache` (
  `id` varchar(200) NOT NULL COMMENT 'Cache Id',
  `data` mediumblob COMMENT 'Cache Data',
  `create_time` int(11) DEFAULT NULL COMMENT 'Cache Creation Time',
  `update_time` int(11) DEFAULT NULL COMMENT 'Time of Cache Updating',
  `expire_time` int(11) DEFAULT NULL COMMENT 'Cache Expiration Time',
  PRIMARY KEY (`id`),
  KEY `IDX_CORE_CACHE_EXPIRE_TIME` (`expire_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Caches';

-- ----------------------------
-- Records of core_cache
-- ----------------------------

-- ----------------------------
-- Table structure for core_cache_option
-- ----------------------------
DROP TABLE IF EXISTS `core_cache_option`;
CREATE TABLE `core_cache_option` (
  `code` varchar(32) NOT NULL COMMENT 'Code',
  `value` smallint(6) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache Options';

-- ----------------------------
-- Records of core_cache_option
-- ----------------------------
INSERT INTO `core_cache_option` VALUES ('block_html', '1');
INSERT INTO `core_cache_option` VALUES ('collections', '1');
INSERT INTO `core_cache_option` VALUES ('config', '1');
INSERT INTO `core_cache_option` VALUES ('config_api', '1');
INSERT INTO `core_cache_option` VALUES ('config_api2', '1');
INSERT INTO `core_cache_option` VALUES ('eav', '1');
INSERT INTO `core_cache_option` VALUES ('layout', '1');
INSERT INTO `core_cache_option` VALUES ('translate', '1');

-- ----------------------------
-- Table structure for core_cache_tag
-- ----------------------------
DROP TABLE IF EXISTS `core_cache_tag`;
CREATE TABLE `core_cache_tag` (
  `tag` varchar(100) NOT NULL COMMENT 'Tag',
  `cache_id` varchar(200) NOT NULL COMMENT 'Cache Id',
  PRIMARY KEY (`tag`,`cache_id`),
  KEY `IDX_CORE_CACHE_TAG_CACHE_ID` (`cache_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Caches';

-- ----------------------------
-- Records of core_cache_tag
-- ----------------------------

-- ----------------------------
-- Table structure for core_config_data
-- ----------------------------
DROP TABLE IF EXISTS `core_config_data`;
CREATE TABLE `core_config_data` (
  `config_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Config Id',
  `scope` varchar(8) NOT NULL DEFAULT 'default' COMMENT 'Config Scope',
  `scope_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Config Scope Id',
  `path` varchar(255) NOT NULL DEFAULT 'general' COMMENT 'Config Path',
  `value` text COMMENT 'Config Value',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `UNQ_CORE_CONFIG_DATA_SCOPE_SCOPE_ID_PATH` (`scope`,`scope_id`,`path`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='Config Data';

-- ----------------------------
-- Records of core_config_data
-- ----------------------------
INSERT INTO `core_config_data` VALUES ('1', 'default', '0', 'general/region/display_all', '1');
INSERT INTO `core_config_data` VALUES ('2', 'default', '0', 'general/region/state_required', 'AT,CA,CH,DE,EE,ES,FI,FR,LT,LV,RO,US');
INSERT INTO `core_config_data` VALUES ('3', 'default', '0', 'catalog/category/root_id', '2');
INSERT INTO `core_config_data` VALUES ('4', 'default', '0', 'payment/paypal_express/skip_order_review_step', '1');
INSERT INTO `core_config_data` VALUES ('5', 'default', '0', 'payment/payflow_link/mobile_optimized', '1');
INSERT INTO `core_config_data` VALUES ('6', 'default', '0', 'payment/payflow_advanced/mobile_optimized', '1');
INSERT INTO `core_config_data` VALUES ('7', 'default', '0', 'payment/hosted_pro/mobile_optimized', '1');
INSERT INTO `core_config_data` VALUES ('8', 'default', '0', 'admin/dashboard/enable_charts', '1');
INSERT INTO `core_config_data` VALUES ('9', 'default', '0', 'web/unsecure/base_url', 'http://localhost:8086/');
INSERT INTO `core_config_data` VALUES ('10', 'default', '0', 'web/secure/base_url', 'http://localhost:8086/');
INSERT INTO `core_config_data` VALUES ('11', 'default', '0', 'general/locale/code', 'en_US');
INSERT INTO `core_config_data` VALUES ('12', 'default', '0', 'general/locale/timezone', 'America/Los_Angeles');
INSERT INTO `core_config_data` VALUES ('13', 'default', '0', 'currency/options/base', 'USD');
INSERT INTO `core_config_data` VALUES ('14', 'default', '0', 'currency/options/default', 'USD');
INSERT INTO `core_config_data` VALUES ('15', 'default', '0', 'currency/options/allow', 'USD');

-- ----------------------------
-- Table structure for core_email_queue
-- ----------------------------
DROP TABLE IF EXISTS `core_email_queue`;
CREATE TABLE `core_email_queue` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Message Id',
  `entity_id` int(10) unsigned DEFAULT NULL COMMENT 'Entity ID',
  `entity_type` varchar(128) DEFAULT NULL COMMENT 'Entity Type',
  `event_type` varchar(128) DEFAULT NULL COMMENT 'Event Type',
  `message_body_hash` varchar(64) NOT NULL COMMENT 'Message Body Hash',
  `message_body` mediumtext NOT NULL COMMENT 'Message Body',
  `message_parameters` text NOT NULL COMMENT 'Message Parameters',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `processed_at` timestamp NULL DEFAULT NULL COMMENT 'Finish Time',
  PRIMARY KEY (`message_id`),
  KEY `0ADECE62FD629241C147389ADF20706E` (`entity_id`,`entity_type`,`event_type`,`message_body_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Queue';

-- ----------------------------
-- Records of core_email_queue
-- ----------------------------

-- ----------------------------
-- Table structure for core_email_queue_recipients
-- ----------------------------
DROP TABLE IF EXISTS `core_email_queue_recipients`;
CREATE TABLE `core_email_queue_recipients` (
  `recipient_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Recipient Id',
  `message_id` int(10) unsigned NOT NULL COMMENT 'Message ID',
  `recipient_email` varchar(128) NOT NULL COMMENT 'Recipient Email',
  `recipient_name` varchar(255) NOT NULL COMMENT 'Recipient Name',
  `email_type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Email Type',
  PRIMARY KEY (`recipient_id`),
  UNIQUE KEY `19BDB9C5FE4BD685FCF992A71E976CD0` (`message_id`,`recipient_email`,`email_type`),
  KEY `IDX_CORE_EMAIL_QUEUE_RECIPIENTS_RECIPIENT_EMAIL` (`recipient_email`),
  KEY `IDX_CORE_EMAIL_QUEUE_RECIPIENTS_EMAIL_TYPE` (`email_type`),
  CONSTRAINT `FK_6F4948F3ABF97DE12127EF14B140802A` FOREIGN KEY (`message_id`) REFERENCES `core_email_queue` (`message_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Queue';

-- ----------------------------
-- Records of core_email_queue_recipients
-- ----------------------------

-- ----------------------------
-- Table structure for core_email_template
-- ----------------------------
DROP TABLE IF EXISTS `core_email_template`;
CREATE TABLE `core_email_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `template_code` varchar(150) NOT NULL COMMENT 'Template Name',
  `template_text` text NOT NULL COMMENT 'Template Content',
  `template_styles` text COMMENT 'Templste Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) NOT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Date of Template Creation',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Date of Template Modification',
  `orig_template_code` varchar(200) DEFAULT NULL COMMENT 'Original Template Code',
  `orig_template_variables` text COMMENT 'Original Template Variables',
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `UNQ_CORE_EMAIL_TEMPLATE_TEMPLATE_CODE` (`template_code`),
  KEY `IDX_CORE_EMAIL_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `IDX_CORE_EMAIL_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Templates';

-- ----------------------------
-- Records of core_email_template
-- ----------------------------

-- ----------------------------
-- Table structure for core_flag
-- ----------------------------
DROP TABLE IF EXISTS `core_flag`;
CREATE TABLE `core_flag` (
  `flag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Flag Id',
  `flag_code` varchar(255) NOT NULL COMMENT 'Flag Code',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag State',
  `flag_data` text COMMENT 'Flag Data',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of Last Flag Update',
  PRIMARY KEY (`flag_id`),
  KEY `IDX_CORE_FLAG_LAST_UPDATE` (`last_update`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Flag';

-- ----------------------------
-- Records of core_flag
-- ----------------------------
INSERT INTO `core_flag` VALUES ('1', 'admin_notification_survey', '0', 'a:1:{s:13:\"survey_viewed\";b:1;}', '2015-08-06 05:58:08');

-- ----------------------------
-- Table structure for core_layout_link
-- ----------------------------
DROP TABLE IF EXISTS `core_layout_link`;
CREATE TABLE `core_layout_link` (
  `layout_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `area` varchar(64) DEFAULT NULL COMMENT 'Area',
  `package` varchar(64) DEFAULT NULL COMMENT 'Package',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  PRIMARY KEY (`layout_link_id`),
  UNIQUE KEY `UNQ_CORE_LAYOUT_LINK_STORE_ID_PACKAGE_THEME_LAYOUT_UPDATE_ID` (`store_id`,`package`,`theme`,`layout_update_id`),
  KEY `IDX_CORE_LAYOUT_LINK_LAYOUT_UPDATE_ID` (`layout_update_id`),
  CONSTRAINT `FK_CORE_LAYOUT_LINK_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_LYT_LNK_LYT_UPDATE_ID_CORE_LYT_UPDATE_LYT_UPDATE_ID` FOREIGN KEY (`layout_update_id`) REFERENCES `core_layout_update` (`layout_update_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Link';

-- ----------------------------
-- Records of core_layout_link
-- ----------------------------

-- ----------------------------
-- Table structure for core_layout_update
-- ----------------------------
DROP TABLE IF EXISTS `core_layout_update`;
CREATE TABLE `core_layout_update` (
  `layout_update_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Layout Update Id',
  `handle` varchar(255) DEFAULT NULL COMMENT 'Handle',
  `xml` text COMMENT 'Xml',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`layout_update_id`),
  KEY `IDX_CORE_LAYOUT_UPDATE_HANDLE` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Updates';

-- ----------------------------
-- Records of core_layout_update
-- ----------------------------

-- ----------------------------
-- Table structure for core_resource
-- ----------------------------
DROP TABLE IF EXISTS `core_resource`;
CREATE TABLE `core_resource` (
  `code` varchar(50) NOT NULL COMMENT 'Resource Code',
  `version` varchar(50) DEFAULT NULL COMMENT 'Resource Version',
  `data_version` varchar(50) DEFAULT NULL COMMENT 'Data Version',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Resources';

-- ----------------------------
-- Records of core_resource
-- ----------------------------
INSERT INTO `core_resource` VALUES ('adminnotification_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('admin_setup', '1.6.1.1', '1.6.1.1');
INSERT INTO `core_resource` VALUES ('api2_setup', '1.0.0.0', '1.0.0.0');
INSERT INTO `core_resource` VALUES ('api_setup', '1.6.0.1', '1.6.0.1');
INSERT INTO `core_resource` VALUES ('backup_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('bundle_setup', '1.6.0.0.1', '1.6.0.0.1');
INSERT INTO `core_resource` VALUES ('captcha_setup', '1.7.0.0.0', '1.7.0.0.0');
INSERT INTO `core_resource` VALUES ('catalogindex_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('cataloginventory_setup', '1.6.0.0.2', '1.6.0.0.2');
INSERT INTO `core_resource` VALUES ('catalogrule_setup', '1.6.0.3', '1.6.0.3');
INSERT INTO `core_resource` VALUES ('catalogsearch_setup', '1.8.2.0', '1.8.2.0');
INSERT INTO `core_resource` VALUES ('catalog_setup', '1.6.0.0.19.1.2', '1.6.0.0.19.1.2');
INSERT INTO `core_resource` VALUES ('checkout_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('cms_setup', '1.6.0.0.2', '1.6.0.0.2');
INSERT INTO `core_resource` VALUES ('compiler_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('contacts_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('core_setup', '1.6.0.6', '1.6.0.6');
INSERT INTO `core_resource` VALUES ('cron_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('customer_setup', '1.6.2.0.4', '1.6.2.0.4');
INSERT INTO `core_resource` VALUES ('dataflow_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('directory_setup', '1.6.0.3', '1.6.0.3');
INSERT INTO `core_resource` VALUES ('downloadable_setup', '1.6.0.0.2', '1.6.0.0.2');
INSERT INTO `core_resource` VALUES ('eav_setup', '1.6.0.1', '1.6.0.1');
INSERT INTO `core_resource` VALUES ('giftmessage_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('googleanalytics_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('importexport_setup', '1.6.0.2', '1.6.0.2');
INSERT INTO `core_resource` VALUES ('index_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('log_setup', '1.6.1.1', '1.6.1.1');
INSERT INTO `core_resource` VALUES ('moneybookers_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('newsletter_setup', '1.6.0.2', '1.6.0.2');
INSERT INTO `core_resource` VALUES ('oauth_setup', '1.0.0.0', '1.0.0.0');
INSERT INTO `core_resource` VALUES ('paygate_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('payment_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('paypaluk_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('paypal_setup', '1.6.0.6', '1.6.0.6');
INSERT INTO `core_resource` VALUES ('persistent_setup', '1.0.0.0', '1.0.0.0');
INSERT INTO `core_resource` VALUES ('poll_setup', '1.6.0.1', '1.6.0.1');
INSERT INTO `core_resource` VALUES ('productalert_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('rating_setup', '1.6.0.1', '1.6.0.1');
INSERT INTO `core_resource` VALUES ('reports_setup', '1.6.0.0.1', '1.6.0.0.1');
INSERT INTO `core_resource` VALUES ('review_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('salesrule_setup', '1.6.0.3', '1.6.0.3');
INSERT INTO `core_resource` VALUES ('sales_setup', '1.6.0.9', '1.6.0.9');
INSERT INTO `core_resource` VALUES ('sendfriend_setup', '1.6.0.1', '1.6.0.1');
INSERT INTO `core_resource` VALUES ('shipping_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('sitemap_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('tag_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('tax_setup', '1.6.0.4', '1.6.0.4');
INSERT INTO `core_resource` VALUES ('usa_setup', '1.6.0.3', '1.6.0.3');
INSERT INTO `core_resource` VALUES ('weee_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('widget_setup', '1.6.0.0', '1.6.0.0');
INSERT INTO `core_resource` VALUES ('wishlist_setup', '1.6.0.0', '1.6.0.0');

-- ----------------------------
-- Table structure for core_session
-- ----------------------------
DROP TABLE IF EXISTS `core_session`;
CREATE TABLE `core_session` (
  `session_id` varchar(255) NOT NULL COMMENT 'Session Id',
  `session_expires` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Date of Session Expiration',
  `session_data` mediumblob NOT NULL COMMENT 'Session Data',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Database Sessions Storage';

-- ----------------------------
-- Records of core_session
-- ----------------------------

-- ----------------------------
-- Table structure for core_store
-- ----------------------------
DROP TABLE IF EXISTS `core_store`;
CREATE TABLE `core_store` (
  `store_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Store Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Sort Order',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Activity',
  PRIMARY KEY (`store_id`),
  UNIQUE KEY `UNQ_CORE_STORE_CODE` (`code`),
  KEY `IDX_CORE_STORE_WEBSITE_ID` (`website_id`),
  KEY `IDX_CORE_STORE_IS_ACTIVE_SORT_ORDER` (`is_active`,`sort_order`),
  KEY `IDX_CORE_STORE_GROUP_ID` (`group_id`),
  CONSTRAINT `FK_CORE_STORE_GROUP_ID_CORE_STORE_GROUP_GROUP_ID` FOREIGN KEY (`group_id`) REFERENCES `core_store_group` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_STORE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores';

-- ----------------------------
-- Records of core_store
-- ----------------------------
INSERT INTO `core_store` VALUES ('0', 'admin', '0', '0', 'Admin', '0', '1');
INSERT INTO `core_store` VALUES ('1', 'default', '1', '1', 'Default Store View', '0', '1');

-- ----------------------------
-- Table structure for core_store_group
-- ----------------------------
DROP TABLE IF EXISTS `core_store_group`;
CREATE TABLE `core_store_group` (
  `group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Group Name',
  `root_category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Root Category Id',
  `default_store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Store Id',
  PRIMARY KEY (`group_id`),
  KEY `IDX_CORE_STORE_GROUP_WEBSITE_ID` (`website_id`),
  KEY `IDX_CORE_STORE_GROUP_DEFAULT_STORE_ID` (`default_store_id`),
  CONSTRAINT `FK_CORE_STORE_GROUP_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Store Groups';

-- ----------------------------
-- Records of core_store_group
-- ----------------------------
INSERT INTO `core_store_group` VALUES ('0', '0', 'Default', '0', '0');
INSERT INTO `core_store_group` VALUES ('1', '1', 'Main Website Store', '2', '1');

-- ----------------------------
-- Table structure for core_translate
-- ----------------------------
DROP TABLE IF EXISTS `core_translate`;
CREATE TABLE `core_translate` (
  `key_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Key Id of Translation',
  `string` varchar(255) NOT NULL DEFAULT 'Translate String' COMMENT 'Translation String',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `translate` varchar(255) DEFAULT NULL COMMENT 'Translate',
  `locale` varchar(20) NOT NULL DEFAULT 'en_US' COMMENT 'Locale',
  `crc_string` bigint(20) NOT NULL DEFAULT '1591228201' COMMENT 'Translation String CRC32 Hash',
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `UNQ_CORE_TRANSLATE_STORE_ID_LOCALE_CRC_STRING_STRING` (`store_id`,`locale`,`crc_string`,`string`),
  KEY `IDX_CORE_TRANSLATE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CORE_TRANSLATE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations';

-- ----------------------------
-- Records of core_translate
-- ----------------------------

-- ----------------------------
-- Table structure for core_url_rewrite
-- ----------------------------
DROP TABLE IF EXISTS `core_url_rewrite`;
CREATE TABLE `core_url_rewrite` (
  `url_rewrite_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rewrite Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `id_path` varchar(255) DEFAULT NULL COMMENT 'Id Path',
  `request_path` varchar(255) DEFAULT NULL COMMENT 'Request Path',
  `target_path` varchar(255) DEFAULT NULL COMMENT 'Target Path',
  `is_system` smallint(5) unsigned DEFAULT '1' COMMENT 'Defines is Rewrite System',
  `options` varchar(255) DEFAULT NULL COMMENT 'Options',
  `description` varchar(255) DEFAULT NULL COMMENT 'Deascription',
  `category_id` int(10) unsigned DEFAULT NULL COMMENT 'Category Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  PRIMARY KEY (`url_rewrite_id`),
  UNIQUE KEY `UNQ_CORE_URL_REWRITE_REQUEST_PATH_STORE_ID` (`request_path`,`store_id`),
  UNIQUE KEY `UNQ_CORE_URL_REWRITE_ID_PATH_IS_SYSTEM_STORE_ID` (`id_path`,`is_system`,`store_id`),
  KEY `IDX_CORE_URL_REWRITE_TARGET_PATH_STORE_ID` (`target_path`,`store_id`),
  KEY `IDX_CORE_URL_REWRITE_ID_PATH` (`id_path`),
  KEY `IDX_CORE_URL_REWRITE_STORE_ID` (`store_id`),
  KEY `FK_CORE_URL_REWRITE_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` (`category_id`),
  KEY `FK_CORE_URL_REWRITE_PRODUCT_ID_CATALOG_CATEGORY_ENTITY_ENTITY_ID` (`product_id`),
  CONSTRAINT `FK_CORE_URL_REWRITE_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_URL_REWRITE_PRODUCT_ID_CATALOG_CATEGORY_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_URL_REWRITE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Url Rewrites';

-- ----------------------------
-- Records of core_url_rewrite
-- ----------------------------

-- ----------------------------
-- Table structure for core_variable
-- ----------------------------
DROP TABLE IF EXISTS `core_variable`;
CREATE TABLE `core_variable` (
  `variable_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Variable Code',
  `name` varchar(255) DEFAULT NULL COMMENT 'Variable Name',
  PRIMARY KEY (`variable_id`),
  UNIQUE KEY `UNQ_CORE_VARIABLE_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variables';

-- ----------------------------
-- Records of core_variable
-- ----------------------------

-- ----------------------------
-- Table structure for core_variable_value
-- ----------------------------
DROP TABLE IF EXISTS `core_variable_value`;
CREATE TABLE `core_variable_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Value Id',
  `variable_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Variable Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `plain_value` text COMMENT 'Plain Text Value',
  `html_value` text COMMENT 'Html Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CORE_VARIABLE_VALUE_VARIABLE_ID_STORE_ID` (`variable_id`,`store_id`),
  KEY `IDX_CORE_VARIABLE_VALUE_VARIABLE_ID` (`variable_id`),
  KEY `IDX_CORE_VARIABLE_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CORE_VARIABLE_VALUE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_VARIABLE_VALUE_VARIABLE_ID_CORE_VARIABLE_VARIABLE_ID` FOREIGN KEY (`variable_id`) REFERENCES `core_variable` (`variable_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variable Value';

-- ----------------------------
-- Records of core_variable_value
-- ----------------------------

-- ----------------------------
-- Table structure for core_website
-- ----------------------------
DROP TABLE IF EXISTS `core_website`;
CREATE TABLE `core_website` (
  `website_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Website Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `name` varchar(64) DEFAULT NULL COMMENT 'Website Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Group Id',
  `is_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Defines Is Website Default',
  PRIMARY KEY (`website_id`),
  UNIQUE KEY `UNQ_CORE_WEBSITE_CODE` (`code`),
  KEY `IDX_CORE_WEBSITE_SORT_ORDER` (`sort_order`),
  KEY `IDX_CORE_WEBSITE_DEFAULT_GROUP_ID` (`default_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Websites';

-- ----------------------------
-- Records of core_website
-- ----------------------------
INSERT INTO `core_website` VALUES ('0', 'admin', 'Admin', '0', '0', '0');
INSERT INTO `core_website` VALUES ('1', 'base', 'Main Website', '0', '1', '1');

-- ----------------------------
-- Table structure for coupon_aggregated
-- ----------------------------
DROP TABLE IF EXISTS `coupon_aggregated`;
CREATE TABLE `coupon_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_COUPON_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_COUPON_AGGREGATED_STORE_ID` (`store_id`),
  KEY `IDX_COUPON_AGGREGATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_COUPON_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated';

-- ----------------------------
-- Records of coupon_aggregated
-- ----------------------------

-- ----------------------------
-- Table structure for coupon_aggregated_order
-- ----------------------------
DROP TABLE IF EXISTS `coupon_aggregated_order`;
CREATE TABLE `coupon_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_COUPON_AGGRED_ORDER_PERIOD_STORE_ID_ORDER_STS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_COUPON_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  KEY `IDX_COUPON_AGGREGATED_ORDER_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_COUPON_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated Order';

-- ----------------------------
-- Records of coupon_aggregated_order
-- ----------------------------

-- ----------------------------
-- Table structure for coupon_aggregated_updated
-- ----------------------------
DROP TABLE IF EXISTS `coupon_aggregated_updated`;
CREATE TABLE `coupon_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_COUPON_AGGRED_UPDATED_PERIOD_STORE_ID_ORDER_STS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_COUPON_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  KEY `IDX_COUPON_AGGREGATED_UPDATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_COUPON_AGGREGATED_UPDATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated Updated';

-- ----------------------------
-- Records of coupon_aggregated_updated
-- ----------------------------

-- ----------------------------
-- Table structure for cron_schedule
-- ----------------------------
DROP TABLE IF EXISTS `cron_schedule`;
CREATE TABLE `cron_schedule` (
  `schedule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Schedule Id',
  `job_code` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Job Code',
  `status` varchar(7) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `messages` text COMMENT 'Messages',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `scheduled_at` timestamp NULL DEFAULT NULL COMMENT 'Scheduled At',
  `executed_at` timestamp NULL DEFAULT NULL COMMENT 'Executed At',
  `finished_at` timestamp NULL DEFAULT NULL COMMENT 'Finished At',
  PRIMARY KEY (`schedule_id`),
  KEY `IDX_CRON_SCHEDULE_JOB_CODE` (`job_code`),
  KEY `IDX_CRON_SCHEDULE_SCHEDULED_AT_STATUS` (`scheduled_at`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cron Schedule';

-- ----------------------------
-- Records of cron_schedule
-- ----------------------------

-- ----------------------------
-- Table structure for customer_address_entity
-- ----------------------------
DROP TABLE IF EXISTS `customer_address_entity`;
CREATE TABLE `customer_address_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_CUSTOMER_ADDRESS_ENTITY_PARENT_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity';

-- ----------------------------
-- Records of customer_address_entity
-- ----------------------------

-- ----------------------------
-- Table structure for customer_address_entity_datetime
-- ----------------------------
DROP TABLE IF EXISTS `customer_address_entity_datetime`;
CREATE TABLE `customer_address_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_CSTR_ADDR_ENTT_DTIME_ENTT_ID_ATTR_ID_VAL` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DTIME_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Datetime';

-- ----------------------------
-- Records of customer_address_entity_datetime
-- ----------------------------

-- ----------------------------
-- Table structure for customer_address_entity_decimal
-- ----------------------------
DROP TABLE IF EXISTS `customer_address_entity_decimal`;
CREATE TABLE `customer_address_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DEC_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DEC_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Decimal';

-- ----------------------------
-- Records of customer_address_entity_decimal
-- ----------------------------

-- ----------------------------
-- Table structure for customer_address_entity_int
-- ----------------------------
DROP TABLE IF EXISTS `customer_address_entity_int`;
CREATE TABLE `customer_address_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_INT_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_INT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Int';

-- ----------------------------
-- Records of customer_address_entity_int
-- ----------------------------

-- ----------------------------
-- Table structure for customer_address_entity_text
-- ----------------------------
DROP TABLE IF EXISTS `customer_address_entity_text`;
CREATE TABLE `customer_address_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_TEXT_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_TEXT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Text';

-- ----------------------------
-- Records of customer_address_entity_text
-- ----------------------------

-- ----------------------------
-- Table structure for customer_address_entity_varchar
-- ----------------------------
DROP TABLE IF EXISTS `customer_address_entity_varchar`;
CREATE TABLE `customer_address_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_VCHR_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_VCHR_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Varchar';

-- ----------------------------
-- Records of customer_address_entity_varchar
-- ----------------------------

-- ----------------------------
-- Table structure for customer_eav_attribute
-- ----------------------------
DROP TABLE IF EXISTS `customer_eav_attribute`;
CREATE TABLE `customer_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `input_filter` varchar(255) DEFAULT NULL COMMENT 'Input Filter',
  `multiline_count` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Multiline Count',
  `validate_rules` text COMMENT 'Validate Rules',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `data_model` varchar(255) DEFAULT NULL COMMENT 'Data Model',
  PRIMARY KEY (`attribute_id`),
  CONSTRAINT `FK_CSTR_EAV_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute';

-- ----------------------------
-- Records of customer_eav_attribute
-- ----------------------------
INSERT INTO `customer_eav_attribute` VALUES ('1', '1', null, '0', null, '1', '10', null);
INSERT INTO `customer_eav_attribute` VALUES ('2', '0', null, '0', null, '1', '0', null);
INSERT INTO `customer_eav_attribute` VALUES ('3', '1', null, '0', null, '1', '20', null);
INSERT INTO `customer_eav_attribute` VALUES ('4', '0', null, '0', null, '0', '30', null);
INSERT INTO `customer_eav_attribute` VALUES ('5', '1', null, '0', 'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}', '1', '40', null);
INSERT INTO `customer_eav_attribute` VALUES ('6', '1', null, '0', null, '0', '50', null);
INSERT INTO `customer_eav_attribute` VALUES ('7', '1', null, '0', 'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}', '1', '60', null);
INSERT INTO `customer_eav_attribute` VALUES ('8', '0', null, '0', null, '0', '70', null);
INSERT INTO `customer_eav_attribute` VALUES ('9', '1', null, '0', 'a:1:{s:16:\"input_validation\";s:5:\"email\";}', '1', '80', null);
INSERT INTO `customer_eav_attribute` VALUES ('10', '1', null, '0', null, '1', '25', null);
INSERT INTO `customer_eav_attribute` VALUES ('11', '0', 'date', '0', 'a:1:{s:16:\"input_validation\";s:4:\"date\";}', '0', '90', null);
INSERT INTO `customer_eav_attribute` VALUES ('12', '0', null, '0', null, '1', '0', null);
INSERT INTO `customer_eav_attribute` VALUES ('13', '0', null, '0', null, '1', '0', null);
INSERT INTO `customer_eav_attribute` VALUES ('14', '0', null, '0', null, '1', '0', null);
INSERT INTO `customer_eav_attribute` VALUES ('15', '0', null, '0', 'a:1:{s:15:\"max_text_length\";i:255;}', '0', '100', null);
INSERT INTO `customer_eav_attribute` VALUES ('16', '0', null, '0', null, '1', '0', null);
INSERT INTO `customer_eav_attribute` VALUES ('17', '0', 'datetime', '0', null, '0', '0', null);
INSERT INTO `customer_eav_attribute` VALUES ('18', '0', null, '0', 'a:0:{}', '0', '110', null);
INSERT INTO `customer_eav_attribute` VALUES ('19', '0', null, '0', null, '0', '10', null);
INSERT INTO `customer_eav_attribute` VALUES ('20', '1', null, '0', 'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}', '1', '20', null);
INSERT INTO `customer_eav_attribute` VALUES ('21', '1', null, '0', null, '0', '30', null);
INSERT INTO `customer_eav_attribute` VALUES ('22', '1', null, '0', 'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}', '1', '40', null);
INSERT INTO `customer_eav_attribute` VALUES ('23', '0', null, '0', null, '0', '50', null);
INSERT INTO `customer_eav_attribute` VALUES ('24', '1', null, '0', 'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}', '1', '60', null);
INSERT INTO `customer_eav_attribute` VALUES ('25', '1', null, '2', 'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}', '1', '70', null);
INSERT INTO `customer_eav_attribute` VALUES ('26', '1', null, '0', 'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}', '1', '80', null);
INSERT INTO `customer_eav_attribute` VALUES ('27', '1', null, '0', null, '1', '90', null);
INSERT INTO `customer_eav_attribute` VALUES ('28', '1', null, '0', null, '1', '100', null);
INSERT INTO `customer_eav_attribute` VALUES ('29', '1', null, '0', null, '1', '100', null);
INSERT INTO `customer_eav_attribute` VALUES ('30', '1', null, '0', 'a:0:{}', '1', '110', 'customer/attribute_data_postcode');
INSERT INTO `customer_eav_attribute` VALUES ('31', '1', null, '0', 'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}', '1', '120', null);
INSERT INTO `customer_eav_attribute` VALUES ('32', '1', null, '0', 'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}', '1', '130', null);
INSERT INTO `customer_eav_attribute` VALUES ('33', '0', null, '0', null, '1', '0', null);
INSERT INTO `customer_eav_attribute` VALUES ('34', '0', null, '0', 'a:1:{s:16:\"input_validation\";s:4:\"date\";}', '1', '0', null);
INSERT INTO `customer_eav_attribute` VALUES ('35', '1', null, '0', null, '1', '28', null);
INSERT INTO `customer_eav_attribute` VALUES ('36', '1', null, '0', null, '1', '140', null);
INSERT INTO `customer_eav_attribute` VALUES ('37', '0', null, '0', null, '1', '0', null);
INSERT INTO `customer_eav_attribute` VALUES ('38', '0', null, '0', null, '1', '0', null);
INSERT INTO `customer_eav_attribute` VALUES ('39', '0', null, '0', null, '1', '0', null);
INSERT INTO `customer_eav_attribute` VALUES ('40', '0', null, '0', null, '1', '0', null);

-- ----------------------------
-- Table structure for customer_eav_attribute_website
-- ----------------------------
DROP TABLE IF EXISTS `customer_eav_attribute_website`;
CREATE TABLE `customer_eav_attribute_website` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `is_visible` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Visible',
  `is_required` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Required',
  `default_value` text COMMENT 'Default Value',
  `multiline_count` smallint(5) unsigned DEFAULT NULL COMMENT 'Multiline Count',
  PRIMARY KEY (`attribute_id`,`website_id`),
  KEY `IDX_CUSTOMER_EAV_ATTRIBUTE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CSTR_EAV_ATTR_WS_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_EAV_ATTR_WS_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute Website';

-- ----------------------------
-- Records of customer_eav_attribute_website
-- ----------------------------

-- ----------------------------
-- Table structure for customer_entity
-- ----------------------------
DROP TABLE IF EXISTS `customer_entity`;
CREATE TABLE `customer_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `website_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Website Id',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  `disable_auto_group_change` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Disable automatic group change based on VAT ID',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_EMAIL_WEBSITE_ID` (`email`,`website_id`),
  KEY `IDX_CUSTOMER_ENTITY_STORE_ID` (`store_id`),
  KEY `IDX_CUSTOMER_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_EMAIL_WEBSITE_ID` (`email`,`website_id`),
  KEY `IDX_CUSTOMER_ENTITY_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CUSTOMER_ENTITY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity';

-- ----------------------------
-- Records of customer_entity
-- ----------------------------

-- ----------------------------
-- Table structure for customer_entity_datetime
-- ----------------------------
DROP TABLE IF EXISTS `customer_entity_datetime`;
CREATE TABLE `customer_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Datetime';

-- ----------------------------
-- Records of customer_entity_datetime
-- ----------------------------

-- ----------------------------
-- Table structure for customer_entity_decimal
-- ----------------------------
DROP TABLE IF EXISTS `customer_entity_decimal`;
CREATE TABLE `customer_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ENTT_DEC_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Decimal';

-- ----------------------------
-- Records of customer_entity_decimal
-- ----------------------------

-- ----------------------------
-- Table structure for customer_entity_int
-- ----------------------------
DROP TABLE IF EXISTS `customer_entity_int`;
CREATE TABLE `customer_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ENTT_INT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_INT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_INT_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Int';

-- ----------------------------
-- Records of customer_entity_int
-- ----------------------------

-- ----------------------------
-- Table structure for customer_entity_text
-- ----------------------------
DROP TABLE IF EXISTS `customer_entity_text`;
CREATE TABLE `customer_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CSTR_ENTT_TEXT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_TEXT_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Text';

-- ----------------------------
-- Records of customer_entity_text
-- ----------------------------

-- ----------------------------
-- Table structure for customer_entity_varchar
-- ----------------------------
DROP TABLE IF EXISTS `customer_entity_varchar`;
CREATE TABLE `customer_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ENTT_VCHR_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Varchar';

-- ----------------------------
-- Records of customer_entity_varchar
-- ----------------------------

-- ----------------------------
-- Table structure for customer_form_attribute
-- ----------------------------
DROP TABLE IF EXISTS `customer_form_attribute`;
CREATE TABLE `customer_form_attribute` (
  `form_code` varchar(32) NOT NULL COMMENT 'Form Code',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`form_code`,`attribute_id`),
  KEY `IDX_CUSTOMER_FORM_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_CSTR_FORM_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Form Attribute';

-- ----------------------------
-- Records of customer_form_attribute
-- ----------------------------
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '1');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '3');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '4');
INSERT INTO `customer_form_attribute` VALUES ('checkout_register', '4');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_create', '4');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_edit', '4');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '5');
INSERT INTO `customer_form_attribute` VALUES ('checkout_register', '5');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_create', '5');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_edit', '5');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '6');
INSERT INTO `customer_form_attribute` VALUES ('checkout_register', '6');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_create', '6');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_edit', '6');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '7');
INSERT INTO `customer_form_attribute` VALUES ('checkout_register', '7');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_create', '7');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_edit', '7');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '8');
INSERT INTO `customer_form_attribute` VALUES ('checkout_register', '8');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_create', '8');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_edit', '8');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_checkout', '9');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '9');
INSERT INTO `customer_form_attribute` VALUES ('checkout_register', '9');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_create', '9');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_edit', '9');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_checkout', '10');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '10');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_checkout', '11');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '11');
INSERT INTO `customer_form_attribute` VALUES ('checkout_register', '11');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_create', '11');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_edit', '11');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_checkout', '15');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '15');
INSERT INTO `customer_form_attribute` VALUES ('checkout_register', '15');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_create', '15');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_edit', '15');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '17');
INSERT INTO `customer_form_attribute` VALUES ('checkout_register', '17');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_create', '17');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_edit', '17');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_checkout', '18');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '18');
INSERT INTO `customer_form_attribute` VALUES ('checkout_register', '18');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_create', '18');
INSERT INTO `customer_form_attribute` VALUES ('customer_account_edit', '18');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '19');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '19');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '19');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '20');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '20');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '20');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '21');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '21');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '21');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '22');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '22');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '22');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '23');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '23');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '23');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '24');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '24');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '24');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '25');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '25');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '25');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '26');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '26');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '26');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '27');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '27');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '27');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '28');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '28');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '28');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '29');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '29');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '29');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '30');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '30');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '30');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '31');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '31');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '31');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '32');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '32');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '32');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer', '35');
INSERT INTO `customer_form_attribute` VALUES ('adminhtml_customer_address', '36');
INSERT INTO `customer_form_attribute` VALUES ('customer_address_edit', '36');
INSERT INTO `customer_form_attribute` VALUES ('customer_register_address', '36');

-- ----------------------------
-- Table structure for customer_group
-- ----------------------------
DROP TABLE IF EXISTS `customer_group`;
CREATE TABLE `customer_group` (
  `customer_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Customer Group Id',
  `customer_group_code` varchar(32) NOT NULL COMMENT 'Customer Group Code',
  `tax_class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tax Class Id',
  PRIMARY KEY (`customer_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Customer Group';

-- ----------------------------
-- Records of customer_group
-- ----------------------------
INSERT INTO `customer_group` VALUES ('0', 'NOT LOGGED IN', '3');
INSERT INTO `customer_group` VALUES ('1', 'General', '3');
INSERT INTO `customer_group` VALUES ('2', 'Wholesale', '3');
INSERT INTO `customer_group` VALUES ('3', 'Retailer', '3');

-- ----------------------------
-- Table structure for dataflow_batch
-- ----------------------------
DROP TABLE IF EXISTS `dataflow_batch`;
CREATE TABLE `dataflow_batch` (
  `batch_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `adapter` varchar(128) DEFAULT NULL COMMENT 'Adapter',
  `params` text COMMENT 'Parameters',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`batch_id`),
  KEY `IDX_DATAFLOW_BATCH_PROFILE_ID` (`profile_id`),
  KEY `IDX_DATAFLOW_BATCH_STORE_ID` (`store_id`),
  KEY `IDX_DATAFLOW_BATCH_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_DATAFLOW_BATCH_PROFILE_ID_DATAFLOW_PROFILE_PROFILE_ID` FOREIGN KEY (`profile_id`) REFERENCES `dataflow_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_DATAFLOW_BATCH_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch';

-- ----------------------------
-- Records of dataflow_batch
-- ----------------------------

-- ----------------------------
-- Table structure for dataflow_batch_export
-- ----------------------------
DROP TABLE IF EXISTS `dataflow_batch_export`;
CREATE TABLE `dataflow_batch_export` (
  `batch_export_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Export Id',
  `batch_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Batch Id',
  `batch_data` longtext COMMENT 'Batch Data',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`batch_export_id`),
  KEY `IDX_DATAFLOW_BATCH_EXPORT_BATCH_ID` (`batch_id`),
  CONSTRAINT `FK_DATAFLOW_BATCH_EXPORT_BATCH_ID_DATAFLOW_BATCH_BATCH_ID` FOREIGN KEY (`batch_id`) REFERENCES `dataflow_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch Export';

-- ----------------------------
-- Records of dataflow_batch_export
-- ----------------------------

-- ----------------------------
-- Table structure for dataflow_batch_import
-- ----------------------------
DROP TABLE IF EXISTS `dataflow_batch_import`;
CREATE TABLE `dataflow_batch_import` (
  `batch_import_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Import Id',
  `batch_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Batch Id',
  `batch_data` longtext COMMENT 'Batch Data',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`batch_import_id`),
  KEY `IDX_DATAFLOW_BATCH_IMPORT_BATCH_ID` (`batch_id`),
  CONSTRAINT `FK_DATAFLOW_BATCH_IMPORT_BATCH_ID_DATAFLOW_BATCH_BATCH_ID` FOREIGN KEY (`batch_id`) REFERENCES `dataflow_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch Import';

-- ----------------------------
-- Records of dataflow_batch_import
-- ----------------------------

-- ----------------------------
-- Table structure for dataflow_import_data
-- ----------------------------
DROP TABLE IF EXISTS `dataflow_import_data`;
CREATE TABLE `dataflow_import_data` (
  `import_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Import Id',
  `session_id` int(11) DEFAULT NULL COMMENT 'Session Id',
  `serial_number` int(11) NOT NULL DEFAULT '0' COMMENT 'Serial Number',
  `value` text COMMENT 'Value',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`import_id`),
  KEY `IDX_DATAFLOW_IMPORT_DATA_SESSION_ID` (`session_id`),
  CONSTRAINT `FK_DATAFLOW_IMPORT_DATA_SESSION_ID_DATAFLOW_SESSION_SESSION_ID` FOREIGN KEY (`session_id`) REFERENCES `dataflow_session` (`session_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Import Data';

-- ----------------------------
-- Records of dataflow_import_data
-- ----------------------------

-- ----------------------------
-- Table structure for dataflow_profile
-- ----------------------------
DROP TABLE IF EXISTS `dataflow_profile`;
CREATE TABLE `dataflow_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Profile Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `actions_xml` text COMMENT 'Actions Xml',
  `gui_data` text COMMENT 'Gui Data',
  `direction` varchar(6) DEFAULT NULL COMMENT 'Direction',
  `entity_type` varchar(64) DEFAULT NULL COMMENT 'Entity Type',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `data_transfer` varchar(11) DEFAULT NULL COMMENT 'Data Transfer',
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Dataflow Profile';

-- ----------------------------
-- Records of dataflow_profile
-- ----------------------------
INSERT INTO `dataflow_profile` VALUES ('1', 'Export All Products', '2015-08-06 05:56:53', '2015-08-06 05:56:53', '<action type=\"catalog/convert_adapter_product\" method=\"load\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"catalog/convert_parser_product\" method=\"unparse\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_mapper_column\" method=\"map\">\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_parser_csv\" method=\"unparse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_adapter_io\" method=\"save\">\\r\\n    <var name=\"type\">file</var>\\r\\n    <var name=\"path\">var/export</var>\\r\\n    <var name=\"filename\"><![CDATA[export_all_products.csv]]></var>\\r\\n</action>\\r\\n\\r\\n', 'a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:23:\"export_all_products.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}', 'export', 'product', '0', 'file');
INSERT INTO `dataflow_profile` VALUES ('2', 'Export Product Stocks', '2015-08-06 05:56:53', '2015-08-06 05:56:53', '<action type=\"catalog/convert_adapter_product\" method=\"load\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"catalog/convert_parser_product\" method=\"unparse\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_mapper_column\" method=\"map\">\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_parser_csv\" method=\"unparse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_adapter_io\" method=\"save\">\\r\\n    <var name=\"type\">file</var>\\r\\n    <var name=\"path\">var/export</var>\\r\\n    <var name=\"filename\"><![CDATA[export_all_products.csv]]></var>\\r\\n</action>\\r\\n\\r\\n', 'a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:25:\"export_product_stocks.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:4:\"true\";s:7:\"product\";a:2:{s:2:\"db\";a:4:{i:1;s:5:\"store\";i:2;s:3:\"sku\";i:3;s:3:\"qty\";i:4;s:11:\"is_in_stock\";}s:4:\"file\";a:4:{i:1;s:5:\"store\";i:2;s:3:\"sku\";i:3;s:3:\"qty\";i:4;s:11:\"is_in_stock\";}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}', 'export', 'product', '0', 'file');
INSERT INTO `dataflow_profile` VALUES ('3', 'Import All Products', '2015-08-06 05:56:53', '2015-08-06 05:56:53', '<action type=\"dataflow/convert_parser_csv\" method=\"parse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"adapter\">catalog/convert_adapter_product</var>\\r\\n    <var name=\"method\">parse</var>\\r\\n</action>', 'a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:23:\"export_all_products.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}', 'import', 'product', '0', 'interactive');
INSERT INTO `dataflow_profile` VALUES ('4', 'Import Product Stocks', '2015-08-06 05:56:53', '2015-08-06 05:56:53', '<action type=\"dataflow/convert_parser_csv\" method=\"parse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"adapter\">catalog/convert_adapter_product</var>\\r\\n    <var name=\"method\">parse</var>\\r\\n</action>', 'a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:18:\"export_product.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}', 'import', 'product', '0', 'interactive');
INSERT INTO `dataflow_profile` VALUES ('5', 'Export Customers', '2015-08-06 05:56:53', '2015-08-06 05:56:53', '<action type=\"customer/convert_adapter_customer\" method=\"load\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"filter/adressType\"><![CDATA[default_billing]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"customer/convert_parser_customer\" method=\"unparse\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_mapper_column\" method=\"map\">\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_parser_csv\" method=\"unparse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_adapter_io\" method=\"save\">\\r\\n    <var name=\"type\">file</var>\\r\\n    <var name=\"path\">var/export</var>\\r\\n    <var name=\"filename\"><![CDATA[export_customers.csv]]></var>\\r\\n</action>\\r\\n\\r\\n', 'a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:20:\"export_customers.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}', 'export', 'customer', '0', 'file');
INSERT INTO `dataflow_profile` VALUES ('6', 'Import Customers', '2015-08-06 05:56:53', '2015-08-06 05:56:53', '<action type=\"dataflow/convert_parser_csv\" method=\"parse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"adapter\">customer/convert_adapter_customer</var>\\r\\n    <var name=\"method\">parse</var>\\r\\n</action>', 'a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:19:\"export_customer.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}', 'import', 'customer', '0', 'interactive');

-- ----------------------------
-- Table structure for dataflow_profile_history
-- ----------------------------
DROP TABLE IF EXISTS `dataflow_profile_history`;
CREATE TABLE `dataflow_profile_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Id',
  `action_code` varchar(64) DEFAULT NULL COMMENT 'Action Code',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User Id',
  `performed_at` timestamp NULL DEFAULT NULL COMMENT 'Performed At',
  PRIMARY KEY (`history_id`),
  KEY `IDX_DATAFLOW_PROFILE_HISTORY_PROFILE_ID` (`profile_id`),
  CONSTRAINT `FK_AEA06B0C500063D3CE6EA671AE776645` FOREIGN KEY (`profile_id`) REFERENCES `dataflow_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Dataflow Profile History';

-- ----------------------------
-- Records of dataflow_profile_history
-- ----------------------------
INSERT INTO `dataflow_profile_history` VALUES ('1', '1', 'create', '0', '2015-08-06 05:56:53');
INSERT INTO `dataflow_profile_history` VALUES ('2', '2', 'create', '0', '2015-08-06 05:56:53');
INSERT INTO `dataflow_profile_history` VALUES ('3', '3', 'create', '0', '2015-08-06 05:56:53');
INSERT INTO `dataflow_profile_history` VALUES ('4', '4', 'create', '0', '2015-08-06 05:56:53');
INSERT INTO `dataflow_profile_history` VALUES ('5', '5', 'create', '0', '2015-08-06 05:56:53');
INSERT INTO `dataflow_profile_history` VALUES ('6', '6', 'create', '0', '2015-08-06 05:56:53');

-- ----------------------------
-- Table structure for dataflow_session
-- ----------------------------
DROP TABLE IF EXISTS `dataflow_session`;
CREATE TABLE `dataflow_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Session Id',
  `user_id` int(11) NOT NULL COMMENT 'User Id',
  `created_date` timestamp NULL DEFAULT NULL COMMENT 'Created Date',
  `file` varchar(255) DEFAULT NULL COMMENT 'File',
  `type` varchar(32) DEFAULT NULL COMMENT 'Type',
  `direction` varchar(32) DEFAULT NULL COMMENT 'Direction',
  `comment` varchar(255) DEFAULT NULL COMMENT 'Comment',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Session';

-- ----------------------------
-- Records of dataflow_session
-- ----------------------------

-- ----------------------------
-- Table structure for design_change
-- ----------------------------
DROP TABLE IF EXISTS `design_change`;
CREATE TABLE `design_change` (
  `design_change_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Design Change Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `design` varchar(255) DEFAULT NULL COMMENT 'Design',
  `date_from` date DEFAULT NULL COMMENT 'First Date of Design Activity',
  `date_to` date DEFAULT NULL COMMENT 'Last Date of Design Activity',
  PRIMARY KEY (`design_change_id`),
  KEY `IDX_DESIGN_CHANGE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_DESIGN_CHANGE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Design Changes';

-- ----------------------------
-- Records of design_change
-- ----------------------------

-- ----------------------------
-- Table structure for directory_country
-- ----------------------------
DROP TABLE IF EXISTS `directory_country`;
CREATE TABLE `directory_country` (
  `country_id` varchar(2) NOT NULL DEFAULT '' COMMENT 'Country Id in ISO-2',
  `iso2_code` varchar(2) DEFAULT NULL COMMENT 'Country ISO-2 format',
  `iso3_code` varchar(3) DEFAULT NULL COMMENT 'Country ISO-3',
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country';

-- ----------------------------
-- Records of directory_country
-- ----------------------------
INSERT INTO `directory_country` VALUES ('AD', 'AD', 'AND');
INSERT INTO `directory_country` VALUES ('AE', 'AE', 'ARE');
INSERT INTO `directory_country` VALUES ('AF', 'AF', 'AFG');
INSERT INTO `directory_country` VALUES ('AG', 'AG', 'ATG');
INSERT INTO `directory_country` VALUES ('AI', 'AI', 'AIA');
INSERT INTO `directory_country` VALUES ('AL', 'AL', 'ALB');
INSERT INTO `directory_country` VALUES ('AM', 'AM', 'ARM');
INSERT INTO `directory_country` VALUES ('AN', 'AN', 'ANT');
INSERT INTO `directory_country` VALUES ('AO', 'AO', 'AGO');
INSERT INTO `directory_country` VALUES ('AQ', 'AQ', 'ATA');
INSERT INTO `directory_country` VALUES ('AR', 'AR', 'ARG');
INSERT INTO `directory_country` VALUES ('AS', 'AS', 'ASM');
INSERT INTO `directory_country` VALUES ('AT', 'AT', 'AUT');
INSERT INTO `directory_country` VALUES ('AU', 'AU', 'AUS');
INSERT INTO `directory_country` VALUES ('AW', 'AW', 'ABW');
INSERT INTO `directory_country` VALUES ('AX', 'AX', 'ALA');
INSERT INTO `directory_country` VALUES ('AZ', 'AZ', 'AZE');
INSERT INTO `directory_country` VALUES ('BA', 'BA', 'BIH');
INSERT INTO `directory_country` VALUES ('BB', 'BB', 'BRB');
INSERT INTO `directory_country` VALUES ('BD', 'BD', 'BGD');
INSERT INTO `directory_country` VALUES ('BE', 'BE', 'BEL');
INSERT INTO `directory_country` VALUES ('BF', 'BF', 'BFA');
INSERT INTO `directory_country` VALUES ('BG', 'BG', 'BGR');
INSERT INTO `directory_country` VALUES ('BH', 'BH', 'BHR');
INSERT INTO `directory_country` VALUES ('BI', 'BI', 'BDI');
INSERT INTO `directory_country` VALUES ('BJ', 'BJ', 'BEN');
INSERT INTO `directory_country` VALUES ('BL', 'BL', 'BLM');
INSERT INTO `directory_country` VALUES ('BM', 'BM', 'BMU');
INSERT INTO `directory_country` VALUES ('BN', 'BN', 'BRN');
INSERT INTO `directory_country` VALUES ('BO', 'BO', 'BOL');
INSERT INTO `directory_country` VALUES ('BR', 'BR', 'BRA');
INSERT INTO `directory_country` VALUES ('BS', 'BS', 'BHS');
INSERT INTO `directory_country` VALUES ('BT', 'BT', 'BTN');
INSERT INTO `directory_country` VALUES ('BV', 'BV', 'BVT');
INSERT INTO `directory_country` VALUES ('BW', 'BW', 'BWA');
INSERT INTO `directory_country` VALUES ('BY', 'BY', 'BLR');
INSERT INTO `directory_country` VALUES ('BZ', 'BZ', 'BLZ');
INSERT INTO `directory_country` VALUES ('CA', 'CA', 'CAN');
INSERT INTO `directory_country` VALUES ('CC', 'CC', 'CCK');
INSERT INTO `directory_country` VALUES ('CD', 'CD', 'COD');
INSERT INTO `directory_country` VALUES ('CF', 'CF', 'CAF');
INSERT INTO `directory_country` VALUES ('CG', 'CG', 'COG');
INSERT INTO `directory_country` VALUES ('CH', 'CH', 'CHE');
INSERT INTO `directory_country` VALUES ('CI', 'CI', 'CIV');
INSERT INTO `directory_country` VALUES ('CK', 'CK', 'COK');
INSERT INTO `directory_country` VALUES ('CL', 'CL', 'CHL');
INSERT INTO `directory_country` VALUES ('CM', 'CM', 'CMR');
INSERT INTO `directory_country` VALUES ('CN', 'CN', 'CHN');
INSERT INTO `directory_country` VALUES ('CO', 'CO', 'COL');
INSERT INTO `directory_country` VALUES ('CR', 'CR', 'CRI');
INSERT INTO `directory_country` VALUES ('CU', 'CU', 'CUB');
INSERT INTO `directory_country` VALUES ('CV', 'CV', 'CPV');
INSERT INTO `directory_country` VALUES ('CX', 'CX', 'CXR');
INSERT INTO `directory_country` VALUES ('CY', 'CY', 'CYP');
INSERT INTO `directory_country` VALUES ('CZ', 'CZ', 'CZE');
INSERT INTO `directory_country` VALUES ('DE', 'DE', 'DEU');
INSERT INTO `directory_country` VALUES ('DJ', 'DJ', 'DJI');
INSERT INTO `directory_country` VALUES ('DK', 'DK', 'DNK');
INSERT INTO `directory_country` VALUES ('DM', 'DM', 'DMA');
INSERT INTO `directory_country` VALUES ('DO', 'DO', 'DOM');
INSERT INTO `directory_country` VALUES ('DZ', 'DZ', 'DZA');
INSERT INTO `directory_country` VALUES ('EC', 'EC', 'ECU');
INSERT INTO `directory_country` VALUES ('EE', 'EE', 'EST');
INSERT INTO `directory_country` VALUES ('EG', 'EG', 'EGY');
INSERT INTO `directory_country` VALUES ('EH', 'EH', 'ESH');
INSERT INTO `directory_country` VALUES ('ER', 'ER', 'ERI');
INSERT INTO `directory_country` VALUES ('ES', 'ES', 'ESP');
INSERT INTO `directory_country` VALUES ('ET', 'ET', 'ETH');
INSERT INTO `directory_country` VALUES ('FI', 'FI', 'FIN');
INSERT INTO `directory_country` VALUES ('FJ', 'FJ', 'FJI');
INSERT INTO `directory_country` VALUES ('FK', 'FK', 'FLK');
INSERT INTO `directory_country` VALUES ('FM', 'FM', 'FSM');
INSERT INTO `directory_country` VALUES ('FO', 'FO', 'FRO');
INSERT INTO `directory_country` VALUES ('FR', 'FR', 'FRA');
INSERT INTO `directory_country` VALUES ('GA', 'GA', 'GAB');
INSERT INTO `directory_country` VALUES ('GB', 'GB', 'GBR');
INSERT INTO `directory_country` VALUES ('GD', 'GD', 'GRD');
INSERT INTO `directory_country` VALUES ('GE', 'GE', 'GEO');
INSERT INTO `directory_country` VALUES ('GF', 'GF', 'GUF');
INSERT INTO `directory_country` VALUES ('GG', 'GG', 'GGY');
INSERT INTO `directory_country` VALUES ('GH', 'GH', 'GHA');
INSERT INTO `directory_country` VALUES ('GI', 'GI', 'GIB');
INSERT INTO `directory_country` VALUES ('GL', 'GL', 'GRL');
INSERT INTO `directory_country` VALUES ('GM', 'GM', 'GMB');
INSERT INTO `directory_country` VALUES ('GN', 'GN', 'GIN');
INSERT INTO `directory_country` VALUES ('GP', 'GP', 'GLP');
INSERT INTO `directory_country` VALUES ('GQ', 'GQ', 'GNQ');
INSERT INTO `directory_country` VALUES ('GR', 'GR', 'GRC');
INSERT INTO `directory_country` VALUES ('GS', 'GS', 'SGS');
INSERT INTO `directory_country` VALUES ('GT', 'GT', 'GTM');
INSERT INTO `directory_country` VALUES ('GU', 'GU', 'GUM');
INSERT INTO `directory_country` VALUES ('GW', 'GW', 'GNB');
INSERT INTO `directory_country` VALUES ('GY', 'GY', 'GUY');
INSERT INTO `directory_country` VALUES ('HK', 'HK', 'HKG');
INSERT INTO `directory_country` VALUES ('HM', 'HM', 'HMD');
INSERT INTO `directory_country` VALUES ('HN', 'HN', 'HND');
INSERT INTO `directory_country` VALUES ('HR', 'HR', 'HRV');
INSERT INTO `directory_country` VALUES ('HT', 'HT', 'HTI');
INSERT INTO `directory_country` VALUES ('HU', 'HU', 'HUN');
INSERT INTO `directory_country` VALUES ('ID', 'ID', 'IDN');
INSERT INTO `directory_country` VALUES ('IE', 'IE', 'IRL');
INSERT INTO `directory_country` VALUES ('IL', 'IL', 'ISR');
INSERT INTO `directory_country` VALUES ('IM', 'IM', 'IMN');
INSERT INTO `directory_country` VALUES ('IN', 'IN', 'IND');
INSERT INTO `directory_country` VALUES ('IO', 'IO', 'IOT');
INSERT INTO `directory_country` VALUES ('IQ', 'IQ', 'IRQ');
INSERT INTO `directory_country` VALUES ('IR', 'IR', 'IRN');
INSERT INTO `directory_country` VALUES ('IS', 'IS', 'ISL');
INSERT INTO `directory_country` VALUES ('IT', 'IT', 'ITA');
INSERT INTO `directory_country` VALUES ('JE', 'JE', 'JEY');
INSERT INTO `directory_country` VALUES ('JM', 'JM', 'JAM');
INSERT INTO `directory_country` VALUES ('JO', 'JO', 'JOR');
INSERT INTO `directory_country` VALUES ('JP', 'JP', 'JPN');
INSERT INTO `directory_country` VALUES ('KE', 'KE', 'KEN');
INSERT INTO `directory_country` VALUES ('KG', 'KG', 'KGZ');
INSERT INTO `directory_country` VALUES ('KH', 'KH', 'KHM');
INSERT INTO `directory_country` VALUES ('KI', 'KI', 'KIR');
INSERT INTO `directory_country` VALUES ('KM', 'KM', 'COM');
INSERT INTO `directory_country` VALUES ('KN', 'KN', 'KNA');
INSERT INTO `directory_country` VALUES ('KP', 'KP', 'PRK');
INSERT INTO `directory_country` VALUES ('KR', 'KR', 'KOR');
INSERT INTO `directory_country` VALUES ('KW', 'KW', 'KWT');
INSERT INTO `directory_country` VALUES ('KY', 'KY', 'CYM');
INSERT INTO `directory_country` VALUES ('KZ', 'KZ', 'KAZ');
INSERT INTO `directory_country` VALUES ('LA', 'LA', 'LAO');
INSERT INTO `directory_country` VALUES ('LB', 'LB', 'LBN');
INSERT INTO `directory_country` VALUES ('LC', 'LC', 'LCA');
INSERT INTO `directory_country` VALUES ('LI', 'LI', 'LIE');
INSERT INTO `directory_country` VALUES ('LK', 'LK', 'LKA');
INSERT INTO `directory_country` VALUES ('LR', 'LR', 'LBR');
INSERT INTO `directory_country` VALUES ('LS', 'LS', 'LSO');
INSERT INTO `directory_country` VALUES ('LT', 'LT', 'LTU');
INSERT INTO `directory_country` VALUES ('LU', 'LU', 'LUX');
INSERT INTO `directory_country` VALUES ('LV', 'LV', 'LVA');
INSERT INTO `directory_country` VALUES ('LY', 'LY', 'LBY');
INSERT INTO `directory_country` VALUES ('MA', 'MA', 'MAR');
INSERT INTO `directory_country` VALUES ('MC', 'MC', 'MCO');
INSERT INTO `directory_country` VALUES ('MD', 'MD', 'MDA');
INSERT INTO `directory_country` VALUES ('ME', 'ME', 'MNE');
INSERT INTO `directory_country` VALUES ('MF', 'MF', 'MAF');
INSERT INTO `directory_country` VALUES ('MG', 'MG', 'MDG');
INSERT INTO `directory_country` VALUES ('MH', 'MH', 'MHL');
INSERT INTO `directory_country` VALUES ('MK', 'MK', 'MKD');
INSERT INTO `directory_country` VALUES ('ML', 'ML', 'MLI');
INSERT INTO `directory_country` VALUES ('MM', 'MM', 'MMR');
INSERT INTO `directory_country` VALUES ('MN', 'MN', 'MNG');
INSERT INTO `directory_country` VALUES ('MO', 'MO', 'MAC');
INSERT INTO `directory_country` VALUES ('MP', 'MP', 'MNP');
INSERT INTO `directory_country` VALUES ('MQ', 'MQ', 'MTQ');
INSERT INTO `directory_country` VALUES ('MR', 'MR', 'MRT');
INSERT INTO `directory_country` VALUES ('MS', 'MS', 'MSR');
INSERT INTO `directory_country` VALUES ('MT', 'MT', 'MLT');
INSERT INTO `directory_country` VALUES ('MU', 'MU', 'MUS');
INSERT INTO `directory_country` VALUES ('MV', 'MV', 'MDV');
INSERT INTO `directory_country` VALUES ('MW', 'MW', 'MWI');
INSERT INTO `directory_country` VALUES ('MX', 'MX', 'MEX');
INSERT INTO `directory_country` VALUES ('MY', 'MY', 'MYS');
INSERT INTO `directory_country` VALUES ('MZ', 'MZ', 'MOZ');
INSERT INTO `directory_country` VALUES ('NA', 'NA', 'NAM');
INSERT INTO `directory_country` VALUES ('NC', 'NC', 'NCL');
INSERT INTO `directory_country` VALUES ('NE', 'NE', 'NER');
INSERT INTO `directory_country` VALUES ('NF', 'NF', 'NFK');
INSERT INTO `directory_country` VALUES ('NG', 'NG', 'NGA');
INSERT INTO `directory_country` VALUES ('NI', 'NI', 'NIC');
INSERT INTO `directory_country` VALUES ('NL', 'NL', 'NLD');
INSERT INTO `directory_country` VALUES ('NO', 'NO', 'NOR');
INSERT INTO `directory_country` VALUES ('NP', 'NP', 'NPL');
INSERT INTO `directory_country` VALUES ('NR', 'NR', 'NRU');
INSERT INTO `directory_country` VALUES ('NU', 'NU', 'NIU');
INSERT INTO `directory_country` VALUES ('NZ', 'NZ', 'NZL');
INSERT INTO `directory_country` VALUES ('OM', 'OM', 'OMN');
INSERT INTO `directory_country` VALUES ('PA', 'PA', 'PAN');
INSERT INTO `directory_country` VALUES ('PE', 'PE', 'PER');
INSERT INTO `directory_country` VALUES ('PF', 'PF', 'PYF');
INSERT INTO `directory_country` VALUES ('PG', 'PG', 'PNG');
INSERT INTO `directory_country` VALUES ('PH', 'PH', 'PHL');
INSERT INTO `directory_country` VALUES ('PK', 'PK', 'PAK');
INSERT INTO `directory_country` VALUES ('PL', 'PL', 'POL');
INSERT INTO `directory_country` VALUES ('PM', 'PM', 'SPM');
INSERT INTO `directory_country` VALUES ('PN', 'PN', 'PCN');
INSERT INTO `directory_country` VALUES ('PR', 'PR', 'PRI');
INSERT INTO `directory_country` VALUES ('PS', 'PS', 'PSE');
INSERT INTO `directory_country` VALUES ('PT', 'PT', 'PRT');
INSERT INTO `directory_country` VALUES ('PW', 'PW', 'PLW');
INSERT INTO `directory_country` VALUES ('PY', 'PY', 'PRY');
INSERT INTO `directory_country` VALUES ('QA', 'QA', 'QAT');
INSERT INTO `directory_country` VALUES ('RE', 'RE', 'REU');
INSERT INTO `directory_country` VALUES ('RO', 'RO', 'ROU');
INSERT INTO `directory_country` VALUES ('RS', 'RS', 'SRB');
INSERT INTO `directory_country` VALUES ('RU', 'RU', 'RUS');
INSERT INTO `directory_country` VALUES ('RW', 'RW', 'RWA');
INSERT INTO `directory_country` VALUES ('SA', 'SA', 'SAU');
INSERT INTO `directory_country` VALUES ('SB', 'SB', 'SLB');
INSERT INTO `directory_country` VALUES ('SC', 'SC', 'SYC');
INSERT INTO `directory_country` VALUES ('SD', 'SD', 'SDN');
INSERT INTO `directory_country` VALUES ('SE', 'SE', 'SWE');
INSERT INTO `directory_country` VALUES ('SG', 'SG', 'SGP');
INSERT INTO `directory_country` VALUES ('SH', 'SH', 'SHN');
INSERT INTO `directory_country` VALUES ('SI', 'SI', 'SVN');
INSERT INTO `directory_country` VALUES ('SJ', 'SJ', 'SJM');
INSERT INTO `directory_country` VALUES ('SK', 'SK', 'SVK');
INSERT INTO `directory_country` VALUES ('SL', 'SL', 'SLE');
INSERT INTO `directory_country` VALUES ('SM', 'SM', 'SMR');
INSERT INTO `directory_country` VALUES ('SN', 'SN', 'SEN');
INSERT INTO `directory_country` VALUES ('SO', 'SO', 'SOM');
INSERT INTO `directory_country` VALUES ('SR', 'SR', 'SUR');
INSERT INTO `directory_country` VALUES ('ST', 'ST', 'STP');
INSERT INTO `directory_country` VALUES ('SV', 'SV', 'SLV');
INSERT INTO `directory_country` VALUES ('SY', 'SY', 'SYR');
INSERT INTO `directory_country` VALUES ('SZ', 'SZ', 'SWZ');
INSERT INTO `directory_country` VALUES ('TC', 'TC', 'TCA');
INSERT INTO `directory_country` VALUES ('TD', 'TD', 'TCD');
INSERT INTO `directory_country` VALUES ('TF', 'TF', 'ATF');
INSERT INTO `directory_country` VALUES ('TG', 'TG', 'TGO');
INSERT INTO `directory_country` VALUES ('TH', 'TH', 'THA');
INSERT INTO `directory_country` VALUES ('TJ', 'TJ', 'TJK');
INSERT INTO `directory_country` VALUES ('TK', 'TK', 'TKL');
INSERT INTO `directory_country` VALUES ('TL', 'TL', 'TLS');
INSERT INTO `directory_country` VALUES ('TM', 'TM', 'TKM');
INSERT INTO `directory_country` VALUES ('TN', 'TN', 'TUN');
INSERT INTO `directory_country` VALUES ('TO', 'TO', 'TON');
INSERT INTO `directory_country` VALUES ('TR', 'TR', 'TUR');
INSERT INTO `directory_country` VALUES ('TT', 'TT', 'TTO');
INSERT INTO `directory_country` VALUES ('TV', 'TV', 'TUV');
INSERT INTO `directory_country` VALUES ('TW', 'TW', 'TWN');
INSERT INTO `directory_country` VALUES ('TZ', 'TZ', 'TZA');
INSERT INTO `directory_country` VALUES ('UA', 'UA', 'UKR');
INSERT INTO `directory_country` VALUES ('UG', 'UG', 'UGA');
INSERT INTO `directory_country` VALUES ('UM', 'UM', 'UMI');
INSERT INTO `directory_country` VALUES ('US', 'US', 'USA');
INSERT INTO `directory_country` VALUES ('UY', 'UY', 'URY');
INSERT INTO `directory_country` VALUES ('UZ', 'UZ', 'UZB');
INSERT INTO `directory_country` VALUES ('VA', 'VA', 'VAT');
INSERT INTO `directory_country` VALUES ('VC', 'VC', 'VCT');
INSERT INTO `directory_country` VALUES ('VE', 'VE', 'VEN');
INSERT INTO `directory_country` VALUES ('VG', 'VG', 'VGB');
INSERT INTO `directory_country` VALUES ('VI', 'VI', 'VIR');
INSERT INTO `directory_country` VALUES ('VN', 'VN', 'VNM');
INSERT INTO `directory_country` VALUES ('VU', 'VU', 'VUT');
INSERT INTO `directory_country` VALUES ('WF', 'WF', 'WLF');
INSERT INTO `directory_country` VALUES ('WS', 'WS', 'WSM');
INSERT INTO `directory_country` VALUES ('YE', 'YE', 'YEM');
INSERT INTO `directory_country` VALUES ('YT', 'YT', 'MYT');
INSERT INTO `directory_country` VALUES ('ZA', 'ZA', 'ZAF');
INSERT INTO `directory_country` VALUES ('ZM', 'ZM', 'ZMB');
INSERT INTO `directory_country` VALUES ('ZW', 'ZW', 'ZWE');

-- ----------------------------
-- Table structure for directory_country_format
-- ----------------------------
DROP TABLE IF EXISTS `directory_country_format`;
CREATE TABLE `directory_country_format` (
  `country_format_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Country Format Id',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id in ISO-2',
  `type` varchar(30) DEFAULT NULL COMMENT 'Country Format Type',
  `format` text NOT NULL COMMENT 'Country Format',
  PRIMARY KEY (`country_format_id`),
  UNIQUE KEY `UNQ_DIRECTORY_COUNTRY_FORMAT_COUNTRY_ID_TYPE` (`country_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Format';

-- ----------------------------
-- Records of directory_country_format
-- ----------------------------

-- ----------------------------
-- Table structure for directory_country_region
-- ----------------------------
DROP TABLE IF EXISTS `directory_country_region`;
CREATE TABLE `directory_country_region` (
  `region_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Region Id',
  `country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Country Id in ISO-2',
  `code` varchar(32) DEFAULT NULL COMMENT 'Region code',
  `default_name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`region_id`),
  KEY `IDX_DIRECTORY_COUNTRY_REGION_COUNTRY_ID` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=485 DEFAULT CHARSET=utf8 COMMENT='Directory Country Region';

-- ----------------------------
-- Records of directory_country_region
-- ----------------------------
INSERT INTO `directory_country_region` VALUES ('1', 'US', 'AL', 'Alabama');
INSERT INTO `directory_country_region` VALUES ('2', 'US', 'AK', 'Alaska');
INSERT INTO `directory_country_region` VALUES ('3', 'US', 'AS', 'American Samoa');
INSERT INTO `directory_country_region` VALUES ('4', 'US', 'AZ', 'Arizona');
INSERT INTO `directory_country_region` VALUES ('5', 'US', 'AR', 'Arkansas');
INSERT INTO `directory_country_region` VALUES ('6', 'US', 'AF', 'Armed Forces Africa');
INSERT INTO `directory_country_region` VALUES ('7', 'US', 'AA', 'Armed Forces Americas');
INSERT INTO `directory_country_region` VALUES ('8', 'US', 'AC', 'Armed Forces Canada');
INSERT INTO `directory_country_region` VALUES ('9', 'US', 'AE', 'Armed Forces Europe');
INSERT INTO `directory_country_region` VALUES ('10', 'US', 'AM', 'Armed Forces Middle East');
INSERT INTO `directory_country_region` VALUES ('11', 'US', 'AP', 'Armed Forces Pacific');
INSERT INTO `directory_country_region` VALUES ('12', 'US', 'CA', 'California');
INSERT INTO `directory_country_region` VALUES ('13', 'US', 'CO', 'Colorado');
INSERT INTO `directory_country_region` VALUES ('14', 'US', 'CT', 'Connecticut');
INSERT INTO `directory_country_region` VALUES ('15', 'US', 'DE', 'Delaware');
INSERT INTO `directory_country_region` VALUES ('16', 'US', 'DC', 'District of Columbia');
INSERT INTO `directory_country_region` VALUES ('17', 'US', 'FM', 'Federated States Of Micronesia');
INSERT INTO `directory_country_region` VALUES ('18', 'US', 'FL', 'Florida');
INSERT INTO `directory_country_region` VALUES ('19', 'US', 'GA', 'Georgia');
INSERT INTO `directory_country_region` VALUES ('20', 'US', 'GU', 'Guam');
INSERT INTO `directory_country_region` VALUES ('21', 'US', 'HI', 'Hawaii');
INSERT INTO `directory_country_region` VALUES ('22', 'US', 'ID', 'Idaho');
INSERT INTO `directory_country_region` VALUES ('23', 'US', 'IL', 'Illinois');
INSERT INTO `directory_country_region` VALUES ('24', 'US', 'IN', 'Indiana');
INSERT INTO `directory_country_region` VALUES ('25', 'US', 'IA', 'Iowa');
INSERT INTO `directory_country_region` VALUES ('26', 'US', 'KS', 'Kansas');
INSERT INTO `directory_country_region` VALUES ('27', 'US', 'KY', 'Kentucky');
INSERT INTO `directory_country_region` VALUES ('28', 'US', 'LA', 'Louisiana');
INSERT INTO `directory_country_region` VALUES ('29', 'US', 'ME', 'Maine');
INSERT INTO `directory_country_region` VALUES ('30', 'US', 'MH', 'Marshall Islands');
INSERT INTO `directory_country_region` VALUES ('31', 'US', 'MD', 'Maryland');
INSERT INTO `directory_country_region` VALUES ('32', 'US', 'MA', 'Massachusetts');
INSERT INTO `directory_country_region` VALUES ('33', 'US', 'MI', 'Michigan');
INSERT INTO `directory_country_region` VALUES ('34', 'US', 'MN', 'Minnesota');
INSERT INTO `directory_country_region` VALUES ('35', 'US', 'MS', 'Mississippi');
INSERT INTO `directory_country_region` VALUES ('36', 'US', 'MO', 'Missouri');
INSERT INTO `directory_country_region` VALUES ('37', 'US', 'MT', 'Montana');
INSERT INTO `directory_country_region` VALUES ('38', 'US', 'NE', 'Nebraska');
INSERT INTO `directory_country_region` VALUES ('39', 'US', 'NV', 'Nevada');
INSERT INTO `directory_country_region` VALUES ('40', 'US', 'NH', 'New Hampshire');
INSERT INTO `directory_country_region` VALUES ('41', 'US', 'NJ', 'New Jersey');
INSERT INTO `directory_country_region` VALUES ('42', 'US', 'NM', 'New Mexico');
INSERT INTO `directory_country_region` VALUES ('43', 'US', 'NY', 'New York');
INSERT INTO `directory_country_region` VALUES ('44', 'US', 'NC', 'North Carolina');
INSERT INTO `directory_country_region` VALUES ('45', 'US', 'ND', 'North Dakota');
INSERT INTO `directory_country_region` VALUES ('46', 'US', 'MP', 'Northern Mariana Islands');
INSERT INTO `directory_country_region` VALUES ('47', 'US', 'OH', 'Ohio');
INSERT INTO `directory_country_region` VALUES ('48', 'US', 'OK', 'Oklahoma');
INSERT INTO `directory_country_region` VALUES ('49', 'US', 'OR', 'Oregon');
INSERT INTO `directory_country_region` VALUES ('50', 'US', 'PW', 'Palau');
INSERT INTO `directory_country_region` VALUES ('51', 'US', 'PA', 'Pennsylvania');
INSERT INTO `directory_country_region` VALUES ('52', 'US', 'PR', 'Puerto Rico');
INSERT INTO `directory_country_region` VALUES ('53', 'US', 'RI', 'Rhode Island');
INSERT INTO `directory_country_region` VALUES ('54', 'US', 'SC', 'South Carolina');
INSERT INTO `directory_country_region` VALUES ('55', 'US', 'SD', 'South Dakota');
INSERT INTO `directory_country_region` VALUES ('56', 'US', 'TN', 'Tennessee');
INSERT INTO `directory_country_region` VALUES ('57', 'US', 'TX', 'Texas');
INSERT INTO `directory_country_region` VALUES ('58', 'US', 'UT', 'Utah');
INSERT INTO `directory_country_region` VALUES ('59', 'US', 'VT', 'Vermont');
INSERT INTO `directory_country_region` VALUES ('60', 'US', 'VI', 'Virgin Islands');
INSERT INTO `directory_country_region` VALUES ('61', 'US', 'VA', 'Virginia');
INSERT INTO `directory_country_region` VALUES ('62', 'US', 'WA', 'Washington');
INSERT INTO `directory_country_region` VALUES ('63', 'US', 'WV', 'West Virginia');
INSERT INTO `directory_country_region` VALUES ('64', 'US', 'WI', 'Wisconsin');
INSERT INTO `directory_country_region` VALUES ('65', 'US', 'WY', 'Wyoming');
INSERT INTO `directory_country_region` VALUES ('66', 'CA', 'AB', 'Alberta');
INSERT INTO `directory_country_region` VALUES ('67', 'CA', 'BC', 'British Columbia');
INSERT INTO `directory_country_region` VALUES ('68', 'CA', 'MB', 'Manitoba');
INSERT INTO `directory_country_region` VALUES ('69', 'CA', 'NL', 'Newfoundland and Labrador');
INSERT INTO `directory_country_region` VALUES ('70', 'CA', 'NB', 'New Brunswick');
INSERT INTO `directory_country_region` VALUES ('71', 'CA', 'NS', 'Nova Scotia');
INSERT INTO `directory_country_region` VALUES ('72', 'CA', 'NT', 'Northwest Territories');
INSERT INTO `directory_country_region` VALUES ('73', 'CA', 'NU', 'Nunavut');
INSERT INTO `directory_country_region` VALUES ('74', 'CA', 'ON', 'Ontario');
INSERT INTO `directory_country_region` VALUES ('75', 'CA', 'PE', 'Prince Edward Island');
INSERT INTO `directory_country_region` VALUES ('76', 'CA', 'QC', 'Quebec');
INSERT INTO `directory_country_region` VALUES ('77', 'CA', 'SK', 'Saskatchewan');
INSERT INTO `directory_country_region` VALUES ('78', 'CA', 'YT', 'Yukon Territory');
INSERT INTO `directory_country_region` VALUES ('79', 'DE', 'NDS', 'Niedersachsen');
INSERT INTO `directory_country_region` VALUES ('80', 'DE', 'BAW', 'Baden-Württemberg');
INSERT INTO `directory_country_region` VALUES ('81', 'DE', 'BAY', 'Bayern');
INSERT INTO `directory_country_region` VALUES ('82', 'DE', 'BER', 'Berlin');
INSERT INTO `directory_country_region` VALUES ('83', 'DE', 'BRG', 'Brandenburg');
INSERT INTO `directory_country_region` VALUES ('84', 'DE', 'BRE', 'Bremen');
INSERT INTO `directory_country_region` VALUES ('85', 'DE', 'HAM', 'Hamburg');
INSERT INTO `directory_country_region` VALUES ('86', 'DE', 'HES', 'Hessen');
INSERT INTO `directory_country_region` VALUES ('87', 'DE', 'MEC', 'Mecklenburg-Vorpommern');
INSERT INTO `directory_country_region` VALUES ('88', 'DE', 'NRW', 'Nordrhein-Westfalen');
INSERT INTO `directory_country_region` VALUES ('89', 'DE', 'RHE', 'Rheinland-Pfalz');
INSERT INTO `directory_country_region` VALUES ('90', 'DE', 'SAR', 'Saarland');
INSERT INTO `directory_country_region` VALUES ('91', 'DE', 'SAS', 'Sachsen');
INSERT INTO `directory_country_region` VALUES ('92', 'DE', 'SAC', 'Sachsen-Anhalt');
INSERT INTO `directory_country_region` VALUES ('93', 'DE', 'SCN', 'Schleswig-Holstein');
INSERT INTO `directory_country_region` VALUES ('94', 'DE', 'THE', 'Thüringen');
INSERT INTO `directory_country_region` VALUES ('95', 'AT', 'WI', 'Wien');
INSERT INTO `directory_country_region` VALUES ('96', 'AT', 'NO', 'Niederösterreich');
INSERT INTO `directory_country_region` VALUES ('97', 'AT', 'OO', 'Oberösterreich');
INSERT INTO `directory_country_region` VALUES ('98', 'AT', 'SB', 'Salzburg');
INSERT INTO `directory_country_region` VALUES ('99', 'AT', 'KN', 'Kärnten');
INSERT INTO `directory_country_region` VALUES ('100', 'AT', 'ST', 'Steiermark');
INSERT INTO `directory_country_region` VALUES ('101', 'AT', 'TI', 'Tirol');
INSERT INTO `directory_country_region` VALUES ('102', 'AT', 'BL', 'Burgenland');
INSERT INTO `directory_country_region` VALUES ('103', 'AT', 'VB', 'Vorarlberg');
INSERT INTO `directory_country_region` VALUES ('104', 'CH', 'AG', 'Aargau');
INSERT INTO `directory_country_region` VALUES ('105', 'CH', 'AI', 'Appenzell Innerrhoden');
INSERT INTO `directory_country_region` VALUES ('106', 'CH', 'AR', 'Appenzell Ausserrhoden');
INSERT INTO `directory_country_region` VALUES ('107', 'CH', 'BE', 'Bern');
INSERT INTO `directory_country_region` VALUES ('108', 'CH', 'BL', 'Basel-Landschaft');
INSERT INTO `directory_country_region` VALUES ('109', 'CH', 'BS', 'Basel-Stadt');
INSERT INTO `directory_country_region` VALUES ('110', 'CH', 'FR', 'Freiburg');
INSERT INTO `directory_country_region` VALUES ('111', 'CH', 'GE', 'Genf');
INSERT INTO `directory_country_region` VALUES ('112', 'CH', 'GL', 'Glarus');
INSERT INTO `directory_country_region` VALUES ('113', 'CH', 'GR', 'Graubünden');
INSERT INTO `directory_country_region` VALUES ('114', 'CH', 'JU', 'Jura');
INSERT INTO `directory_country_region` VALUES ('115', 'CH', 'LU', 'Luzern');
INSERT INTO `directory_country_region` VALUES ('116', 'CH', 'NE', 'Neuenburg');
INSERT INTO `directory_country_region` VALUES ('117', 'CH', 'NW', 'Nidwalden');
INSERT INTO `directory_country_region` VALUES ('118', 'CH', 'OW', 'Obwalden');
INSERT INTO `directory_country_region` VALUES ('119', 'CH', 'SG', 'St. Gallen');
INSERT INTO `directory_country_region` VALUES ('120', 'CH', 'SH', 'Schaffhausen');
INSERT INTO `directory_country_region` VALUES ('121', 'CH', 'SO', 'Solothurn');
INSERT INTO `directory_country_region` VALUES ('122', 'CH', 'SZ', 'Schwyz');
INSERT INTO `directory_country_region` VALUES ('123', 'CH', 'TG', 'Thurgau');
INSERT INTO `directory_country_region` VALUES ('124', 'CH', 'TI', 'Tessin');
INSERT INTO `directory_country_region` VALUES ('125', 'CH', 'UR', 'Uri');
INSERT INTO `directory_country_region` VALUES ('126', 'CH', 'VD', 'Waadt');
INSERT INTO `directory_country_region` VALUES ('127', 'CH', 'VS', 'Wallis');
INSERT INTO `directory_country_region` VALUES ('128', 'CH', 'ZG', 'Zug');
INSERT INTO `directory_country_region` VALUES ('129', 'CH', 'ZH', 'Zürich');
INSERT INTO `directory_country_region` VALUES ('130', 'ES', 'A Coruсa', 'A Coruña');
INSERT INTO `directory_country_region` VALUES ('131', 'ES', 'Alava', 'Alava');
INSERT INTO `directory_country_region` VALUES ('132', 'ES', 'Albacete', 'Albacete');
INSERT INTO `directory_country_region` VALUES ('133', 'ES', 'Alicante', 'Alicante');
INSERT INTO `directory_country_region` VALUES ('134', 'ES', 'Almeria', 'Almeria');
INSERT INTO `directory_country_region` VALUES ('135', 'ES', 'Asturias', 'Asturias');
INSERT INTO `directory_country_region` VALUES ('136', 'ES', 'Avila', 'Avila');
INSERT INTO `directory_country_region` VALUES ('137', 'ES', 'Badajoz', 'Badajoz');
INSERT INTO `directory_country_region` VALUES ('138', 'ES', 'Baleares', 'Baleares');
INSERT INTO `directory_country_region` VALUES ('139', 'ES', 'Barcelona', 'Barcelona');
INSERT INTO `directory_country_region` VALUES ('140', 'ES', 'Burgos', 'Burgos');
INSERT INTO `directory_country_region` VALUES ('141', 'ES', 'Caceres', 'Caceres');
INSERT INTO `directory_country_region` VALUES ('142', 'ES', 'Cadiz', 'Cadiz');
INSERT INTO `directory_country_region` VALUES ('143', 'ES', 'Cantabria', 'Cantabria');
INSERT INTO `directory_country_region` VALUES ('144', 'ES', 'Castellon', 'Castellon');
INSERT INTO `directory_country_region` VALUES ('145', 'ES', 'Ceuta', 'Ceuta');
INSERT INTO `directory_country_region` VALUES ('146', 'ES', 'Ciudad Real', 'Ciudad Real');
INSERT INTO `directory_country_region` VALUES ('147', 'ES', 'Cordoba', 'Cordoba');
INSERT INTO `directory_country_region` VALUES ('148', 'ES', 'Cuenca', 'Cuenca');
INSERT INTO `directory_country_region` VALUES ('149', 'ES', 'Girona', 'Girona');
INSERT INTO `directory_country_region` VALUES ('150', 'ES', 'Granada', 'Granada');
INSERT INTO `directory_country_region` VALUES ('151', 'ES', 'Guadalajara', 'Guadalajara');
INSERT INTO `directory_country_region` VALUES ('152', 'ES', 'Guipuzcoa', 'Guipuzcoa');
INSERT INTO `directory_country_region` VALUES ('153', 'ES', 'Huelva', 'Huelva');
INSERT INTO `directory_country_region` VALUES ('154', 'ES', 'Huesca', 'Huesca');
INSERT INTO `directory_country_region` VALUES ('155', 'ES', 'Jaen', 'Jaen');
INSERT INTO `directory_country_region` VALUES ('156', 'ES', 'La Rioja', 'La Rioja');
INSERT INTO `directory_country_region` VALUES ('157', 'ES', 'Las Palmas', 'Las Palmas');
INSERT INTO `directory_country_region` VALUES ('158', 'ES', 'Leon', 'Leon');
INSERT INTO `directory_country_region` VALUES ('159', 'ES', 'Lleida', 'Lleida');
INSERT INTO `directory_country_region` VALUES ('160', 'ES', 'Lugo', 'Lugo');
INSERT INTO `directory_country_region` VALUES ('161', 'ES', 'Madrid', 'Madrid');
INSERT INTO `directory_country_region` VALUES ('162', 'ES', 'Malaga', 'Malaga');
INSERT INTO `directory_country_region` VALUES ('163', 'ES', 'Melilla', 'Melilla');
INSERT INTO `directory_country_region` VALUES ('164', 'ES', 'Murcia', 'Murcia');
INSERT INTO `directory_country_region` VALUES ('165', 'ES', 'Navarra', 'Navarra');
INSERT INTO `directory_country_region` VALUES ('166', 'ES', 'Ourense', 'Ourense');
INSERT INTO `directory_country_region` VALUES ('167', 'ES', 'Palencia', 'Palencia');
INSERT INTO `directory_country_region` VALUES ('168', 'ES', 'Pontevedra', 'Pontevedra');
INSERT INTO `directory_country_region` VALUES ('169', 'ES', 'Salamanca', 'Salamanca');
INSERT INTO `directory_country_region` VALUES ('170', 'ES', 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife');
INSERT INTO `directory_country_region` VALUES ('171', 'ES', 'Segovia', 'Segovia');
INSERT INTO `directory_country_region` VALUES ('172', 'ES', 'Sevilla', 'Sevilla');
INSERT INTO `directory_country_region` VALUES ('173', 'ES', 'Soria', 'Soria');
INSERT INTO `directory_country_region` VALUES ('174', 'ES', 'Tarragona', 'Tarragona');
INSERT INTO `directory_country_region` VALUES ('175', 'ES', 'Teruel', 'Teruel');
INSERT INTO `directory_country_region` VALUES ('176', 'ES', 'Toledo', 'Toledo');
INSERT INTO `directory_country_region` VALUES ('177', 'ES', 'Valencia', 'Valencia');
INSERT INTO `directory_country_region` VALUES ('178', 'ES', 'Valladolid', 'Valladolid');
INSERT INTO `directory_country_region` VALUES ('179', 'ES', 'Vizcaya', 'Vizcaya');
INSERT INTO `directory_country_region` VALUES ('180', 'ES', 'Zamora', 'Zamora');
INSERT INTO `directory_country_region` VALUES ('181', 'ES', 'Zaragoza', 'Zaragoza');
INSERT INTO `directory_country_region` VALUES ('182', 'FR', '1', 'Ain');
INSERT INTO `directory_country_region` VALUES ('183', 'FR', '2', 'Aisne');
INSERT INTO `directory_country_region` VALUES ('184', 'FR', '3', 'Allier');
INSERT INTO `directory_country_region` VALUES ('185', 'FR', '4', 'Alpes-de-Haute-Provence');
INSERT INTO `directory_country_region` VALUES ('186', 'FR', '5', 'Hautes-Alpes');
INSERT INTO `directory_country_region` VALUES ('187', 'FR', '6', 'Alpes-Maritimes');
INSERT INTO `directory_country_region` VALUES ('188', 'FR', '7', 'Ardèche');
INSERT INTO `directory_country_region` VALUES ('189', 'FR', '8', 'Ardennes');
INSERT INTO `directory_country_region` VALUES ('190', 'FR', '9', 'Ariège');
INSERT INTO `directory_country_region` VALUES ('191', 'FR', '10', 'Aube');
INSERT INTO `directory_country_region` VALUES ('192', 'FR', '11', 'Aude');
INSERT INTO `directory_country_region` VALUES ('193', 'FR', '12', 'Aveyron');
INSERT INTO `directory_country_region` VALUES ('194', 'FR', '13', 'Bouches-du-Rhône');
INSERT INTO `directory_country_region` VALUES ('195', 'FR', '14', 'Calvados');
INSERT INTO `directory_country_region` VALUES ('196', 'FR', '15', 'Cantal');
INSERT INTO `directory_country_region` VALUES ('197', 'FR', '16', 'Charente');
INSERT INTO `directory_country_region` VALUES ('198', 'FR', '17', 'Charente-Maritime');
INSERT INTO `directory_country_region` VALUES ('199', 'FR', '18', 'Cher');
INSERT INTO `directory_country_region` VALUES ('200', 'FR', '19', 'Corrèze');
INSERT INTO `directory_country_region` VALUES ('201', 'FR', '2A', 'Corse-du-Sud');
INSERT INTO `directory_country_region` VALUES ('202', 'FR', '2B', 'Haute-Corse');
INSERT INTO `directory_country_region` VALUES ('203', 'FR', '21', 'Côte-d\'Or');
INSERT INTO `directory_country_region` VALUES ('204', 'FR', '22', 'Côtes-d\'Armor');
INSERT INTO `directory_country_region` VALUES ('205', 'FR', '23', 'Creuse');
INSERT INTO `directory_country_region` VALUES ('206', 'FR', '24', 'Dordogne');
INSERT INTO `directory_country_region` VALUES ('207', 'FR', '25', 'Doubs');
INSERT INTO `directory_country_region` VALUES ('208', 'FR', '26', 'Drôme');
INSERT INTO `directory_country_region` VALUES ('209', 'FR', '27', 'Eure');
INSERT INTO `directory_country_region` VALUES ('210', 'FR', '28', 'Eure-et-Loir');
INSERT INTO `directory_country_region` VALUES ('211', 'FR', '29', 'Finistère');
INSERT INTO `directory_country_region` VALUES ('212', 'FR', '30', 'Gard');
INSERT INTO `directory_country_region` VALUES ('213', 'FR', '31', 'Haute-Garonne');
INSERT INTO `directory_country_region` VALUES ('214', 'FR', '32', 'Gers');
INSERT INTO `directory_country_region` VALUES ('215', 'FR', '33', 'Gironde');
INSERT INTO `directory_country_region` VALUES ('216', 'FR', '34', 'Hérault');
INSERT INTO `directory_country_region` VALUES ('217', 'FR', '35', 'Ille-et-Vilaine');
INSERT INTO `directory_country_region` VALUES ('218', 'FR', '36', 'Indre');
INSERT INTO `directory_country_region` VALUES ('219', 'FR', '37', 'Indre-et-Loire');
INSERT INTO `directory_country_region` VALUES ('220', 'FR', '38', 'Isère');
INSERT INTO `directory_country_region` VALUES ('221', 'FR', '39', 'Jura');
INSERT INTO `directory_country_region` VALUES ('222', 'FR', '40', 'Landes');
INSERT INTO `directory_country_region` VALUES ('223', 'FR', '41', 'Loir-et-Cher');
INSERT INTO `directory_country_region` VALUES ('224', 'FR', '42', 'Loire');
INSERT INTO `directory_country_region` VALUES ('225', 'FR', '43', 'Haute-Loire');
INSERT INTO `directory_country_region` VALUES ('226', 'FR', '44', 'Loire-Atlantique');
INSERT INTO `directory_country_region` VALUES ('227', 'FR', '45', 'Loiret');
INSERT INTO `directory_country_region` VALUES ('228', 'FR', '46', 'Lot');
INSERT INTO `directory_country_region` VALUES ('229', 'FR', '47', 'Lot-et-Garonne');
INSERT INTO `directory_country_region` VALUES ('230', 'FR', '48', 'Lozère');
INSERT INTO `directory_country_region` VALUES ('231', 'FR', '49', 'Maine-et-Loire');
INSERT INTO `directory_country_region` VALUES ('232', 'FR', '50', 'Manche');
INSERT INTO `directory_country_region` VALUES ('233', 'FR', '51', 'Marne');
INSERT INTO `directory_country_region` VALUES ('234', 'FR', '52', 'Haute-Marne');
INSERT INTO `directory_country_region` VALUES ('235', 'FR', '53', 'Mayenne');
INSERT INTO `directory_country_region` VALUES ('236', 'FR', '54', 'Meurthe-et-Moselle');
INSERT INTO `directory_country_region` VALUES ('237', 'FR', '55', 'Meuse');
INSERT INTO `directory_country_region` VALUES ('238', 'FR', '56', 'Morbihan');
INSERT INTO `directory_country_region` VALUES ('239', 'FR', '57', 'Moselle');
INSERT INTO `directory_country_region` VALUES ('240', 'FR', '58', 'Nièvre');
INSERT INTO `directory_country_region` VALUES ('241', 'FR', '59', 'Nord');
INSERT INTO `directory_country_region` VALUES ('242', 'FR', '60', 'Oise');
INSERT INTO `directory_country_region` VALUES ('243', 'FR', '61', 'Orne');
INSERT INTO `directory_country_region` VALUES ('244', 'FR', '62', 'Pas-de-Calais');
INSERT INTO `directory_country_region` VALUES ('245', 'FR', '63', 'Puy-de-Dôme');
INSERT INTO `directory_country_region` VALUES ('246', 'FR', '64', 'Pyrénées-Atlantiques');
INSERT INTO `directory_country_region` VALUES ('247', 'FR', '65', 'Hautes-Pyrénées');
INSERT INTO `directory_country_region` VALUES ('248', 'FR', '66', 'Pyrénées-Orientales');
INSERT INTO `directory_country_region` VALUES ('249', 'FR', '67', 'Bas-Rhin');
INSERT INTO `directory_country_region` VALUES ('250', 'FR', '68', 'Haut-Rhin');
INSERT INTO `directory_country_region` VALUES ('251', 'FR', '69', 'Rhône');
INSERT INTO `directory_country_region` VALUES ('252', 'FR', '70', 'Haute-Saône');
INSERT INTO `directory_country_region` VALUES ('253', 'FR', '71', 'Saône-et-Loire');
INSERT INTO `directory_country_region` VALUES ('254', 'FR', '72', 'Sarthe');
INSERT INTO `directory_country_region` VALUES ('255', 'FR', '73', 'Savoie');
INSERT INTO `directory_country_region` VALUES ('256', 'FR', '74', 'Haute-Savoie');
INSERT INTO `directory_country_region` VALUES ('257', 'FR', '75', 'Paris');
INSERT INTO `directory_country_region` VALUES ('258', 'FR', '76', 'Seine-Maritime');
INSERT INTO `directory_country_region` VALUES ('259', 'FR', '77', 'Seine-et-Marne');
INSERT INTO `directory_country_region` VALUES ('260', 'FR', '78', 'Yvelines');
INSERT INTO `directory_country_region` VALUES ('261', 'FR', '79', 'Deux-Sèvres');
INSERT INTO `directory_country_region` VALUES ('262', 'FR', '80', 'Somme');
INSERT INTO `directory_country_region` VALUES ('263', 'FR', '81', 'Tarn');
INSERT INTO `directory_country_region` VALUES ('264', 'FR', '82', 'Tarn-et-Garonne');
INSERT INTO `directory_country_region` VALUES ('265', 'FR', '83', 'Var');
INSERT INTO `directory_country_region` VALUES ('266', 'FR', '84', 'Vaucluse');
INSERT INTO `directory_country_region` VALUES ('267', 'FR', '85', 'Vendée');
INSERT INTO `directory_country_region` VALUES ('268', 'FR', '86', 'Vienne');
INSERT INTO `directory_country_region` VALUES ('269', 'FR', '87', 'Haute-Vienne');
INSERT INTO `directory_country_region` VALUES ('270', 'FR', '88', 'Vosges');
INSERT INTO `directory_country_region` VALUES ('271', 'FR', '89', 'Yonne');
INSERT INTO `directory_country_region` VALUES ('272', 'FR', '90', 'Territoire-de-Belfort');
INSERT INTO `directory_country_region` VALUES ('273', 'FR', '91', 'Essonne');
INSERT INTO `directory_country_region` VALUES ('274', 'FR', '92', 'Hauts-de-Seine');
INSERT INTO `directory_country_region` VALUES ('275', 'FR', '93', 'Seine-Saint-Denis');
INSERT INTO `directory_country_region` VALUES ('276', 'FR', '94', 'Val-de-Marne');
INSERT INTO `directory_country_region` VALUES ('277', 'FR', '95', 'Val-d\'Oise');
INSERT INTO `directory_country_region` VALUES ('278', 'RO', 'AB', 'Alba');
INSERT INTO `directory_country_region` VALUES ('279', 'RO', 'AR', 'Arad');
INSERT INTO `directory_country_region` VALUES ('280', 'RO', 'AG', 'Argeş');
INSERT INTO `directory_country_region` VALUES ('281', 'RO', 'BC', 'Bacău');
INSERT INTO `directory_country_region` VALUES ('282', 'RO', 'BH', 'Bihor');
INSERT INTO `directory_country_region` VALUES ('283', 'RO', 'BN', 'Bistriţa-Năsăud');
INSERT INTO `directory_country_region` VALUES ('284', 'RO', 'BT', 'Botoşani');
INSERT INTO `directory_country_region` VALUES ('285', 'RO', 'BV', 'Braşov');
INSERT INTO `directory_country_region` VALUES ('286', 'RO', 'BR', 'Brăila');
INSERT INTO `directory_country_region` VALUES ('287', 'RO', 'B', 'Bucureşti');
INSERT INTO `directory_country_region` VALUES ('288', 'RO', 'BZ', 'Buzău');
INSERT INTO `directory_country_region` VALUES ('289', 'RO', 'CS', 'Caraş-Severin');
INSERT INTO `directory_country_region` VALUES ('290', 'RO', 'CL', 'Călăraşi');
INSERT INTO `directory_country_region` VALUES ('291', 'RO', 'CJ', 'Cluj');
INSERT INTO `directory_country_region` VALUES ('292', 'RO', 'CT', 'Constanţa');
INSERT INTO `directory_country_region` VALUES ('293', 'RO', 'CV', 'Covasna');
INSERT INTO `directory_country_region` VALUES ('294', 'RO', 'DB', 'Dâmboviţa');
INSERT INTO `directory_country_region` VALUES ('295', 'RO', 'DJ', 'Dolj');
INSERT INTO `directory_country_region` VALUES ('296', 'RO', 'GL', 'Galaţi');
INSERT INTO `directory_country_region` VALUES ('297', 'RO', 'GR', 'Giurgiu');
INSERT INTO `directory_country_region` VALUES ('298', 'RO', 'GJ', 'Gorj');
INSERT INTO `directory_country_region` VALUES ('299', 'RO', 'HR', 'Harghita');
INSERT INTO `directory_country_region` VALUES ('300', 'RO', 'HD', 'Hunedoara');
INSERT INTO `directory_country_region` VALUES ('301', 'RO', 'IL', 'Ialomiţa');
INSERT INTO `directory_country_region` VALUES ('302', 'RO', 'IS', 'Iaşi');
INSERT INTO `directory_country_region` VALUES ('303', 'RO', 'IF', 'Ilfov');
INSERT INTO `directory_country_region` VALUES ('304', 'RO', 'MM', 'Maramureş');
INSERT INTO `directory_country_region` VALUES ('305', 'RO', 'MH', 'Mehedinţi');
INSERT INTO `directory_country_region` VALUES ('306', 'RO', 'MS', 'Mureş');
INSERT INTO `directory_country_region` VALUES ('307', 'RO', 'NT', 'Neamţ');
INSERT INTO `directory_country_region` VALUES ('308', 'RO', 'OT', 'Olt');
INSERT INTO `directory_country_region` VALUES ('309', 'RO', 'PH', 'Prahova');
INSERT INTO `directory_country_region` VALUES ('310', 'RO', 'SM', 'Satu-Mare');
INSERT INTO `directory_country_region` VALUES ('311', 'RO', 'SJ', 'Sălaj');
INSERT INTO `directory_country_region` VALUES ('312', 'RO', 'SB', 'Sibiu');
INSERT INTO `directory_country_region` VALUES ('313', 'RO', 'SV', 'Suceava');
INSERT INTO `directory_country_region` VALUES ('314', 'RO', 'TR', 'Teleorman');
INSERT INTO `directory_country_region` VALUES ('315', 'RO', 'TM', 'Timiş');
INSERT INTO `directory_country_region` VALUES ('316', 'RO', 'TL', 'Tulcea');
INSERT INTO `directory_country_region` VALUES ('317', 'RO', 'VS', 'Vaslui');
INSERT INTO `directory_country_region` VALUES ('318', 'RO', 'VL', 'Vâlcea');
INSERT INTO `directory_country_region` VALUES ('319', 'RO', 'VN', 'Vrancea');
INSERT INTO `directory_country_region` VALUES ('320', 'FI', 'Lappi', 'Lappi');
INSERT INTO `directory_country_region` VALUES ('321', 'FI', 'Pohjois-Pohjanmaa', 'Pohjois-Pohjanmaa');
INSERT INTO `directory_country_region` VALUES ('322', 'FI', 'Kainuu', 'Kainuu');
INSERT INTO `directory_country_region` VALUES ('323', 'FI', 'Pohjois-Karjala', 'Pohjois-Karjala');
INSERT INTO `directory_country_region` VALUES ('324', 'FI', 'Pohjois-Savo', 'Pohjois-Savo');
INSERT INTO `directory_country_region` VALUES ('325', 'FI', 'Etelä-Savo', 'Etelä-Savo');
INSERT INTO `directory_country_region` VALUES ('326', 'FI', 'Etelä-Pohjanmaa', 'Etelä-Pohjanmaa');
INSERT INTO `directory_country_region` VALUES ('327', 'FI', 'Pohjanmaa', 'Pohjanmaa');
INSERT INTO `directory_country_region` VALUES ('328', 'FI', 'Pirkanmaa', 'Pirkanmaa');
INSERT INTO `directory_country_region` VALUES ('329', 'FI', 'Satakunta', 'Satakunta');
INSERT INTO `directory_country_region` VALUES ('330', 'FI', 'Keski-Pohjanmaa', 'Keski-Pohjanmaa');
INSERT INTO `directory_country_region` VALUES ('331', 'FI', 'Keski-Suomi', 'Keski-Suomi');
INSERT INTO `directory_country_region` VALUES ('332', 'FI', 'Varsinais-Suomi', 'Varsinais-Suomi');
INSERT INTO `directory_country_region` VALUES ('333', 'FI', 'Etelä-Karjala', 'Etelä-Karjala');
INSERT INTO `directory_country_region` VALUES ('334', 'FI', 'Päijät-Häme', 'Päijät-Häme');
INSERT INTO `directory_country_region` VALUES ('335', 'FI', 'Kanta-Häme', 'Kanta-Häme');
INSERT INTO `directory_country_region` VALUES ('336', 'FI', 'Uusimaa', 'Uusimaa');
INSERT INTO `directory_country_region` VALUES ('337', 'FI', 'Itä-Uusimaa', 'Itä-Uusimaa');
INSERT INTO `directory_country_region` VALUES ('338', 'FI', 'Kymenlaakso', 'Kymenlaakso');
INSERT INTO `directory_country_region` VALUES ('339', 'FI', 'Ahvenanmaa', 'Ahvenanmaa');
INSERT INTO `directory_country_region` VALUES ('340', 'EE', 'EE-37', 'Harjumaa');
INSERT INTO `directory_country_region` VALUES ('341', 'EE', 'EE-39', 'Hiiumaa');
INSERT INTO `directory_country_region` VALUES ('342', 'EE', 'EE-44', 'Ida-Virumaa');
INSERT INTO `directory_country_region` VALUES ('343', 'EE', 'EE-49', 'Jõgevamaa');
INSERT INTO `directory_country_region` VALUES ('344', 'EE', 'EE-51', 'Järvamaa');
INSERT INTO `directory_country_region` VALUES ('345', 'EE', 'EE-57', 'Läänemaa');
INSERT INTO `directory_country_region` VALUES ('346', 'EE', 'EE-59', 'Lääne-Virumaa');
INSERT INTO `directory_country_region` VALUES ('347', 'EE', 'EE-65', 'Põlvamaa');
INSERT INTO `directory_country_region` VALUES ('348', 'EE', 'EE-67', 'Pärnumaa');
INSERT INTO `directory_country_region` VALUES ('349', 'EE', 'EE-70', 'Raplamaa');
INSERT INTO `directory_country_region` VALUES ('350', 'EE', 'EE-74', 'Saaremaa');
INSERT INTO `directory_country_region` VALUES ('351', 'EE', 'EE-78', 'Tartumaa');
INSERT INTO `directory_country_region` VALUES ('352', 'EE', 'EE-82', 'Valgamaa');
INSERT INTO `directory_country_region` VALUES ('353', 'EE', 'EE-84', 'Viljandimaa');
INSERT INTO `directory_country_region` VALUES ('354', 'EE', 'EE-86', 'Võrumaa');
INSERT INTO `directory_country_region` VALUES ('355', 'LV', 'LV-DGV', 'Daugavpils');
INSERT INTO `directory_country_region` VALUES ('356', 'LV', 'LV-JEL', 'Jelgava');
INSERT INTO `directory_country_region` VALUES ('357', 'LV', 'Jēkabpils', 'Jēkabpils');
INSERT INTO `directory_country_region` VALUES ('358', 'LV', 'LV-JUR', 'Jūrmala');
INSERT INTO `directory_country_region` VALUES ('359', 'LV', 'LV-LPX', 'Liepāja');
INSERT INTO `directory_country_region` VALUES ('360', 'LV', 'LV-LE', 'Liepājas novads');
INSERT INTO `directory_country_region` VALUES ('361', 'LV', 'LV-REZ', 'Rēzekne');
INSERT INTO `directory_country_region` VALUES ('362', 'LV', 'LV-RIX', 'Rīga');
INSERT INTO `directory_country_region` VALUES ('363', 'LV', 'LV-RI', 'Rīgas novads');
INSERT INTO `directory_country_region` VALUES ('364', 'LV', 'Valmiera', 'Valmiera');
INSERT INTO `directory_country_region` VALUES ('365', 'LV', 'LV-VEN', 'Ventspils');
INSERT INTO `directory_country_region` VALUES ('366', 'LV', 'Aglonas novads', 'Aglonas novads');
INSERT INTO `directory_country_region` VALUES ('367', 'LV', 'LV-AI', 'Aizkraukles novads');
INSERT INTO `directory_country_region` VALUES ('368', 'LV', 'Aizputes novads', 'Aizputes novads');
INSERT INTO `directory_country_region` VALUES ('369', 'LV', 'Aknīstes novads', 'Aknīstes novads');
INSERT INTO `directory_country_region` VALUES ('370', 'LV', 'Alojas novads', 'Alojas novads');
INSERT INTO `directory_country_region` VALUES ('371', 'LV', 'Alsungas novads', 'Alsungas novads');
INSERT INTO `directory_country_region` VALUES ('372', 'LV', 'LV-AL', 'Alūksnes novads');
INSERT INTO `directory_country_region` VALUES ('373', 'LV', 'Amatas novads', 'Amatas novads');
INSERT INTO `directory_country_region` VALUES ('374', 'LV', 'Apes novads', 'Apes novads');
INSERT INTO `directory_country_region` VALUES ('375', 'LV', 'Auces novads', 'Auces novads');
INSERT INTO `directory_country_region` VALUES ('376', 'LV', 'Babītes novads', 'Babītes novads');
INSERT INTO `directory_country_region` VALUES ('377', 'LV', 'Baldones novads', 'Baldones novads');
INSERT INTO `directory_country_region` VALUES ('378', 'LV', 'Baltinavas novads', 'Baltinavas novads');
INSERT INTO `directory_country_region` VALUES ('379', 'LV', 'LV-BL', 'Balvu novads');
INSERT INTO `directory_country_region` VALUES ('380', 'LV', 'LV-BU', 'Bauskas novads');
INSERT INTO `directory_country_region` VALUES ('381', 'LV', 'Beverīnas novads', 'Beverīnas novads');
INSERT INTO `directory_country_region` VALUES ('382', 'LV', 'Brocēnu novads', 'Brocēnu novads');
INSERT INTO `directory_country_region` VALUES ('383', 'LV', 'Burtnieku novads', 'Burtnieku novads');
INSERT INTO `directory_country_region` VALUES ('384', 'LV', 'Carnikavas novads', 'Carnikavas novads');
INSERT INTO `directory_country_region` VALUES ('385', 'LV', 'Cesvaines novads', 'Cesvaines novads');
INSERT INTO `directory_country_region` VALUES ('386', 'LV', 'Ciblas novads', 'Ciblas novads');
INSERT INTO `directory_country_region` VALUES ('387', 'LV', 'LV-CE', 'Cēsu novads');
INSERT INTO `directory_country_region` VALUES ('388', 'LV', 'Dagdas novads', 'Dagdas novads');
INSERT INTO `directory_country_region` VALUES ('389', 'LV', 'LV-DA', 'Daugavpils novads');
INSERT INTO `directory_country_region` VALUES ('390', 'LV', 'LV-DO', 'Dobeles novads');
INSERT INTO `directory_country_region` VALUES ('391', 'LV', 'Dundagas novads', 'Dundagas novads');
INSERT INTO `directory_country_region` VALUES ('392', 'LV', 'Durbes novads', 'Durbes novads');
INSERT INTO `directory_country_region` VALUES ('393', 'LV', 'Engures novads', 'Engures novads');
INSERT INTO `directory_country_region` VALUES ('394', 'LV', 'Garkalnes novads', 'Garkalnes novads');
INSERT INTO `directory_country_region` VALUES ('395', 'LV', 'Grobiņas novads', 'Grobiņas novads');
INSERT INTO `directory_country_region` VALUES ('396', 'LV', 'LV-GU', 'Gulbenes novads');
INSERT INTO `directory_country_region` VALUES ('397', 'LV', 'Iecavas novads', 'Iecavas novads');
INSERT INTO `directory_country_region` VALUES ('398', 'LV', 'Ikšķiles novads', 'Ikšķiles novads');
INSERT INTO `directory_country_region` VALUES ('399', 'LV', 'Ilūkstes novads', 'Ilūkstes novads');
INSERT INTO `directory_country_region` VALUES ('400', 'LV', 'Inčukalna novads', 'Inčukalna novads');
INSERT INTO `directory_country_region` VALUES ('401', 'LV', 'Jaunjelgavas novads', 'Jaunjelgavas novads');
INSERT INTO `directory_country_region` VALUES ('402', 'LV', 'Jaunpiebalgas novads', 'Jaunpiebalgas novads');
INSERT INTO `directory_country_region` VALUES ('403', 'LV', 'Jaunpils novads', 'Jaunpils novads');
INSERT INTO `directory_country_region` VALUES ('404', 'LV', 'LV-JL', 'Jelgavas novads');
INSERT INTO `directory_country_region` VALUES ('405', 'LV', 'LV-JK', 'Jēkabpils novads');
INSERT INTO `directory_country_region` VALUES ('406', 'LV', 'Kandavas novads', 'Kandavas novads');
INSERT INTO `directory_country_region` VALUES ('407', 'LV', 'Kokneses novads', 'Kokneses novads');
INSERT INTO `directory_country_region` VALUES ('408', 'LV', 'Krimuldas novads', 'Krimuldas novads');
INSERT INTO `directory_country_region` VALUES ('409', 'LV', 'Krustpils novads', 'Krustpils novads');
INSERT INTO `directory_country_region` VALUES ('410', 'LV', 'LV-KR', 'Krāslavas novads');
INSERT INTO `directory_country_region` VALUES ('411', 'LV', 'LV-KU', 'Kuldīgas novads');
INSERT INTO `directory_country_region` VALUES ('412', 'LV', 'Kārsavas novads', 'Kārsavas novads');
INSERT INTO `directory_country_region` VALUES ('413', 'LV', 'Lielvārdes novads', 'Lielvārdes novads');
INSERT INTO `directory_country_region` VALUES ('414', 'LV', 'LV-LM', 'Limbažu novads');
INSERT INTO `directory_country_region` VALUES ('415', 'LV', 'Lubānas novads', 'Lubānas novads');
INSERT INTO `directory_country_region` VALUES ('416', 'LV', 'LV-LU', 'Ludzas novads');
INSERT INTO `directory_country_region` VALUES ('417', 'LV', 'Līgatnes novads', 'Līgatnes novads');
INSERT INTO `directory_country_region` VALUES ('418', 'LV', 'Līvānu novads', 'Līvānu novads');
INSERT INTO `directory_country_region` VALUES ('419', 'LV', 'LV-MA', 'Madonas novads');
INSERT INTO `directory_country_region` VALUES ('420', 'LV', 'Mazsalacas novads', 'Mazsalacas novads');
INSERT INTO `directory_country_region` VALUES ('421', 'LV', 'Mālpils novads', 'Mālpils novads');
INSERT INTO `directory_country_region` VALUES ('422', 'LV', 'Mārupes novads', 'Mārupes novads');
INSERT INTO `directory_country_region` VALUES ('423', 'LV', 'Naukšēnu novads', 'Naukšēnu novads');
INSERT INTO `directory_country_region` VALUES ('424', 'LV', 'Neretas novads', 'Neretas novads');
INSERT INTO `directory_country_region` VALUES ('425', 'LV', 'Nīcas novads', 'Nīcas novads');
INSERT INTO `directory_country_region` VALUES ('426', 'LV', 'LV-OG', 'Ogres novads');
INSERT INTO `directory_country_region` VALUES ('427', 'LV', 'Olaines novads', 'Olaines novads');
INSERT INTO `directory_country_region` VALUES ('428', 'LV', 'Ozolnieku novads', 'Ozolnieku novads');
INSERT INTO `directory_country_region` VALUES ('429', 'LV', 'LV-PR', 'Preiļu novads');
INSERT INTO `directory_country_region` VALUES ('430', 'LV', 'Priekules novads', 'Priekules novads');
INSERT INTO `directory_country_region` VALUES ('431', 'LV', 'Priekuļu novads', 'Priekuļu novads');
INSERT INTO `directory_country_region` VALUES ('432', 'LV', 'Pārgaujas novads', 'Pārgaujas novads');
INSERT INTO `directory_country_region` VALUES ('433', 'LV', 'Pāvilostas novads', 'Pāvilostas novads');
INSERT INTO `directory_country_region` VALUES ('434', 'LV', 'Pļaviņu novads', 'Pļaviņu novads');
INSERT INTO `directory_country_region` VALUES ('435', 'LV', 'Raunas novads', 'Raunas novads');
INSERT INTO `directory_country_region` VALUES ('436', 'LV', 'Riebiņu novads', 'Riebiņu novads');
INSERT INTO `directory_country_region` VALUES ('437', 'LV', 'Rojas novads', 'Rojas novads');
INSERT INTO `directory_country_region` VALUES ('438', 'LV', 'Ropažu novads', 'Ropažu novads');
INSERT INTO `directory_country_region` VALUES ('439', 'LV', 'Rucavas novads', 'Rucavas novads');
INSERT INTO `directory_country_region` VALUES ('440', 'LV', 'Rugāju novads', 'Rugāju novads');
INSERT INTO `directory_country_region` VALUES ('441', 'LV', 'Rundāles novads', 'Rundāles novads');
INSERT INTO `directory_country_region` VALUES ('442', 'LV', 'LV-RE', 'Rēzeknes novads');
INSERT INTO `directory_country_region` VALUES ('443', 'LV', 'Rūjienas novads', 'Rūjienas novads');
INSERT INTO `directory_country_region` VALUES ('444', 'LV', 'Salacgrīvas novads', 'Salacgrīvas novads');
INSERT INTO `directory_country_region` VALUES ('445', 'LV', 'Salas novads', 'Salas novads');
INSERT INTO `directory_country_region` VALUES ('446', 'LV', 'Salaspils novads', 'Salaspils novads');
INSERT INTO `directory_country_region` VALUES ('447', 'LV', 'LV-SA', 'Saldus novads');
INSERT INTO `directory_country_region` VALUES ('448', 'LV', 'Saulkrastu novads', 'Saulkrastu novads');
INSERT INTO `directory_country_region` VALUES ('449', 'LV', 'Siguldas novads', 'Siguldas novads');
INSERT INTO `directory_country_region` VALUES ('450', 'LV', 'Skrundas novads', 'Skrundas novads');
INSERT INTO `directory_country_region` VALUES ('451', 'LV', 'Skrīveru novads', 'Skrīveru novads');
INSERT INTO `directory_country_region` VALUES ('452', 'LV', 'Smiltenes novads', 'Smiltenes novads');
INSERT INTO `directory_country_region` VALUES ('453', 'LV', 'Stopiņu novads', 'Stopiņu novads');
INSERT INTO `directory_country_region` VALUES ('454', 'LV', 'Strenču novads', 'Strenču novads');
INSERT INTO `directory_country_region` VALUES ('455', 'LV', 'Sējas novads', 'Sējas novads');
INSERT INTO `directory_country_region` VALUES ('456', 'LV', 'LV-TA', 'Talsu novads');
INSERT INTO `directory_country_region` VALUES ('457', 'LV', 'LV-TU', 'Tukuma novads');
INSERT INTO `directory_country_region` VALUES ('458', 'LV', 'Tērvetes novads', 'Tērvetes novads');
INSERT INTO `directory_country_region` VALUES ('459', 'LV', 'Vaiņodes novads', 'Vaiņodes novads');
INSERT INTO `directory_country_region` VALUES ('460', 'LV', 'LV-VK', 'Valkas novads');
INSERT INTO `directory_country_region` VALUES ('461', 'LV', 'LV-VM', 'Valmieras novads');
INSERT INTO `directory_country_region` VALUES ('462', 'LV', 'Varakļānu novads', 'Varakļānu novads');
INSERT INTO `directory_country_region` VALUES ('463', 'LV', 'Vecpiebalgas novads', 'Vecpiebalgas novads');
INSERT INTO `directory_country_region` VALUES ('464', 'LV', 'Vecumnieku novads', 'Vecumnieku novads');
INSERT INTO `directory_country_region` VALUES ('465', 'LV', 'LV-VE', 'Ventspils novads');
INSERT INTO `directory_country_region` VALUES ('466', 'LV', 'Viesītes novads', 'Viesītes novads');
INSERT INTO `directory_country_region` VALUES ('467', 'LV', 'Viļakas novads', 'Viļakas novads');
INSERT INTO `directory_country_region` VALUES ('468', 'LV', 'Viļānu novads', 'Viļānu novads');
INSERT INTO `directory_country_region` VALUES ('469', 'LV', 'Vārkavas novads', 'Vārkavas novads');
INSERT INTO `directory_country_region` VALUES ('470', 'LV', 'Zilupes novads', 'Zilupes novads');
INSERT INTO `directory_country_region` VALUES ('471', 'LV', 'Ādažu novads', 'Ādažu novads');
INSERT INTO `directory_country_region` VALUES ('472', 'LV', 'Ērgļu novads', 'Ērgļu novads');
INSERT INTO `directory_country_region` VALUES ('473', 'LV', 'Ķeguma novads', 'Ķeguma novads');
INSERT INTO `directory_country_region` VALUES ('474', 'LV', 'Ķekavas novads', 'Ķekavas novads');
INSERT INTO `directory_country_region` VALUES ('475', 'LT', 'LT-AL', 'Alytaus Apskritis');
INSERT INTO `directory_country_region` VALUES ('476', 'LT', 'LT-KU', 'Kauno Apskritis');
INSERT INTO `directory_country_region` VALUES ('477', 'LT', 'LT-KL', 'Klaipėdos Apskritis');
INSERT INTO `directory_country_region` VALUES ('478', 'LT', 'LT-MR', 'Marijampolės Apskritis');
INSERT INTO `directory_country_region` VALUES ('479', 'LT', 'LT-PN', 'Panevėžio Apskritis');
INSERT INTO `directory_country_region` VALUES ('480', 'LT', 'LT-SA', 'Šiaulių Apskritis');
INSERT INTO `directory_country_region` VALUES ('481', 'LT', 'LT-TA', 'Tauragės Apskritis');
INSERT INTO `directory_country_region` VALUES ('482', 'LT', 'LT-TE', 'Telšių Apskritis');
INSERT INTO `directory_country_region` VALUES ('483', 'LT', 'LT-UT', 'Utenos Apskritis');
INSERT INTO `directory_country_region` VALUES ('484', 'LT', 'LT-VL', 'Vilniaus Apskritis');

-- ----------------------------
-- Table structure for directory_country_region_name
-- ----------------------------
DROP TABLE IF EXISTS `directory_country_region_name`;
CREATE TABLE `directory_country_region_name` (
  `locale` varchar(8) NOT NULL DEFAULT '' COMMENT 'Locale',
  `region_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Region Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`locale`,`region_id`),
  KEY `IDX_DIRECTORY_COUNTRY_REGION_NAME_REGION_ID` (`region_id`),
  CONSTRAINT `FK_D7CFDEB379F775328EB6F62695E2B3E1` FOREIGN KEY (`region_id`) REFERENCES `directory_country_region` (`region_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Region Name';

-- ----------------------------
-- Records of directory_country_region_name
-- ----------------------------
INSERT INTO `directory_country_region_name` VALUES ('en_US', '1', 'Alabama');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '2', 'Alaska');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '3', 'American Samoa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '4', 'Arizona');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '5', 'Arkansas');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '6', 'Armed Forces Africa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '7', 'Armed Forces Americas');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '8', 'Armed Forces Canada');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '9', 'Armed Forces Europe');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '10', 'Armed Forces Middle East');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '11', 'Armed Forces Pacific');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '12', 'California');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '13', 'Colorado');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '14', 'Connecticut');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '15', 'Delaware');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '16', 'District of Columbia');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '17', 'Federated States Of Micronesia');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '18', 'Florida');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '19', 'Georgia');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '20', 'Guam');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '21', 'Hawaii');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '22', 'Idaho');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '23', 'Illinois');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '24', 'Indiana');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '25', 'Iowa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '26', 'Kansas');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '27', 'Kentucky');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '28', 'Louisiana');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '29', 'Maine');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '30', 'Marshall Islands');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '31', 'Maryland');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '32', 'Massachusetts');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '33', 'Michigan');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '34', 'Minnesota');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '35', 'Mississippi');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '36', 'Missouri');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '37', 'Montana');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '38', 'Nebraska');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '39', 'Nevada');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '40', 'New Hampshire');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '41', 'New Jersey');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '42', 'New Mexico');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '43', 'New York');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '44', 'North Carolina');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '45', 'North Dakota');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '46', 'Northern Mariana Islands');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '47', 'Ohio');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '48', 'Oklahoma');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '49', 'Oregon');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '50', 'Palau');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '51', 'Pennsylvania');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '52', 'Puerto Rico');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '53', 'Rhode Island');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '54', 'South Carolina');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '55', 'South Dakota');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '56', 'Tennessee');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '57', 'Texas');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '58', 'Utah');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '59', 'Vermont');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '60', 'Virgin Islands');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '61', 'Virginia');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '62', 'Washington');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '63', 'West Virginia');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '64', 'Wisconsin');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '65', 'Wyoming');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '66', 'Alberta');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '67', 'British Columbia');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '68', 'Manitoba');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '69', 'Newfoundland and Labrador');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '70', 'New Brunswick');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '71', 'Nova Scotia');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '72', 'Northwest Territories');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '73', 'Nunavut');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '74', 'Ontario');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '75', 'Prince Edward Island');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '76', 'Quebec');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '77', 'Saskatchewan');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '78', 'Yukon Territory');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '79', 'Niedersachsen');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '80', 'Baden-Württemberg');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '81', 'Bayern');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '82', 'Berlin');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '83', 'Brandenburg');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '84', 'Bremen');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '85', 'Hamburg');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '86', 'Hessen');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '87', 'Mecklenburg-Vorpommern');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '88', 'Nordrhein-Westfalen');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '89', 'Rheinland-Pfalz');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '90', 'Saarland');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '91', 'Sachsen');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '92', 'Sachsen-Anhalt');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '93', 'Schleswig-Holstein');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '94', 'Thüringen');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '95', 'Wien');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '96', 'Niederösterreich');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '97', 'Oberösterreich');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '98', 'Salzburg');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '99', 'Kärnten');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '100', 'Steiermark');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '101', 'Tirol');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '102', 'Burgenland');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '103', 'Vorarlberg');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '104', 'Aargau');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '105', 'Appenzell Innerrhoden');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '106', 'Appenzell Ausserrhoden');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '107', 'Bern');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '108', 'Basel-Landschaft');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '109', 'Basel-Stadt');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '110', 'Freiburg');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '111', 'Genf');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '112', 'Glarus');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '113', 'Graubünden');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '114', 'Jura');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '115', 'Luzern');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '116', 'Neuenburg');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '117', 'Nidwalden');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '118', 'Obwalden');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '119', 'St. Gallen');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '120', 'Schaffhausen');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '121', 'Solothurn');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '122', 'Schwyz');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '123', 'Thurgau');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '124', 'Tessin');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '125', 'Uri');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '126', 'Waadt');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '127', 'Wallis');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '128', 'Zug');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '129', 'Zürich');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '130', 'A Coruña');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '131', 'Alava');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '132', 'Albacete');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '133', 'Alicante');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '134', 'Almeria');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '135', 'Asturias');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '136', 'Avila');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '137', 'Badajoz');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '138', 'Baleares');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '139', 'Barcelona');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '140', 'Burgos');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '141', 'Caceres');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '142', 'Cadiz');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '143', 'Cantabria');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '144', 'Castellon');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '145', 'Ceuta');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '146', 'Ciudad Real');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '147', 'Cordoba');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '148', 'Cuenca');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '149', 'Girona');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '150', 'Granada');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '151', 'Guadalajara');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '152', 'Guipuzcoa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '153', 'Huelva');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '154', 'Huesca');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '155', 'Jaen');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '156', 'La Rioja');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '157', 'Las Palmas');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '158', 'Leon');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '159', 'Lleida');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '160', 'Lugo');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '161', 'Madrid');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '162', 'Malaga');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '163', 'Melilla');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '164', 'Murcia');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '165', 'Navarra');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '166', 'Ourense');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '167', 'Palencia');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '168', 'Pontevedra');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '169', 'Salamanca');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '170', 'Santa Cruz de Tenerife');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '171', 'Segovia');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '172', 'Sevilla');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '173', 'Soria');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '174', 'Tarragona');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '175', 'Teruel');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '176', 'Toledo');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '177', 'Valencia');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '178', 'Valladolid');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '179', 'Vizcaya');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '180', 'Zamora');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '181', 'Zaragoza');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '182', 'Ain');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '183', 'Aisne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '184', 'Allier');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '185', 'Alpes-de-Haute-Provence');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '186', 'Hautes-Alpes');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '187', 'Alpes-Maritimes');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '188', 'Ardèche');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '189', 'Ardennes');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '190', 'Ariège');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '191', 'Aube');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '192', 'Aude');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '193', 'Aveyron');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '194', 'Bouches-du-Rhône');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '195', 'Calvados');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '196', 'Cantal');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '197', 'Charente');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '198', 'Charente-Maritime');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '199', 'Cher');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '200', 'Corrèze');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '201', 'Corse-du-Sud');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '202', 'Haute-Corse');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '203', 'Côte-d\'Or');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '204', 'Côtes-d\'Armor');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '205', 'Creuse');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '206', 'Dordogne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '207', 'Doubs');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '208', 'Drôme');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '209', 'Eure');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '210', 'Eure-et-Loir');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '211', 'Finistère');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '212', 'Gard');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '213', 'Haute-Garonne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '214', 'Gers');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '215', 'Gironde');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '216', 'Hérault');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '217', 'Ille-et-Vilaine');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '218', 'Indre');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '219', 'Indre-et-Loire');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '220', 'Isère');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '221', 'Jura');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '222', 'Landes');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '223', 'Loir-et-Cher');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '224', 'Loire');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '225', 'Haute-Loire');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '226', 'Loire-Atlantique');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '227', 'Loiret');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '228', 'Lot');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '229', 'Lot-et-Garonne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '230', 'Lozère');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '231', 'Maine-et-Loire');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '232', 'Manche');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '233', 'Marne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '234', 'Haute-Marne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '235', 'Mayenne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '236', 'Meurthe-et-Moselle');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '237', 'Meuse');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '238', 'Morbihan');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '239', 'Moselle');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '240', 'Nièvre');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '241', 'Nord');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '242', 'Oise');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '243', 'Orne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '244', 'Pas-de-Calais');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '245', 'Puy-de-Dôme');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '246', 'Pyrénées-Atlantiques');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '247', 'Hautes-Pyrénées');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '248', 'Pyrénées-Orientales');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '249', 'Bas-Rhin');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '250', 'Haut-Rhin');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '251', 'Rhône');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '252', 'Haute-Saône');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '253', 'Saône-et-Loire');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '254', 'Sarthe');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '255', 'Savoie');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '256', 'Haute-Savoie');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '257', 'Paris');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '258', 'Seine-Maritime');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '259', 'Seine-et-Marne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '260', 'Yvelines');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '261', 'Deux-Sèvres');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '262', 'Somme');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '263', 'Tarn');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '264', 'Tarn-et-Garonne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '265', 'Var');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '266', 'Vaucluse');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '267', 'Vendée');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '268', 'Vienne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '269', 'Haute-Vienne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '270', 'Vosges');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '271', 'Yonne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '272', 'Territoire-de-Belfort');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '273', 'Essonne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '274', 'Hauts-de-Seine');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '275', 'Seine-Saint-Denis');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '276', 'Val-de-Marne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '277', 'Val-d\'Oise');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '278', 'Alba');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '279', 'Arad');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '280', 'Argeş');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '281', 'Bacău');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '282', 'Bihor');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '283', 'Bistriţa-Năsăud');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '284', 'Botoşani');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '285', 'Braşov');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '286', 'Brăila');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '287', 'Bucureşti');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '288', 'Buzău');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '289', 'Caraş-Severin');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '290', 'Călăraşi');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '291', 'Cluj');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '292', 'Constanţa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '293', 'Covasna');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '294', 'Dâmboviţa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '295', 'Dolj');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '296', 'Galaţi');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '297', 'Giurgiu');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '298', 'Gorj');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '299', 'Harghita');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '300', 'Hunedoara');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '301', 'Ialomiţa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '302', 'Iaşi');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '303', 'Ilfov');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '304', 'Maramureş');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '305', 'Mehedinţi');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '306', 'Mureş');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '307', 'Neamţ');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '308', 'Olt');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '309', 'Prahova');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '310', 'Satu-Mare');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '311', 'Sălaj');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '312', 'Sibiu');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '313', 'Suceava');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '314', 'Teleorman');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '315', 'Timiş');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '316', 'Tulcea');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '317', 'Vaslui');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '318', 'Vâlcea');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '319', 'Vrancea');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '320', 'Lappi');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '321', 'Pohjois-Pohjanmaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '322', 'Kainuu');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '323', 'Pohjois-Karjala');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '324', 'Pohjois-Savo');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '325', 'Etelä-Savo');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '326', 'Etelä-Pohjanmaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '327', 'Pohjanmaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '328', 'Pirkanmaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '329', 'Satakunta');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '330', 'Keski-Pohjanmaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '331', 'Keski-Suomi');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '332', 'Varsinais-Suomi');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '333', 'Etelä-Karjala');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '334', 'Päijät-Häme');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '335', 'Kanta-Häme');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '336', 'Uusimaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '337', 'Itä-Uusimaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '338', 'Kymenlaakso');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '339', 'Ahvenanmaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '340', 'Harjumaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '341', 'Hiiumaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '342', 'Ida-Virumaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '343', 'Jõgevamaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '344', 'Järvamaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '345', 'Läänemaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '346', 'Lääne-Virumaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '347', 'Põlvamaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '348', 'Pärnumaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '349', 'Raplamaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '350', 'Saaremaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '351', 'Tartumaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '352', 'Valgamaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '353', 'Viljandimaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '354', 'Võrumaa');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '355', 'Daugavpils');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '356', 'Jelgava');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '357', 'Jēkabpils');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '358', 'Jūrmala');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '359', 'Liepāja');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '360', 'Liepājas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '361', 'Rēzekne');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '362', 'Rīga');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '363', 'Rīgas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '364', 'Valmiera');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '365', 'Ventspils');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '366', 'Aglonas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '367', 'Aizkraukles novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '368', 'Aizputes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '369', 'Aknīstes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '370', 'Alojas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '371', 'Alsungas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '372', 'Alūksnes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '373', 'Amatas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '374', 'Apes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '375', 'Auces novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '376', 'Babītes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '377', 'Baldones novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '378', 'Baltinavas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '379', 'Balvu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '380', 'Bauskas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '381', 'Beverīnas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '382', 'Brocēnu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '383', 'Burtnieku novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '384', 'Carnikavas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '385', 'Cesvaines novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '386', 'Ciblas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '387', 'Cēsu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '388', 'Dagdas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '389', 'Daugavpils novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '390', 'Dobeles novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '391', 'Dundagas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '392', 'Durbes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '393', 'Engures novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '394', 'Garkalnes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '395', 'Grobiņas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '396', 'Gulbenes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '397', 'Iecavas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '398', 'Ikšķiles novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '399', 'Ilūkstes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '400', 'Inčukalna novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '401', 'Jaunjelgavas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '402', 'Jaunpiebalgas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '403', 'Jaunpils novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '404', 'Jelgavas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '405', 'Jēkabpils novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '406', 'Kandavas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '407', 'Kokneses novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '408', 'Krimuldas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '409', 'Krustpils novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '410', 'Krāslavas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '411', 'Kuldīgas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '412', 'Kārsavas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '413', 'Lielvārdes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '414', 'Limbažu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '415', 'Lubānas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '416', 'Ludzas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '417', 'Līgatnes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '418', 'Līvānu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '419', 'Madonas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '420', 'Mazsalacas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '421', 'Mālpils novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '422', 'Mārupes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '423', 'Naukšēnu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '424', 'Neretas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '425', 'Nīcas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '426', 'Ogres novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '427', 'Olaines novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '428', 'Ozolnieku novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '429', 'Preiļu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '430', 'Priekules novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '431', 'Priekuļu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '432', 'Pārgaujas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '433', 'Pāvilostas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '434', 'Pļaviņu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '435', 'Raunas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '436', 'Riebiņu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '437', 'Rojas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '438', 'Ropažu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '439', 'Rucavas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '440', 'Rugāju novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '441', 'Rundāles novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '442', 'Rēzeknes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '443', 'Rūjienas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '444', 'Salacgrīvas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '445', 'Salas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '446', 'Salaspils novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '447', 'Saldus novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '448', 'Saulkrastu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '449', 'Siguldas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '450', 'Skrundas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '451', 'Skrīveru novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '452', 'Smiltenes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '453', 'Stopiņu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '454', 'Strenču novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '455', 'Sējas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '456', 'Talsu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '457', 'Tukuma novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '458', 'Tērvetes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '459', 'Vaiņodes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '460', 'Valkas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '461', 'Valmieras novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '462', 'Varakļānu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '463', 'Vecpiebalgas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '464', 'Vecumnieku novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '465', 'Ventspils novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '466', 'Viesītes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '467', 'Viļakas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '468', 'Viļānu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '469', 'Vārkavas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '470', 'Zilupes novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '471', 'Ādažu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '472', 'Ērgļu novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '473', 'Ķeguma novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '474', 'Ķekavas novads');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '475', 'Alytaus Apskritis');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '476', 'Kauno Apskritis');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '477', 'Klaipėdos Apskritis');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '478', 'Marijampolės Apskritis');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '479', 'Panevėžio Apskritis');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '480', 'Šiaulių Apskritis');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '481', 'Tauragės Apskritis');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '482', 'Telšių Apskritis');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '483', 'Utenos Apskritis');
INSERT INTO `directory_country_region_name` VALUES ('en_US', '484', 'Vilniaus Apskritis');

-- ----------------------------
-- Table structure for directory_currency_rate
-- ----------------------------
DROP TABLE IF EXISTS `directory_currency_rate`;
CREATE TABLE `directory_currency_rate` (
  `currency_from` varchar(3) NOT NULL DEFAULT '' COMMENT 'Currency Code Convert From',
  `currency_to` varchar(3) NOT NULL DEFAULT '' COMMENT 'Currency Code Convert To',
  `rate` decimal(24,12) NOT NULL DEFAULT '0.000000000000' COMMENT 'Currency Conversion Rate',
  PRIMARY KEY (`currency_from`,`currency_to`),
  KEY `IDX_DIRECTORY_CURRENCY_RATE_CURRENCY_TO` (`currency_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Currency Rate';

-- ----------------------------
-- Records of directory_currency_rate
-- ----------------------------
INSERT INTO `directory_currency_rate` VALUES ('EUR', 'EUR', '1.000000000000');
INSERT INTO `directory_currency_rate` VALUES ('EUR', 'USD', '1.415000000000');
INSERT INTO `directory_currency_rate` VALUES ('USD', 'EUR', '0.706700000000');
INSERT INTO `directory_currency_rate` VALUES ('USD', 'USD', '1.000000000000');

-- ----------------------------
-- Table structure for downloadable_link
-- ----------------------------
DROP TABLE IF EXISTS `downloadable_link`;
CREATE TABLE `downloadable_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  `number_of_downloads` int(11) DEFAULT NULL COMMENT 'Number of downloads',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(20) DEFAULT NULL COMMENT 'Link Type',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample Url',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample File',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  PRIMARY KEY (`link_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRODUCT_ID` (`product_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRODUCT_ID_SORT_ORDER` (`product_id`,`sort_order`),
  CONSTRAINT `FK_DOWNLOADABLE_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Table';

-- ----------------------------
-- Records of downloadable_link
-- ----------------------------

-- ----------------------------
-- Table structure for downloadable_link_price
-- ----------------------------
DROP TABLE IF EXISTS `downloadable_link_price`;
CREATE TABLE `downloadable_link_price` (
  `price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  PRIMARY KEY (`price_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRICE_LINK_ID` (`link_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_DOWNLOADABLE_LINK_PRICE_LINK_ID_DOWNLOADABLE_LINK_LINK_ID` FOREIGN KEY (`link_id`) REFERENCES `downloadable_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DOWNLOADABLE_LINK_PRICE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Price Table';

-- ----------------------------
-- Records of downloadable_link_price
-- ----------------------------

-- ----------------------------
-- Table structure for downloadable_link_purchased
-- ----------------------------
DROP TABLE IF EXISTS `downloadable_link_purchased`;
CREATE TABLE `downloadable_link_purchased` (
  `purchased_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Purchased ID',
  `order_id` int(10) unsigned DEFAULT '0' COMMENT 'Order ID',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment ID',
  `order_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Item ID',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of creation',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of modification',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer ID',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product name',
  `product_sku` varchar(255) DEFAULT NULL COMMENT 'Product sku',
  `link_section_title` varchar(255) DEFAULT NULL COMMENT 'Link_section_title',
  PRIMARY KEY (`purchased_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ORDER_ID` (`order_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ORDER_ITEM_ID` (`order_item_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_DL_LNK_PURCHASED_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_DL_LNK_PURCHASED_ORDER_ID_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Table';

-- ----------------------------
-- Records of downloadable_link_purchased
-- ----------------------------

-- ----------------------------
-- Table structure for downloadable_link_purchased_item
-- ----------------------------
DROP TABLE IF EXISTS `downloadable_link_purchased_item`;
CREATE TABLE `downloadable_link_purchased_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item ID',
  `purchased_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Purchased ID',
  `order_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Order Item ID',
  `product_id` int(10) unsigned DEFAULT '0' COMMENT 'Product ID',
  `link_hash` varchar(255) DEFAULT NULL COMMENT 'Link hash',
  `number_of_downloads_bought` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads bought',
  `number_of_downloads_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads used',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `link_title` varchar(255) DEFAULT NULL COMMENT 'Link Title',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable Flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(255) DEFAULT NULL COMMENT 'Link Type',
  `status` varchar(50) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Update Time',
  PRIMARY KEY (`item_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ITEM_LINK_HASH` (`link_hash`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ITEM_ORDER_ITEM_ID` (`order_item_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ITEM_PURCHASED_ID` (`purchased_id`),
  CONSTRAINT `FK_46CC8E252307CE62F00A8F1887512A39` FOREIGN KEY (`purchased_id`) REFERENCES `downloadable_link_purchased` (`purchased_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_B219BF25756700DEE44550B21220ECCE` FOREIGN KEY (`order_item_id`) REFERENCES `sales_flat_order_item` (`item_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Item Table';

-- ----------------------------
-- Records of downloadable_link_purchased_item
-- ----------------------------

-- ----------------------------
-- Table structure for downloadable_link_title
-- ----------------------------
DROP TABLE IF EXISTS `downloadable_link_title`;
CREATE TABLE `downloadable_link_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `UNQ_DOWNLOADABLE_LINK_TITLE_LINK_ID_STORE_ID` (`link_id`,`store_id`),
  KEY `IDX_DOWNLOADABLE_LINK_TITLE_LINK_ID` (`link_id`),
  KEY `IDX_DOWNLOADABLE_LINK_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_DOWNLOADABLE_LINK_TITLE_LINK_ID_DOWNLOADABLE_LINK_LINK_ID` FOREIGN KEY (`link_id`) REFERENCES `downloadable_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DOWNLOADABLE_LINK_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link Title Table';

-- ----------------------------
-- Records of downloadable_link_title
-- ----------------------------

-- ----------------------------
-- Table structure for downloadable_sample
-- ----------------------------
DROP TABLE IF EXISTS `downloadable_sample`;
CREATE TABLE `downloadable_sample` (
  `sample_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sample ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample URL',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample file',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`sample_id`),
  KEY `IDX_DOWNLOADABLE_SAMPLE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_DL_SAMPLE_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Table';

-- ----------------------------
-- Records of downloadable_sample
-- ----------------------------

-- ----------------------------
-- Table structure for downloadable_sample_title
-- ----------------------------
DROP TABLE IF EXISTS `downloadable_sample_title`;
CREATE TABLE `downloadable_sample_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `sample_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sample ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `UNQ_DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID_STORE_ID` (`sample_id`,`store_id`),
  KEY `IDX_DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID` (`sample_id`),
  KEY `IDX_DOWNLOADABLE_SAMPLE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_DL_SAMPLE_TTL_SAMPLE_ID_DL_SAMPLE_SAMPLE_ID` FOREIGN KEY (`sample_id`) REFERENCES `downloadable_sample` (`sample_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DOWNLOADABLE_SAMPLE_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Title Table';

-- ----------------------------
-- Records of downloadable_sample_title
-- ----------------------------

-- ----------------------------
-- Table structure for eav_attribute
-- ----------------------------
DROP TABLE IF EXISTS `eav_attribute`;
CREATE TABLE `eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_code` varchar(255) DEFAULT NULL COMMENT 'Attribute Code',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `backend_model` varchar(255) DEFAULT NULL COMMENT 'Backend Model',
  `backend_type` varchar(8) NOT NULL DEFAULT 'static' COMMENT 'Backend Type',
  `backend_table` varchar(255) DEFAULT NULL COMMENT 'Backend Table',
  `frontend_model` varchar(255) DEFAULT NULL COMMENT 'Frontend Model',
  `frontend_input` varchar(50) DEFAULT NULL COMMENT 'Frontend Input',
  `frontend_label` varchar(255) DEFAULT NULL COMMENT 'Frontend Label',
  `frontend_class` varchar(255) DEFAULT NULL COMMENT 'Frontend Class',
  `source_model` varchar(255) DEFAULT NULL COMMENT 'Source Model',
  `is_required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Required',
  `is_user_defined` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is User Defined',
  `default_value` text COMMENT 'Default Value',
  `is_unique` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Unique',
  `note` varchar(255) DEFAULT NULL COMMENT 'Note',
  PRIMARY KEY (`attribute_id`),
  UNIQUE KEY `UNQ_EAV_ATTRIBUTE_ENTITY_TYPE_ID_ATTRIBUTE_CODE` (`entity_type_id`,`attribute_code`),
  KEY `IDX_EAV_ATTRIBUTE_ENTITY_TYPE_ID` (`entity_type_id`),
  CONSTRAINT `FK_EAV_ATTRIBUTE_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute';

-- ----------------------------
-- Records of eav_attribute
-- ----------------------------
INSERT INTO `eav_attribute` VALUES ('1', '1', 'website_id', null, 'customer/customer_attribute_backend_website', 'static', null, null, 'select', 'Associate to Website', null, 'customer/customer_attribute_source_website', '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('2', '1', 'store_id', null, 'customer/customer_attribute_backend_store', 'static', null, null, 'select', 'Create In', null, 'customer/customer_attribute_source_store', '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('3', '1', 'created_in', null, null, 'varchar', null, null, 'text', 'Created From', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('4', '1', 'prefix', null, null, 'varchar', null, null, 'text', 'Prefix', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('5', '1', 'firstname', null, null, 'varchar', null, null, 'text', 'First Name', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('6', '1', 'middlename', null, null, 'varchar', null, null, 'text', 'Middle Name/Initial', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('7', '1', 'lastname', null, null, 'varchar', null, null, 'text', 'Last Name', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('8', '1', 'suffix', null, null, 'varchar', null, null, 'text', 'Suffix', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('9', '1', 'email', null, null, 'static', null, null, 'text', 'Email', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('10', '1', 'group_id', null, null, 'static', null, null, 'select', 'Group', null, 'customer/customer_attribute_source_group', '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('11', '1', 'dob', null, 'eav/entity_attribute_backend_datetime', 'datetime', null, 'eav/entity_attribute_frontend_datetime', 'date', 'Date Of Birth', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('12', '1', 'password_hash', null, 'customer/customer_attribute_backend_password', 'varchar', null, null, 'hidden', null, null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('13', '1', 'default_billing', null, 'customer/customer_attribute_backend_billing', 'int', null, null, 'text', 'Default Billing Address', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('14', '1', 'default_shipping', null, 'customer/customer_attribute_backend_shipping', 'int', null, null, 'text', 'Default Shipping Address', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('15', '1', 'taxvat', null, null, 'varchar', null, null, 'text', 'Tax/VAT Number', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('16', '1', 'confirmation', null, null, 'varchar', null, null, 'text', 'Is Confirmed', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('17', '1', 'created_at', null, null, 'static', null, null, 'datetime', 'Created At', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('18', '1', 'gender', null, null, 'int', null, null, 'select', 'Gender', null, 'eav/entity_attribute_source_table', '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('19', '2', 'prefix', null, null, 'varchar', null, null, 'text', 'Prefix', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('20', '2', 'firstname', null, null, 'varchar', null, null, 'text', 'First Name', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('21', '2', 'middlename', null, null, 'varchar', null, null, 'text', 'Middle Name/Initial', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('22', '2', 'lastname', null, null, 'varchar', null, null, 'text', 'Last Name', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('23', '2', 'suffix', null, null, 'varchar', null, null, 'text', 'Suffix', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('24', '2', 'company', null, null, 'varchar', null, null, 'text', 'Company', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('25', '2', 'street', null, 'customer/entity_address_attribute_backend_street', 'text', null, null, 'multiline', 'Street Address', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('26', '2', 'city', null, null, 'varchar', null, null, 'text', 'City', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('27', '2', 'country_id', null, null, 'varchar', null, null, 'select', 'Country', null, 'customer/entity_address_attribute_source_country', '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('28', '2', 'region', null, 'customer/entity_address_attribute_backend_region', 'varchar', null, null, 'text', 'State/Province', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('29', '2', 'region_id', null, null, 'int', null, null, 'hidden', 'State/Province', null, 'customer/entity_address_attribute_source_region', '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('30', '2', 'postcode', null, null, 'varchar', null, null, 'text', 'Zip/Postal Code', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('31', '2', 'telephone', null, null, 'varchar', null, null, 'text', 'Telephone', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('32', '2', 'fax', null, null, 'varchar', null, null, 'text', 'Fax', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('33', '1', 'rp_token', null, null, 'varchar', null, null, 'hidden', null, null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('34', '1', 'rp_token_created_at', null, null, 'datetime', null, null, 'date', null, null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('35', '1', 'disable_auto_group_change', null, 'customer/attribute_backend_data_boolean', 'static', null, null, 'boolean', 'Disable Automatic Group Change Based on VAT ID', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('36', '2', 'vat_id', null, null, 'varchar', null, null, 'text', 'VAT number', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('37', '2', 'vat_is_valid', null, null, 'int', null, null, 'text', 'VAT number validity', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('38', '2', 'vat_request_id', null, null, 'varchar', null, null, 'text', 'VAT number validation request ID', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('39', '2', 'vat_request_date', null, null, 'varchar', null, null, 'text', 'VAT number validation request date', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('40', '2', 'vat_request_success', null, null, 'int', null, null, 'text', 'VAT number validation request success', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('41', '3', 'name', null, null, 'varchar', null, null, 'text', 'Name', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('42', '3', 'is_active', null, null, 'int', null, null, 'select', 'Is Active', null, 'eav/entity_attribute_source_boolean', '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('43', '3', 'url_key', null, 'catalog/category_attribute_backend_urlkey', 'varchar', null, null, 'text', 'URL Key', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('44', '3', 'description', null, null, 'text', null, null, 'textarea', 'Description', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('45', '3', 'image', null, 'catalog/category_attribute_backend_image', 'varchar', null, null, 'image', 'Image', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('46', '3', 'meta_title', null, null, 'varchar', null, null, 'text', 'Page Title', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('47', '3', 'meta_keywords', null, null, 'text', null, null, 'textarea', 'Meta Keywords', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('48', '3', 'meta_description', null, null, 'text', null, null, 'textarea', 'Meta Description', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('49', '3', 'display_mode', null, null, 'varchar', null, null, 'select', 'Display Mode', null, 'catalog/category_attribute_source_mode', '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('50', '3', 'landing_page', null, null, 'int', null, null, 'select', 'CMS Block', null, 'catalog/category_attribute_source_page', '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('51', '3', 'is_anchor', null, null, 'int', null, null, 'select', 'Is Anchor', null, 'eav/entity_attribute_source_boolean', '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('52', '3', 'path', null, null, 'static', null, null, 'text', 'Path', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('53', '3', 'position', null, null, 'static', null, null, 'text', 'Position', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('54', '3', 'all_children', null, null, 'text', null, null, 'text', null, null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('55', '3', 'path_in_store', null, null, 'text', null, null, 'text', null, null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('56', '3', 'children', null, null, 'text', null, null, 'text', null, null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('57', '3', 'url_path', null, null, 'varchar', null, null, 'text', null, null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('58', '3', 'custom_design', null, null, 'varchar', null, null, 'select', 'Custom Design', null, 'core/design_source_design', '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('59', '3', 'custom_design_from', null, 'eav/entity_attribute_backend_datetime', 'datetime', null, null, 'date', 'Active From', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('60', '3', 'custom_design_to', null, 'eav/entity_attribute_backend_datetime', 'datetime', null, null, 'date', 'Active To', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('61', '3', 'page_layout', null, null, 'varchar', null, null, 'select', 'Page Layout', null, 'catalog/category_attribute_source_layout', '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('62', '3', 'custom_layout_update', null, 'catalog/attribute_backend_customlayoutupdate', 'text', null, null, 'textarea', 'Custom Layout Update', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('63', '3', 'level', null, null, 'static', null, null, 'text', 'Level', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('64', '3', 'children_count', null, null, 'static', null, null, 'text', 'Children Count', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('65', '3', 'available_sort_by', null, 'catalog/category_attribute_backend_sortby', 'text', null, null, 'multiselect', 'Available Product Listing Sort By', null, 'catalog/category_attribute_source_sortby', '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('66', '3', 'default_sort_by', null, 'catalog/category_attribute_backend_sortby', 'varchar', null, null, 'select', 'Default Product Listing Sort By', null, 'catalog/category_attribute_source_sortby', '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('67', '3', 'include_in_menu', null, null, 'int', null, null, 'select', 'Include in Navigation Menu', null, 'eav/entity_attribute_source_boolean', '1', '0', '1', '0', null);
INSERT INTO `eav_attribute` VALUES ('68', '3', 'custom_use_parent_settings', null, null, 'int', null, null, 'select', 'Use Parent Category Settings', null, 'eav/entity_attribute_source_boolean', '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('69', '3', 'custom_apply_to_products', null, null, 'int', null, null, 'select', 'Apply To Products', null, 'eav/entity_attribute_source_boolean', '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('70', '3', 'filter_price_range', null, null, 'decimal', null, null, 'text', 'Layered Navigation Price Step', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('71', '4', 'name', null, null, 'varchar', null, null, 'text', 'Name', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('72', '4', 'description', null, null, 'text', null, null, 'textarea', 'Description', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('73', '4', 'short_description', null, null, 'text', null, null, 'textarea', 'Short Description', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('74', '4', 'sku', null, 'catalog/product_attribute_backend_sku', 'static', null, null, 'text', 'SKU', null, null, '1', '0', null, '1', null);
INSERT INTO `eav_attribute` VALUES ('75', '4', 'price', null, 'catalog/product_attribute_backend_price', 'decimal', null, null, 'price', 'Price', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('76', '4', 'special_price', null, 'catalog/product_attribute_backend_price', 'decimal', null, null, 'price', 'Special Price', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('77', '4', 'special_from_date', null, 'catalog/product_attribute_backend_startdate', 'datetime', null, null, 'date', 'Special Price From Date', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('78', '4', 'special_to_date', null, 'eav/entity_attribute_backend_datetime', 'datetime', null, null, 'date', 'Special Price To Date', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('79', '4', 'cost', null, 'catalog/product_attribute_backend_price', 'decimal', null, null, 'price', 'Cost', null, null, '0', '1', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('80', '4', 'weight', null, null, 'decimal', null, null, 'weight', 'Weight', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('81', '4', 'manufacturer', null, null, 'int', null, null, 'select', 'Manufacturer', null, null, '0', '1', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('82', '4', 'meta_title', null, null, 'varchar', null, null, 'text', 'Meta Title', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('83', '4', 'meta_keyword', null, null, 'text', null, null, 'textarea', 'Meta Keywords', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('84', '4', 'meta_description', null, null, 'varchar', null, null, 'textarea', 'Meta Description', null, null, '0', '0', null, '0', 'Maximum 255 chars');
INSERT INTO `eav_attribute` VALUES ('85', '4', 'image', null, null, 'varchar', null, 'catalog/product_attribute_frontend_image', 'media_image', 'Base Image', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('86', '4', 'small_image', null, null, 'varchar', null, 'catalog/product_attribute_frontend_image', 'media_image', 'Small Image', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('87', '4', 'thumbnail', null, null, 'varchar', null, 'catalog/product_attribute_frontend_image', 'media_image', 'Thumbnail', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('88', '4', 'media_gallery', null, 'catalog/product_attribute_backend_media', 'varchar', null, null, 'gallery', 'Media Gallery', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('89', '4', 'old_id', null, null, 'int', null, null, 'text', null, null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('90', '4', 'group_price', null, 'catalog/product_attribute_backend_groupprice', 'decimal', null, null, 'text', 'Group Price', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('91', '4', 'tier_price', null, 'catalog/product_attribute_backend_tierprice', 'decimal', null, null, 'text', 'Tier Price', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('92', '4', 'color', null, null, 'int', null, null, 'select', 'Color', null, null, '0', '1', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('93', '4', 'news_from_date', null, 'eav/entity_attribute_backend_datetime', 'datetime', null, null, 'date', 'Set Product as New from Date', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('94', '4', 'news_to_date', null, 'eav/entity_attribute_backend_datetime', 'datetime', null, null, 'date', 'Set Product as New to Date', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('95', '4', 'gallery', null, null, 'varchar', null, null, 'gallery', 'Image Gallery', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('96', '4', 'status', null, null, 'int', null, null, 'select', 'Status', null, 'catalog/product_status', '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('97', '4', 'url_key', null, 'catalog/product_attribute_backend_urlkey', 'varchar', null, null, 'text', 'URL Key', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('98', '4', 'url_path', null, null, 'varchar', null, null, 'text', null, null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('99', '4', 'minimal_price', null, null, 'decimal', null, null, 'price', 'Minimal Price', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('100', '4', 'is_recurring', null, null, 'int', null, null, 'select', 'Enable Recurring Profile', null, 'eav/entity_attribute_source_boolean', '0', '0', null, '0', 'Products with recurring profile participate in catalog as nominal items.');
INSERT INTO `eav_attribute` VALUES ('101', '4', 'recurring_profile', null, 'catalog/product_attribute_backend_recurring', 'text', null, null, 'text', 'Recurring Payment Profile', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('102', '4', 'visibility', null, null, 'int', null, null, 'select', 'Visibility', null, 'catalog/product_visibility', '1', '0', '4', '0', null);
INSERT INTO `eav_attribute` VALUES ('103', '4', 'custom_design', null, null, 'varchar', null, null, 'select', 'Custom Design', null, 'core/design_source_design', '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('104', '4', 'custom_design_from', null, 'eav/entity_attribute_backend_datetime', 'datetime', null, null, 'date', 'Active From', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('105', '4', 'custom_design_to', null, 'eav/entity_attribute_backend_datetime', 'datetime', null, null, 'date', 'Active To', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('106', '4', 'custom_layout_update', null, 'catalog/attribute_backend_customlayoutupdate', 'text', null, null, 'textarea', 'Custom Layout Update', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('107', '4', 'page_layout', null, null, 'varchar', null, null, 'select', 'Page Layout', null, 'catalog/product_attribute_source_layout', '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('108', '4', 'category_ids', null, null, 'static', null, null, 'text', null, null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('109', '4', 'options_container', null, null, 'varchar', null, null, 'select', 'Display Product Options In', null, 'catalog/entity_product_attribute_design_options_container', '0', '0', 'container1', '0', null);
INSERT INTO `eav_attribute` VALUES ('110', '4', 'required_options', null, null, 'static', null, null, 'text', null, null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('111', '4', 'has_options', null, null, 'static', null, null, 'text', null, null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('112', '4', 'image_label', null, null, 'varchar', null, null, 'text', 'Image Label', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('113', '4', 'small_image_label', null, null, 'varchar', null, null, 'text', 'Small Image Label', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('114', '4', 'thumbnail_label', null, null, 'varchar', null, null, 'text', 'Thumbnail Label', null, null, '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('115', '4', 'created_at', null, 'eav/entity_attribute_backend_time_created', 'static', null, null, 'text', null, null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('116', '4', 'updated_at', null, 'eav/entity_attribute_backend_time_updated', 'static', null, null, 'text', null, null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('117', '4', 'tax_class_id', null, null, 'int', null, null, 'select', 'Tax Class', null, 'tax/class_source_product', '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('118', '4', 'gift_message_available', null, 'catalog/product_attribute_backend_boolean', 'varchar', null, null, 'select', 'Allow Gift Message', null, 'eav/entity_attribute_source_boolean', '0', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('119', '4', 'price_type', null, null, 'int', null, null, null, null, null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('120', '4', 'sku_type', null, null, 'int', null, null, null, null, null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('121', '4', 'weight_type', null, null, 'int', null, null, null, null, null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('122', '4', 'price_view', null, null, 'int', null, null, 'select', 'Price View', null, 'bundle/product_attribute_source_price_view', '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('123', '4', 'shipment_type', null, null, 'int', null, null, null, 'Shipment', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('124', '4', 'links_purchased_separately', null, null, 'int', null, null, null, 'Links can be purchased separately', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('125', '4', 'samples_title', null, null, 'varchar', null, null, null, 'Samples title', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('126', '4', 'links_title', null, null, 'varchar', null, null, null, 'Links title', null, null, '1', '0', null, '0', null);
INSERT INTO `eav_attribute` VALUES ('127', '4', 'links_exist', null, null, 'int', null, null, null, null, null, null, '0', '0', '0', '0', null);

-- ----------------------------
-- Table structure for eav_attribute_group
-- ----------------------------
DROP TABLE IF EXISTS `eav_attribute_group`;
CREATE TABLE `eav_attribute_group` (
  `attribute_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Group Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Group Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Default Id',
  PRIMARY KEY (`attribute_group_id`),
  UNIQUE KEY `UNQ_EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_ATTRIBUTE_GROUP_NAME` (`attribute_set_id`,`attribute_group_name`),
  KEY `IDX_EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  CONSTRAINT `FK_EAV_ATTR_GROUP_ATTR_SET_ID_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Group';

-- ----------------------------
-- Records of eav_attribute_group
-- ----------------------------
INSERT INTO `eav_attribute_group` VALUES ('1', '1', 'General', '1', '1');
INSERT INTO `eav_attribute_group` VALUES ('2', '2', 'General', '1', '1');
INSERT INTO `eav_attribute_group` VALUES ('3', '3', 'General', '10', '1');
INSERT INTO `eav_attribute_group` VALUES ('4', '3', 'General Information', '2', '0');
INSERT INTO `eav_attribute_group` VALUES ('5', '3', 'Display Settings', '20', '0');
INSERT INTO `eav_attribute_group` VALUES ('6', '3', 'Custom Design', '30', '0');
INSERT INTO `eav_attribute_group` VALUES ('7', '4', 'General', '1', '1');
INSERT INTO `eav_attribute_group` VALUES ('8', '4', 'Prices', '2', '0');
INSERT INTO `eav_attribute_group` VALUES ('9', '4', 'Meta Information', '3', '0');
INSERT INTO `eav_attribute_group` VALUES ('10', '4', 'Images', '4', '0');
INSERT INTO `eav_attribute_group` VALUES ('11', '4', 'Recurring Profile', '5', '0');
INSERT INTO `eav_attribute_group` VALUES ('12', '4', 'Design', '6', '0');
INSERT INTO `eav_attribute_group` VALUES ('13', '5', 'General', '1', '1');
INSERT INTO `eav_attribute_group` VALUES ('14', '6', 'General', '1', '1');
INSERT INTO `eav_attribute_group` VALUES ('15', '7', 'General', '1', '1');
INSERT INTO `eav_attribute_group` VALUES ('16', '8', 'General', '1', '1');
INSERT INTO `eav_attribute_group` VALUES ('17', '4', 'Gift Options', '7', '0');

-- ----------------------------
-- Table structure for eav_attribute_label
-- ----------------------------
DROP TABLE IF EXISTS `eav_attribute_label`;
CREATE TABLE `eav_attribute_label` (
  `attribute_label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Label Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`attribute_label_id`),
  KEY `IDX_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_STORE_ID` (`attribute_id`,`store_id`),
  CONSTRAINT `FK_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ATTRIBUTE_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Label';

-- ----------------------------
-- Records of eav_attribute_label
-- ----------------------------

-- ----------------------------
-- Table structure for eav_attribute_option
-- ----------------------------
DROP TABLE IF EXISTS `eav_attribute_option`;
CREATE TABLE `eav_attribute_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `IDX_EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option';

-- ----------------------------
-- Records of eav_attribute_option
-- ----------------------------
INSERT INTO `eav_attribute_option` VALUES ('1', '18', '0');
INSERT INTO `eav_attribute_option` VALUES ('2', '18', '1');

-- ----------------------------
-- Table structure for eav_attribute_option_value
-- ----------------------------
DROP TABLE IF EXISTS `eav_attribute_option_value`;
CREATE TABLE `eav_attribute_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `IDX_EAV_ATTRIBUTE_OPTION_VALUE_OPTION_ID` (`option_id`),
  KEY `IDX_EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ATTR_OPT_VAL_OPT_ID_EAV_ATTR_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `eav_attribute_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option Value';

-- ----------------------------
-- Records of eav_attribute_option_value
-- ----------------------------
INSERT INTO `eav_attribute_option_value` VALUES ('1', '1', '0', 'Male');
INSERT INTO `eav_attribute_option_value` VALUES ('2', '2', '0', 'Female');

-- ----------------------------
-- Table structure for eav_attribute_set
-- ----------------------------
DROP TABLE IF EXISTS `eav_attribute_set`;
CREATE TABLE `eav_attribute_set` (
  `attribute_set_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Set Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Set Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`attribute_set_id`),
  UNIQUE KEY `UNQ_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_ATTRIBUTE_SET_NAME` (`entity_type_id`,`attribute_set_name`),
  KEY `IDX_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_SORT_ORDER` (`entity_type_id`,`sort_order`),
  CONSTRAINT `FK_EAV_ATTR_SET_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Set';

-- ----------------------------
-- Records of eav_attribute_set
-- ----------------------------
INSERT INTO `eav_attribute_set` VALUES ('1', '1', 'Default', '1');
INSERT INTO `eav_attribute_set` VALUES ('2', '2', 'Default', '1');
INSERT INTO `eav_attribute_set` VALUES ('3', '3', 'Default', '1');
INSERT INTO `eav_attribute_set` VALUES ('4', '4', 'Default', '1');
INSERT INTO `eav_attribute_set` VALUES ('5', '5', 'Default', '1');
INSERT INTO `eav_attribute_set` VALUES ('6', '6', 'Default', '1');
INSERT INTO `eav_attribute_set` VALUES ('7', '7', 'Default', '1');
INSERT INTO `eav_attribute_set` VALUES ('8', '8', 'Default', '1');

-- ----------------------------
-- Table structure for eav_entity
-- ----------------------------
DROP TABLE IF EXISTS `eav_entity`;
CREATE TABLE `eav_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Entity Active',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_EAV_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_ENTITY_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity';

-- ----------------------------
-- Records of eav_entity
-- ----------------------------

-- ----------------------------
-- Table structure for eav_entity_attribute
-- ----------------------------
DROP TABLE IF EXISTS `eav_entity_attribute`;
CREATE TABLE `eav_entity_attribute` (
  `entity_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`entity_attribute_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_ATTRIBUTE_ID` (`attribute_set_id`,`attribute_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_GROUP_ID_ATTRIBUTE_ID` (`attribute_group_id`,`attribute_id`),
  KEY `IDX_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  KEY `IDX_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_ATTR_ATTR_GROUP_ID_EAV_ATTR_GROUP_ATTR_GROUP_ID` FOREIGN KEY (`attribute_group_id`) REFERENCES `eav_attribute_group` (`attribute_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COMMENT='Eav Entity Attributes';

-- ----------------------------
-- Records of eav_entity_attribute
-- ----------------------------
INSERT INTO `eav_entity_attribute` VALUES ('1', '1', '1', '1', '1', '10');
INSERT INTO `eav_entity_attribute` VALUES ('2', '1', '1', '1', '2', '0');
INSERT INTO `eav_entity_attribute` VALUES ('3', '1', '1', '1', '3', '20');
INSERT INTO `eav_entity_attribute` VALUES ('4', '1', '1', '1', '4', '30');
INSERT INTO `eav_entity_attribute` VALUES ('5', '1', '1', '1', '5', '40');
INSERT INTO `eav_entity_attribute` VALUES ('6', '1', '1', '1', '6', '50');
INSERT INTO `eav_entity_attribute` VALUES ('7', '1', '1', '1', '7', '60');
INSERT INTO `eav_entity_attribute` VALUES ('8', '1', '1', '1', '8', '70');
INSERT INTO `eav_entity_attribute` VALUES ('9', '1', '1', '1', '9', '80');
INSERT INTO `eav_entity_attribute` VALUES ('10', '1', '1', '1', '10', '25');
INSERT INTO `eav_entity_attribute` VALUES ('11', '1', '1', '1', '11', '90');
INSERT INTO `eav_entity_attribute` VALUES ('12', '1', '1', '1', '12', '0');
INSERT INTO `eav_entity_attribute` VALUES ('13', '1', '1', '1', '13', '0');
INSERT INTO `eav_entity_attribute` VALUES ('14', '1', '1', '1', '14', '0');
INSERT INTO `eav_entity_attribute` VALUES ('15', '1', '1', '1', '15', '100');
INSERT INTO `eav_entity_attribute` VALUES ('16', '1', '1', '1', '16', '0');
INSERT INTO `eav_entity_attribute` VALUES ('17', '1', '1', '1', '17', '86');
INSERT INTO `eav_entity_attribute` VALUES ('18', '1', '1', '1', '18', '110');
INSERT INTO `eav_entity_attribute` VALUES ('19', '2', '2', '2', '19', '10');
INSERT INTO `eav_entity_attribute` VALUES ('20', '2', '2', '2', '20', '20');
INSERT INTO `eav_entity_attribute` VALUES ('21', '2', '2', '2', '21', '30');
INSERT INTO `eav_entity_attribute` VALUES ('22', '2', '2', '2', '22', '40');
INSERT INTO `eav_entity_attribute` VALUES ('23', '2', '2', '2', '23', '50');
INSERT INTO `eav_entity_attribute` VALUES ('24', '2', '2', '2', '24', '60');
INSERT INTO `eav_entity_attribute` VALUES ('25', '2', '2', '2', '25', '70');
INSERT INTO `eav_entity_attribute` VALUES ('26', '2', '2', '2', '26', '80');
INSERT INTO `eav_entity_attribute` VALUES ('27', '2', '2', '2', '27', '90');
INSERT INTO `eav_entity_attribute` VALUES ('28', '2', '2', '2', '28', '100');
INSERT INTO `eav_entity_attribute` VALUES ('29', '2', '2', '2', '29', '100');
INSERT INTO `eav_entity_attribute` VALUES ('30', '2', '2', '2', '30', '110');
INSERT INTO `eav_entity_attribute` VALUES ('31', '2', '2', '2', '31', '120');
INSERT INTO `eav_entity_attribute` VALUES ('32', '2', '2', '2', '32', '130');
INSERT INTO `eav_entity_attribute` VALUES ('33', '1', '1', '1', '33', '111');
INSERT INTO `eav_entity_attribute` VALUES ('34', '1', '1', '1', '34', '112');
INSERT INTO `eav_entity_attribute` VALUES ('35', '1', '1', '1', '35', '28');
INSERT INTO `eav_entity_attribute` VALUES ('36', '2', '2', '2', '36', '140');
INSERT INTO `eav_entity_attribute` VALUES ('37', '2', '2', '2', '37', '132');
INSERT INTO `eav_entity_attribute` VALUES ('38', '2', '2', '2', '38', '133');
INSERT INTO `eav_entity_attribute` VALUES ('39', '2', '2', '2', '39', '134');
INSERT INTO `eav_entity_attribute` VALUES ('40', '2', '2', '2', '40', '135');
INSERT INTO `eav_entity_attribute` VALUES ('41', '3', '3', '4', '41', '1');
INSERT INTO `eav_entity_attribute` VALUES ('42', '3', '3', '4', '42', '2');
INSERT INTO `eav_entity_attribute` VALUES ('43', '3', '3', '4', '43', '3');
INSERT INTO `eav_entity_attribute` VALUES ('44', '3', '3', '4', '44', '4');
INSERT INTO `eav_entity_attribute` VALUES ('45', '3', '3', '4', '45', '5');
INSERT INTO `eav_entity_attribute` VALUES ('46', '3', '3', '4', '46', '6');
INSERT INTO `eav_entity_attribute` VALUES ('47', '3', '3', '4', '47', '7');
INSERT INTO `eav_entity_attribute` VALUES ('48', '3', '3', '4', '48', '8');
INSERT INTO `eav_entity_attribute` VALUES ('49', '3', '3', '5', '49', '10');
INSERT INTO `eav_entity_attribute` VALUES ('50', '3', '3', '5', '50', '20');
INSERT INTO `eav_entity_attribute` VALUES ('51', '3', '3', '5', '51', '30');
INSERT INTO `eav_entity_attribute` VALUES ('52', '3', '3', '4', '52', '12');
INSERT INTO `eav_entity_attribute` VALUES ('53', '3', '3', '4', '53', '13');
INSERT INTO `eav_entity_attribute` VALUES ('54', '3', '3', '4', '54', '14');
INSERT INTO `eav_entity_attribute` VALUES ('55', '3', '3', '4', '55', '15');
INSERT INTO `eav_entity_attribute` VALUES ('56', '3', '3', '4', '56', '16');
INSERT INTO `eav_entity_attribute` VALUES ('57', '3', '3', '4', '57', '17');
INSERT INTO `eav_entity_attribute` VALUES ('58', '3', '3', '6', '58', '10');
INSERT INTO `eav_entity_attribute` VALUES ('59', '3', '3', '6', '59', '30');
INSERT INTO `eav_entity_attribute` VALUES ('60', '3', '3', '6', '60', '40');
INSERT INTO `eav_entity_attribute` VALUES ('61', '3', '3', '6', '61', '50');
INSERT INTO `eav_entity_attribute` VALUES ('62', '3', '3', '6', '62', '60');
INSERT INTO `eav_entity_attribute` VALUES ('63', '3', '3', '4', '63', '24');
INSERT INTO `eav_entity_attribute` VALUES ('64', '3', '3', '4', '64', '25');
INSERT INTO `eav_entity_attribute` VALUES ('65', '3', '3', '5', '65', '40');
INSERT INTO `eav_entity_attribute` VALUES ('66', '3', '3', '5', '66', '50');
INSERT INTO `eav_entity_attribute` VALUES ('67', '3', '3', '4', '67', '10');
INSERT INTO `eav_entity_attribute` VALUES ('68', '3', '3', '6', '68', '5');
INSERT INTO `eav_entity_attribute` VALUES ('69', '3', '3', '6', '69', '6');
INSERT INTO `eav_entity_attribute` VALUES ('70', '3', '3', '5', '70', '51');
INSERT INTO `eav_entity_attribute` VALUES ('71', '4', '4', '7', '71', '1');
INSERT INTO `eav_entity_attribute` VALUES ('72', '4', '4', '7', '72', '2');
INSERT INTO `eav_entity_attribute` VALUES ('73', '4', '4', '7', '73', '3');
INSERT INTO `eav_entity_attribute` VALUES ('74', '4', '4', '7', '74', '4');
INSERT INTO `eav_entity_attribute` VALUES ('75', '4', '4', '8', '75', '1');
INSERT INTO `eav_entity_attribute` VALUES ('76', '4', '4', '8', '76', '3');
INSERT INTO `eav_entity_attribute` VALUES ('77', '4', '4', '8', '77', '4');
INSERT INTO `eav_entity_attribute` VALUES ('78', '4', '4', '8', '78', '5');
INSERT INTO `eav_entity_attribute` VALUES ('79', '4', '4', '8', '79', '6');
INSERT INTO `eav_entity_attribute` VALUES ('80', '4', '4', '7', '80', '5');
INSERT INTO `eav_entity_attribute` VALUES ('81', '4', '4', '9', '82', '1');
INSERT INTO `eav_entity_attribute` VALUES ('82', '4', '4', '9', '83', '2');
INSERT INTO `eav_entity_attribute` VALUES ('83', '4', '4', '9', '84', '3');
INSERT INTO `eav_entity_attribute` VALUES ('84', '4', '4', '10', '85', '1');
INSERT INTO `eav_entity_attribute` VALUES ('85', '4', '4', '10', '86', '2');
INSERT INTO `eav_entity_attribute` VALUES ('86', '4', '4', '10', '87', '3');
INSERT INTO `eav_entity_attribute` VALUES ('87', '4', '4', '10', '88', '4');
INSERT INTO `eav_entity_attribute` VALUES ('88', '4', '4', '7', '89', '6');
INSERT INTO `eav_entity_attribute` VALUES ('89', '4', '4', '8', '90', '2');
INSERT INTO `eav_entity_attribute` VALUES ('90', '4', '4', '8', '91', '7');
INSERT INTO `eav_entity_attribute` VALUES ('91', '4', '4', '7', '93', '7');
INSERT INTO `eav_entity_attribute` VALUES ('92', '4', '4', '7', '94', '8');
INSERT INTO `eav_entity_attribute` VALUES ('93', '4', '4', '10', '95', '5');
INSERT INTO `eav_entity_attribute` VALUES ('94', '4', '4', '7', '96', '9');
INSERT INTO `eav_entity_attribute` VALUES ('95', '4', '4', '7', '97', '10');
INSERT INTO `eav_entity_attribute` VALUES ('96', '4', '4', '7', '98', '11');
INSERT INTO `eav_entity_attribute` VALUES ('97', '4', '4', '8', '99', '8');
INSERT INTO `eav_entity_attribute` VALUES ('98', '4', '4', '11', '100', '1');
INSERT INTO `eav_entity_attribute` VALUES ('99', '4', '4', '11', '101', '2');
INSERT INTO `eav_entity_attribute` VALUES ('100', '4', '4', '7', '102', '12');
INSERT INTO `eav_entity_attribute` VALUES ('101', '4', '4', '12', '103', '1');
INSERT INTO `eav_entity_attribute` VALUES ('102', '4', '4', '12', '104', '2');
INSERT INTO `eav_entity_attribute` VALUES ('103', '4', '4', '12', '105', '3');
INSERT INTO `eav_entity_attribute` VALUES ('104', '4', '4', '12', '106', '4');
INSERT INTO `eav_entity_attribute` VALUES ('105', '4', '4', '12', '107', '5');
INSERT INTO `eav_entity_attribute` VALUES ('106', '4', '4', '7', '108', '13');
INSERT INTO `eav_entity_attribute` VALUES ('107', '4', '4', '12', '109', '6');
INSERT INTO `eav_entity_attribute` VALUES ('108', '4', '4', '7', '110', '14');
INSERT INTO `eav_entity_attribute` VALUES ('109', '4', '4', '7', '111', '15');
INSERT INTO `eav_entity_attribute` VALUES ('110', '4', '4', '7', '112', '16');
INSERT INTO `eav_entity_attribute` VALUES ('111', '4', '4', '7', '113', '17');
INSERT INTO `eav_entity_attribute` VALUES ('112', '4', '4', '7', '114', '18');
INSERT INTO `eav_entity_attribute` VALUES ('113', '4', '4', '7', '115', '19');
INSERT INTO `eav_entity_attribute` VALUES ('114', '4', '4', '7', '116', '20');
INSERT INTO `eav_entity_attribute` VALUES ('115', '4', '4', '8', '117', '9');
INSERT INTO `eav_entity_attribute` VALUES ('116', '4', '4', '17', '118', '1');
INSERT INTO `eav_entity_attribute` VALUES ('117', '4', '4', '7', '119', '21');
INSERT INTO `eav_entity_attribute` VALUES ('118', '4', '4', '7', '120', '22');
INSERT INTO `eav_entity_attribute` VALUES ('119', '4', '4', '7', '121', '23');
INSERT INTO `eav_entity_attribute` VALUES ('120', '4', '4', '8', '122', '10');
INSERT INTO `eav_entity_attribute` VALUES ('121', '4', '4', '7', '123', '24');
INSERT INTO `eav_entity_attribute` VALUES ('122', '4', '4', '7', '124', '25');
INSERT INTO `eav_entity_attribute` VALUES ('123', '4', '4', '7', '125', '26');
INSERT INTO `eav_entity_attribute` VALUES ('124', '4', '4', '7', '126', '27');
INSERT INTO `eav_entity_attribute` VALUES ('125', '4', '4', '7', '127', '28');

-- ----------------------------
-- Table structure for eav_entity_datetime
-- ----------------------------
DROP TABLE IF EXISTS `eav_entity_datetime`;
CREATE TABLE `eav_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_DATETIME_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_EAV_ENTITY_DATETIME_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_DATETIME_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';

-- ----------------------------
-- Records of eav_entity_datetime
-- ----------------------------

-- ----------------------------
-- Table structure for eav_entity_decimal
-- ----------------------------
DROP TABLE IF EXISTS `eav_entity_decimal`;
CREATE TABLE `eav_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_EAV_ENTITY_DECIMAL_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_DECIMAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_DEC_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';

-- ----------------------------
-- Records of eav_entity_decimal
-- ----------------------------

-- ----------------------------
-- Table structure for eav_entity_int
-- ----------------------------
DROP TABLE IF EXISTS `eav_entity_int`;
CREATE TABLE `eav_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_INT_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_INT_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_EAV_ENTITY_INT_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_INT_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_INT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';

-- ----------------------------
-- Records of eav_entity_int
-- ----------------------------

-- ----------------------------
-- Table structure for eav_entity_store
-- ----------------------------
DROP TABLE IF EXISTS `eav_entity_store`;
CREATE TABLE `eav_entity_store` (
  `entity_store_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Store Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `increment_prefix` varchar(20) DEFAULT NULL COMMENT 'Increment Prefix',
  `increment_last_id` varchar(50) DEFAULT NULL COMMENT 'Last Incremented Id',
  PRIMARY KEY (`entity_store_id`),
  KEY `IDX_EAV_ENTITY_STORE_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_ENTITY_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_STORE_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Store';

-- ----------------------------
-- Records of eav_entity_store
-- ----------------------------

-- ----------------------------
-- Table structure for eav_entity_text
-- ----------------------------
DROP TABLE IF EXISTS `eav_entity_text`;
CREATE TABLE `eav_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_EAV_ENTITY_TEXT_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_TEXT_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';

-- ----------------------------
-- Records of eav_entity_text
-- ----------------------------

-- ----------------------------
-- Table structure for eav_entity_type
-- ----------------------------
DROP TABLE IF EXISTS `eav_entity_type`;
CREATE TABLE `eav_entity_type` (
  `entity_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Type Id',
  `entity_type_code` varchar(50) NOT NULL COMMENT 'Entity Type Code',
  `entity_model` varchar(255) NOT NULL COMMENT 'Entity Model',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `entity_table` varchar(255) DEFAULT NULL COMMENT 'Entity Table',
  `value_table_prefix` varchar(255) DEFAULT NULL COMMENT 'Value Table Prefix',
  `entity_id_field` varchar(255) DEFAULT NULL COMMENT 'Entity Id Field',
  `is_data_sharing` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Data Sharing',
  `data_sharing_key` varchar(100) DEFAULT 'default' COMMENT 'Data Sharing Key',
  `default_attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Attribute Set Id',
  `increment_model` varchar(255) DEFAULT '' COMMENT 'Increment Model',
  `increment_per_store` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Increment Per Store',
  `increment_pad_length` smallint(5) unsigned NOT NULL DEFAULT '8' COMMENT 'Increment Pad Length',
  `increment_pad_char` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Increment Pad Char',
  `additional_attribute_table` varchar(255) DEFAULT '' COMMENT 'Additional Attribute Table',
  `entity_attribute_collection` varchar(255) DEFAULT NULL COMMENT 'Entity Attribute Collection',
  PRIMARY KEY (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_TYPE_ENTITY_TYPE_CODE` (`entity_type_code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Eav Entity Type';

-- ----------------------------
-- Records of eav_entity_type
-- ----------------------------
INSERT INTO `eav_entity_type` VALUES ('1', 'customer', 'customer/customer', 'customer/attribute', 'customer/entity', null, null, '1', 'default', '1', 'eav/entity_increment_numeric', '0', '8', '0', 'customer/eav_attribute', 'customer/attribute_collection');
INSERT INTO `eav_entity_type` VALUES ('2', 'customer_address', 'customer/address', 'customer/attribute', 'customer/address_entity', null, null, '1', 'default', '2', null, '0', '8', '0', 'customer/eav_attribute', 'customer/address_attribute_collection');
INSERT INTO `eav_entity_type` VALUES ('3', 'catalog_category', 'catalog/category', 'catalog/resource_eav_attribute', 'catalog/category', null, null, '1', 'default', '3', null, '0', '8', '0', 'catalog/eav_attribute', 'catalog/category_attribute_collection');
INSERT INTO `eav_entity_type` VALUES ('4', 'catalog_product', 'catalog/product', 'catalog/resource_eav_attribute', 'catalog/product', null, null, '1', 'default', '4', null, '0', '8', '0', 'catalog/eav_attribute', 'catalog/product_attribute_collection');
INSERT INTO `eav_entity_type` VALUES ('5', 'order', 'sales/order', null, 'sales/order', null, null, '1', 'default', '0', 'eav/entity_increment_numeric', '1', '8', '0', null, null);
INSERT INTO `eav_entity_type` VALUES ('6', 'invoice', 'sales/order_invoice', null, 'sales/invoice', null, null, '1', 'default', '0', 'eav/entity_increment_numeric', '1', '8', '0', null, null);
INSERT INTO `eav_entity_type` VALUES ('7', 'creditmemo', 'sales/order_creditmemo', null, 'sales/creditmemo', null, null, '1', 'default', '0', 'eav/entity_increment_numeric', '1', '8', '0', null, null);
INSERT INTO `eav_entity_type` VALUES ('8', 'shipment', 'sales/order_shipment', null, 'sales/shipment', null, null, '1', 'default', '0', 'eav/entity_increment_numeric', '1', '8', '0', null, null);

-- ----------------------------
-- Table structure for eav_entity_varchar
-- ----------------------------
DROP TABLE IF EXISTS `eav_entity_varchar`;
CREATE TABLE `eav_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_EAV_ENTITY_VARCHAR_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_VARCHAR_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_VCHR_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';

-- ----------------------------
-- Records of eav_entity_varchar
-- ----------------------------

-- ----------------------------
-- Table structure for eav_form_element
-- ----------------------------
DROP TABLE IF EXISTS `eav_form_element`;
CREATE TABLE `eav_form_element` (
  `element_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Element Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `fieldset_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Fieldset Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`element_id`),
  UNIQUE KEY `UNQ_EAV_FORM_ELEMENT_TYPE_ID_ATTRIBUTE_ID` (`type_id`,`attribute_id`),
  KEY `IDX_EAV_FORM_ELEMENT_TYPE_ID` (`type_id`),
  KEY `IDX_EAV_FORM_ELEMENT_FIELDSET_ID` (`fieldset_id`),
  KEY `IDX_EAV_FORM_ELEMENT_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_EAV_FORM_ELEMENT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_FORM_ELEMENT_FIELDSET_ID_EAV_FORM_FIELDSET_FIELDSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `eav_form_fieldset` (`fieldset_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_FORM_ELEMENT_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COMMENT='Eav Form Element';

-- ----------------------------
-- Records of eav_form_element
-- ----------------------------
INSERT INTO `eav_form_element` VALUES ('1', '1', null, '20', '0');
INSERT INTO `eav_form_element` VALUES ('2', '1', null, '21', '1');
INSERT INTO `eav_form_element` VALUES ('3', '1', null, '22', '2');
INSERT INTO `eav_form_element` VALUES ('4', '1', null, '24', '3');
INSERT INTO `eav_form_element` VALUES ('5', '1', null, '9', '4');
INSERT INTO `eav_form_element` VALUES ('6', '1', null, '25', '5');
INSERT INTO `eav_form_element` VALUES ('7', '1', null, '26', '6');
INSERT INTO `eav_form_element` VALUES ('8', '1', null, '28', '7');
INSERT INTO `eav_form_element` VALUES ('9', '1', null, '30', '8');
INSERT INTO `eav_form_element` VALUES ('10', '1', null, '27', '9');
INSERT INTO `eav_form_element` VALUES ('11', '1', null, '31', '10');
INSERT INTO `eav_form_element` VALUES ('12', '1', null, '32', '11');
INSERT INTO `eav_form_element` VALUES ('13', '2', null, '20', '0');
INSERT INTO `eav_form_element` VALUES ('14', '2', null, '21', '1');
INSERT INTO `eav_form_element` VALUES ('15', '2', null, '22', '2');
INSERT INTO `eav_form_element` VALUES ('16', '2', null, '24', '3');
INSERT INTO `eav_form_element` VALUES ('17', '2', null, '9', '4');
INSERT INTO `eav_form_element` VALUES ('18', '2', null, '25', '5');
INSERT INTO `eav_form_element` VALUES ('19', '2', null, '26', '6');
INSERT INTO `eav_form_element` VALUES ('20', '2', null, '28', '7');
INSERT INTO `eav_form_element` VALUES ('21', '2', null, '30', '8');
INSERT INTO `eav_form_element` VALUES ('22', '2', null, '27', '9');
INSERT INTO `eav_form_element` VALUES ('23', '2', null, '31', '10');
INSERT INTO `eav_form_element` VALUES ('24', '2', null, '32', '11');
INSERT INTO `eav_form_element` VALUES ('25', '3', null, '20', '0');
INSERT INTO `eav_form_element` VALUES ('26', '3', null, '21', '1');
INSERT INTO `eav_form_element` VALUES ('27', '3', null, '22', '2');
INSERT INTO `eav_form_element` VALUES ('28', '3', null, '24', '3');
INSERT INTO `eav_form_element` VALUES ('29', '3', null, '25', '4');
INSERT INTO `eav_form_element` VALUES ('30', '3', null, '26', '5');
INSERT INTO `eav_form_element` VALUES ('31', '3', null, '28', '6');
INSERT INTO `eav_form_element` VALUES ('32', '3', null, '30', '7');
INSERT INTO `eav_form_element` VALUES ('33', '3', null, '27', '8');
INSERT INTO `eav_form_element` VALUES ('34', '3', null, '31', '9');
INSERT INTO `eav_form_element` VALUES ('35', '3', null, '32', '10');
INSERT INTO `eav_form_element` VALUES ('36', '4', null, '20', '0');
INSERT INTO `eav_form_element` VALUES ('37', '4', null, '21', '1');
INSERT INTO `eav_form_element` VALUES ('38', '4', null, '22', '2');
INSERT INTO `eav_form_element` VALUES ('39', '4', null, '24', '3');
INSERT INTO `eav_form_element` VALUES ('40', '4', null, '25', '4');
INSERT INTO `eav_form_element` VALUES ('41', '4', null, '26', '5');
INSERT INTO `eav_form_element` VALUES ('42', '4', null, '28', '6');
INSERT INTO `eav_form_element` VALUES ('43', '4', null, '30', '7');
INSERT INTO `eav_form_element` VALUES ('44', '4', null, '27', '8');
INSERT INTO `eav_form_element` VALUES ('45', '4', null, '31', '9');
INSERT INTO `eav_form_element` VALUES ('46', '4', null, '32', '10');
INSERT INTO `eav_form_element` VALUES ('47', '5', '1', '5', '0');
INSERT INTO `eav_form_element` VALUES ('48', '5', '1', '6', '1');
INSERT INTO `eav_form_element` VALUES ('49', '5', '1', '7', '2');
INSERT INTO `eav_form_element` VALUES ('50', '5', '1', '9', '3');
INSERT INTO `eav_form_element` VALUES ('51', '5', '2', '24', '0');
INSERT INTO `eav_form_element` VALUES ('52', '5', '2', '31', '1');
INSERT INTO `eav_form_element` VALUES ('53', '5', '2', '25', '2');
INSERT INTO `eav_form_element` VALUES ('54', '5', '2', '26', '3');
INSERT INTO `eav_form_element` VALUES ('55', '5', '2', '28', '4');
INSERT INTO `eav_form_element` VALUES ('56', '5', '2', '30', '5');
INSERT INTO `eav_form_element` VALUES ('57', '5', '2', '27', '6');

-- ----------------------------
-- Table structure for eav_form_fieldset
-- ----------------------------
DROP TABLE IF EXISTS `eav_form_fieldset`;
CREATE TABLE `eav_form_fieldset` (
  `fieldset_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Fieldset Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`fieldset_id`),
  UNIQUE KEY `UNQ_EAV_FORM_FIELDSET_TYPE_ID_CODE` (`type_id`,`code`),
  KEY `IDX_EAV_FORM_FIELDSET_TYPE_ID` (`type_id`),
  CONSTRAINT `FK_EAV_FORM_FIELDSET_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset';

-- ----------------------------
-- Records of eav_form_fieldset
-- ----------------------------
INSERT INTO `eav_form_fieldset` VALUES ('1', '5', 'general', '1');
INSERT INTO `eav_form_fieldset` VALUES ('2', '5', 'address', '2');

-- ----------------------------
-- Table structure for eav_form_fieldset_label
-- ----------------------------
DROP TABLE IF EXISTS `eav_form_fieldset_label`;
CREATE TABLE `eav_form_fieldset_label` (
  `fieldset_id` smallint(5) unsigned NOT NULL COMMENT 'Fieldset Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`fieldset_id`,`store_id`),
  KEY `IDX_EAV_FORM_FIELDSET_LABEL_FIELDSET_ID` (`fieldset_id`),
  KEY `IDX_EAV_FORM_FIELDSET_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_FORM_FIELDSET_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_FORM_FSET_LBL_FSET_ID_EAV_FORM_FSET_FSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `eav_form_fieldset` (`fieldset_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset Label';

-- ----------------------------
-- Records of eav_form_fieldset_label
-- ----------------------------
INSERT INTO `eav_form_fieldset_label` VALUES ('1', '0', 'Personal Information');
INSERT INTO `eav_form_fieldset_label` VALUES ('2', '0', 'Address Information');

-- ----------------------------
-- Table structure for eav_form_type
-- ----------------------------
DROP TABLE IF EXISTS `eav_form_type`;
CREATE TABLE `eav_form_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `UNQ_EAV_FORM_TYPE_CODE_THEME_STORE_ID` (`code`,`theme`,`store_id`),
  KEY `IDX_EAV_FORM_TYPE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_FORM_TYPE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Eav Form Type';

-- ----------------------------
-- Records of eav_form_type
-- ----------------------------
INSERT INTO `eav_form_type` VALUES ('1', 'checkout_onepage_register', 'checkout_onepage_register', '1', '', '0');
INSERT INTO `eav_form_type` VALUES ('2', 'checkout_onepage_register_guest', 'checkout_onepage_register_guest', '1', '', '0');
INSERT INTO `eav_form_type` VALUES ('3', 'checkout_onepage_billing_address', 'checkout_onepage_billing_address', '1', '', '0');
INSERT INTO `eav_form_type` VALUES ('4', 'checkout_onepage_shipping_address', 'checkout_onepage_shipping_address', '1', '', '0');
INSERT INTO `eav_form_type` VALUES ('5', 'checkout_multishipping_register', 'checkout_multishipping_register', '1', '', '0');

-- ----------------------------
-- Table structure for eav_form_type_entity
-- ----------------------------
DROP TABLE IF EXISTS `eav_form_type_entity`;
CREATE TABLE `eav_form_type_entity` (
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`type_id`,`entity_type_id`),
  KEY `IDX_EAV_FORM_TYPE_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  CONSTRAINT `FK_EAV_FORM_TYPE_ENTITY_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_FORM_TYPE_ENTT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Type Entity';

-- ----------------------------
-- Records of eav_form_type_entity
-- ----------------------------
INSERT INTO `eav_form_type_entity` VALUES ('1', '1');
INSERT INTO `eav_form_type_entity` VALUES ('2', '1');
INSERT INTO `eav_form_type_entity` VALUES ('5', '1');
INSERT INTO `eav_form_type_entity` VALUES ('1', '2');
INSERT INTO `eav_form_type_entity` VALUES ('2', '2');
INSERT INTO `eav_form_type_entity` VALUES ('3', '2');
INSERT INTO `eav_form_type_entity` VALUES ('4', '2');
INSERT INTO `eav_form_type_entity` VALUES ('5', '2');

-- ----------------------------
-- Table structure for gift_message
-- ----------------------------
DROP TABLE IF EXISTS `gift_message`;
CREATE TABLE `gift_message` (
  `gift_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'GiftMessage Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `sender` varchar(255) DEFAULT NULL COMMENT 'Sender',
  `recipient` varchar(255) DEFAULT NULL COMMENT 'Recipient',
  `message` text COMMENT 'Message',
  PRIMARY KEY (`gift_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Gift Message';

-- ----------------------------
-- Records of gift_message
-- ----------------------------

-- ----------------------------
-- Table structure for importexport_importdata
-- ----------------------------
DROP TABLE IF EXISTS `importexport_importdata`;
CREATE TABLE `importexport_importdata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `entity` varchar(50) NOT NULL COMMENT 'Entity',
  `behavior` varchar(10) NOT NULL DEFAULT 'append' COMMENT 'Behavior',
  `data` longtext COMMENT 'Data',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Import Data Table';

-- ----------------------------
-- Records of importexport_importdata
-- ----------------------------

-- ----------------------------
-- Table structure for index_event
-- ----------------------------
DROP TABLE IF EXISTS `index_event`;
CREATE TABLE `index_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `type` varchar(64) NOT NULL COMMENT 'Type',
  `entity` varchar(64) NOT NULL COMMENT 'Entity',
  `entity_pk` bigint(20) DEFAULT NULL COMMENT 'Entity Primary Key',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Creation Time',
  `old_data` mediumtext COMMENT 'Old Data',
  `new_data` mediumtext COMMENT 'New Data',
  PRIMARY KEY (`event_id`),
  UNIQUE KEY `UNQ_INDEX_EVENT_TYPE_ENTITY_ENTITY_PK` (`type`,`entity`,`entity_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Index Event';

-- ----------------------------
-- Records of index_event
-- ----------------------------
INSERT INTO `index_event` VALUES ('1', 'save', 'catalog_category', '1', '2015-08-06 05:57:05', null, 'a:5:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:1;s:35:\"catalogsearch_fulltext_match_result\";b:1;}');
INSERT INTO `index_event` VALUES ('2', 'save', 'catalog_category', '2', '2015-08-06 05:57:05', null, 'a:5:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:1;s:35:\"catalogsearch_fulltext_match_result\";b:1;}');

-- ----------------------------
-- Table structure for index_process
-- ----------------------------
DROP TABLE IF EXISTS `index_process`;
CREATE TABLE `index_process` (
  `process_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Process Id',
  `indexer_code` varchar(32) NOT NULL COMMENT 'Indexer Code',
  `status` varchar(15) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `started_at` timestamp NULL DEFAULT NULL COMMENT 'Started At',
  `ended_at` timestamp NULL DEFAULT NULL COMMENT 'Ended At',
  `mode` varchar(9) NOT NULL DEFAULT 'real_time' COMMENT 'Mode',
  PRIMARY KEY (`process_id`),
  UNIQUE KEY `UNQ_INDEX_PROCESS_INDEXER_CODE` (`indexer_code`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='Index Process';

-- ----------------------------
-- Records of index_process
-- ----------------------------
INSERT INTO `index_process` VALUES ('1', 'catalog_product_attribute', 'require_reindex', null, null, 'real_time');
INSERT INTO `index_process` VALUES ('2', 'catalog_product_price', 'require_reindex', null, null, 'real_time');
INSERT INTO `index_process` VALUES ('3', 'catalog_url', 'require_reindex', '2015-08-06 05:57:05', '2015-08-06 05:57:05', 'real_time');
INSERT INTO `index_process` VALUES ('4', 'catalog_product_flat', 'require_reindex', null, null, 'real_time');
INSERT INTO `index_process` VALUES ('5', 'catalog_category_flat', 'require_reindex', null, null, 'real_time');
INSERT INTO `index_process` VALUES ('6', 'catalog_category_product', 'require_reindex', '2015-08-06 05:57:05', '2015-08-06 05:57:05', 'real_time');
INSERT INTO `index_process` VALUES ('7', 'catalogsearch_fulltext', 'require_reindex', '2015-08-06 05:57:05', '2015-08-06 05:57:05', 'real_time');
INSERT INTO `index_process` VALUES ('8', 'cataloginventory_stock', 'require_reindex', null, null, 'real_time');
INSERT INTO `index_process` VALUES ('9', 'tag_summary', 'require_reindex', null, null, 'real_time');

-- ----------------------------
-- Table structure for index_process_event
-- ----------------------------
DROP TABLE IF EXISTS `index_process_event`;
CREATE TABLE `index_process_event` (
  `process_id` int(10) unsigned NOT NULL COMMENT 'Process Id',
  `event_id` bigint(20) unsigned NOT NULL COMMENT 'Event Id',
  `status` varchar(7) NOT NULL DEFAULT 'new' COMMENT 'Status',
  PRIMARY KEY (`process_id`,`event_id`),
  KEY `IDX_INDEX_PROCESS_EVENT_EVENT_ID` (`event_id`),
  CONSTRAINT `FK_INDEX_PROCESS_EVENT_EVENT_ID_INDEX_EVENT_EVENT_ID` FOREIGN KEY (`event_id`) REFERENCES `index_event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_INDEX_PROCESS_EVENT_PROCESS_ID_INDEX_PROCESS_PROCESS_ID` FOREIGN KEY (`process_id`) REFERENCES `index_process` (`process_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Index Process Event';

-- ----------------------------
-- Records of index_process_event
-- ----------------------------

-- ----------------------------
-- Table structure for log_customer
-- ----------------------------
DROP TABLE IF EXISTS `log_customer`;
CREATE TABLE `log_customer` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `login_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Login Time',
  `logout_at` timestamp NULL DEFAULT NULL COMMENT 'Logout Time',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`log_id`),
  KEY `IDX_LOG_CUSTOMER_VISITOR_ID` (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Customers Table';

-- ----------------------------
-- Records of log_customer
-- ----------------------------

-- ----------------------------
-- Table structure for log_quote
-- ----------------------------
DROP TABLE IF EXISTS `log_quote`;
CREATE TABLE `log_quote` (
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Creation Time',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Deletion Time',
  PRIMARY KEY (`quote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Quotes Table';

-- ----------------------------
-- Records of log_quote
-- ----------------------------

-- ----------------------------
-- Table structure for log_summary
-- ----------------------------
DROP TABLE IF EXISTS `log_summary`;
CREATE TABLE `log_summary` (
  `summary_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Summary ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `type_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Type ID',
  `visitor_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Visitor Count',
  `customer_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer Count',
  `add_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date',
  PRIMARY KEY (`summary_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Summary Table';

-- ----------------------------
-- Records of log_summary
-- ----------------------------

-- ----------------------------
-- Table structure for log_summary_type
-- ----------------------------
DROP TABLE IF EXISTS `log_summary_type`;
CREATE TABLE `log_summary_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type ID',
  `type_code` varchar(64) DEFAULT NULL COMMENT 'Type Code',
  `period` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Period',
  `period_type` varchar(6) NOT NULL DEFAULT 'MINUTE' COMMENT 'Period Type',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Log Summary Types Table';

-- ----------------------------
-- Records of log_summary_type
-- ----------------------------
INSERT INTO `log_summary_type` VALUES ('1', 'hour', '1', 'HOUR');
INSERT INTO `log_summary_type` VALUES ('2', 'day', '1', 'DAY');

-- ----------------------------
-- Table structure for log_url
-- ----------------------------
DROP TABLE IF EXISTS `log_url`;
CREATE TABLE `log_url` (
  `url_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'URL ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `visit_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Visit Time',
  KEY `IDX_LOG_URL_VISITOR_ID` (`visitor_id`),
  KEY `url_id` (`url_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log URL Table';

-- ----------------------------
-- Records of log_url
-- ----------------------------

-- ----------------------------
-- Table structure for log_url_info
-- ----------------------------
DROP TABLE IF EXISTS `log_url_info`;
CREATE TABLE `log_url_info` (
  `url_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'URL ID',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL',
  `referer` varchar(255) DEFAULT NULL COMMENT 'Referrer',
  PRIMARY KEY (`url_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log URL Info Table';

-- ----------------------------
-- Records of log_url_info
-- ----------------------------

-- ----------------------------
-- Table structure for log_visitor
-- ----------------------------
DROP TABLE IF EXISTS `log_visitor`;
CREATE TABLE `log_visitor` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `session_id` varchar(64) DEFAULT NULL COMMENT 'Session ID',
  `first_visit_at` timestamp NULL DEFAULT NULL COMMENT 'First Visit Time',
  `last_visit_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Last Visit Time',
  `last_url_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Last URL ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Log Visitors Table';

-- ----------------------------
-- Records of log_visitor
-- ----------------------------
INSERT INTO `log_visitor` VALUES ('1', '15k1uhrb2nch4tskf9r08horo7', '2015-08-06 05:58:13', '2015-08-06 05:58:16', '0', '1');
INSERT INTO `log_visitor` VALUES ('2', 'm0fggu7g665qku54j9634mujh5', '2015-08-06 07:02:05', '2015-08-06 07:02:07', '0', '1');

-- ----------------------------
-- Table structure for log_visitor_info
-- ----------------------------
DROP TABLE IF EXISTS `log_visitor_info`;
CREATE TABLE `log_visitor_info` (
  `visitor_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `http_referer` varchar(255) DEFAULT NULL COMMENT 'HTTP Referrer',
  `http_user_agent` varchar(255) DEFAULT NULL COMMENT 'HTTP User-Agent',
  `http_accept_charset` varchar(255) DEFAULT NULL COMMENT 'HTTP Accept-Charset',
  `http_accept_language` varchar(255) DEFAULT NULL COMMENT 'HTTP Accept-Language',
  `server_addr` varbinary(16) DEFAULT NULL,
  `remote_addr` varbinary(16) DEFAULT NULL,
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitor Info Table';

-- ----------------------------
-- Records of log_visitor_info
-- ----------------------------

-- ----------------------------
-- Table structure for log_visitor_online
-- ----------------------------
DROP TABLE IF EXISTS `log_visitor_online`;
CREATE TABLE `log_visitor_online` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `visitor_type` varchar(1) NOT NULL COMMENT 'Visitor Type',
  `remote_addr` varbinary(16) DEFAULT NULL,
  `first_visit_at` timestamp NULL DEFAULT NULL COMMENT 'First Visit Time',
  `last_visit_at` timestamp NULL DEFAULT NULL COMMENT 'Last Visit Time',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `last_url` varchar(255) DEFAULT NULL COMMENT 'Last URL',
  PRIMARY KEY (`visitor_id`),
  KEY `IDX_LOG_VISITOR_ONLINE_VISITOR_TYPE` (`visitor_type`),
  KEY `IDX_LOG_VISITOR_ONLINE_FIRST_VISIT_AT_LAST_VISIT_AT` (`first_visit_at`,`last_visit_at`),
  KEY `IDX_LOG_VISITOR_ONLINE_CUSTOMER_ID` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitor Online Table';

-- ----------------------------
-- Records of log_visitor_online
-- ----------------------------

-- ----------------------------
-- Table structure for newsletter_problem
-- ----------------------------
DROP TABLE IF EXISTS `newsletter_problem`;
CREATE TABLE `newsletter_problem` (
  `problem_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Problem Id',
  `subscriber_id` int(10) unsigned DEFAULT NULL COMMENT 'Subscriber Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `problem_error_code` int(10) unsigned DEFAULT '0' COMMENT 'Problem Error Code',
  `problem_error_text` varchar(200) DEFAULT NULL COMMENT 'Problem Error Text',
  PRIMARY KEY (`problem_id`),
  KEY `IDX_NEWSLETTER_PROBLEM_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `IDX_NEWSLETTER_PROBLEM_QUEUE_ID` (`queue_id`),
  CONSTRAINT `FK_NEWSLETTER_PROBLEM_QUEUE_ID_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NLTTR_PROBLEM_SUBSCRIBER_ID_NLTTR_SUBSCRIBER_SUBSCRIBER_ID` FOREIGN KEY (`subscriber_id`) REFERENCES `newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Problems';

-- ----------------------------
-- Records of newsletter_problem
-- ----------------------------

-- ----------------------------
-- Table structure for newsletter_queue
-- ----------------------------
DROP TABLE IF EXISTS `newsletter_queue`;
CREATE TABLE `newsletter_queue` (
  `queue_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Id',
  `template_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Template Id',
  `newsletter_type` int(11) DEFAULT NULL COMMENT 'Newsletter Type',
  `newsletter_text` text COMMENT 'Newsletter Text',
  `newsletter_styles` text COMMENT 'Newsletter Styles',
  `newsletter_subject` varchar(200) DEFAULT NULL COMMENT 'Newsletter Subject',
  `newsletter_sender_name` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Name',
  `newsletter_sender_email` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Email',
  `queue_status` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Status',
  `queue_start_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Start At',
  `queue_finish_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Finish At',
  PRIMARY KEY (`queue_id`),
  KEY `IDX_NEWSLETTER_QUEUE_TEMPLATE_ID` (`template_id`),
  CONSTRAINT `FK_NEWSLETTER_QUEUE_TEMPLATE_ID_NEWSLETTER_TEMPLATE_TEMPLATE_ID` FOREIGN KEY (`template_id`) REFERENCES `newsletter_template` (`template_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue';

-- ----------------------------
-- Records of newsletter_queue
-- ----------------------------

-- ----------------------------
-- Table structure for newsletter_queue_link
-- ----------------------------
DROP TABLE IF EXISTS `newsletter_queue_link`;
CREATE TABLE `newsletter_queue_link` (
  `queue_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Link Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `subscriber_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subscriber Id',
  `letter_sent_at` timestamp NULL DEFAULT NULL COMMENT 'Letter Sent At',
  PRIMARY KEY (`queue_link_id`),
  KEY `IDX_NEWSLETTER_QUEUE_LINK_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `IDX_NEWSLETTER_QUEUE_LINK_QUEUE_ID` (`queue_id`),
  KEY `IDX_NEWSLETTER_QUEUE_LINK_QUEUE_ID_LETTER_SENT_AT` (`queue_id`,`letter_sent_at`),
  CONSTRAINT `FK_NEWSLETTER_QUEUE_LINK_QUEUE_ID_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NLTTR_QUEUE_LNK_SUBSCRIBER_ID_NLTTR_SUBSCRIBER_SUBSCRIBER_ID` FOREIGN KEY (`subscriber_id`) REFERENCES `newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Link';

-- ----------------------------
-- Records of newsletter_queue_link
-- ----------------------------

-- ----------------------------
-- Table structure for newsletter_queue_store_link
-- ----------------------------
DROP TABLE IF EXISTS `newsletter_queue_store_link`;
CREATE TABLE `newsletter_queue_store_link` (
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`queue_id`,`store_id`),
  KEY `IDX_NEWSLETTER_QUEUE_STORE_LINK_STORE_ID` (`store_id`),
  CONSTRAINT `FK_NEWSLETTER_QUEUE_STORE_LINK_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NLTTR_QUEUE_STORE_LNK_QUEUE_ID_NLTTR_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Store Link';

-- ----------------------------
-- Records of newsletter_queue_store_link
-- ----------------------------

-- ----------------------------
-- Table structure for newsletter_subscriber
-- ----------------------------
DROP TABLE IF EXISTS `newsletter_subscriber`;
CREATE TABLE `newsletter_subscriber` (
  `subscriber_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Subscriber Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `change_status_at` timestamp NULL DEFAULT NULL COMMENT 'Change Status At',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `subscriber_email` varchar(150) DEFAULT NULL COMMENT 'Subscriber Email',
  `subscriber_status` int(11) NOT NULL DEFAULT '0' COMMENT 'Subscriber Status',
  `subscriber_confirm_code` varchar(32) DEFAULT 'NULL' COMMENT 'Subscriber Confirm Code',
  PRIMARY KEY (`subscriber_id`),
  KEY `IDX_NEWSLETTER_SUBSCRIBER_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_NEWSLETTER_SUBSCRIBER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_NEWSLETTER_SUBSCRIBER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Subscriber';

-- ----------------------------
-- Records of newsletter_subscriber
-- ----------------------------

-- ----------------------------
-- Table structure for newsletter_template
-- ----------------------------
DROP TABLE IF EXISTS `newsletter_template`;
CREATE TABLE `newsletter_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `template_code` varchar(150) DEFAULT NULL COMMENT 'Template Code',
  `template_text` text COMMENT 'Template Text',
  `template_text_preprocessed` text COMMENT 'Template Text Preprocessed',
  `template_styles` text COMMENT 'Template Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) DEFAULT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `template_actual` smallint(5) unsigned DEFAULT '1' COMMENT 'Template Actual',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Added At',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Modified At',
  PRIMARY KEY (`template_id`),
  KEY `IDX_NEWSLETTER_TEMPLATE_TEMPLATE_ACTUAL` (`template_actual`),
  KEY `IDX_NEWSLETTER_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `IDX_NEWSLETTER_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Newsletter Template';

-- ----------------------------
-- Records of newsletter_template
-- ----------------------------
INSERT INTO `newsletter_template` VALUES ('1', 'Example Newsletter Template', '{{template config_path=\"design/email/header\"}}\n{{inlinecss file=\"email-inline.css\"}}\n\n<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n<tr>\n    <td class=\"full\">\n        <table class=\"columns\">\n            <tr>\n                <td class=\"email-heading\">\n                    <h1>Welcome</h1>\n                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,\n                    sed do eiusmod tempor incididunt ut labore et.</p>\n                </td>\n                <td class=\"store-info\">\n                    <h4>Contact Us</h4>\n                    <p>\n                        {{depend store_phone}}\n                        <b>Call Us:</b>\n                        <a href=\"tel:{{var phone}}\">{{var store_phone}}</a><br>\n                        {{/depend}}\n                        {{depend store_hours}}\n                        <span class=\"no-link\">{{var store_hours}}</span><br>\n                        {{/depend}}\n                        {{depend store_email}}\n                        <b>Email:</b> <a href=\"mailto:{{var store_email}}\">{{var store_email}}</a>\n                        {{/depend}}\n                    </p>\n                </td>\n            </tr>\n        </table>\n    </td>\n</tr>\n<tr>\n    <td class=\"full\">\n        <table class=\"columns\">\n            <tr>\n                <td>\n                    <img width=\"600\" src=\"http://placehold.it/600x200\" class=\"main-image\">\n                </td>\n                <td class=\"expander\"></td>\n            </tr>\n        </table>\n        <table class=\"columns\">\n            <tr>\n                <td class=\"panel\">\n                    <p>Phasellus dictum sapien a neque luctus cursus. Pellentesque sem dolor, fringilla et pharetra\n                    vitae. <a href=\"#\">Click it! &raquo;</a></p>\n                </td>\n                <td class=\"expander\"></td>\n            </tr>\n        </table>\n    </td>\n</tr>\n<tr>\n    <td>\n        <table class=\"row\">\n            <tr>\n                <td class=\"half left wrapper\">\n                    <table class=\"columns\">\n                        <tr>\n                            <td>\n                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor\n                                incididunt ut labore et. Lorem ipsum dolor sit amet, consectetur adipisicing elit,\n                                sed do eiusmod tempor incididunt ut labore et. Lorem ipsum dolor sit amet.</p>\n                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor\n                                incididunt ut labore et. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed\n                                do eiusmod tempor incididunt ut labore et. Lorem ipsum dolor sit amet.</p>\n                                <table class=\"button\">\n                                    <tr>\n                                        <td>\n                                            <a href=\"#\">Click Me!</a>\n                                        </td>\n                                    </tr>\n                                </table>\n                            </td>\n                            <td class=\"expander\"></td>\n                        </tr>\n                    </table>\n                </td>\n                <td class=\"half right wrapper last\">\n                    <table class=\"columns\">\n                        <tr>\n                            <td class=\"panel sidebar-links\">\n                                <h6>Header Thing</h6>\n                                <p>Sub-head or something</p>\n                                <table>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr><td>&nbsp;</td></tr>\n                                </table>\n                            </td>\n                            <td class=\"expander\"></td>\n                        </tr>\n                    </table>\n                    <br>\n                    <table class=\"columns\">\n                        <tr>\n                            <td class=\"panel\">\n                                <h6>Connect With Us:</h6>\n                                <table class=\"social-button facebook\">\n                                    <tr>\n                                        <td>\n                                            <a href=\"#\">Facebook</a>\n                                        </td>\n                                    </tr>\n                                </table>\n                                <hr>\n                                <table class=\"social-button twitter\">\n                                    <tr>\n                                        <td>\n                                            <a href=\"#\">Twitter</a>\n                                        </td>\n                                    </tr>\n                                </table>\n                                <hr>\n                                <table class=\"social-button google-plus\">\n                                    <tr>\n                                        <td>\n                                            <a href=\"#\">Google +</a>\n                                        </td>\n                                    </tr>\n                                </table>\n                                <br>\n                                <h6>Contact Info:</h6>\n                                {{depend store_phone}}\n                                <p>\n                                    <b>Call Us:</b>\n                                    <a href=\"tel:{{var phone}}\">{{var store_phone}}</a>\n                                </p>\n                                {{/depend}}\n                                {{depend store_hours}}\n                                <p><span class=\"no-link\">{{var store_hours}}</span><br></p>\n                                {{/depend}}\n                                {{depend store_email}}\n                                <p><b>Email:</b> <a href=\"mailto:{{var store_email}}\">{{var store_email}}</a></p>\n                                {{/depend}}\n                            </td>\n                            <td class=\"expander\"></td>\n                        </tr>\n                    </table>\n                </td>\n            </tr>\n        </table>\n        <table class=\"row\">\n            <tr>\n                <td class=\"full wrapper\">\n                    {{block type=\"catalog/product_new\" template=\"email/catalog/product/new.phtml\" products_count=\"4\"\n                    column_count=\"4\" }}\n                </td>\n            </tr>\n        </table>\n        <table class=\"row\">\n            <tr>\n                <td class=\"full wrapper last\">\n                    <table class=\"columns\">\n                        <tr>\n                            <td align=\"center\">\n                                <center>\n                                    <p><a href=\"#\">Terms</a> | <a href=\"#\">Privacy</a> | <a href=\"#\">Unsubscribe</a></p>\n                                </center>\n                            </td>\n                            <td class=\"expander\"></td>\n                        </tr>\n                    </table>\n                </td>\n            </tr>\n        </table>\n    </td>\n</tr>\n</table>\n\n{{template config_path=\"design/email/footer\"}}', null, null, '2', 'Example Subject', 'Owner', 'owner@example.com', '1', '2015-08-06 05:57:14', '2015-08-06 05:57:14');

-- ----------------------------
-- Table structure for oauth_consumer
-- ----------------------------
DROP TABLE IF EXISTS `oauth_consumer`;
CREATE TABLE `oauth_consumer` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `name` varchar(255) NOT NULL COMMENT 'Name of consumer',
  `key` varchar(32) NOT NULL COMMENT 'Key code',
  `secret` varchar(32) NOT NULL COMMENT 'Secret code',
  `callback_url` varchar(255) DEFAULT NULL COMMENT 'Callback URL',
  `rejected_callback_url` varchar(255) NOT NULL COMMENT 'Rejected callback URL',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_OAUTH_CONSUMER_KEY` (`key`),
  UNIQUE KEY `UNQ_OAUTH_CONSUMER_SECRET` (`secret`),
  KEY `IDX_OAUTH_CONSUMER_CREATED_AT` (`created_at`),
  KEY `IDX_OAUTH_CONSUMER_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Consumers';

-- ----------------------------
-- Records of oauth_consumer
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_nonce
-- ----------------------------
DROP TABLE IF EXISTS `oauth_nonce`;
CREATE TABLE `oauth_nonce` (
  `nonce` varchar(32) NOT NULL COMMENT 'Nonce String',
  `timestamp` int(10) unsigned NOT NULL COMMENT 'Nonce Timestamp',
  UNIQUE KEY `UNQ_OAUTH_NONCE_NONCE` (`nonce`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='oauth_nonce';

-- ----------------------------
-- Records of oauth_nonce
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_token
-- ----------------------------
DROP TABLE IF EXISTS `oauth_token`;
CREATE TABLE `oauth_token` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `consumer_id` int(10) unsigned NOT NULL COMMENT 'Consumer ID',
  `admin_id` int(10) unsigned DEFAULT NULL COMMENT 'Admin user ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer user ID',
  `type` varchar(16) NOT NULL COMMENT 'Token Type',
  `token` varchar(32) NOT NULL COMMENT 'Token',
  `secret` varchar(32) NOT NULL COMMENT 'Token Secret',
  `verifier` varchar(32) DEFAULT NULL COMMENT 'Token Verifier',
  `callback_url` varchar(255) NOT NULL COMMENT 'Token Callback URL',
  `revoked` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token revoked',
  `authorized` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token authorized',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Token creation timestamp',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_OAUTH_TOKEN_TOKEN` (`token`),
  KEY `IDX_OAUTH_TOKEN_CONSUMER_ID` (`consumer_id`),
  KEY `FK_OAUTH_TOKEN_ADMIN_ID_ADMIN_USER_USER_ID` (`admin_id`),
  KEY `FK_OAUTH_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` (`customer_id`),
  CONSTRAINT `FK_OAUTH_TOKEN_ADMIN_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_OAUTH_TOKEN_CONSUMER_ID_OAUTH_CONSUMER_ENTITY_ID` FOREIGN KEY (`consumer_id`) REFERENCES `oauth_consumer` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_OAUTH_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Tokens';

-- ----------------------------
-- Records of oauth_token
-- ----------------------------

-- ----------------------------
-- Table structure for paypal_cert
-- ----------------------------
DROP TABLE IF EXISTS `paypal_cert`;
CREATE TABLE `paypal_cert` (
  `cert_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Cert Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `content` text COMMENT 'Content',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`cert_id`),
  KEY `IDX_PAYPAL_CERT_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_PAYPAL_CERT_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Certificate Table';

-- ----------------------------
-- Records of paypal_cert
-- ----------------------------

-- ----------------------------
-- Table structure for paypal_payment_transaction
-- ----------------------------
DROP TABLE IF EXISTS `paypal_payment_transaction`;
CREATE TABLE `paypal_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `UNQ_PAYPAL_PAYMENT_TRANSACTION_TXN_ID` (`txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='PayPal Payflow Link Payment Transaction';

-- ----------------------------
-- Records of paypal_payment_transaction
-- ----------------------------

-- ----------------------------
-- Table structure for paypal_settlement_report
-- ----------------------------
DROP TABLE IF EXISTS `paypal_settlement_report`;
CREATE TABLE `paypal_settlement_report` (
  `report_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Report Id',
  `report_date` timestamp NULL DEFAULT NULL COMMENT 'Report Date',
  `account_id` varchar(64) DEFAULT NULL COMMENT 'Account Id',
  `filename` varchar(24) DEFAULT NULL COMMENT 'Filename',
  `last_modified` timestamp NULL DEFAULT NULL COMMENT 'Last Modified',
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `UNQ_PAYPAL_SETTLEMENT_REPORT_REPORT_DATE_ACCOUNT_ID` (`report_date`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Table';

-- ----------------------------
-- Records of paypal_settlement_report
-- ----------------------------

-- ----------------------------
-- Table structure for paypal_settlement_report_row
-- ----------------------------
DROP TABLE IF EXISTS `paypal_settlement_report_row`;
CREATE TABLE `paypal_settlement_report_row` (
  `row_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Row Id',
  `report_id` int(10) unsigned NOT NULL COMMENT 'Report Id',
  `transaction_id` varchar(19) DEFAULT NULL COMMENT 'Transaction Id',
  `invoice_id` varchar(127) DEFAULT NULL COMMENT 'Invoice Id',
  `paypal_reference_id` varchar(19) DEFAULT NULL COMMENT 'Paypal Reference Id',
  `paypal_reference_id_type` varchar(3) DEFAULT NULL COMMENT 'Paypal Reference Id Type',
  `transaction_event_code` varchar(5) DEFAULT NULL COMMENT 'Transaction Event Code',
  `transaction_initiation_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Initiation Date',
  `transaction_completion_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Completion Date',
  `transaction_debit_or_credit` varchar(2) NOT NULL DEFAULT 'CR' COMMENT 'Transaction Debit Or Credit',
  `gross_transaction_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Gross Transaction Amount',
  `gross_transaction_currency` varchar(3) DEFAULT '' COMMENT 'Gross Transaction Currency',
  `fee_debit_or_credit` varchar(2) DEFAULT NULL COMMENT 'Fee Debit Or Credit',
  `fee_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Fee Amount',
  `fee_currency` varchar(3) DEFAULT NULL COMMENT 'Fee Currency',
  `custom_field` varchar(255) DEFAULT NULL COMMENT 'Custom Field',
  `consumer_id` varchar(127) DEFAULT NULL COMMENT 'Consumer Id',
  `payment_tracking_id` varchar(255) DEFAULT NULL COMMENT 'Payment Tracking ID',
  `store_id` varchar(50) DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`row_id`),
  KEY `IDX_PAYPAL_SETTLEMENT_REPORT_ROW_REPORT_ID` (`report_id`),
  CONSTRAINT `FK_E183E488F593E0DE10C6EBFFEBAC9B55` FOREIGN KEY (`report_id`) REFERENCES `paypal_settlement_report` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Row Table';

-- ----------------------------
-- Records of paypal_settlement_report_row
-- ----------------------------

-- ----------------------------
-- Table structure for persistent_session
-- ----------------------------
DROP TABLE IF EXISTS `persistent_session`;
CREATE TABLE `persistent_session` (
  `persistent_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Session id',
  `key` varchar(50) NOT NULL COMMENT 'Unique cookie key',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `info` text COMMENT 'Session Data',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`persistent_id`),
  UNIQUE KEY `IDX_PERSISTENT_SESSION_KEY` (`key`),
  UNIQUE KEY `IDX_PERSISTENT_SESSION_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_PERSISTENT_SESSION_UPDATED_AT` (`updated_at`),
  KEY `FK_PERSISTENT_SESSION_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_PERSISTENT_SESSION_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_PERSISTENT_SESSION_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Persistent Session';

-- ----------------------------
-- Records of persistent_session
-- ----------------------------

-- ----------------------------
-- Table structure for poll
-- ----------------------------
DROP TABLE IF EXISTS `poll`;
CREATE TABLE `poll` (
  `poll_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Poll Id',
  `poll_title` varchar(255) DEFAULT NULL COMMENT 'Poll title',
  `votes_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Votes Count',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  `date_posted` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date posted',
  `date_closed` timestamp NULL DEFAULT NULL COMMENT 'Date closed',
  `active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is active',
  `closed` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is closed',
  `answers_display` smallint(6) DEFAULT NULL COMMENT 'Answers display',
  PRIMARY KEY (`poll_id`),
  KEY `IDX_POLL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_POLL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Poll';

-- ----------------------------
-- Records of poll
-- ----------------------------
INSERT INTO `poll` VALUES ('1', 'What is your favorite color', '7', '0', '2015-08-06 05:57:09', null, '1', '0', null);

-- ----------------------------
-- Table structure for poll_answer
-- ----------------------------
DROP TABLE IF EXISTS `poll_answer`;
CREATE TABLE `poll_answer` (
  `answer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Answer Id',
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `answer_title` varchar(255) DEFAULT NULL COMMENT 'Answer title',
  `votes_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Votes Count',
  `answer_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Answers display',
  PRIMARY KEY (`answer_id`),
  KEY `IDX_POLL_ANSWER_POLL_ID` (`poll_id`),
  CONSTRAINT `FK_POLL_ANSWER_POLL_ID_POLL_POLL_ID` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`poll_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Poll Answers';

-- ----------------------------
-- Records of poll_answer
-- ----------------------------
INSERT INTO `poll_answer` VALUES ('1', '1', 'Green', '4', '0');
INSERT INTO `poll_answer` VALUES ('2', '1', 'Red', '1', '0');
INSERT INTO `poll_answer` VALUES ('3', '1', 'Black', '0', '0');
INSERT INTO `poll_answer` VALUES ('4', '1', 'Magenta', '2', '0');

-- ----------------------------
-- Table structure for poll_store
-- ----------------------------
DROP TABLE IF EXISTS `poll_store`;
CREATE TABLE `poll_store` (
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`poll_id`,`store_id`),
  KEY `IDX_POLL_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_POLL_STORE_POLL_ID_POLL_POLL_ID` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`poll_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_POLL_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll Store';

-- ----------------------------
-- Records of poll_store
-- ----------------------------
INSERT INTO `poll_store` VALUES ('1', '1');

-- ----------------------------
-- Table structure for poll_vote
-- ----------------------------
DROP TABLE IF EXISTS `poll_vote`;
CREATE TABLE `poll_vote` (
  `vote_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote Id',
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `poll_answer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll answer id',
  `ip_address` varbinary(16) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer id',
  `vote_time` timestamp NULL DEFAULT NULL COMMENT 'Date closed',
  PRIMARY KEY (`vote_id`),
  KEY `IDX_POLL_VOTE_POLL_ANSWER_ID` (`poll_answer_id`),
  CONSTRAINT `FK_POLL_VOTE_POLL_ANSWER_ID_POLL_ANSWER_ANSWER_ID` FOREIGN KEY (`poll_answer_id`) REFERENCES `poll_answer` (`answer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll Vote';

-- ----------------------------
-- Records of poll_vote
-- ----------------------------

-- ----------------------------
-- Table structure for product_alert_price
-- ----------------------------
DROP TABLE IF EXISTS `product_alert_price`;
CREATE TABLE `product_alert_price` (
  `alert_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert price id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price amount',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Product alert add date',
  `last_send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert last send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert send count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_price_id`),
  KEY `IDX_PRODUCT_ALERT_PRICE_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_PRODUCT_ALERT_PRICE_PRODUCT_ID` (`product_id`),
  KEY `IDX_PRODUCT_ALERT_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_PRD_ALERT_PRICE_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCT_ALERT_PRICE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCT_ALERT_PRICE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Price';

-- ----------------------------
-- Records of product_alert_price
-- ----------------------------

-- ----------------------------
-- Table structure for product_alert_stock
-- ----------------------------
DROP TABLE IF EXISTS `product_alert_stock`;
CREATE TABLE `product_alert_stock` (
  `alert_stock_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert stock id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Product alert add date',
  `send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Send Count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_stock_id`),
  KEY `IDX_PRODUCT_ALERT_STOCK_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_PRODUCT_ALERT_STOCK_PRODUCT_ID` (`product_id`),
  KEY `IDX_PRODUCT_ALERT_STOCK_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_PRD_ALERT_STOCK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCT_ALERT_STOCK_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCT_ALERT_STOCK_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Stock';

-- ----------------------------
-- Records of product_alert_stock
-- ----------------------------

-- ----------------------------
-- Table structure for rating
-- ----------------------------
DROP TABLE IF EXISTS `rating`;
CREATE TABLE `rating` (
  `rating_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Id',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `rating_code` varchar(64) NOT NULL COMMENT 'Rating Code',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Position On Frontend',
  PRIMARY KEY (`rating_id`),
  UNIQUE KEY `UNQ_RATING_RATING_CODE` (`rating_code`),
  KEY `IDX_RATING_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_RATING_ENTITY_ID_RATING_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `rating_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Ratings';

-- ----------------------------
-- Records of rating
-- ----------------------------
INSERT INTO `rating` VALUES ('1', '1', 'Quality', '0');
INSERT INTO `rating` VALUES ('2', '1', 'Value', '0');
INSERT INTO `rating` VALUES ('3', '1', 'Price', '0');

-- ----------------------------
-- Table structure for rating_entity
-- ----------------------------
DROP TABLE IF EXISTS `rating_entity`;
CREATE TABLE `rating_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_code` varchar(64) NOT NULL COMMENT 'Entity Code',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_RATING_ENTITY_ENTITY_CODE` (`entity_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Rating entities';

-- ----------------------------
-- Records of rating_entity
-- ----------------------------
INSERT INTO `rating_entity` VALUES ('1', 'product');
INSERT INTO `rating_entity` VALUES ('2', 'product_review');
INSERT INTO `rating_entity` VALUES ('3', 'review');

-- ----------------------------
-- Table structure for rating_option
-- ----------------------------
DROP TABLE IF EXISTS `rating_option`;
CREATE TABLE `rating_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Option Id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `code` varchar(32) NOT NULL COMMENT 'Rating Option Code',
  `value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Option Value',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Ration option position on frontend',
  PRIMARY KEY (`option_id`),
  KEY `IDX_RATING_OPTION_RATING_ID` (`rating_id`),
  CONSTRAINT `FK_RATING_OPTION_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='Rating options';

-- ----------------------------
-- Records of rating_option
-- ----------------------------
INSERT INTO `rating_option` VALUES ('1', '1', '1', '1', '1');
INSERT INTO `rating_option` VALUES ('2', '1', '2', '2', '2');
INSERT INTO `rating_option` VALUES ('3', '1', '3', '3', '3');
INSERT INTO `rating_option` VALUES ('4', '1', '4', '4', '4');
INSERT INTO `rating_option` VALUES ('5', '1', '5', '5', '5');
INSERT INTO `rating_option` VALUES ('6', '2', '1', '1', '1');
INSERT INTO `rating_option` VALUES ('7', '2', '2', '2', '2');
INSERT INTO `rating_option` VALUES ('8', '2', '3', '3', '3');
INSERT INTO `rating_option` VALUES ('9', '2', '4', '4', '4');
INSERT INTO `rating_option` VALUES ('10', '2', '5', '5', '5');
INSERT INTO `rating_option` VALUES ('11', '3', '1', '1', '1');
INSERT INTO `rating_option` VALUES ('12', '3', '2', '2', '2');
INSERT INTO `rating_option` VALUES ('13', '3', '3', '3', '3');
INSERT INTO `rating_option` VALUES ('14', '3', '4', '4', '4');
INSERT INTO `rating_option` VALUES ('15', '3', '5', '5', '5');

-- ----------------------------
-- Table structure for rating_option_vote
-- ----------------------------
DROP TABLE IF EXISTS `rating_option_vote`;
CREATE TABLE `rating_option_vote` (
  `vote_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote option id',
  `remote_ip` varchar(50) DEFAULT NULL,
  `remote_ip_long` varbinary(16) DEFAULT NULL,
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `review_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Review id',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Percent amount',
  `value` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote option value',
  PRIMARY KEY (`vote_id`),
  KEY `IDX_RATING_OPTION_VOTE_OPTION_ID` (`option_id`),
  KEY `FK_RATING_OPTION_VOTE_REVIEW_ID_REVIEW_REVIEW_ID` (`review_id`),
  CONSTRAINT `FK_RATING_OPTION_VOTE_OPTION_ID_RATING_OPTION_OPTION_ID` FOREIGN KEY (`option_id`) REFERENCES `rating_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RATING_OPTION_VOTE_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating option values';

-- ----------------------------
-- Records of rating_option_vote
-- ----------------------------

-- ----------------------------
-- Table structure for rating_option_vote_aggregated
-- ----------------------------
DROP TABLE IF EXISTS `rating_option_vote_aggregated`;
CREATE TABLE `rating_option_vote_aggregated` (
  `primary_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Vote aggregation id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `vote_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote dty',
  `vote_value_sum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'General vote sum',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote percent',
  `percent_approved` smallint(6) DEFAULT '0' COMMENT 'Vote percent approved by admin',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`primary_id`),
  KEY `IDX_RATING_OPTION_VOTE_AGGREGATED_RATING_ID` (`rating_id`),
  KEY `IDX_RATING_OPTION_VOTE_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_RATING_OPTION_VOTE_AGGREGATED_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RATING_OPTION_VOTE_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating vote aggregated';

-- ----------------------------
-- Records of rating_option_vote_aggregated
-- ----------------------------

-- ----------------------------
-- Table structure for rating_store
-- ----------------------------
DROP TABLE IF EXISTS `rating_store`;
CREATE TABLE `rating_store` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `IDX_RATING_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_RATING_STORE_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_RATING_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Store';

-- ----------------------------
-- Records of rating_store
-- ----------------------------

-- ----------------------------
-- Table structure for rating_title
-- ----------------------------
DROP TABLE IF EXISTS `rating_title`;
CREATE TABLE `rating_title` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Rating Label',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `IDX_RATING_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_RATING_TITLE_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RATING_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Title';

-- ----------------------------
-- Records of rating_title
-- ----------------------------

-- ----------------------------
-- Table structure for report_compared_product_index
-- ----------------------------
DROP TABLE IF EXISTS `report_compared_product_index`;
CREATE TABLE `report_compared_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `UNQ_REPORT_COMPARED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `UNQ_REPORT_COMPARED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_REPORT_COMPARED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_COMPARED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `IDX_REPORT_COMPARED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_CMPD_PRD_IDX_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_CMPD_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_COMPARED_PRODUCT_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Compared Product Index Table';

-- ----------------------------
-- Records of report_compared_product_index
-- ----------------------------

-- ----------------------------
-- Table structure for report_event
-- ----------------------------
DROP TABLE IF EXISTS `report_event`;
CREATE TABLE `report_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `logged_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Logged At',
  `event_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Type Id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Object Id',
  `subject_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subject Id',
  `subtype` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Subtype',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`event_id`),
  KEY `IDX_REPORT_EVENT_EVENT_TYPE_ID` (`event_type_id`),
  KEY `IDX_REPORT_EVENT_SUBJECT_ID` (`subject_id`),
  KEY `IDX_REPORT_EVENT_OBJECT_ID` (`object_id`),
  KEY `IDX_REPORT_EVENT_SUBTYPE` (`subtype`),
  KEY `IDX_REPORT_EVENT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_REPORT_EVENT_EVENT_TYPE_ID_REPORT_EVENT_TYPES_EVENT_TYPE_ID` FOREIGN KEY (`event_type_id`) REFERENCES `report_event_types` (`event_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_EVENT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Event Table';

-- ----------------------------
-- Records of report_event
-- ----------------------------

-- ----------------------------
-- Table structure for report_event_types
-- ----------------------------
DROP TABLE IF EXISTS `report_event_types`;
CREATE TABLE `report_event_types` (
  `event_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Type Id',
  `event_name` varchar(64) NOT NULL COMMENT 'Event Name',
  `customer_login` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Login',
  PRIMARY KEY (`event_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Reports Event Type Table';

-- ----------------------------
-- Records of report_event_types
-- ----------------------------
INSERT INTO `report_event_types` VALUES ('1', 'catalog_product_view', '0');
INSERT INTO `report_event_types` VALUES ('2', 'sendfriend_product', '0');
INSERT INTO `report_event_types` VALUES ('3', 'catalog_product_compare_add_product', '0');
INSERT INTO `report_event_types` VALUES ('4', 'checkout_cart_add_product', '0');
INSERT INTO `report_event_types` VALUES ('5', 'wishlist_add_product', '0');
INSERT INTO `report_event_types` VALUES ('6', 'wishlist_share', '0');

-- ----------------------------
-- Table structure for report_viewed_product_aggregated_daily
-- ----------------------------
DROP TABLE IF EXISTS `report_viewed_product_aggregated_daily`;
CREATE TABLE `report_viewed_product_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRD_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_DAILY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_DAILY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Daily';

-- ----------------------------
-- Records of report_viewed_product_aggregated_daily
-- ----------------------------

-- ----------------------------
-- Table structure for report_viewed_product_aggregated_monthly
-- ----------------------------
DROP TABLE IF EXISTS `report_viewed_product_aggregated_monthly`;
CREATE TABLE `report_viewed_product_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRD_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_MONTHLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_MONTHLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Monthly';

-- ----------------------------
-- Records of report_viewed_product_aggregated_monthly
-- ----------------------------

-- ----------------------------
-- Table structure for report_viewed_product_aggregated_yearly
-- ----------------------------
DROP TABLE IF EXISTS `report_viewed_product_aggregated_yearly`;
CREATE TABLE `report_viewed_product_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRD_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_YEARLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_YEARLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Yearly';

-- ----------------------------
-- Records of report_viewed_product_aggregated_yearly
-- ----------------------------

-- ----------------------------
-- Table structure for report_viewed_product_index
-- ----------------------------
DROP TABLE IF EXISTS `report_viewed_product_index`;
CREATE TABLE `report_viewed_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_VIEWED_PRD_IDX_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRODUCT_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Viewed Product Index Table';

-- ----------------------------
-- Records of report_viewed_product_index
-- ----------------------------

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
  `review_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Review create date',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity id',
  `entity_pk_value` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `status_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status code',
  PRIMARY KEY (`review_id`),
  KEY `IDX_REVIEW_ENTITY_ID` (`entity_id`),
  KEY `IDX_REVIEW_STATUS_ID` (`status_id`),
  KEY `IDX_REVIEW_ENTITY_PK_VALUE` (`entity_pk_value`),
  CONSTRAINT `FK_REVIEW_ENTITY_ID_REVIEW_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `review_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REVIEW_STATUS_ID_REVIEW_STATUS_STATUS_ID` FOREIGN KEY (`status_id`) REFERENCES `review_status` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review base information';

-- ----------------------------
-- Records of review
-- ----------------------------

-- ----------------------------
-- Table structure for review_detail
-- ----------------------------
DROP TABLE IF EXISTS `review_detail`;
CREATE TABLE `review_detail` (
  `detail_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review detail id',
  `review_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Review id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store id',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `detail` text NOT NULL COMMENT 'Detail description',
  `nickname` varchar(128) NOT NULL COMMENT 'User nickname',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  PRIMARY KEY (`detail_id`),
  KEY `IDX_REVIEW_DETAIL_REVIEW_ID` (`review_id`),
  KEY `IDX_REVIEW_DETAIL_STORE_ID` (`store_id`),
  KEY `IDX_REVIEW_DETAIL_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_REVIEW_DETAIL_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_REVIEW_DETAIL_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REVIEW_DETAIL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review detail information';

-- ----------------------------
-- Records of review_detail
-- ----------------------------

-- ----------------------------
-- Table structure for review_entity
-- ----------------------------
DROP TABLE IF EXISTS `review_entity`;
CREATE TABLE `review_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review entity id',
  `entity_code` varchar(32) NOT NULL COMMENT 'Review entity code',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Review entities';

-- ----------------------------
-- Records of review_entity
-- ----------------------------
INSERT INTO `review_entity` VALUES ('1', 'product');
INSERT INTO `review_entity` VALUES ('2', 'customer');
INSERT INTO `review_entity` VALUES ('3', 'category');

-- ----------------------------
-- Table structure for review_entity_summary
-- ----------------------------
DROP TABLE IF EXISTS `review_entity_summary`;
CREATE TABLE `review_entity_summary` (
  `primary_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Summary review entity id',
  `entity_pk_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Product id',
  `entity_type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Entity type id',
  `reviews_count` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Qty of reviews',
  `rating_summary` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Summarized rating',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`primary_id`),
  KEY `IDX_REVIEW_ENTITY_SUMMARY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_REVIEW_ENTITY_SUMMARY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review aggregates';

-- ----------------------------
-- Records of review_entity_summary
-- ----------------------------

-- ----------------------------
-- Table structure for review_status
-- ----------------------------
DROP TABLE IF EXISTS `review_status`;
CREATE TABLE `review_status` (
  `status_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Status id',
  `status_code` varchar(32) NOT NULL COMMENT 'Status code',
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Review statuses';

-- ----------------------------
-- Records of review_status
-- ----------------------------
INSERT INTO `review_status` VALUES ('1', 'Approved');
INSERT INTO `review_status` VALUES ('2', 'Pending');
INSERT INTO `review_status` VALUES ('3', 'Not Approved');

-- ----------------------------
-- Table structure for review_store
-- ----------------------------
DROP TABLE IF EXISTS `review_store`;
CREATE TABLE `review_store` (
  `review_id` bigint(20) unsigned NOT NULL COMMENT 'Review Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`review_id`,`store_id`),
  KEY `IDX_REVIEW_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_REVIEW_STORE_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REVIEW_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review Store';

-- ----------------------------
-- Records of review_store
-- ----------------------------

-- ----------------------------
-- Table structure for salesrule
-- ----------------------------
DROP TABLE IF EXISTS `salesrule`;
CREATE TABLE `salesrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `uses_per_customer` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Customer',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `is_advanced` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Advanced',
  `product_ids` text COMMENT 'Product Ids',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `discount_qty` decimal(12,4) DEFAULT NULL COMMENT 'Discount Qty',
  `discount_step` int(10) unsigned NOT NULL COMMENT 'Discount Step',
  `simple_free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Simple Free Shipping',
  `apply_to_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Apply To Shipping',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `is_rss` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Rss',
  `coupon_type` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Coupon Type',
  `use_auto_generation` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Use Auto Generation',
  `uses_per_coupon` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Coupon',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_SALESRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule';

-- ----------------------------
-- Records of salesrule
-- ----------------------------

-- ----------------------------
-- Table structure for salesrule_coupon
-- ----------------------------
DROP TABLE IF EXISTS `salesrule_coupon`;
CREATE TABLE `salesrule_coupon` (
  `coupon_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Coupon Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `usage_limit` int(10) unsigned DEFAULT NULL COMMENT 'Usage Limit',
  `usage_per_customer` int(10) unsigned DEFAULT NULL COMMENT 'Usage Per Customer',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `expiration_date` timestamp NULL DEFAULT NULL COMMENT 'Expiration Date',
  `is_primary` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Primary',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Coupon Code Creation Date',
  `type` smallint(6) DEFAULT '0' COMMENT 'Coupon Code Type',
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `UNQ_SALESRULE_COUPON_CODE` (`code`),
  UNIQUE KEY `UNQ_SALESRULE_COUPON_RULE_ID_IS_PRIMARY` (`rule_id`,`is_primary`),
  KEY `IDX_SALESRULE_COUPON_RULE_ID` (`rule_id`),
  CONSTRAINT `FK_SALESRULE_COUPON_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon';

-- ----------------------------
-- Records of salesrule_coupon
-- ----------------------------

-- ----------------------------
-- Table structure for salesrule_coupon_usage
-- ----------------------------
DROP TABLE IF EXISTS `salesrule_coupon_usage`;
CREATE TABLE `salesrule_coupon_usage` (
  `coupon_id` int(10) unsigned NOT NULL COMMENT 'Coupon Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`coupon_id`,`customer_id`),
  KEY `IDX_SALESRULE_COUPON_USAGE_COUPON_ID` (`coupon_id`),
  KEY `IDX_SALESRULE_COUPON_USAGE_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_SALESRULE_COUPON_USAGE_COUPON_ID_SALESRULE_COUPON_COUPON_ID` FOREIGN KEY (`coupon_id`) REFERENCES `salesrule_coupon` (`coupon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_COUPON_USAGE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon Usage';

-- ----------------------------
-- Records of salesrule_coupon_usage
-- ----------------------------

-- ----------------------------
-- Table structure for salesrule_customer
-- ----------------------------
DROP TABLE IF EXISTS `salesrule_customer`;
CREATE TABLE `salesrule_customer` (
  `rule_customer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Customer Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `times_used` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`rule_customer_id`),
  KEY `IDX_SALESRULE_CUSTOMER_RULE_ID_CUSTOMER_ID` (`rule_id`,`customer_id`),
  KEY `IDX_SALESRULE_CUSTOMER_CUSTOMER_ID_RULE_ID` (`customer_id`,`rule_id`),
  CONSTRAINT `FK_SALESRULE_CUSTOMER_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_CUSTOMER_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Customer';

-- ----------------------------
-- Records of salesrule_customer
-- ----------------------------

-- ----------------------------
-- Table structure for salesrule_customer_group
-- ----------------------------
DROP TABLE IF EXISTS `salesrule_customer_group`;
CREATE TABLE `salesrule_customer_group` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`),
  KEY `IDX_SALESRULE_CUSTOMER_GROUP_RULE_ID` (`rule_id`),
  KEY `IDX_SALESRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_SALESRULE_CSTR_GROUP_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_CUSTOMER_GROUP_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Customer Groups Relations';

-- ----------------------------
-- Records of salesrule_customer_group
-- ----------------------------

-- ----------------------------
-- Table structure for salesrule_label
-- ----------------------------
DROP TABLE IF EXISTS `salesrule_label`;
CREATE TABLE `salesrule_label` (
  `label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Label Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  PRIMARY KEY (`label_id`),
  UNIQUE KEY `UNQ_SALESRULE_LABEL_RULE_ID_STORE_ID` (`rule_id`,`store_id`),
  KEY `IDX_SALESRULE_LABEL_STORE_ID` (`store_id`),
  KEY `IDX_SALESRULE_LABEL_RULE_ID` (`rule_id`),
  CONSTRAINT `FK_SALESRULE_LABEL_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Label';

-- ----------------------------
-- Records of salesrule_label
-- ----------------------------

-- ----------------------------
-- Table structure for salesrule_product_attribute
-- ----------------------------
DROP TABLE IF EXISTS `salesrule_product_attribute`;
CREATE TABLE `salesrule_product_attribute` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`rule_id`,`website_id`,`customer_group_id`,`attribute_id`),
  KEY `IDX_SALESRULE_PRODUCT_ATTRIBUTE_WEBSITE_ID` (`website_id`),
  KEY `IDX_SALESRULE_PRODUCT_ATTRIBUTE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_SALESRULE_PRODUCT_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_SALESRULE_PRD_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_SALESRULE_PRD_ATTR_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_SALESRULE_PRD_ATTR_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_SALESRULE_PRODUCT_ATTRIBUTE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Product Attribute';

-- ----------------------------
-- Records of salesrule_product_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for salesrule_website
-- ----------------------------
DROP TABLE IF EXISTS `salesrule_website`;
CREATE TABLE `salesrule_website` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `IDX_SALESRULE_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_SALESRULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_SALESRULE_WEBSITE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Websites Relations';

-- ----------------------------
-- Records of salesrule_website
-- ----------------------------

-- ----------------------------
-- Table structure for sales_bestsellers_aggregated_daily
-- ----------------------------
DROP TABLE IF EXISTS `sales_bestsellers_aggregated_daily`;
CREATE TABLE `sales_bestsellers_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_BESTSELLERS_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_DAILY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_DAILY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Daily';

-- ----------------------------
-- Records of sales_bestsellers_aggregated_daily
-- ----------------------------

-- ----------------------------
-- Table structure for sales_bestsellers_aggregated_monthly
-- ----------------------------
DROP TABLE IF EXISTS `sales_bestsellers_aggregated_monthly`;
CREATE TABLE `sales_bestsellers_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_BESTSELLERS_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_MONTHLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_MONTHLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Monthly';

-- ----------------------------
-- Records of sales_bestsellers_aggregated_monthly
-- ----------------------------

-- ----------------------------
-- Table structure for sales_bestsellers_aggregated_yearly
-- ----------------------------
DROP TABLE IF EXISTS `sales_bestsellers_aggregated_yearly`;
CREATE TABLE `sales_bestsellers_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_BESTSELLERS_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_YEARLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_YEARLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Yearly';

-- ----------------------------
-- Records of sales_bestsellers_aggregated_yearly
-- ----------------------------

-- ----------------------------
-- Table structure for sales_billing_agreement
-- ----------------------------
DROP TABLE IF EXISTS `sales_billing_agreement`;
CREATE TABLE `sales_billing_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `reference_id` varchar(32) NOT NULL COMMENT 'Reference Id',
  `status` varchar(20) NOT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `agreement_label` varchar(255) DEFAULT NULL COMMENT 'Agreement Label',
  PRIMARY KEY (`agreement_id`),
  KEY `IDX_SALES_BILLING_AGREEMENT_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_BILLING_AGREEMENT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_BILLING_AGREEMENT_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BILLING_AGREEMENT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement';

-- ----------------------------
-- Records of sales_billing_agreement
-- ----------------------------

-- ----------------------------
-- Table structure for sales_billing_agreement_order
-- ----------------------------
DROP TABLE IF EXISTS `sales_billing_agreement_order`;
CREATE TABLE `sales_billing_agreement_order` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  PRIMARY KEY (`agreement_id`,`order_id`),
  KEY `IDX_SALES_BILLING_AGREEMENT_ORDER_ORDER_ID` (`order_id`),
  CONSTRAINT `FK_SALES_BILLING_AGRT_ORDER_AGRT_ID_SALES_BILLING_AGRT_AGRT_ID` FOREIGN KEY (`agreement_id`) REFERENCES `sales_billing_agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BILLING_AGRT_ORDER_ORDER_ID_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement Order';

-- ----------------------------
-- Records of sales_billing_agreement_order
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_creditmemo
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_creditmemo`;
CREATE TABLE `sales_flat_creditmemo` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_CREDITMEMO_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_STATE` (`state`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_SALES_FLAT_CREDITMEMO_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_CREDITMEMO_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo';

-- ----------------------------
-- Records of sales_flat_creditmemo
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_creditmemo_comment
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_creditmemo_comment`;
CREATE TABLE `sales_flat_creditmemo_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_B0FCB0B5467075BE63D474F2CD5F7804` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Comment';

-- ----------------------------
-- Records of sales_flat_creditmemo_comment
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_creditmemo_grid
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_creditmemo_grid`;
CREATE TABLE `sales_flat_creditmemo_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_CREDITMEMO_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_STATE` (`state`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_BILLING_NAME` (`billing_name`),
  CONSTRAINT `FK_78C711B225167A11CC077B03D1C8E1CC` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_CREDITMEMO_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Grid';

-- ----------------------------
-- Records of sales_flat_creditmemo_grid
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_creditmemo_item
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_creditmemo_item`;
CREATE TABLE `sales_flat_creditmemo_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_306DAC836C699F0B5E13BE486557AC8A` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Item';

-- ----------------------------
-- Records of sales_flat_creditmemo_item
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_invoice
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_invoice`;
CREATE TABLE `sales_flat_invoice` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `is_used_for_refund` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Used For Refund',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `can_void_flag` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Void Flag',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_INVOICE_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_INVOICE_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_INVOICE_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_INVOICE_STATE` (`state`),
  KEY `IDX_SALES_FLAT_INVOICE_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_SALES_FLAT_INVOICE_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_INVOICE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice';

-- ----------------------------
-- Records of sales_flat_invoice
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_invoice_comment
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_invoice_comment`;
CREATE TABLE `sales_flat_invoice_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_INVOICE_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_INVOICE_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_5C4B36BBE5231A76AB8018B281ED50BC` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Comment';

-- ----------------------------
-- Records of sales_flat_invoice_comment
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_invoice_grid
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_invoice_grid`;
CREATE TABLE `sales_flat_invoice_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_INVOICE_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_STATE` (`state`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_BILLING_NAME` (`billing_name`),
  CONSTRAINT `FK_SALES_FLAT_INVOICE_GRID_ENTT_ID_SALES_FLAT_INVOICE_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_INVOICE_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Grid';

-- ----------------------------
-- Records of sales_flat_invoice_grid
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_invoice_item
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_invoice_item`;
CREATE TABLE `sales_flat_invoice_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_INVOICE_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_SALES_FLAT_INVOICE_ITEM_PARENT_ID_SALES_FLAT_INVOICE_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Item';

-- ----------------------------
-- Records of sales_flat_invoice_item
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_order
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_order`;
CREATE TABLE `sales_flat_order` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `state` varchar(32) DEFAULT NULL COMMENT 'State',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `protect_code` varchar(255) DEFAULT NULL COMMENT 'Protect Code',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Canceled',
  `base_discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Invoiced',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `base_shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Canceled',
  `base_shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Invoiced',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Refunded',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `base_subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Canceled',
  `base_subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Invoiced',
  `base_subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Refunded',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Canceled',
  `base_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Invoiced',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `base_total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Canceled',
  `base_total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced',
  `base_total_invoiced_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced Cost',
  `base_total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Offline Refunded',
  `base_total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Online Refunded',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `base_total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Qty Ordered',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Discount Canceled',
  `discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Discount Invoiced',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Canceled',
  `shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Invoiced',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Refunded',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Canceled',
  `subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Invoiced',
  `subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Refunded',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Tax Invoiced',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Total Canceled',
  `total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Total Invoiced',
  `total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Offline Refunded',
  `total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Online Refunded',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty Ordered',
  `total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Refunded',
  `can_ship_partially` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially',
  `can_ship_partially_item` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially Item',
  `customer_is_guest` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Is Guest',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `edit_increment` int(11) DEFAULT NULL COMMENT 'Edit Increment',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `forced_shipment_with_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Forced Do Shipment With Invoice',
  `payment_auth_expiration` int(11) DEFAULT NULL COMMENT 'Payment Authorization Expiration',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `quote_id` int(11) DEFAULT NULL COMMENT 'Quote Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `base_total_due` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Due',
  `payment_authorization_amount` decimal(12,4) DEFAULT NULL COMMENT 'Payment Authorization Amount',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `total_due` decimal(12,4) DEFAULT NULL COMMENT 'Total Due',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_middlename` varchar(255) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_prefix` varchar(255) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_suffix` varchar(255) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `ext_customer_id` varchar(255) DEFAULT NULL COMMENT 'Ext Customer Id',
  `ext_order_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Id',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `hold_before_state` varchar(255) DEFAULT NULL COMMENT 'Hold Before State',
  `hold_before_status` varchar(255) DEFAULT NULL COMMENT 'Hold Before Status',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `original_increment_id` varchar(50) DEFAULT NULL COMMENT 'Original Increment Id',
  `relation_child_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Id',
  `relation_child_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Real Id',
  `relation_parent_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Id',
  `relation_parent_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Real Id',
  `remote_ip` varchar(255) DEFAULT NULL COMMENT 'Remote Ip',
  `shipping_method` varchar(255) DEFAULT NULL COMMENT 'Shipping Method',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `x_forwarded_for` varchar(255) DEFAULT NULL COMMENT 'X Forwarded For',
  `customer_note` text COMMENT 'Customer Note',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `total_item_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Total Item Count',
  `customer_gender` int(11) DEFAULT NULL COMMENT 'Customer Gender',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Invoiced',
  `base_hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Invoiced',
  `hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Refunded',
  `base_hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Refunded',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `coupon_rule_name` varchar(255) DEFAULT NULL COMMENT 'Coupon Sales Rule Name',
  `paypal_ipn_customer_notified` int(11) DEFAULT '0' COMMENT 'Paypal Ipn Customer Notified',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_ORDER_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_ORDER_STATUS` (`status`),
  KEY `IDX_SALES_FLAT_ORDER_STATE` (`state`),
  KEY `IDX_SALES_FLAT_ORDER_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_ORDER_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_ORDER_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_FLAT_ORDER_EXT_ORDER_ID` (`ext_order_id`),
  KEY `IDX_SALES_FLAT_ORDER_QUOTE_ID` (`quote_id`),
  KEY `IDX_SALES_FLAT_ORDER_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order';

-- ----------------------------
-- Records of sales_flat_order
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_order_address
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_order_address`;
CREATE TABLE `sales_flat_order_address` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `customer_address_id` int(11) DEFAULT NULL COMMENT 'Customer Address Id',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `region_id` int(11) DEFAULT NULL COMMENT 'Region Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Telephone',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `prefix` varchar(255) DEFAULT NULL COMMENT 'Prefix',
  `middlename` varchar(255) DEFAULT NULL COMMENT 'Middlename',
  `suffix` varchar(255) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_ORDER_ADDRESS_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_ADDRESS_PARENT_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Address';

-- ----------------------------
-- Records of sales_flat_order_address
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_order_grid
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_order_grid`;
CREATE TABLE `sales_flat_order_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_ORDER_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_STATUS` (`status`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_BASE_TOTAL_PAID` (`base_total_paid`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_TOTAL_PAID` (`total_paid`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_SHIPPING_NAME` (`shipping_name`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_BILLING_NAME` (`billing_name`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_GRID_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_ORDER_GRID_ENTITY_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_ORDER_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Grid';

-- ----------------------------
-- Records of sales_flat_order_grid
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_order_item
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_order_item`;
CREATE TABLE `sales_flat_order_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Quote Item Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `product_options` text COMMENT 'Product Options',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'No Discount',
  `qty_backordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Backordered',
  `qty_canceled` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Canceled',
  `qty_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Invoiced',
  `qty_ordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `qty_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Refunded',
  `qty_shipped` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Shipped',
  `base_cost` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Cost',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `original_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `base_original_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Original Price',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Invoiced',
  `base_tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Invoiced',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Invoiced',
  `base_discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Invoiced',
  `amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Amount Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Amount Refunded',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Invoiced',
  `base_row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Invoiced',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `ext_order_item_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Item Id',
  `locked_do_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Invoice',
  `locked_do_ship` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Ship',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Invoiced',
  `base_hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Invoiced',
  `hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Refunded',
  `base_hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Refunded',
  `is_nominal` int(11) NOT NULL DEFAULT '0' COMMENT 'Is Nominal',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `hidden_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Canceled',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `gift_message_available` int(11) DEFAULT NULL COMMENT 'Gift Message Available',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`item_id`),
  KEY `IDX_SALES_FLAT_ORDER_ITEM_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_ORDER_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_ITEM_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_ORDER_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Item';

-- ----------------------------
-- Records of sales_flat_order_item
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_order_payment
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_order_payment`;
CREATE TABLE `sales_flat_order_payment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Captured',
  `shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Captured',
  `amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Amount Refunded',
  `base_amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid',
  `amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Amount Canceled',
  `base_amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Authorized',
  `base_amount_paid_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid Online',
  `base_amount_refunded_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded Online',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Amount Paid',
  `amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Amount Authorized',
  `base_amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Ordered',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded',
  `amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Amount Ordered',
  `base_amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Canceled',
  `quote_payment_id` int(11) DEFAULT NULL COMMENT 'Quote Payment Id',
  `additional_data` text COMMENT 'Additional Data',
  `cc_exp_month` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Month',
  `cc_ss_start_year` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Start Year',
  `echeck_bank_name` varchar(255) DEFAULT NULL COMMENT 'Echeck Bank Name',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_debug_request_body` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Request Body',
  `cc_secure_verify` varchar(255) DEFAULT NULL COMMENT 'Cc Secure Verify',
  `protection_eligibility` varchar(255) DEFAULT NULL COMMENT 'Protection Eligibility',
  `cc_approval` varchar(255) DEFAULT NULL COMMENT 'Cc Approval',
  `cc_last4` varchar(255) DEFAULT NULL COMMENT 'Cc Last4',
  `cc_status_description` varchar(255) DEFAULT NULL COMMENT 'Cc Status Description',
  `echeck_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Type',
  `cc_debug_response_serialized` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Response Serialized',
  `cc_ss_start_month` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Start Month',
  `echeck_account_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Type',
  `last_trans_id` varchar(255) DEFAULT NULL COMMENT 'Last Trans Id',
  `cc_cid_status` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Status',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `cc_exp_year` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Year',
  `cc_status` varchar(255) DEFAULT NULL COMMENT 'Cc Status',
  `echeck_routing_number` varchar(255) DEFAULT NULL COMMENT 'Echeck Routing Number',
  `account_status` varchar(255) DEFAULT NULL COMMENT 'Account Status',
  `anet_trans_method` varchar(255) DEFAULT NULL COMMENT 'Anet Trans Method',
  `cc_debug_response_body` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Response Body',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `echeck_account_name` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Name',
  `cc_avs_status` varchar(255) DEFAULT NULL COMMENT 'Cc Avs Status',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_trans_id` varchar(255) DEFAULT NULL COMMENT 'Cc Trans Id',
  `paybox_request_number` varchar(255) DEFAULT NULL COMMENT 'Paybox Request Number',
  `address_status` varchar(255) DEFAULT NULL COMMENT 'Address Status',
  `additional_information` text COMMENT 'Additional Information',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_ORDER_PAYMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_PAYMENT_PARENT_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Payment';

-- ----------------------------
-- Records of sales_flat_order_payment
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_order_status_history
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_order_status_history`;
CREATE TABLE `sales_flat_order_status_history` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `entity_name` varchar(32) DEFAULT NULL COMMENT 'Shows what entity history is bind to.',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_ORDER_STATUS_HISTORY_PARENT_ID` (`parent_id`),
  KEY `IDX_SALES_FLAT_ORDER_STATUS_HISTORY_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_CE7C71E74CB74DDACED337CEE6753D5E` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Status History';

-- ----------------------------
-- Records of sales_flat_order_status_history
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_quote
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_quote`;
CREATE TABLE `sales_flat_quote` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `converted_at` timestamp NULL DEFAULT NULL COMMENT 'Converted At',
  `is_active` smallint(5) unsigned DEFAULT '1' COMMENT 'Is Active',
  `is_virtual` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Virtual',
  `is_multi_shipping` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Multi Shipping',
  `items_count` int(10) unsigned DEFAULT '0' COMMENT 'Items Count',
  `items_qty` decimal(12,4) DEFAULT '0.0000' COMMENT 'Items Qty',
  `orig_order_id` int(10) unsigned DEFAULT '0' COMMENT 'Orig Order Id',
  `store_to_base_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Base Rate',
  `store_to_quote_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Quote Rate',
  `base_currency_code` varchar(255) DEFAULT NULL COMMENT 'Base Currency Code',
  `store_currency_code` varchar(255) DEFAULT NULL COMMENT 'Store Currency Code',
  `quote_currency_code` varchar(255) DEFAULT NULL COMMENT 'Quote Currency Code',
  `grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `checkout_method` varchar(255) DEFAULT NULL COMMENT 'Checkout Method',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `customer_tax_class_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Tax Class Id',
  `customer_group_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Group Id',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_prefix` varchar(40) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_middlename` varchar(40) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_suffix` varchar(40) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `customer_note` varchar(255) DEFAULT NULL COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT '1' COMMENT 'Customer Note Notify',
  `customer_is_guest` smallint(5) unsigned DEFAULT '0' COMMENT 'Customer Is Guest',
  `remote_ip` varchar(255) DEFAULT NULL COMMENT 'Remote Ip',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `reserved_order_id` varchar(64) DEFAULT NULL COMMENT 'Reserved Order Id',
  `password_hash` varchar(255) DEFAULT NULL COMMENT 'Password Hash',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `global_currency_code` varchar(255) DEFAULT NULL COMMENT 'Global Currency Code',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_quote_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Quote Rate',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `customer_gender` varchar(255) DEFAULT NULL COMMENT 'Customer Gender',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal With Discount',
  `is_changed` int(10) unsigned DEFAULT NULL COMMENT 'Is Changed',
  `trigger_recollect` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Trigger Recollect',
  `ext_shipping_info` text COMMENT 'Ext Shipping Info',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `is_persistent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Quote Persistent',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_QUOTE_CUSTOMER_ID_STORE_ID_IS_ACTIVE` (`customer_id`,`store_id`,`is_active`),
  KEY `IDX_SALES_FLAT_QUOTE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_FLAT_QUOTE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote';

-- ----------------------------
-- Records of sales_flat_quote
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_quote_address
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_quote_address`;
CREATE TABLE `sales_flat_quote_address` (
  `address_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `save_in_address_book` smallint(6) DEFAULT '0' COMMENT 'Save In Address Book',
  `customer_address_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Address Id',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `prefix` varchar(40) DEFAULT NULL COMMENT 'Prefix',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `middlename` varchar(40) DEFAULT NULL COMMENT 'Middlename',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `suffix` varchar(40) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `region_id` int(10) unsigned DEFAULT NULL COMMENT 'Region Id',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `country_id` varchar(255) DEFAULT NULL COMMENT 'Country Id',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Telephone',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `same_as_billing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Same As Billing',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `collect_shipping_rates` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Collect Shipping Rates',
  `shipping_method` varchar(255) DEFAULT NULL COMMENT 'Shipping Method',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `weight` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Weight',
  `subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal With Discount',
  `tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Shipping Amount',
  `base_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Shipping Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `customer_notes` text COMMENT 'Customer Notes',
  `applied_taxes` text COMMENT 'Applied Taxes',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`address_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_QUOTE_ID` (`quote_id`),
  CONSTRAINT `FK_SALES_FLAT_QUOTE_ADDRESS_QUOTE_ID_SALES_FLAT_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address';

-- ----------------------------
-- Records of sales_flat_quote_address
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_quote_address_item
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_quote_address_item`;
CREATE TABLE `sales_flat_quote_address_item` (
  `address_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Item Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Address Id',
  `quote_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Item Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `super_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Super Product Id',
  `parent_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Product Id',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `free_shipping` int(10) unsigned DEFAULT NULL COMMENT 'Free Shipping',
  `is_qty_decimal` int(10) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `discount_percent` decimal(12,4) DEFAULT NULL COMMENT 'Discount Percent',
  `no_discount` int(10) unsigned DEFAULT NULL COMMENT 'No Discount',
  `tax_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tax Percent',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`address_item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_ITEM_QUOTE_ADDRESS_ID` (`quote_address_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_ITEM_QUOTE_ITEM_ID` (`quote_item_id`),
  CONSTRAINT `FK_2EF8E28181D666D94D4E30DC2B0F80BF` FOREIGN KEY (`quote_item_id`) REFERENCES `sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_A345FC758F20C314169CE27DCE53477F` FOREIGN KEY (`parent_item_id`) REFERENCES `sales_flat_quote_address_item` (`address_item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_B521389746C00700D1B2B76EBBE53854` FOREIGN KEY (`quote_address_id`) REFERENCES `sales_flat_quote_address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address Item';

-- ----------------------------
-- Records of sales_flat_quote_address_item
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_quote_item
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_quote_item`;
CREATE TABLE `sales_flat_quote_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned DEFAULT '0' COMMENT 'No Discount',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Custom Price',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `original_custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Custom Price',
  `redirect_url` varchar(255) DEFAULT NULL COMMENT 'Redirect Url',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  PRIMARY KEY (`item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_QUOTE_ID` (`quote_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_B201DEB5DE51B791AF5C5BF87053C5A7` FOREIGN KEY (`parent_item_id`) REFERENCES `sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_QUOTE_ITEM_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_QUOTE_ITEM_QUOTE_ID_SALES_FLAT_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_QUOTE_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item';

-- ----------------------------
-- Records of sales_flat_quote_item
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_quote_item_option
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_quote_item_option`;
CREATE TABLE `sales_flat_quote_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_OPTION_ITEM_ID` (`item_id`),
  CONSTRAINT `FK_5F20E478CA64B6891EA8A9D6C2735739` FOREIGN KEY (`item_id`) REFERENCES `sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item Option';

-- ----------------------------
-- Records of sales_flat_quote_item_option
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_quote_payment
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_quote_payment`;
CREATE TABLE `sales_flat_quote_payment` (
  `payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_last4` varchar(255) DEFAULT NULL COMMENT 'Cc Last4',
  `cc_cid_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Enc',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_exp_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Month',
  `cc_exp_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Year',
  `cc_ss_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Owner',
  `cc_ss_start_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Month',
  `cc_ss_start_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Year',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `additional_data` text COMMENT 'Additional Data',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `additional_information` text COMMENT 'Additional Information',
  `paypal_payer_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Id',
  `paypal_payer_status` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Status',
  `paypal_correlation_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Correlation Id',
  PRIMARY KEY (`payment_id`),
  KEY `IDX_SALES_FLAT_QUOTE_PAYMENT_QUOTE_ID` (`quote_id`),
  CONSTRAINT `FK_SALES_FLAT_QUOTE_PAYMENT_QUOTE_ID_SALES_FLAT_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Payment';

-- ----------------------------
-- Records of sales_flat_quote_payment
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_quote_shipping_rate
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_quote_shipping_rate`;
CREATE TABLE `sales_flat_quote_shipping_rate` (
  `rate_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rate Id',
  `address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Address Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `carrier` varchar(255) DEFAULT NULL COMMENT 'Carrier',
  `carrier_title` varchar(255) DEFAULT NULL COMMENT 'Carrier Title',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `method_description` text COMMENT 'Method Description',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `error_message` text COMMENT 'Error Message',
  `method_title` text COMMENT 'Method Title',
  PRIMARY KEY (`rate_id`),
  KEY `IDX_SALES_FLAT_QUOTE_SHIPPING_RATE_ADDRESS_ID` (`address_id`),
  CONSTRAINT `FK_B1F177EFB73D3EDF5322BA64AC48D150` FOREIGN KEY (`address_id`) REFERENCES `sales_flat_quote_address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Shipping Rate';

-- ----------------------------
-- Records of sales_flat_quote_shipping_rate
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_shipment
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_shipment`;
CREATE TABLE `sales_flat_shipment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_weight` decimal(12,4) DEFAULT NULL COMMENT 'Total Weight',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `packages` text COMMENT 'Packed Products in Packages',
  `shipping_label` mediumblob COMMENT 'Shipping Label Content',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_SHIPMENT_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TOTAL_QTY` (`total_qty`),
  KEY `IDX_SALES_FLAT_SHIPMENT_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_SALES_FLAT_SHIPMENT_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_SHIPMENT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment';

-- ----------------------------
-- Records of sales_flat_shipment
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_shipment_comment
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_shipment_comment`;
CREATE TABLE `sales_flat_shipment_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_C2D69CC1FB03D2B2B794B0439F6650CF` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Comment';

-- ----------------------------
-- Records of sales_flat_shipment_comment
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_shipment_grid
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_shipment_grid`;
CREATE TABLE `sales_flat_shipment_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_SHIPMENT_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_TOTAL_QTY` (`total_qty`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_SHIPMENT_STATUS` (`shipment_status`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_SHIPPING_NAME` (`shipping_name`),
  CONSTRAINT `FK_SALES_FLAT_SHIPMENT_GRID_ENTT_ID_SALES_FLAT_SHIPMENT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_SHIPMENT_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Grid';

-- ----------------------------
-- Records of sales_flat_shipment_grid
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_shipment_item
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_shipment_item`;
CREATE TABLE `sales_flat_shipment_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_3AECE5007D18F159231B87E8306FC02A` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Item';

-- ----------------------------
-- Records of sales_flat_shipment_item
-- ----------------------------

-- ----------------------------
-- Table structure for sales_flat_shipment_track
-- ----------------------------
DROP TABLE IF EXISTS `sales_flat_shipment_track`;
CREATE TABLE `sales_flat_shipment_track` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `track_number` text COMMENT 'Number',
  `description` text COMMENT 'Description',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `carrier_code` varchar(32) DEFAULT NULL COMMENT 'Carrier Code',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TRACK_PARENT_ID` (`parent_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TRACK_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TRACK_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_BCD2FA28717D29F37E10A153E6F2F841` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Track';

-- ----------------------------
-- Records of sales_flat_shipment_track
-- ----------------------------

-- ----------------------------
-- Table structure for sales_invoiced_aggregated
-- ----------------------------
DROP TABLE IF EXISTS `sales_invoiced_aggregated`;
CREATE TABLE `sales_invoiced_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_INVOICED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_INVOICED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_INVOICED_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated';

-- ----------------------------
-- Records of sales_invoiced_aggregated
-- ----------------------------

-- ----------------------------
-- Table structure for sales_invoiced_aggregated_order
-- ----------------------------
DROP TABLE IF EXISTS `sales_invoiced_aggregated_order`;
CREATE TABLE `sales_invoiced_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_INVOICED_AGGREGATED_ORDER_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_INVOICED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_INVOICED_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated Order';

-- ----------------------------
-- Records of sales_invoiced_aggregated_order
-- ----------------------------

-- ----------------------------
-- Table structure for sales_order_aggregated_created
-- ----------------------------
DROP TABLE IF EXISTS `sales_order_aggregated_created`;
CREATE TABLE `sales_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_ORDER_AGGREGATED_CREATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_ORDER_AGGREGATED_CREATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Aggregated Created';

-- ----------------------------
-- Records of sales_order_aggregated_created
-- ----------------------------

-- ----------------------------
-- Table structure for sales_order_aggregated_updated
-- ----------------------------
DROP TABLE IF EXISTS `sales_order_aggregated_updated`;
CREATE TABLE `sales_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_ORDER_AGGREGATED_UPDATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_ORDER_AGGREGATED_UPDATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Aggregated Updated';

-- ----------------------------
-- Records of sales_order_aggregated_updated
-- ----------------------------

-- ----------------------------
-- Table structure for sales_order_status
-- ----------------------------
DROP TABLE IF EXISTS `sales_order_status`;
CREATE TABLE `sales_order_status` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';

-- ----------------------------
-- Records of sales_order_status
-- ----------------------------
INSERT INTO `sales_order_status` VALUES ('canceled', 'Canceled');
INSERT INTO `sales_order_status` VALUES ('closed', 'Closed');
INSERT INTO `sales_order_status` VALUES ('complete', 'Complete');
INSERT INTO `sales_order_status` VALUES ('fraud', 'Suspected Fraud');
INSERT INTO `sales_order_status` VALUES ('holded', 'On Hold');
INSERT INTO `sales_order_status` VALUES ('payment_review', 'Payment Review');
INSERT INTO `sales_order_status` VALUES ('paypal_canceled_reversal', 'PayPal Canceled Reversal');
INSERT INTO `sales_order_status` VALUES ('paypal_reversed', 'PayPal Reversed');
INSERT INTO `sales_order_status` VALUES ('pending', 'Pending');
INSERT INTO `sales_order_status` VALUES ('pending_payment', 'Pending Payment');
INSERT INTO `sales_order_status` VALUES ('pending_paypal', 'Pending PayPal');
INSERT INTO `sales_order_status` VALUES ('processing', 'Processing');

-- ----------------------------
-- Table structure for sales_order_status_label
-- ----------------------------
DROP TABLE IF EXISTS `sales_order_status_label`;
CREATE TABLE `sales_order_status_label` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`,`store_id`),
  KEY `IDX_SALES_ORDER_STATUS_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_ORDER_STATUS_LABEL_STATUS_SALES_ORDER_STATUS_STATUS` FOREIGN KEY (`status`) REFERENCES `sales_order_status` (`status`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_ORDER_STATUS_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Label Table';

-- ----------------------------
-- Records of sales_order_status_label
-- ----------------------------

-- ----------------------------
-- Table structure for sales_order_status_state
-- ----------------------------
DROP TABLE IF EXISTS `sales_order_status_state`;
CREATE TABLE `sales_order_status_state` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `state` varchar(32) NOT NULL COMMENT 'Label',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  PRIMARY KEY (`status`,`state`),
  CONSTRAINT `FK_SALES_ORDER_STATUS_STATE_STATUS_SALES_ORDER_STATUS_STATUS` FOREIGN KEY (`status`) REFERENCES `sales_order_status` (`status`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';

-- ----------------------------
-- Records of sales_order_status_state
-- ----------------------------
INSERT INTO `sales_order_status_state` VALUES ('canceled', 'canceled', '1');
INSERT INTO `sales_order_status_state` VALUES ('closed', 'closed', '1');
INSERT INTO `sales_order_status_state` VALUES ('complete', 'complete', '1');
INSERT INTO `sales_order_status_state` VALUES ('fraud', 'payment_review', '0');
INSERT INTO `sales_order_status_state` VALUES ('holded', 'holded', '1');
INSERT INTO `sales_order_status_state` VALUES ('payment_review', 'payment_review', '1');
INSERT INTO `sales_order_status_state` VALUES ('pending', 'new', '1');
INSERT INTO `sales_order_status_state` VALUES ('pending_payment', 'pending_payment', '1');
INSERT INTO `sales_order_status_state` VALUES ('processing', 'processing', '1');

-- ----------------------------
-- Table structure for sales_order_tax
-- ----------------------------
DROP TABLE IF EXISTS `sales_order_tax`;
CREATE TABLE `sales_order_tax` (
  `tax_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `percent` decimal(12,4) DEFAULT NULL COMMENT 'Percent',
  `amount` decimal(12,4) DEFAULT NULL COMMENT 'Amount',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `base_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount',
  `process` smallint(6) NOT NULL COMMENT 'Process',
  `base_real_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Real Amount',
  `hidden` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Hidden',
  PRIMARY KEY (`tax_id`),
  KEY `IDX_SALES_ORDER_TAX_ORDER_ID_PRIORITY_POSITION` (`order_id`,`priority`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Table';

-- ----------------------------
-- Records of sales_order_tax
-- ----------------------------

-- ----------------------------
-- Table structure for sales_order_tax_item
-- ----------------------------
DROP TABLE IF EXISTS `sales_order_tax_item`;
CREATE TABLE `sales_order_tax_item` (
  `tax_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Item Id',
  `tax_id` int(10) unsigned NOT NULL COMMENT 'Tax Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `tax_percent` decimal(12,4) NOT NULL COMMENT 'Real Tax Percent For Item',
  PRIMARY KEY (`tax_item_id`),
  UNIQUE KEY `UNQ_SALES_ORDER_TAX_ITEM_TAX_ID_ITEM_ID` (`tax_id`,`item_id`),
  KEY `IDX_SALES_ORDER_TAX_ITEM_TAX_ID` (`tax_id`),
  KEY `IDX_SALES_ORDER_TAX_ITEM_ITEM_ID` (`item_id`),
  CONSTRAINT `FK_SALES_ORDER_TAX_ITEM_ITEM_ID_SALES_FLAT_ORDER_ITEM_ITEM_ID` FOREIGN KEY (`item_id`) REFERENCES `sales_flat_order_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_ORDER_TAX_ITEM_TAX_ID_SALES_ORDER_TAX_TAX_ID` FOREIGN KEY (`tax_id`) REFERENCES `sales_order_tax` (`tax_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Item';

-- ----------------------------
-- Records of sales_order_tax_item
-- ----------------------------

-- ----------------------------
-- Table structure for sales_payment_transaction
-- ----------------------------
DROP TABLE IF EXISTS `sales_payment_transaction`;
CREATE TABLE `sales_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Transaction Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `payment_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Payment Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `parent_txn_id` varchar(100) DEFAULT NULL COMMENT 'Parent Txn Id',
  `txn_type` varchar(15) DEFAULT NULL COMMENT 'Txn Type',
  `is_closed` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Closed',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `UNQ_SALES_PAYMENT_TRANSACTION_ORDER_ID_PAYMENT_ID_TXN_ID` (`order_id`,`payment_id`,`txn_id`),
  KEY `IDX_SALES_PAYMENT_TRANSACTION_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_PAYMENT_TRANSACTION_PARENT_ID` (`parent_id`),
  KEY `IDX_SALES_PAYMENT_TRANSACTION_PAYMENT_ID` (`payment_id`),
  CONSTRAINT `FK_B99FF1A06402D725EBDB0F3A7ECD47A2` FOREIGN KEY (`parent_id`) REFERENCES `sales_payment_transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DA51A10B2405B64A4DAEF77A64F0DAAD` FOREIGN KEY (`payment_id`) REFERENCES `sales_flat_order_payment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_PAYMENT_TRANSACTION_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Payment Transaction';

-- ----------------------------
-- Records of sales_payment_transaction
-- ----------------------------

-- ----------------------------
-- Table structure for sales_recurring_profile
-- ----------------------------
DROP TABLE IF EXISTS `sales_recurring_profile`;
CREATE TABLE `sales_recurring_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Profile Id',
  `state` varchar(20) NOT NULL COMMENT 'State',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `reference_id` varchar(32) DEFAULT NULL COMMENT 'Reference Id',
  `subscriber_name` varchar(150) DEFAULT NULL COMMENT 'Subscriber Name',
  `start_datetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Start Datetime',
  `internal_reference_id` varchar(42) NOT NULL COMMENT 'Internal Reference Id',
  `schedule_description` varchar(255) NOT NULL COMMENT 'Schedule Description',
  `suspension_threshold` smallint(5) unsigned DEFAULT NULL COMMENT 'Suspension Threshold',
  `bill_failed_later` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Bill Failed Later',
  `period_unit` varchar(20) NOT NULL COMMENT 'Period Unit',
  `period_frequency` smallint(5) unsigned DEFAULT NULL COMMENT 'Period Frequency',
  `period_max_cycles` smallint(5) unsigned DEFAULT NULL COMMENT 'Period Max Cycles',
  `billing_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Billing Amount',
  `trial_period_unit` varchar(20) DEFAULT NULL COMMENT 'Trial Period Unit',
  `trial_period_frequency` smallint(5) unsigned DEFAULT NULL COMMENT 'Trial Period Frequency',
  `trial_period_max_cycles` smallint(5) unsigned DEFAULT NULL COMMENT 'Trial Period Max Cycles',
  `trial_billing_amount` text COMMENT 'Trial Billing Amount',
  `currency_code` varchar(3) NOT NULL COMMENT 'Currency Code',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `init_amount` decimal(12,4) DEFAULT NULL COMMENT 'Init Amount',
  `init_may_fail` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Init May Fail',
  `order_info` text NOT NULL COMMENT 'Order Info',
  `order_item_info` text NOT NULL COMMENT 'Order Item Info',
  `billing_address_info` text NOT NULL COMMENT 'Billing Address Info',
  `shipping_address_info` text COMMENT 'Shipping Address Info',
  `profile_vendor_info` text COMMENT 'Profile Vendor Info',
  `additional_info` text COMMENT 'Additional Info',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `UNQ_SALES_RECURRING_PROFILE_INTERNAL_REFERENCE_ID` (`internal_reference_id`),
  KEY `IDX_SALES_RECURRING_PROFILE_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_RECURRING_PROFILE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_RECURRING_PROFILE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_RECURRING_PROFILE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Recurring Profile';

-- ----------------------------
-- Records of sales_recurring_profile
-- ----------------------------

-- ----------------------------
-- Table structure for sales_recurring_profile_order
-- ----------------------------
DROP TABLE IF EXISTS `sales_recurring_profile_order`;
CREATE TABLE `sales_recurring_profile_order` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_SALES_RECURRING_PROFILE_ORDER_PROFILE_ID_ORDER_ID` (`profile_id`,`order_id`),
  KEY `IDX_SALES_RECURRING_PROFILE_ORDER_ORDER_ID` (`order_id`),
  CONSTRAINT `FK_7FF85741C66DCD37A4FBE3E3255A5A01` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_B8A7A5397B67455786E55461748C59F4` FOREIGN KEY (`profile_id`) REFERENCES `sales_recurring_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Recurring Profile Order';

-- ----------------------------
-- Records of sales_recurring_profile_order
-- ----------------------------

-- ----------------------------
-- Table structure for sales_refunded_aggregated
-- ----------------------------
DROP TABLE IF EXISTS `sales_refunded_aggregated`;
CREATE TABLE `sales_refunded_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_REFUNDED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_REFUNDED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_REFUNDED_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated';

-- ----------------------------
-- Records of sales_refunded_aggregated
-- ----------------------------

-- ----------------------------
-- Table structure for sales_refunded_aggregated_order
-- ----------------------------
DROP TABLE IF EXISTS `sales_refunded_aggregated_order`;
CREATE TABLE `sales_refunded_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_REFUNDED_AGGREGATED_ORDER_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated Order';

-- ----------------------------
-- Records of sales_refunded_aggregated_order
-- ----------------------------

-- ----------------------------
-- Table structure for sales_shipping_aggregated
-- ----------------------------
DROP TABLE IF EXISTS `sales_shipping_aggregated`;
CREATE TABLE `sales_shipping_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_SHPP_AGGRED_PERIOD_STORE_ID_ORDER_STS_SHPP_DESCRIPTION` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `IDX_SALES_SHIPPING_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_SHIPPING_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated';

-- ----------------------------
-- Records of sales_shipping_aggregated
-- ----------------------------

-- ----------------------------
-- Table structure for sales_shipping_aggregated_order
-- ----------------------------
DROP TABLE IF EXISTS `sales_shipping_aggregated_order`;
CREATE TABLE `sales_shipping_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `C05FAE47282EEA68654D0924E946761F` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `IDX_SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated Order';

-- ----------------------------
-- Records of sales_shipping_aggregated_order
-- ----------------------------

-- ----------------------------
-- Table structure for sendfriend_log
-- ----------------------------
DROP TABLE IF EXISTS `sendfriend_log`;
CREATE TABLE `sendfriend_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `ip` varbinary(16) DEFAULT NULL,
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Log time',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`log_id`),
  KEY `IDX_SENDFRIEND_LOG_IP` (`ip`),
  KEY `IDX_SENDFRIEND_LOG_TIME` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Send to friend function log storage table';

-- ----------------------------
-- Records of sendfriend_log
-- ----------------------------

-- ----------------------------
-- Table structure for shipping_tablerate
-- ----------------------------
DROP TABLE IF EXISTS `shipping_tablerate`;
CREATE TABLE `shipping_tablerate` (
  `pk` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `website_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `dest_country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Destination coutry ISO/2 or ISO/3 code',
  `dest_region_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Destination Region Id',
  `dest_zip` varchar(10) NOT NULL DEFAULT '*' COMMENT 'Destination Post Code (Zip)',
  `condition_name` varchar(20) NOT NULL COMMENT 'Rate Condition name',
  `condition_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rate condition value',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `cost` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Cost',
  PRIMARY KEY (`pk`),
  UNIQUE KEY `D60821CDB2AFACEE1566CFC02D0D4CAA` (`website_id`,`dest_country_id`,`dest_region_id`,`dest_zip`,`condition_name`,`condition_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Shipping Tablerate';

-- ----------------------------
-- Records of shipping_tablerate
-- ----------------------------

-- ----------------------------
-- Table structure for sitemap
-- ----------------------------
DROP TABLE IF EXISTS `sitemap`;
CREATE TABLE `sitemap` (
  `sitemap_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sitemap Id',
  `sitemap_type` varchar(32) DEFAULT NULL COMMENT 'Sitemap Type',
  `sitemap_filename` varchar(32) DEFAULT NULL COMMENT 'Sitemap Filename',
  `sitemap_path` varchar(255) DEFAULT NULL COMMENT 'Sitemap Path',
  `sitemap_time` timestamp NULL DEFAULT NULL COMMENT 'Sitemap Time',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`sitemap_id`),
  KEY `IDX_SITEMAP_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SITEMAP_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Sitemap';

-- ----------------------------
-- Records of sitemap
-- ----------------------------

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Status',
  `first_customer_id` int(10) unsigned DEFAULT NULL COMMENT 'First Customer Id',
  `first_store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'First Store Id',
  PRIMARY KEY (`tag_id`),
  KEY `FK_TAG_FIRST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` (`first_customer_id`),
  KEY `FK_TAG_FIRST_STORE_ID_CORE_STORE_STORE_ID` (`first_store_id`),
  CONSTRAINT `FK_TAG_FIRST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`first_customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_TAG_FIRST_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`first_store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag';

-- ----------------------------
-- Records of tag
-- ----------------------------

-- ----------------------------
-- Table structure for tag_properties
-- ----------------------------
DROP TABLE IF EXISTS `tag_properties`;
CREATE TABLE `tag_properties` (
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `base_popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Base Popularity',
  PRIMARY KEY (`tag_id`,`store_id`),
  KEY `IDX_TAG_PROPERTIES_STORE_ID` (`store_id`),
  CONSTRAINT `FK_TAG_PROPERTIES_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_PROPERTIES_TAG_ID_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Properties';

-- ----------------------------
-- Records of tag_properties
-- ----------------------------

-- ----------------------------
-- Table structure for tag_relation
-- ----------------------------
DROP TABLE IF EXISTS `tag_relation`;
CREATE TABLE `tag_relation` (
  `tag_relation_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag Relation Id',
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Store Id',
  `active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Active',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`tag_relation_id`),
  UNIQUE KEY `UNQ_TAG_RELATION_TAG_ID_CUSTOMER_ID_PRODUCT_ID_STORE_ID` (`tag_id`,`customer_id`,`product_id`,`store_id`),
  KEY `IDX_TAG_RELATION_PRODUCT_ID` (`product_id`),
  KEY `IDX_TAG_RELATION_TAG_ID` (`tag_id`),
  KEY `IDX_TAG_RELATION_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_TAG_RELATION_STORE_ID` (`store_id`),
  CONSTRAINT `FK_TAG_RELATION_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_RELATION_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_RELATION_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_RELATION_TAG_ID_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Relation';

-- ----------------------------
-- Records of tag_relation
-- ----------------------------

-- ----------------------------
-- Table structure for tag_summary
-- ----------------------------
DROP TABLE IF EXISTS `tag_summary`;
CREATE TABLE `tag_summary` (
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `customers` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customers',
  `products` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Products',
  `uses` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Uses',
  `historical_uses` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Historical Uses',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `base_popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Base Popularity',
  PRIMARY KEY (`tag_id`,`store_id`),
  KEY `IDX_TAG_SUMMARY_STORE_ID` (`store_id`),
  KEY `IDX_TAG_SUMMARY_TAG_ID` (`tag_id`),
  CONSTRAINT `FK_TAG_SUMMARY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_SUMMARY_TAG_ID_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Summary';

-- ----------------------------
-- Records of tag_summary
-- ----------------------------

-- ----------------------------
-- Table structure for tax_calculation
-- ----------------------------
DROP TABLE IF EXISTS `tax_calculation`;
CREATE TABLE `tax_calculation` (
  `tax_calculation_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `tax_calculation_rule_id` int(11) NOT NULL COMMENT 'Tax Calculation Rule Id',
  `customer_tax_class_id` smallint(6) NOT NULL COMMENT 'Customer Tax Class Id',
  `product_tax_class_id` smallint(6) NOT NULL COMMENT 'Product Tax Class Id',
  PRIMARY KEY (`tax_calculation_id`),
  KEY `IDX_TAX_CALCULATION_TAX_CALCULATION_RULE_ID` (`tax_calculation_rule_id`),
  KEY `IDX_TAX_CALCULATION_TAX_CALCULATION_RATE_ID` (`tax_calculation_rate_id`),
  KEY `IDX_TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID` (`customer_tax_class_id`),
  KEY `IDX_TAX_CALCULATION_PRODUCT_TAX_CLASS_ID` (`product_tax_class_id`),
  KEY `IDX_TAX_CALC_TAX_CALC_RATE_ID_CSTR_TAX_CLASS_ID_PRD_TAX_CLASS_ID` (`tax_calculation_rate_id`,`customer_tax_class_id`,`product_tax_class_id`),
  CONSTRAINT `FK_TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID_TAX_CLASS_CLASS_ID` FOREIGN KEY (`customer_tax_class_id`) REFERENCES `tax_class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAX_CALCULATION_PRODUCT_TAX_CLASS_ID_TAX_CLASS_CLASS_ID` FOREIGN KEY (`product_tax_class_id`) REFERENCES `tax_class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAX_CALC_TAX_CALC_RATE_ID_TAX_CALC_RATE_TAX_CALC_RATE_ID` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAX_CALC_TAX_CALC_RULE_ID_TAX_CALC_RULE_TAX_CALC_RULE_ID` FOREIGN KEY (`tax_calculation_rule_id`) REFERENCES `tax_calculation_rule` (`tax_calculation_rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Tax Calculation';

-- ----------------------------
-- Records of tax_calculation
-- ----------------------------
INSERT INTO `tax_calculation` VALUES ('1', '1', '1', '3', '2');
INSERT INTO `tax_calculation` VALUES ('2', '2', '1', '3', '2');

-- ----------------------------
-- Table structure for tax_calculation_rate
-- ----------------------------
DROP TABLE IF EXISTS `tax_calculation_rate`;
CREATE TABLE `tax_calculation_rate` (
  `tax_calculation_rate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Id',
  `tax_country_id` varchar(2) NOT NULL COMMENT 'Tax Country Id',
  `tax_region_id` int(11) NOT NULL COMMENT 'Tax Region Id',
  `tax_postcode` varchar(21) DEFAULT NULL COMMENT 'Tax Postcode',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `rate` decimal(12,4) NOT NULL COMMENT 'Rate',
  `zip_is_range` smallint(6) DEFAULT NULL COMMENT 'Zip Is Range',
  `zip_from` int(10) unsigned DEFAULT NULL COMMENT 'Zip From',
  `zip_to` int(10) unsigned DEFAULT NULL COMMENT 'Zip To',
  PRIMARY KEY (`tax_calculation_rate_id`),
  KEY `IDX_TAX_CALC_RATE_TAX_COUNTRY_ID_TAX_REGION_ID_TAX_POSTCODE` (`tax_country_id`,`tax_region_id`,`tax_postcode`),
  KEY `IDX_TAX_CALCULATION_RATE_CODE` (`code`),
  KEY `CA799F1E2CB843495F601E56C84A626D` (`tax_calculation_rate_id`,`tax_country_id`,`tax_region_id`,`zip_is_range`,`tax_postcode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate';

-- ----------------------------
-- Records of tax_calculation_rate
-- ----------------------------
INSERT INTO `tax_calculation_rate` VALUES ('1', 'US', '12', '*', 'US-CA-*-Rate 1', '8.2500', null, null, null);
INSERT INTO `tax_calculation_rate` VALUES ('2', 'US', '43', '*', 'US-NY-*-Rate 1', '8.3750', null, null, null);

-- ----------------------------
-- Table structure for tax_calculation_rate_title
-- ----------------------------
DROP TABLE IF EXISTS `tax_calculation_rate_title`;
CREATE TABLE `tax_calculation_rate_title` (
  `tax_calculation_rate_title_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Title Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`tax_calculation_rate_title_id`),
  KEY `IDX_TAX_CALCULATION_RATE_TITLE_TAX_CALCULATION_RATE_ID_STORE_ID` (`tax_calculation_rate_id`,`store_id`),
  KEY `IDX_TAX_CALCULATION_RATE_TITLE_TAX_CALCULATION_RATE_ID` (`tax_calculation_rate_id`),
  KEY `IDX_TAX_CALCULATION_RATE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_37FB965F786AD5897BB3AE90470C42AB` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAX_CALCULATION_RATE_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate Title';

-- ----------------------------
-- Records of tax_calculation_rate_title
-- ----------------------------

-- ----------------------------
-- Table structure for tax_calculation_rule
-- ----------------------------
DROP TABLE IF EXISTS `tax_calculation_rule`;
CREATE TABLE `tax_calculation_rule` (
  `tax_calculation_rule_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rule Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `calculate_subtotal` int(11) NOT NULL COMMENT 'Calculate off subtotal option',
  PRIMARY KEY (`tax_calculation_rule_id`),
  KEY `IDX_TAX_CALC_RULE_PRIORITY_POSITION_TAX_CALC_RULE_ID` (`priority`,`position`,`tax_calculation_rule_id`),
  KEY `IDX_TAX_CALCULATION_RULE_CODE` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rule';

-- ----------------------------
-- Records of tax_calculation_rule
-- ----------------------------
INSERT INTO `tax_calculation_rule` VALUES ('1', 'Retail Customer-Taxable Goods-Rate 1', '1', '1', '0');

-- ----------------------------
-- Table structure for tax_class
-- ----------------------------
DROP TABLE IF EXISTS `tax_class`;
CREATE TABLE `tax_class` (
  `class_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Class Id',
  `class_name` varchar(255) NOT NULL COMMENT 'Class Name',
  `class_type` varchar(8) NOT NULL DEFAULT 'CUSTOMER' COMMENT 'Class Type',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Tax Class';

-- ----------------------------
-- Records of tax_class
-- ----------------------------
INSERT INTO `tax_class` VALUES ('2', 'Taxable Goods', 'PRODUCT');
INSERT INTO `tax_class` VALUES ('3', 'Retail Customer', 'CUSTOMER');
INSERT INTO `tax_class` VALUES ('4', 'Shipping', 'PRODUCT');

-- ----------------------------
-- Table structure for tax_order_aggregated_created
-- ----------------------------
DROP TABLE IF EXISTS `tax_order_aggregated_created`;
CREATE TABLE `tax_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `FCA5E2C02689EB2641B30580D7AACF12` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `IDX_TAX_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_TAX_ORDER_AGGREGATED_CREATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Order Aggregation';

-- ----------------------------
-- Records of tax_order_aggregated_created
-- ----------------------------

-- ----------------------------
-- Table structure for tax_order_aggregated_updated
-- ----------------------------
DROP TABLE IF EXISTS `tax_order_aggregated_updated`;
CREATE TABLE `tax_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `DB0AF14011199AA6CD31D5078B90AA8D` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `IDX_TAX_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_TAX_ORDER_AGGREGATED_UPDATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Order Aggregated Updated';

-- ----------------------------
-- Records of tax_order_aggregated_updated
-- ----------------------------

-- ----------------------------
-- Table structure for weee_discount
-- ----------------------------
DROP TABLE IF EXISTS `weee_discount`;
CREATE TABLE `weee_discount` (
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  KEY `IDX_WEEE_DISCOUNT_WEBSITE_ID` (`website_id`),
  KEY `IDX_WEEE_DISCOUNT_ENTITY_ID` (`entity_id`),
  KEY `IDX_WEEE_DISCOUNT_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_WEEE_DISCOUNT_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_DISCOUNT_ENTITY_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_DISCOUNT_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Discount';

-- ----------------------------
-- Records of weee_discount
-- ----------------------------

-- ----------------------------
-- Table structure for weee_tax
-- ----------------------------
DROP TABLE IF EXISTS `weee_tax`;
CREATE TABLE `weee_tax` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `country` varchar(2) DEFAULT NULL COMMENT 'Country',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `state` varchar(255) NOT NULL DEFAULT '*' COMMENT 'State',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`value_id`),
  KEY `IDX_WEEE_TAX_WEBSITE_ID` (`website_id`),
  KEY `IDX_WEEE_TAX_ENTITY_ID` (`entity_id`),
  KEY `IDX_WEEE_TAX_COUNTRY` (`country`),
  KEY `IDX_WEEE_TAX_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_WEEE_TAX_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_TAX_COUNTRY_DIRECTORY_COUNTRY_COUNTRY_ID` FOREIGN KEY (`country`) REFERENCES `directory_country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_TAX_ENTITY_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_TAX_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Tax';

-- ----------------------------
-- Records of weee_tax
-- ----------------------------

-- ----------------------------
-- Table structure for widget
-- ----------------------------
DROP TABLE IF EXISTS `widget`;
CREATE TABLE `widget` (
  `widget_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Widget Id',
  `widget_code` varchar(255) DEFAULT NULL COMMENT 'Widget code for template directive',
  `widget_type` varchar(255) DEFAULT NULL COMMENT 'Widget Type',
  `parameters` text COMMENT 'Parameters',
  PRIMARY KEY (`widget_id`),
  KEY `IDX_WIDGET_WIDGET_CODE` (`widget_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Preconfigured Widgets';

-- ----------------------------
-- Records of widget
-- ----------------------------

-- ----------------------------
-- Table structure for widget_instance
-- ----------------------------
DROP TABLE IF EXISTS `widget_instance`;
CREATE TABLE `widget_instance` (
  `instance_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Instance Id',
  `instance_type` varchar(255) DEFAULT NULL COMMENT 'Instance Type',
  `package_theme` varchar(255) DEFAULT NULL COMMENT 'Package Theme',
  `title` varchar(255) DEFAULT NULL COMMENT 'Widget Title',
  `store_ids` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Store ids',
  `widget_parameters` text COMMENT 'Widget parameters',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  PRIMARY KEY (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instances of Widget for Package Theme';

-- ----------------------------
-- Records of widget_instance
-- ----------------------------

-- ----------------------------
-- Table structure for widget_instance_page
-- ----------------------------
DROP TABLE IF EXISTS `widget_instance_page`;
CREATE TABLE `widget_instance_page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Page Id',
  `instance_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance Id',
  `page_group` varchar(25) DEFAULT NULL COMMENT 'Block Group Type',
  `layout_handle` varchar(255) DEFAULT NULL COMMENT 'Layout Handle',
  `block_reference` varchar(255) DEFAULT NULL COMMENT 'Block Reference',
  `page_for` varchar(25) DEFAULT NULL COMMENT 'For instance entities',
  `entities` text COMMENT 'Catalog entities (comma separated)',
  `page_template` varchar(255) DEFAULT NULL COMMENT 'Path to widget template',
  PRIMARY KEY (`page_id`),
  KEY `IDX_WIDGET_INSTANCE_PAGE_INSTANCE_ID` (`instance_id`),
  CONSTRAINT `FK_WIDGET_INSTANCE_PAGE_INSTANCE_ID_WIDGET_INSTANCE_INSTANCE_ID` FOREIGN KEY (`instance_id`) REFERENCES `widget_instance` (`instance_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instance of Widget on Page';

-- ----------------------------
-- Records of widget_instance_page
-- ----------------------------

-- ----------------------------
-- Table structure for widget_instance_page_layout
-- ----------------------------
DROP TABLE IF EXISTS `widget_instance_page_layout`;
CREATE TABLE `widget_instance_page_layout` (
  `page_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Page Id',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  UNIQUE KEY `UNQ_WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID_PAGE_ID` (`layout_update_id`,`page_id`),
  KEY `IDX_WIDGET_INSTANCE_PAGE_LAYOUT_PAGE_ID` (`page_id`),
  KEY `IDX_WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID` (`layout_update_id`),
  CONSTRAINT `FK_0A5D06DCEC6A6845F50E5FAAC5A1C96D` FOREIGN KEY (`layout_update_id`) REFERENCES `core_layout_update` (`layout_update_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WIDGET_INSTANCE_PAGE_LYT_PAGE_ID_WIDGET_INSTANCE_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `widget_instance_page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout updates';

-- ----------------------------
-- Records of widget_instance_page_layout
-- ----------------------------

-- ----------------------------
-- Table structure for wishlist
-- ----------------------------
DROP TABLE IF EXISTS `wishlist`;
CREATE TABLE `wishlist` (
  `wishlist_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist ID',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `shared` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sharing flag (0 or 1)',
  `sharing_code` varchar(32) DEFAULT NULL COMMENT 'Sharing encrypted code',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Last updated date',
  PRIMARY KEY (`wishlist_id`),
  UNIQUE KEY `UNQ_WISHLIST_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_WISHLIST_SHARED` (`shared`),
  CONSTRAINT `FK_WISHLIST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist main Table';

-- ----------------------------
-- Records of wishlist
-- ----------------------------

-- ----------------------------
-- Table structure for wishlist_item
-- ----------------------------
DROP TABLE IF EXISTS `wishlist_item`;
CREATE TABLE `wishlist_item` (
  `wishlist_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist item ID',
  `wishlist_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Wishlist ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Add date and time',
  `description` text COMMENT 'Short description of wish list item',
  `qty` decimal(12,4) NOT NULL COMMENT 'Qty',
  PRIMARY KEY (`wishlist_item_id`),
  KEY `IDX_WISHLIST_ITEM_WISHLIST_ID` (`wishlist_id`),
  KEY `IDX_WISHLIST_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_WISHLIST_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_WISHLIST_ITEM_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WISHLIST_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_WISHLIST_ITEM_WISHLIST_ID_WISHLIST_WISHLIST_ID` FOREIGN KEY (`wishlist_id`) REFERENCES `wishlist` (`wishlist_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist items';

-- ----------------------------
-- Records of wishlist_item
-- ----------------------------

-- ----------------------------
-- Table structure for wishlist_item_option
-- ----------------------------
DROP TABLE IF EXISTS `wishlist_item_option`;
CREATE TABLE `wishlist_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `wishlist_item_id` int(10) unsigned NOT NULL COMMENT 'Wishlist Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `FK_A014B30B04B72DD0EAB3EECD779728D6` (`wishlist_item_id`),
  CONSTRAINT `FK_A014B30B04B72DD0EAB3EECD779728D6` FOREIGN KEY (`wishlist_item_id`) REFERENCES `wishlist_item` (`wishlist_item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist Item Option Table';

-- ----------------------------
-- Records of wishlist_item_option
-- ----------------------------
