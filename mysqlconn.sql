show databases;

CREATE TABLE DeviceRegistry.`global_metadata` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `model_name` varchar(500) NOT NULL,
  `registration_time` datetime NOT NULL,
  `device_type` varchar(500) NOT NULL,
  `manufacturer` varchar(500) NOT NULL,
  `category` varchar(100) NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table DeviceRegistry.`global_metadata`;



CREATE TABLE DeviceRegistry.`specific_metadata` (
  `item_id` int(11) NOT NULL,
  `metadata_key` varchar(500) NOT NULL,
  `metadata_value` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

drop table DeviceRegistry.`specific_metadata`;



CREATE TABLE DeviceRegistry.`device_list` (
  `device_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `system_id` varchar(100) NOT NULL,
  `device_name` varchar(500) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `deployment_time` datetime NOT NULL,
  `deployment_location` varchar(500) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


drop table DeviceRegistry.`device_list`; 
