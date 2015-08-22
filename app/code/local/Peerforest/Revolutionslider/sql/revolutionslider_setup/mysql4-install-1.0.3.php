<?php

$installer = $this;

$installer->startSetup();

$installer->run("

DROP TABLE IF EXISTS {$this->getTable('revolutionslider')};
CREATE TABLE {$this->getTable('revolutionslider')} (
  `revolutionslider_id` int(11) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `filename` varchar(255) NOT NULL default '',
  `text` text NULL,
  `data_transition` varchar(255) NULL,
  `data_slotamount` varchar(255) NULL,
  `data_masterspeed` varchar(255) NULL,
  `data_delay` varchar(255) NULL,
  `sorting_order` int(11) NULL,
  `status` smallint(6) NOT NULL default '0',
  `weblink` varchar(255) NULL,
  `created_time` datetime NULL,
  `update_time` datetime NULL,
  PRIMARY KEY (`revolutionslider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

    ");

$installer->endSetup(); 