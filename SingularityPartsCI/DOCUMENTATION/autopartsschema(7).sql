-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 27, 2013 at 01:29 AM
-- Server version: 5.6.11
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `autopartsschema`
--
CREATE DATABASE IF NOT EXISTS `autopartsschema` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `autopartsschema`;

-- --------------------------------------------------------

--
-- Table structure for table `bool_facet`
--

CREATE TABLE IF NOT EXISTS `bool_facet` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores types of facets (product specs) that are yes/no or tr /* comment truncated */ /*ue/false in nature*/' AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `bool_facet_value`
--

CREATE TABLE IF NOT EXISTS `bool_facet_value` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `bool_facet_id` bigint(20) unsigned NOT NULL,
  `value` tinyint(1) NOT NULL,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `job_bool_facet` (`bool_facet_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `bool_facet_value_product`
--

CREATE TABLE IF NOT EXISTS `bool_facet_value_product` (
  `product_id` bigint(20) unsigned NOT NULL,
  `bool_facet_value_id` bigint(20) unsigned NOT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `facets` (`bool_facet_value_id`),
  KEY `bool_facet_product` (`product_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='maps products to the values of their boolean facets. ' AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `bool_facet_value_vehicle`
--

CREATE TABLE IF NOT EXISTS `bool_facet_value_vehicle` (
  `bool_facet_value_id` bigint(20) unsigned NOT NULL,
  `vehicle_id` bigint(20) unsigned NOT NULL,
  KEY `bool_facet_id_fk4567` (`bool_facet_value_id`),
  KEY `bool_facet_vehicle` (`vehicle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='habtm - boolean facets and vehicles';

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE IF NOT EXISTS `branch` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `streetno` tinytext NOT NULL,
  `streetname` text NOT NULL,
  `city` text NOT NULL,
  `state` bigint(20) unsigned NOT NULL,
  `postcode` tinytext NOT NULL,
  `latitude` float(11,8) NOT NULL,
  `longitude` float(11,8) NOT NULL,
  `pobox` tinytext,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  `email` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `branch_state_idx` (`state`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`id`, `streetno`, `streetname`, `city`, `state`, `postcode`, `latitude`, `longitude`, `pobox`, `name`, `description`, `email`) VALUES
(1, '404', 'Fake Street', 'Montgomery', 1, '36101', 42.00000000, 42.00000000, 'test', 'Singularity Parts', 'test', 'test');

-- --------------------------------------------------------

--
-- Table structure for table `branch_inventory_received_date`
--

CREATE TABLE IF NOT EXISTS `branch_inventory_received_date` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_inventory_request_id` bigint(20) unsigned NOT NULL,
  `received_date` date NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `product_condition_id` bigint(20) unsigned NOT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `person_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `req_id1` (`branch_inventory_request_id`),
  KEY `person_id_fk16789` (`person_id`),
  KEY `prod_id_fk1234g5678` (`product_id`),
  KEY `cond_birc_idx` (`product_condition_id`),
  KEY `country_birc_idx` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='logs who receives what in the back of the store and when. ' AUTO_INCREMENT=8 ;

--
-- Dumping data for table `branch_inventory_received_date`
--

INSERT INTO `branch_inventory_received_date` (`id`, `branch_inventory_request_id`, `received_date`, `product_id`, `product_condition_id`, `country_id`, `quantity`, `person_id`) VALUES
(3, 3, '2013-11-26', 1, 1, 1, 50, 21),
(4, 3, '2013-11-26', 2, 1, 1, 50, 21),
(5, 3, '2013-11-26', 3, 1, 1, 50, 21),
(6, 3, '2013-11-26', 4, 1, 1, 50, 21),
(7, 3, '2013-11-26', 5, 1, 1, 50, 21);

-- --------------------------------------------------------

--
-- Table structure for table `branch_inventory_request`
--

CREATE TABLE IF NOT EXISTS `branch_inventory_request` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) unsigned NOT NULL,
  `order_date` date NOT NULL,
  `person_id` bigint(20) unsigned NOT NULL,
  `extra_fees` float NOT NULL,
  `vendor_id` bigint(20) unsigned NOT NULL,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `branch_id_fk` (`branch_id`),
  KEY `person_id_fk` (`person_id`),
  KEY `vendor_req` (`vendor_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the request _id, branch_id, and order date of each inve /* comment truncated */ /*ntory request.*/' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `branch_inventory_request`
--

INSERT INTO `branch_inventory_request` (`id`, `branch_id`, `order_date`, `person_id`, `extra_fees`, `vendor_id`, `name`, `description`) VALUES
(3, 1, '2013-11-26', 21, 42, 1, 'Supply Request', 'Request for Supplies');

-- --------------------------------------------------------

--
-- Table structure for table `branch_inventory_request_product`
--

CREATE TABLE IF NOT EXISTS `branch_inventory_request_product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_inventory_request_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `product_condition_id` bigint(20) unsigned NOT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id_fk` (`product_id`),
  KEY `req_id` (`branch_inventory_request_id`),
  KEY `cond_inventory_request_idx` (`product_condition_id`),
  KEY `country_inventory_request_idx` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the products and quantities associated with each inve /* comment truncated */ /*ntory request*/' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `branch_inventory_request_product`
--

INSERT INTO `branch_inventory_request_product` (`id`, `branch_inventory_request_id`, `product_id`, `product_condition_id`, `country_id`, `quantity`) VALUES
(1, 3, 1, 1, 1, 50),
(2, 3, 2, 1, 1, 50),
(3, 3, 3, 1, 1, 50),
(4, 3, 4, 1, 1, 50),
(5, 3, 5, 1, 1, 50);

-- --------------------------------------------------------

--
-- Table structure for table `branch_inventory_return`
--

CREATE TABLE IF NOT EXISTS `branch_inventory_return` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_inventory_request_id` bigint(20) unsigned NOT NULL,
  `person_id` bigint(20) unsigned NOT NULL,
  `return_date` date NOT NULL,
  `reason_id` bigint(20) unsigned NOT NULL,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `branch_branch_inventory_request_id_fk` (`branch_inventory_request_id`),
  KEY `person_id_fk2` (`person_id`),
  KEY `reason_id_inventory` (`reason_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the _id of the employee who prepared the return. ' AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `branch_inventory_return_product`
--

CREATE TABLE IF NOT EXISTS `branch_inventory_return_product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_inventory_return_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `product_condition_id` bigint(20) unsigned NOT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id_fk1` (`product_id`),
  KEY `returns` (`branch_inventory_return_id`),
  KEY `condition_id_fk234_idx` (`product_condition_id`),
  KEY `return_country_id_idx` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores inventory returns and the reasons for them. ' AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `branch_received_product`
--
CREATE TABLE IF NOT EXISTS `branch_received_product` (
`Product_ID` bigint(20) unsigned
,`product_condition_ID` bigint(20) unsigned
,`Country_ID` bigint(20) unsigned
,`TotalQty` decimal(32,0)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `branch_returned_product`
--
CREATE TABLE IF NOT EXISTS `branch_returned_product` (
`Product_ID` bigint(20) unsigned
,`product_Condition_ID` bigint(20) unsigned
,`Country_ID` bigint(20) unsigned
,`TotalQty` decimal(32,0)
);
-- --------------------------------------------------------

--
-- Table structure for table `cash_payment`
--

CREATE TABLE IF NOT EXISTS `cash_payment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `amount` float NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id_fk4321` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cc_payment`
--

CREATE TABLE IF NOT EXISTS `cc_payment` (
  `id` bigint(20) unsigned NOT NULL,
  `order_id` bigint(20) unsigned NOT NULL,
  `cc_number` text NOT NULL,
  `amount` float NOT NULL,
  `date` date NOT NULL,
  `billing_name` text NOT NULL,
  `billing_address1` text NOT NULL,
  `billing_address2` text,
  `City` text NOT NULL,
  `state` bigint(20) unsigned NOT NULL,
  `postcode` text NOT NULL,
  `exp_date` date NOT NULL,
  `phone` tinytext NOT NULL,
  `security_code` smallint(3) NOT NULL,
  KEY `order_id_fk5431` (`order_id`),
  KEY `payment_state_idx` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='this stores all credit card payments made. may or may not be /* comment truncated */ /* modified depending on use of library like stripe. */';

--
-- Dumping data for table `cc_payment`
--

INSERT INTO `cc_payment` (`id`, `order_id`, `cc_number`, `amount`, `date`, `billing_name`, `billing_address1`, `billing_address2`, `City`, `state`, `postcode`, `exp_date`, `phone`, `security_code`) VALUES
(0, 12, '44444444444', 42, '0000-00-00', '500', '404 Fake St', '808 Other St', 'Montgomery', 1, '36101', '0000-00-00', '', 500);

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

CREATE TABLE IF NOT EXISTS `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ci_sessions`
--

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('b42e4651d75beb03aa450ef93cc2c68f', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:25.0) Gecko/20100101 Firefox/25.0', 1385509995, 'a:4:{s:9:"user_data";s:0:"";s:9:"person_id";s:2:"21";s:9:"logged_in";b:1;s:13:"cart_contents";a:3:{s:32:"698d51a19d8a121ce581499d7b701668";a:7:{s:5:"rowid";s:32:"698d51a19d8a121ce581499d7b701668";s:2:"id";s:1:"1";s:3:"qty";s:1:"1";s:5:"price";s:2:"42";s:4:"name";s:14:"Battery Mark 1";s:7:"options";a:2:{s:12:"condition_id";s:1:"1";s:10:"country_id";s:1:"1";}s:8:"subtotal";i:42;}s:11:"total_items";i:1;s:10:"cart_total";i:42;}}');

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE IF NOT EXISTS `country` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `currency` varchar(3) NOT NULL,
  `two_letter_code` varchar(2) NOT NULL,
  `three_letter_code` varchar(3) NOT NULL,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `currency`, `two_letter_code`, `three_letter_code`, `name`) VALUES
(1, 'USD', 'US', 'USA', 'United States');

-- --------------------------------------------------------

--
-- Stand-in structure for view `customer_purchased_product`
--
CREATE TABLE IF NOT EXISTS `customer_purchased_product` (
`Product_ID` bigint(20) unsigned
,`Product_Condition_ID` bigint(20) unsigned
,`Country_ID` bigint(20) unsigned
,`TotalQty` decimal(32,0)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `customer_returned_product`
--
CREATE TABLE IF NOT EXISTS `customer_returned_product` (
`Product_ID` bigint(20) unsigned
,`Product_Condition_ID` bigint(20) unsigned
,`Country_ID` bigint(20) unsigned
,`TotalQty` decimal(32,0)
);
-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE IF NOT EXISTS `department` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores a list of departments in the company. ' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `department_job`
--

CREATE TABLE IF NOT EXISTS `department_job` (
  `job_id` bigint(20) unsigned NOT NULL,
  `department_id` bigint(20) unsigned NOT NULL,
  KEY `job_id_fk3` (`job_id`),
  KEY `department_id_fk` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='maps jobs to their departments.';

-- --------------------------------------------------------

--
-- Table structure for table `employee_branch_history`
--

CREATE TABLE IF NOT EXISTS `employee_branch_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `reason_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id_fk3` (`person_id`),
  KEY `branch_id_fk1` (`branch_id`),
  KEY `reason_id_branchhist` (`reason_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores the start date of an employee branch history entry.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_clock`
--

CREATE TABLE IF NOT EXISTS `employee_clock` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clock_in` datetime NOT NULL,
  `clock_out` datetime NOT NULL,
  `person_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id_fk6543` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_reimbursement`
--

CREATE TABLE IF NOT EXISTS `employee_reimbursement` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) unsigned NOT NULL,
  `fromdate` date NOT NULL,
  `extraamount` float NOT NULL,
  `paymenthash` text NOT NULL,
  `reason_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_reimburse` (`person_id`),
  KEY `reason_reimburse_idx` (`reason_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `float_facet`
--

CREATE TABLE IF NOT EXISTS `float_facet` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `min` float DEFAULT NULL,
  `max` float DEFAULT NULL,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores floating-point facets ' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `float_facet_value`
--

CREATE TABLE IF NOT EXISTS `float_facet_value` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `float_facet_id` bigint(20) unsigned NOT NULL,
  `value` float NOT NULL,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `float_facet_value_idx` (`float_facet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `float_facet_value_product`
--

CREATE TABLE IF NOT EXISTS `float_facet_value_product` (
  `product_id` bigint(20) unsigned NOT NULL,
  `float_facet_value_id` bigint(20) unsigned NOT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `facets` (`float_facet_value_id`),
  KEY `float_facet_product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='maps products to the values of their float facets. ' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `float_facet_value_vehicle`
--

CREATE TABLE IF NOT EXISTS `float_facet_value_vehicle` (
  `float_facet_value_id` bigint(20) unsigned NOT NULL,
  `vehicle_id` bigint(20) unsigned NOT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `float_facet_id_fk4567` (`float_facet_value_id`),
  KEY `float_facet_vehicle` (`vehicle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='habtm - float facets and vehicles' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `held_product`
--
CREATE TABLE IF NOT EXISTS `held_product` (
`Product_ID` bigint(20) unsigned
,`Product_Condition_ID` bigint(20) unsigned
,`Country_ID` bigint(20) unsigned
,`TotalQty` decimal(33,0)
);
-- --------------------------------------------------------

--
-- Table structure for table `int_facet`
--

CREATE TABLE IF NOT EXISTS `int_facet` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `max` int(11) DEFAULT NULL,
  `min` int(11) DEFAULT NULL,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `int_facet`
--

INSERT INTO `int_facet` (`id`, `max`, `min`, `name`, `description`) VALUES
(1, NULL, NULL, 'FirstFacet', 'TestFacet');

-- --------------------------------------------------------

--
-- Table structure for table `int_facet_value`
--

CREATE TABLE IF NOT EXISTS `int_facet_value` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `int_facet_id` bigint(20) unsigned NOT NULL,
  `value` int(11) NOT NULL,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `int_facet_value_idx` (`int_facet_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `int_facet_value`
--

INSERT INTO `int_facet_value` (`id`, `int_facet_id`, `value`, `name`) VALUES
(1, 1, 3, ''),
(2, 1, 4, ''),
(3, 1, 6, '');

-- --------------------------------------------------------

--
-- Table structure for table `int_facet_value_product`
--

CREATE TABLE IF NOT EXISTS `int_facet_value_product` (
  `product_id` bigint(20) unsigned NOT NULL,
  `int_facet_value_id` bigint(20) unsigned NOT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `facets` (`int_facet_value_id`),
  KEY `int_facet_product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='maps products to the values of their int facets. ' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `int_facet_value_vehicle`
--

CREATE TABLE IF NOT EXISTS `int_facet_value_vehicle` (
  `int_facet_value_id` bigint(20) unsigned NOT NULL,
  `vehicle_id` bigint(20) unsigned NOT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `int_facet_id_fk4567` (`int_facet_value_id`),
  KEY `int_facet_vehicle` (`vehicle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='habtm - int facets and vehicles' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `job`
--

CREATE TABLE IF NOT EXISTS `job` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='includes name and description for all jobs' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `job`
--

INSERT INTO `job` (`id`, `name`, `description`) VALUES
(1, 'Database Admin', 'DBAdmin');

-- --------------------------------------------------------

--
-- Table structure for table `job_pay`
--

CREATE TABLE IF NOT EXISTS `job_pay` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `job_id` bigint(20) unsigned NOT NULL,
  `pays` float NOT NULL,
  `pay_rate_denom` bigint(20) unsigned NOT NULL,
  `pay_period` bigint(20) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `job_id_fk4` (`job_id`),
  KEY `pay_period_fk2` (`pay_period`),
  KEY `pay_rate_fk2` (`pay_rate_denom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores the base pay for a job, if pay is not overwritten at  /* comment truncated */ /*a particular branch.*/' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `job_posting`
--

CREATE TABLE IF NOT EXISTS `job_posting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `job_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `date_created` date NOT NULL,
  `person_id` bigint(20) unsigned NOT NULL,
  `quantity` int(11) NOT NULL,
  `additional_info` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `job_id_fk4537` (`job_id`),
  KEY `branch_id_fk4537` (`branch_id`),
  KEY `person_id_fk4537` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `job_posting_filling`
--

CREATE TABLE IF NOT EXISTS `job_posting_filling` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `job_posting_id` bigint(20) unsigned NOT NULL,
  `filled_date` date NOT NULL,
  `person_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id_fk300` (`person_id`),
  KEY `posting` (`job_posting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `job_role`
--

CREATE TABLE IF NOT EXISTS `job_role` (
  `job_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `job_id_fk5` (`job_id`),
  KEY `role_id_fk554433` (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the roles associated with each job.' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `job_role`
--

INSERT INTO `job_role` (`job_id`, `role_id`, `id`) VALUES
(1, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `make`
--

CREATE TABLE IF NOT EXISTS `make` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `manufacturer_id` bigint(20) unsigned NOT NULL,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  `email` tinytext NOT NULL,
  `website` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `make_mfr_idx` (`manufacturer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `make`
--

INSERT INTO `make` (`id`, `manufacturer_id`, `name`, `description`, `email`, `website`) VALUES
(2, 1, 'Acme ', 'A Sled with a Rocket Strapped to it', 'acme@acme.com', 'acme.com');

-- --------------------------------------------------------

--
-- Table structure for table `manufacturer`
--

CREATE TABLE IF NOT EXISTS `manufacturer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` text NOT NULL,
  `street_no` tinytext NOT NULL,
  `street_name` tinytext NOT NULL,
  `city` tinytext NOT NULL,
  `state_id` bigint(20) unsigned NOT NULL,
  `postcode` tinytext NOT NULL,
  `po_box` tinytext,
  `phone_number` tinytext NOT NULL,
  `email_address` tinytext NOT NULL,
  `website` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `manufacturer_state_idx` (`state_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='prov_ides information on manufacturers. ' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `manufacturer`
--

INSERT INTO `manufacturer` (`id`, `name`, `description`, `street_no`, `street_name`, `city`, `state_id`, `postcode`, `po_box`, `phone_number`, `email_address`, `website`) VALUES
(1, 'Acme Corp', 'A great manufacturer!', '888', 'Example Rd', 'Anytown', 4, '92456', NULL, '1234567890', 'sales@acme.com', 'www.acmecorp.example.com'),
(2, 'Ajax Corp', 'Another great manufacturer!', '234', 'Test St', 'Anyville', 23, '71234', NULL, '1234567890', 'sales@ajax.com', 'www.ajaxcorp.example.com');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE IF NOT EXISTS `order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `order_date` date NOT NULL,
  `is_cod` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id_fk6` (`person_id`),
  KEY `branch_id_fk3` (`branch_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the customer, branch, and order number for each order /* comment truncated */ /*. */' AUTO_INCREMENT=13 ;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`id`, `person_id`, `branch_id`, `order_date`, `is_cod`) VALUES
(6, 21, NULL, '2013-11-26', 1),
(7, 21, NULL, '2013-11-27', 1),
(8, 21, NULL, '2013-11-27', 1),
(9, 21, NULL, '2013-11-27', 0),
(10, 21, NULL, '2013-11-27', 0),
(11, 21, NULL, '2013-11-27', 0),
(12, 21, NULL, '2013-11-27', 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_cancellation`
--

CREATE TABLE IF NOT EXISTS `order_cancellation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `reason_id` bigint(20) unsigned NOT NULL,
  `cancellation_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id_fk2` (`order_id`),
  KEY `reason_cancellation` (`reason_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores all cancelled orders. ' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `order_product`
--

CREATE TABLE IF NOT EXISTS `order_product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `product_condition_id` bigint(20) unsigned NOT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id_fk3` (`order_id`),
  KEY `product_id_fk9` (`product_id`),
  KEY `order_cond_fk123_idx` (`product_condition_id`),
  KEY `order_country_fk123_idx` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the products sold for an order. ' AUTO_INCREMENT=8 ;

--
-- Dumping data for table `order_product`
--

INSERT INTO `order_product` (`id`, `order_id`, `product_id`, `product_condition_id`, `country_id`, `quantity`) VALUES
(4, 6, 1, 1, 1, 4),
(5, 6, 3, 1, 1, 1),
(6, 7, 3, 1, 1, 1),
(7, 8, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `order_return`
--

CREATE TABLE IF NOT EXISTS `order_return` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `person_id` bigint(20) unsigned NOT NULL,
  `return_date` datetime NOT NULL,
  `reason_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `branch_id_fk1_morerandomtext1` (`branch_id`),
  KEY `order_id_fk14578967` (`order_id`),
  KEY `return_reason_idx` (`reason_id`),
  KEY `employee_processing_return_idx` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='maps returns to their associated orders and to the associate /* comment truncated */ /*s that processed the return. */' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `order_return_product`
--

CREATE TABLE IF NOT EXISTS `order_return_product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_return_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `product_condition_id` bigint(20) unsigned NOT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id_fk34` (`product_id`),
  KEY `return1` (`order_return_id`),
  KEY `ret_country_fk124_idx` (`country_id`),
  KEY `ret_cond_fk123_idx` (`product_condition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='maps the products returned to the return event. ' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `order_shipping`
--

CREATE TABLE IF NOT EXISTS `order_shipping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `shipping_date` date NOT NULL,
  `shipping_tracking` tinytext NOT NULL,
  `shipping_rate` float unsigned NOT NULL,
  `shipping_method` tinytext NOT NULL,
  `person_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `shipping_order_idx` (`order_id`),
  KEY `employee_shipping_idx` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `password_hash`
--

CREATE TABLE IF NOT EXISTS `password_hash` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `hash` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id_fk5` (`person_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `password_hash`
--

INSERT INTO `password_hash` (`id`, `person_id`, `start_date`, `end_date`, `hash`) VALUES
(11, 21, '2013-11-26', NULL, '$2y$10$JkaKQE0NgeEr0z2eS4dzlO3PmAPNOD59ZJYfwzYx3Pyo2/dSJjpN2'),
(12, 22, '2013-11-26', NULL, '$2y$10$0yCmRX5S5ZKpzlBDrhwid.5vadFM.P9fK7M6G1E5JIahkQSPhZz2O');

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE IF NOT EXISTS `person` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `middle_name` text,
  `dob` date NOT NULL,
  `street_no` tinytext,
  `street_name` tinytext,
  `apt_or_suite_no` tinytext,
  `city` tinytext,
  `state_id` bigint(20) unsigned NOT NULL,
  `postcode` tinytext,
  `po_box` tinytext,
  `email` tinytext NOT NULL,
  `website` text,
  `branch_id` bigint(20) unsigned NOT NULL,
  `vehicle_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_state_idx` (`state_id`),
  KEY `branch_id_idx` (`branch_id`),
  KEY `person_vehicle_idx` (`vehicle_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`id`, `first_name`, `last_name`, `middle_name`, `dob`, `street_no`, `street_name`, `apt_or_suite_no`, `city`, `state_id`, `postcode`, `po_box`, `email`, `website`, `branch_id`, `vehicle_id`) VALUES
(21, 'a', 'a', NULL, '1991-01-01', '404', 'Fake Street', '404', 'Denton', 43, '44444', NULL, 'a@a.com', NULL, 1, 7),
(22, 'c', 'c', NULL, '1991-01-01', '404', 'Fake Street', '404', 'Montgomery', 1, '36101', NULL, 'c@c.com', NULL, 1, 7);

-- --------------------------------------------------------

--
-- Table structure for table `processing_type`
--

CREATE TABLE IF NOT EXISTS `processing_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `manufacturer_id` bigint(20) unsigned NOT NULL,
  `length_meters` float unsigned NOT NULL,
  `width_meters` float unsigned NOT NULL,
  `height_meters` float unsigned NOT NULL,
  `weight_kilograms` float unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `barcode` tinytext NOT NULL,
  `product_category_id` bigint(20) unsigned NOT NULL,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `manufacturer_id_fk` (`manufacturer_id`),
  KEY `category` (`product_category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='keeps a list of all products in stores. ' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `manufacturer_id`, `length_meters`, `width_meters`, `height_meters`, `weight_kilograms`, `start_date`, `end_date`, `barcode`, `product_category_id`, `name`, `description`) VALUES
(1, 1, 0.3333, 0.33, 0.33, 12, '2013-11-01', NULL, '765253835203', 2, 'Battery Mark 1', 'A good battery'),
(2, 2, 0.3333, 0.33, 0.33, 12, '2013-11-01', NULL, '765253835204', 2, 'Battery Mark 2', 'Another good battery'),
(3, 1, 0.33333, 0.33, 0.33, 12, '2013-11-01', NULL, '765253835303', 3, 'Oil Mark 1', 'A good oil'),
(4, 2, 0.33333, 0.33, 0.33, 10, '2013-11-01', NULL, '765253845203', 3, 'Oil Mark 2', 'Another good oil'),
(5, 1, 21, 21, 21, 21, '2013-11-25', NULL, '19284739176', 3, 'Oil of Speed', 'The oil that makes you go faster.');

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE IF NOT EXISTS `product_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='prov_ides a pseudo-directory tree for each product using two  /* comment truncated */ /*columns. a product category can have many children but only one parent. */' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`id`, `name`, `description`) VALUES
(1, 'first category', 'first category'),
(2, 'batteries', 'batteries'),
(3, 'oil', 'oil');

-- --------------------------------------------------------

--
-- Table structure for table `product_condition`
--

CREATE TABLE IF NOT EXISTS `product_condition` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `product_condition`
--

INSERT INTO `product_condition` (`id`, `name`, `description`) VALUES
(1, 'New', ''),
(2, 'Used', '');

-- --------------------------------------------------------

--
-- Table structure for table `product_price`
--

CREATE TABLE IF NOT EXISTS `product_price` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `price` float NOT NULL,
  `end_date` date DEFAULT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `condition_id` bigint(20) unsigned NOT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `price_product_product_idx` (`product_id`),
  KEY `price_product_condition_idx` (`condition_id`),
  KEY `price_product_country_idx` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `product_price`
--

INSERT INTO `product_price` (`id`, `start_date`, `price`, `end_date`, `product_id`, `condition_id`, `country_id`) VALUES
(1, '0000-00-00', 42, NULL, 1, 1, 1),
(2, '0000-00-00', 21, NULL, 2, 1, 1),
(3, '0000-00-00', 42, NULL, 3, 1, 1),
(4, '0000-00-00', 15, NULL, 4, 1, 1),
(5, '0000-00-00', 10, NULL, 5, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_string_facet_value`
--

CREATE TABLE IF NOT EXISTS `product_string_facet_value` (
  `product_id` bigint(20) unsigned NOT NULL,
  `string_facet_value_id` bigint(20) unsigned NOT NULL,
  KEY `facet_fk` (`string_facet_value_id`),
  KEY `product_id_fk6` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores string facet values of products. ';

-- --------------------------------------------------------

--
-- Table structure for table `product_vehicle`
--

CREATE TABLE IF NOT EXISTS `product_vehicle` (
  `product_id` bigint(20) unsigned NOT NULL,
  `vehicle_id` bigint(20) unsigned NOT NULL,
  KEY `vehicle_id_fk` (`vehicle_id`),
  KEY `product_id_fk3` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='keeps track of the vehicles that go with each product (if it cannot simply work on all of them)';

--
-- Dumping data for table `product_vehicle`
--

INSERT INTO `product_vehicle` (`product_id`, `vehicle_id`) VALUES
(1, 7);

-- --------------------------------------------------------

--
-- Table structure for table `reason`
--

CREATE TABLE IF NOT EXISTS `reason` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `reason`
--

INSERT INTO `reason` (`id`, `name`, `description`) VALUES
(1, 'Employment', '');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE IF NOT EXISTS `role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the names and descriptions of all roles. ' AUTO_INCREMENT=6 ;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`, `description`) VALUES
(1, 'Admin', 'Administrator');

-- --------------------------------------------------------

--
-- Table structure for table `role_permission`
--

CREATE TABLE IF NOT EXISTS `role_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned NOT NULL,
  `table_name` varchar(45) NOT NULL,
  `can_read` tinyint(1) NOT NULL,
  `can_add` tinyint(1) NOT NULL,
  `can_modify` tinyint(1) NOT NULL,
  `can_delete` tinyint(1) NOT NULL,
  `can_grant_add` tinyint(1) NOT NULL,
  `can_grant_modify` tinyint(1) NOT NULL,
  `can_grant_delete` tinyint(1) NOT NULL,
  `can_grant_read` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `roleconstraint_1234566` (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the specific permissions associated with each role. p /* comment truncated */ /*ermissions include:\n_read\n_add\n_modify\n_delete \n_xown - you can only exercise right x on your own rows\n_grant y - you can give others right y. */' AUTO_INCREMENT=12 ;

--
-- Dumping data for table `role_permission`
--

INSERT INTO `role_permission` (`id`, `role_id`, `table_name`, `can_read`, `can_add`, `can_modify`, `can_delete`, `can_grant_add`, `can_grant_modify`, `can_grant_delete`, `can_grant_read`) VALUES
(1, 1, 'product', 1, 1, 1, 1, 1, 1, 1, 1),
(2, 1, 'order', 1, 1, 1, 1, 1, 1, 1, 1),
(3, 1, 'product_price', 1, 1, 1, 1, 1, 1, 1, 1),
(4, 1, 'role', 1, 1, 1, 1, 1, 1, 1, 1),
(5, 1, 'role_permission', 1, 1, 1, 1, 1, 1, 1, 1),
(6, 1, 'order_shipping', 1, 1, 1, 1, 1, 1, 1, 1),
(7, 1, 'job', 1, 1, 1, 1, 1, 1, 1, 1),
(8, 1, 'job_role', 1, 1, 1, 1, 1, 1, 1, 1),
(9, 1, 'manufacturer', 1, 1, 1, 1, 1, 1, 1, 1),
(10, 1, 'work_history', 1, 1, 1, 1, 1, 1, 1, 1),
(11, 1, 'person', 1, 1, 1, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `sf_config`
--

CREATE TABLE IF NOT EXISTS `sf_config` (
  `sf_id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `sf_table` varchar(64) NOT NULL DEFAULT '',
  `sf_field` varchar(64) NOT NULL DEFAULT '',
  `sf_type` varchar(16) DEFAULT 'default',
  `sf_related` varchar(100) DEFAULT '',
  `sf_label` varchar(64) DEFAULT '',
  `sf_desc` tinytext,
  `sf_order` int(3) DEFAULT NULL,
  `sf_hidden` int(1) DEFAULT '0',
  PRIMARY KEY (`sf_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=402 ;

--
-- Dumping data for table `sf_config`
--

INSERT INTO `sf_config` (`sf_id`, `sf_table`, `sf_field`, `sf_type`, `sf_related`, `sf_label`, `sf_desc`, `sf_order`, `sf_hidden`) VALUES
(1, 'bool_facet', 'id', 'default', '', '', NULL, NULL, 0),
(2, 'bool_facet', 'name', 'default', '', '', NULL, NULL, 0),
(3, 'bool_facet', 'description', 'default', '', '', NULL, NULL, 0),
(4, 'bool_facet_value', 'id', 'default', '', '', NULL, NULL, 0),
(5, 'bool_facet_value', 'bool_facet_id', 'default', '', '', NULL, NULL, 0),
(6, 'bool_facet_value', 'value', 'default', '', '', NULL, NULL, 0),
(7, 'bool_facet_value_product', 'product_id', 'default', '', '', NULL, NULL, 0),
(8, 'bool_facet_value_product', 'bool_facet_value_id', 'default', '', '', NULL, NULL, 0),
(9, 'bool_facet_value_vehicle', 'bool_facet_value_id', 'default', '', '', NULL, NULL, 0),
(10, 'bool_facet_value_vehicle', 'vehicle_id', 'default', '', '', NULL, NULL, 0),
(11, 'branch', 'id', 'default', '', '', NULL, NULL, 0),
(12, 'branch', 'streetno', 'default', '', '', NULL, NULL, 0),
(13, 'branch', 'streetname', 'default', '', '', NULL, NULL, 0),
(14, 'branch', 'city', 'default', '', '', NULL, NULL, 0),
(15, 'branch', 'state', 'default', '', '', NULL, NULL, 0),
(16, 'branch', 'postcode', 'default', '', '', NULL, NULL, 0),
(17, 'branch', 'latitude', 'default', '', '', NULL, NULL, 0),
(18, 'branch', 'longitude', 'default', '', '', NULL, NULL, 0),
(19, 'branch', 'pobox', 'default', '', '', NULL, NULL, 0),
(20, 'branch', 'name', 'default', '', '', NULL, NULL, 0),
(21, 'branch', 'description', 'default', '', '', NULL, NULL, 0),
(22, 'branch', 'email', 'default', '', '', NULL, NULL, 0),
(23, 'branch_inventory_received_date', 'id', 'default', '', '', NULL, NULL, 0),
(24, 'branch_inventory_received_date', 'branch_inventory_request_id', 'default', '', '', NULL, NULL, 0),
(25, 'branch_inventory_received_date', 'received_date', 'default', '', '', NULL, NULL, 0),
(26, 'branch_inventory_received_date', 'product_id', 'default', '', '', NULL, NULL, 0),
(27, 'branch_inventory_received_date', 'product_condition_id', 'default', '', '', NULL, NULL, 0),
(28, 'branch_inventory_received_date', 'country_id', 'default', '', '', NULL, NULL, 0),
(29, 'branch_inventory_received_date', 'quantity', 'default', '', '', NULL, NULL, 0),
(30, 'branch_inventory_received_date', 'person_id', 'default', '', '', NULL, NULL, 0),
(31, 'branch_inventory_request', 'id', 'default', '', '', NULL, NULL, 0),
(32, 'branch_inventory_request', 'branch_id', 'default', '', '', NULL, NULL, 0),
(33, 'branch_inventory_request', 'order_date', 'default', '', '', NULL, NULL, 0),
(34, 'branch_inventory_request', 'person_id', 'default', '', '', NULL, NULL, 0),
(35, 'branch_inventory_request', 'extra_fees', 'default', '', '', NULL, NULL, 0),
(36, 'branch_inventory_request', 'vendor_id', 'default', '', '', NULL, NULL, 0),
(37, 'branch_inventory_request_product', 'id', 'default', '', '', NULL, NULL, 0),
(38, 'branch_inventory_request_product', 'branch_inventory_request_id', 'default', '', '', NULL, NULL, 0),
(39, 'branch_inventory_request_product', 'product_id', 'default', '', '', NULL, NULL, 0),
(40, 'branch_inventory_request_product', 'product_condition_id', 'default', '', '', NULL, NULL, 0),
(41, 'branch_inventory_request_product', 'country_id', 'default', '', '', NULL, NULL, 0),
(42, 'branch_inventory_request_product', 'quantity', 'default', '', '', NULL, NULL, 0),
(43, 'branch_inventory_return', 'id', 'default', '', '', NULL, NULL, 0),
(44, 'branch_inventory_return', 'branch_inventory_request_id', 'default', '', '', NULL, NULL, 0),
(45, 'branch_inventory_return', 'person_id', 'default', '', '', NULL, NULL, 0),
(46, 'branch_inventory_return', 'return_date', 'default', '', '', NULL, NULL, 0),
(47, 'branch_inventory_return', 'reason_id', 'default', '', '', NULL, NULL, 0),
(48, 'branch_inventory_return_product', 'id', 'default', '', '', NULL, NULL, 0),
(49, 'branch_inventory_return_product', 'branch_inventory_return_id', 'default', '', '', NULL, NULL, 0),
(50, 'branch_inventory_return_product', 'product_id', 'default', '', '', NULL, NULL, 0),
(51, 'branch_inventory_return_product', 'product_condition_id', 'default', '', '', NULL, NULL, 0),
(52, 'branch_inventory_return_product', 'country_id', 'default', '', '', NULL, NULL, 0),
(53, 'branch_inventory_return_product', 'quantity', 'default', '', '', NULL, NULL, 0),
(54, 'branch_received_product', 'Product_ID', 'default', '', '', NULL, NULL, 0),
(55, 'branch_received_product', 'product_condition_ID', 'default', '', '', NULL, NULL, 0),
(56, 'branch_received_product', 'Country_ID', 'default', '', '', NULL, NULL, 0),
(57, 'branch_received_product', 'TotalQty', 'default', '', '', NULL, NULL, 0),
(58, 'branch_returned_product', 'Product_ID', 'default', '', '', NULL, NULL, 0),
(59, 'branch_returned_product', 'product_Condition_ID', 'default', '', '', NULL, NULL, 0),
(60, 'branch_returned_product', 'Country_ID', 'default', '', '', NULL, NULL, 0),
(61, 'branch_returned_product', 'TotalQty', 'default', '', '', NULL, NULL, 0),
(62, 'cash_payment', 'id', 'default', '', '', NULL, NULL, 0),
(63, 'cash_payment', 'order_id', 'default', '', '', NULL, NULL, 0),
(64, 'cash_payment', 'amount', 'default', '', '', NULL, NULL, 0),
(65, 'cash_payment', 'date', 'default', '', '', NULL, NULL, 0),
(66, 'cc_payment', 'id', 'default', '', '', NULL, NULL, 0),
(67, 'cc_payment', 'order_id', 'default', '', '', NULL, NULL, 0),
(68, 'cc_payment', 'transaction_hash', 'default', '', '', NULL, NULL, 0),
(69, 'cc_payment', 'amount', 'default', '', '', NULL, NULL, 0),
(70, 'cc_payment', 'date', 'default', '', '', NULL, NULL, 0),
(71, 'check_payment', 'id', 'default', '', '', NULL, NULL, 0),
(72, 'check_payment', 'order_id', 'default', '', '', NULL, NULL, 0),
(73, 'check_payment', 'transaction_hash', 'default', '', '', NULL, NULL, 0),
(74, 'check_payment', 'date', 'default', '', '', NULL, NULL, 0),
(75, 'check_payment', 'amount', 'default', '', '', NULL, NULL, 0),
(76, 'ci_session', 'session_id', 'default', '', '', NULL, NULL, 0),
(77, 'ci_session', 'ip_address', 'default', '', '', NULL, NULL, 0),
(78, 'ci_session', 'user_agent', 'default', '', '', NULL, NULL, 0),
(79, 'ci_session', 'last_activity', 'default', '', '', NULL, NULL, 0),
(80, 'ci_session', 'user_data', 'default', '', '', NULL, NULL, 0),
(81, 'country', 'id', 'default', '', '', NULL, NULL, 0),
(82, 'country', 'currency', 'default', '', '', NULL, NULL, 0),
(83, 'country', 'two_letter_code', 'default', '', '', NULL, NULL, 0),
(84, 'country', 'three_letter_code', 'default', '', '', NULL, NULL, 0),
(85, 'country', 'name', 'default', '', '', NULL, NULL, 0),
(86, 'customer_purchased_product', 'Product_ID', 'default', '', '', NULL, NULL, 0),
(87, 'customer_purchased_product', 'Product_Condition_ID', 'default', '', '', NULL, NULL, 0),
(88, 'customer_purchased_product', 'Country_ID', 'default', '', '', NULL, NULL, 0),
(89, 'customer_purchased_product', 'TotalQty', 'default', '', '', NULL, NULL, 0),
(90, 'customer_returned_product', 'Product_ID', 'default', '', '', NULL, NULL, 0),
(91, 'customer_returned_product', 'Product_Condition_ID', 'default', '', '', NULL, NULL, 0),
(92, 'customer_returned_product', 'Country_ID', 'default', '', '', NULL, NULL, 0),
(93, 'customer_returned_product', 'TotalQty', 'default', '', '', NULL, NULL, 0),
(94, 'department', 'id', 'default', '', '', NULL, NULL, 0),
(95, 'department', 'name', 'default', '', '', NULL, NULL, 0),
(96, 'department', 'description', 'default', '', '', NULL, NULL, 0),
(97, 'department_job', 'job_id', 'default', '', '', NULL, NULL, 0),
(98, 'department_job', 'department_id', 'default', '', '', NULL, NULL, 0),
(99, 'employee_branch_history', 'id', 'default', '', '', NULL, NULL, 0),
(100, 'employee_branch_history', 'person_id', 'default', '', '', NULL, NULL, 0),
(101, 'employee_branch_history', 'branch_id', 'default', '', '', NULL, NULL, 0),
(102, 'employee_branch_history', 'start_date', 'default', '', '', NULL, NULL, 0),
(103, 'employee_branch_history', 'end_date', 'default', '', '', NULL, NULL, 0),
(104, 'employee_branch_history', 'reason_id', 'default', '', '', NULL, NULL, 0),
(105, 'employee_clock', 'id', 'default', '', '', NULL, NULL, 0),
(106, 'employee_clock', 'clock_in', 'default', '', '', NULL, NULL, 0),
(107, 'employee_clock', 'clock_out', 'default', '', '', NULL, NULL, 0),
(108, 'employee_clock', 'person_id', 'default', '', '', NULL, NULL, 0),
(109, 'employee_reimbursement', 'id', 'default', '', '', NULL, NULL, 0),
(110, 'employee_reimbursement', 'person_id', 'default', '', '', NULL, NULL, 0),
(111, 'employee_reimbursement', 'fromdate', 'default', '', '', NULL, NULL, 0),
(112, 'employee_reimbursement', 'extraamount', 'default', '', '', NULL, NULL, 0),
(113, 'employee_reimbursement', 'paymenthash', 'default', '', '', NULL, NULL, 0),
(114, 'employee_reimbursement', 'reason_id', 'default', '', '', NULL, NULL, 0),
(115, 'float_facet', 'id', 'default', '', '', NULL, NULL, 0),
(116, 'float_facet', 'min', 'default', '', '', NULL, NULL, 0),
(117, 'float_facet', 'max', 'default', '', '', NULL, NULL, 0),
(118, 'float_facet', 'name', 'default', '', '', NULL, NULL, 0),
(119, 'float_facet', 'description', 'default', '', '', NULL, NULL, 0),
(120, 'float_facet_value', 'id', 'default', '', '', NULL, NULL, 0),
(121, 'float_facet_value', 'float_facet_id', 'default', '', '', NULL, NULL, 0),
(122, 'float_facet_value', 'value', 'default', '', '', NULL, NULL, 0),
(123, 'float_facet_value_product', 'product_id', 'default', '', '', NULL, NULL, 0),
(124, 'float_facet_value_product', 'float_facet_value_id', 'default', '', '', NULL, NULL, 0),
(125, 'float_facet_value_vehicle', 'float_facet_value_id', 'default', '', '', NULL, NULL, 0),
(126, 'float_facet_value_vehicle', 'vehicle_id', 'default', '', '', NULL, NULL, 0),
(127, 'gc_increase', 'id', 'default', '', '', NULL, NULL, 0),
(128, 'gc_increase', 'gift_card_id', 'default', '', '', NULL, NULL, 0),
(129, 'gc_increase', 'amount', 'default', '', '', NULL, NULL, 0),
(130, 'gc_increase', 'date', 'default', '', '', NULL, NULL, 0),
(131, 'gc_increase', 'order_id', 'default', '', '', NULL, NULL, 0),
(132, 'gc_payment', 'id', 'default', '', '', NULL, NULL, 0),
(133, 'gc_payment', 'order_id', 'default', '', '', NULL, NULL, 0),
(134, 'gc_payment', 'gift_card_id', 'default', '', '', NULL, NULL, 0),
(135, 'gc_payment', 'amt', 'default', '', '', NULL, NULL, 0),
(136, 'gift_card', 'id', 'default', '', '', NULL, NULL, 0),
(137, 'gift_card', 'person_id', 'default', '', '', NULL, NULL, 0),
(138, 'held_product', 'Product_ID', 'default', '', '', NULL, NULL, 0),
(139, 'held_product', 'Product_Condition_ID', 'default', '', '', NULL, NULL, 0),
(140, 'held_product', 'Country_ID', 'default', '', '', NULL, NULL, 0),
(141, 'held_product', 'TotalQty', 'default', '', '', NULL, NULL, 0),
(142, 'int_facet', 'id', 'default', '', '', NULL, NULL, 0),
(143, 'int_facet', 'max', 'default', '', '', NULL, NULL, 0),
(144, 'int_facet', 'min', 'default', '', '', NULL, NULL, 0),
(145, 'int_facet', 'name', 'default', '', '', NULL, NULL, 0),
(146, 'int_facet', 'description', 'default', '', '', NULL, NULL, 0),
(147, 'int_facet_value', 'id', 'default', '', '', NULL, NULL, 0),
(148, 'int_facet_value', 'int_facet_id', 'default', '', '', NULL, NULL, 0),
(149, 'int_facet_value', 'value', 'default', '', '', NULL, NULL, 0),
(150, 'int_facet_value_product', 'product_id', 'default', '', '', NULL, NULL, 0),
(151, 'int_facet_value_product', 'int_facet_value_id', 'default', '', '', NULL, NULL, 0),
(152, 'int_facet_value_vehicle', 'int_facet_value_id', 'default', '', '', NULL, NULL, 0),
(153, 'int_facet_value_vehicle', 'vehicle_id', 'default', '', '', NULL, NULL, 0),
(154, 'job', 'id', 'default', '', '', NULL, NULL, 0),
(155, 'job', 'name', 'default', '', '', NULL, NULL, 0),
(156, 'job', 'description', 'default', '', '', NULL, NULL, 0),
(157, 'job_pay', 'id', 'default', '', '', NULL, NULL, 0),
(158, 'job_pay', 'job_id', 'default', '', '', NULL, NULL, 0),
(159, 'job_pay', 'pays', 'default', '', '', NULL, NULL, 0),
(160, 'job_pay', 'pay_rate_denom', 'default', '', '', NULL, NULL, 0),
(161, 'job_pay', 'pay_period', 'default', '', '', NULL, NULL, 0),
(162, 'job_pay', 'start_date', 'default', '', '', NULL, NULL, 0),
(163, 'job_pay', 'end_date', 'default', '', '', NULL, NULL, 0),
(164, 'job_posting', 'id', 'default', '', '', NULL, NULL, 0),
(165, 'job_posting', 'job_id', 'default', '', '', NULL, NULL, 0),
(166, 'job_posting', 'branch_id', 'default', '', '', NULL, NULL, 0),
(167, 'job_posting', 'date_created', 'default', '', '', NULL, NULL, 0),
(168, 'job_posting', 'person_id', 'default', '', '', NULL, NULL, 0),
(169, 'job_posting', 'quantity', 'default', '', '', NULL, NULL, 0),
(170, 'job_posting', 'additional_info', 'default', '', '', NULL, NULL, 0),
(171, 'job_posting_filling', 'id', 'default', '', '', NULL, NULL, 0),
(172, 'job_posting_filling', 'job_posting_id', 'default', '', '', NULL, NULL, 0),
(173, 'job_posting_filling', 'filled_date', 'default', '', '', NULL, NULL, 0),
(174, 'job_posting_filling', 'person_id', 'default', '', '', NULL, NULL, 0),
(175, 'job_role', 'job_id', 'default', '', '', NULL, NULL, 0),
(176, 'job_role', 'role_id', 'default', '', '', NULL, NULL, 0),
(177, 'make', 'id', 'default', '', '', NULL, NULL, 0),
(178, 'make', 'manufacturer_id', 'default', '', '', NULL, NULL, 0),
(179, 'make', 'name', 'default', '', '', NULL, NULL, 0),
(180, 'make', 'description', 'default', '', '', NULL, NULL, 0),
(181, 'make', 'street_no', 'default', '', '', NULL, NULL, 0),
(182, 'make', 'street_name', 'default', '', '', NULL, NULL, 0),
(183, 'make', 'city', 'default', '', '', NULL, NULL, 0),
(184, 'make', 'state_id', 'default', '', '', NULL, NULL, 0),
(185, 'make', 'postcode', 'default', '', '', NULL, NULL, 0),
(186, 'make', 'po_box', 'default', '', '', NULL, NULL, 0),
(187, 'make', 'email', 'default', '', '', NULL, NULL, 0),
(188, 'make', 'website', 'default', '', '', NULL, NULL, 0),
(189, 'manufacturer', 'id', 'default', '', '', NULL, NULL, 0),
(190, 'manufacturer', 'name', 'default', '', '', NULL, NULL, 0),
(191, 'manufacturer', 'description', 'default', '', '', NULL, NULL, 0),
(192, 'manufacturer', 'street_no', 'default', '', '', NULL, NULL, 0),
(193, 'manufacturer', 'street_name', 'default', '', '', NULL, NULL, 0),
(194, 'manufacturer', 'city', 'default', '', '', NULL, NULL, 0),
(195, 'manufacturer', 'state_id', 'default', '', '', NULL, NULL, 0),
(196, 'manufacturer', 'postcode', 'default', '', '', NULL, NULL, 0),
(197, 'manufacturer', 'po_box', 'default', '', '', NULL, NULL, 0),
(198, 'manufacturer', 'phone_number', 'default', '', '', NULL, NULL, 0),
(199, 'manufacturer', 'email_address', 'default', '', '', NULL, NULL, 0),
(200, 'manufacturer', 'website', 'default', '', '', NULL, NULL, 0),
(201, 'order', 'id', 'default', '', '', NULL, NULL, 0),
(202, 'order', 'person_id', 'default', '', '', NULL, NULL, 0),
(203, 'order', 'branch_id', 'default', '', '', NULL, NULL, 0),
(204, 'order', 'order_date', 'default', '', '', NULL, NULL, 0),
(205, 'order', 'shipping_tracking', 'default', '', '', NULL, NULL, 0),
(206, 'order', 'shipping_cost', 'default', '', '', NULL, NULL, 0),
(207, 'order', 'address_id', 'default', '', '', NULL, NULL, 0),
(208, 'order', 'number_payments', 'default', '', '', NULL, NULL, 0),
(209, 'order', 'time_period_id', 'default', '', '', NULL, NULL, 0),
(210, 'order', 'handling_fees', 'default', '', '', NULL, NULL, 0),
(211, 'order', 'tax', 'default', '', '', NULL, NULL, 0),
(212, 'order_cancellation', 'id', 'default', '', '', NULL, NULL, 0),
(213, 'order_cancellation', 'order_id', 'default', '', '', NULL, NULL, 0),
(214, 'order_cancellation', 'reason_id', 'default', '', '', NULL, NULL, 0),
(215, 'order_cancellation', 'cancellation_date', 'default', '', '', NULL, NULL, 0),
(216, 'order_processing_associate', 'id', 'default', '', '', NULL, NULL, 0),
(217, 'order_processing_associate', 'order_id', 'default', '', '', NULL, NULL, 0),
(218, 'order_processing_associate', 'person_id', 'default', '', '', NULL, NULL, 0),
(219, 'order_processing_associate', 'processing_type_id', 'default', '', '', NULL, NULL, 0),
(220, 'order_processing_associate', 'date', 'default', '', '', NULL, NULL, 0),
(221, 'order_product', 'id', 'default', '', '', NULL, NULL, 0),
(222, 'order_product', 'order_id', 'default', '', '', NULL, NULL, 0),
(223, 'order_product', 'product_id', 'default', '', '', NULL, NULL, 0),
(224, 'order_product', 'product_condition_id', 'default', '', '', NULL, NULL, 0),
(225, 'order_product', 'country_id', 'default', '', '', NULL, NULL, 0),
(226, 'order_product', 'quantity', 'default', '', '', NULL, NULL, 0),
(227, 'order_return', 'id', 'default', '', '', NULL, NULL, 0),
(228, 'order_return', 'order_id', 'default', '', '', NULL, NULL, 0),
(229, 'order_return', 'branch_id', 'default', '', '', NULL, NULL, 0),
(230, 'order_return', 'person_id', 'default', '', '', NULL, NULL, 0),
(231, 'order_return', 'return_date', 'default', '', '', NULL, NULL, 0),
(232, 'order_return', 'return_reason', 'default', '', '', NULL, NULL, 0),
(233, 'order_return_product', 'id', 'default', '', '', NULL, NULL, 0),
(234, 'order_return_product', 'order_return_id', 'default', '', '', NULL, NULL, 0),
(235, 'order_return_product', 'product_id', 'default', '', '', NULL, NULL, 0),
(236, 'order_return_product', 'product_condition_id', 'default', '', '', NULL, NULL, 0),
(237, 'order_return_product', 'country_id', 'default', '', '', NULL, NULL, 0),
(238, 'order_return_product', 'quantity', 'default', '', '', NULL, NULL, 0),
(239, 'password_hash', 'id', 'default', '', '', NULL, NULL, 0),
(240, 'password_hash', 'person_id', 'default', '', '', NULL, NULL, 0),
(241, 'password_hash', 'start_date', 'default', '', '', NULL, NULL, 0),
(242, 'password_hash', 'end_date', 'default', '', '', NULL, NULL, 0),
(243, 'password_hash', 'hash', 'default', '', '', NULL, NULL, 0),
(244, 'password_hash', 'salt', 'default', '', '', NULL, NULL, 0),
(245, 'person', 'id', 'default', '', '', NULL, NULL, 0),
(246, 'person', 'first_name', 'default', '', '', NULL, NULL, 0),
(247, 'person', 'user_name', 'default', '', '', NULL, NULL, 0),
(248, 'person', 'last_name', 'default', '', '', NULL, NULL, 0),
(249, 'person', 'middle_name', 'default', '', '', NULL, NULL, 0),
(250, 'person', 'dob', 'default', '', '', NULL, NULL, 0),
(251, 'person', 'street_no', 'default', '', '', NULL, NULL, 0),
(252, 'person', 'street_name', 'default', '', '', NULL, NULL, 0),
(253, 'person', 'apt_or_suite_no', 'default', '', '', NULL, NULL, 0),
(254, 'person', 'city', 'default', '', '', NULL, NULL, 0),
(255, 'person', 'state_id', 'default', '', '', NULL, NULL, 0),
(256, 'person', 'postcode', 'default', '', '', NULL, NULL, 0),
(257, 'person', 'po_box', 'default', '', '', NULL, NULL, 0),
(258, 'person', 'email', 'default', '', '', NULL, NULL, 0),
(259, 'person', 'website', 'default', '', '', NULL, NULL, 0),
(260, 'person', 'branch_id', 'default', '', '', NULL, NULL, 0),
(261, 'person', 'vehicle_id', 'default', '', '', NULL, NULL, 0),
(262, 'person_security_question_value', 'id', 'default', '', '', NULL, NULL, 0),
(263, 'person_security_question_value', 'person_id', 'default', '', '', NULL, NULL, 0),
(264, 'person_security_question_value', 'security_question_type_id', 'default', '', '', NULL, NULL, 0),
(265, 'person_security_question_value', 'answer', 'default', '', '', NULL, NULL, 0),
(266, 'processing_type', 'id', 'default', '', '', NULL, NULL, 0),
(267, 'processing_type', 'name', 'default', '', '', NULL, NULL, 0),
(268, 'processing_type', 'description', 'default', '', '', NULL, NULL, 0),
(269, 'product', 'id', 'default', '', '', NULL, NULL, 0),
(270, 'product', 'manufacturer_id', 'default', '', '', NULL, NULL, 0),
(271, 'product', 'length_meters', 'default', '', '', NULL, NULL, 0),
(272, 'product', 'width_meters', 'default', '', '', NULL, NULL, 0),
(273, 'product', 'height_meters', 'default', '', '', NULL, NULL, 0),
(274, 'product', 'weight_kilograms', 'default', '', '', NULL, NULL, 0),
(275, 'product', 'start_date', 'default', '', '', NULL, NULL, 0),
(276, 'product', 'end_date', 'default', '', '', NULL, NULL, 0),
(277, 'product', 'barcode', 'default', '', '', NULL, NULL, 0),
(278, 'product', 'product_category_id', 'default', '', '', NULL, NULL, 0),
(279, 'product_category', 'id', 'default', '', '', NULL, NULL, 0),
(280, 'product_category', 'name', 'default', '', '', NULL, NULL, 0),
(281, 'product_category', 'description', 'default', '', '', NULL, NULL, 0),
(282, 'product_condition', 'id', 'default', '', '', NULL, NULL, 0),
(283, 'product_condition', 'name', 'default', '', '', NULL, NULL, 0),
(284, 'product_condition', 'description', 'default', '', '', NULL, NULL, 0),
(285, 'product_price', 'id', 'default', '', '', NULL, NULL, 0),
(286, 'product_price', 'start_date', 'default', '', '', NULL, NULL, 0),
(287, 'product_price', 'price', 'default', '', '', NULL, NULL, 0),
(288, 'product_price', 'end_date', 'default', '', '', NULL, NULL, 0),
(289, 'product_price', 'product_id', 'default', '', '', NULL, NULL, 0),
(290, 'product_price', 'condition_id', 'default', '', '', NULL, NULL, 0),
(291, 'product_price', 'country_id', 'default', '', '', NULL, NULL, 0),
(292, 'product_string_facet_value', 'product_id', 'default', '', '', NULL, NULL, 0),
(293, 'product_string_facet_value', 'string_facet_value_id', 'default', '', '', NULL, NULL, 0),
(294, 'product_vehicle', 'product_id', 'default', '', '', NULL, NULL, 0),
(295, 'product_vehicle', 'vehicle_id', 'default', '', '', NULL, NULL, 0),
(296, 'reason', 'id', 'default', '', '', NULL, NULL, 0),
(297, 'reason', 'name', 'default', '', '', NULL, NULL, 0),
(298, 'reason', 'description', 'default', '', '', NULL, NULL, 0),
(299, 'role', 'id', 'default', '', '', NULL, NULL, 0),
(300, 'role', 'name', 'default', '', '', NULL, NULL, 0),
(301, 'role', 'description', 'default', '', '', NULL, NULL, 0),
(302, 'role_permission', 'id', 'default', '', '', NULL, NULL, 0),
(303, 'role_permission', 'role_id', 'default', '', '', NULL, NULL, 0),
(304, 'role_permission', 'table_name', 'default', '', '', NULL, NULL, 0),
(305, 'role_permission', 'can_read', 'default', '', '', NULL, NULL, 0),
(306, 'role_permission', 'can_add', 'default', '', '', NULL, NULL, 0),
(307, 'role_permission', 'can_modify', 'default', '', '', NULL, NULL, 0),
(308, 'role_permission', 'can_delete', 'default', '', '', NULL, NULL, 0),
(309, 'role_permission', 'can_grant_add', 'default', '', '', NULL, NULL, 0),
(310, 'role_permission', 'can_grant_modify', 'default', '', '', NULL, NULL, 0),
(311, 'role_permission', 'can_grant_delete', 'default', '', '', NULL, NULL, 0),
(312, 'role_permission', 'can_grant_read', 'default', '', '', NULL, NULL, 0),
(313, 'security_question_type', 'id', 'default', '', '', NULL, NULL, 0),
(314, 'security_question_type', 'created', 'default', '', '', NULL, NULL, 0),
(315, 'security_question_type', 'modified', 'default', '', '', NULL, NULL, 0),
(316, 'state', 'id', 'default', '', '', NULL, NULL, 0),
(317, 'state', 'abbreviation', 'default', '', '', NULL, NULL, 0),
(318, 'state', 'country_id', 'default', '', '', NULL, NULL, 0),
(319, 'state', 'name', 'default', '', '', NULL, NULL, 0),
(320, 'string_facet', 'id', 'default', '', '', NULL, NULL, 0),
(321, 'string_facet', 'name', 'default', '', '', NULL, NULL, 0),
(322, 'string_facet', 'description', 'default', '', '', NULL, NULL, 0),
(323, 'string_facet_value', 'id', 'default', '', '', NULL, NULL, 0),
(324, 'string_facet_value', 'string_facet_id', 'default', '', '', NULL, NULL, 0),
(325, 'string_facet_value', 'value', 'default', '', '', NULL, NULL, 0),
(326, 'string_facet_value_vehicle', 'vehicle_id', 'default', '', '', NULL, NULL, 0),
(327, 'string_facet_value_vehicle', 'string_facet_value_id', 'default', '', '', NULL, NULL, 0),
(328, 'supervisor_pairing', 'id', 'default', '', '', NULL, NULL, 0),
(329, 'supervisor_pairing', 'person_id', 'default', '', '', NULL, NULL, 0),
(330, 'supervisor_pairing', 'supervisor_id', 'default', '', '', NULL, NULL, 0),
(331, 'supervisor_pairing', 'start_date', 'default', '', '', NULL, NULL, 0),
(332, 'supervisor_pairing', 'end_date', 'default', '', '', NULL, NULL, 0),
(333, 'supervisor_pairing', 'reason_id', 'default', '', '', NULL, NULL, 0),
(334, 'table_modification', 'id', 'default', '', '', NULL, NULL, 0),
(335, 'table_modification', 'modification_date', 'default', '', '', NULL, NULL, 0),
(336, 'table_modification', 'person_id', 'default', '', '', NULL, NULL, 0),
(337, 'table_modification', 'table_modified', 'default', '', '', NULL, NULL, 0),
(338, 'table_modification', 'row_count_add', 'default', '', '', NULL, NULL, 0),
(339, 'table_modification', 'row_count_remove', 'default', '', '', NULL, NULL, 0),
(340, 'table_modification', 'row_count_update', 'default', '', '', NULL, NULL, 0),
(341, 'temporary_order', 'id', 'default', '', '', NULL, NULL, 0),
(342, 'temporary_order', 'session_id', 'default', '', '', NULL, NULL, 0),
(343, 'temporary_order_product', 'id', 'default', '', '', NULL, NULL, 0),
(344, 'temporary_order_product', 'temporary_order_id', 'default', '', '', NULL, NULL, 0),
(345, 'temporary_order_product', 'product_id', 'default', '', '', NULL, NULL, 0),
(346, 'temporary_order_product', 'product_condition_id', 'default', '', '', NULL, NULL, 0),
(347, 'temporary_order_product', 'country_id', 'default', '', '', NULL, NULL, 0),
(348, 'temporary_order_product', 'quantity', 'default', '', '', NULL, NULL, 0),
(349, 'time_period', 'id', 'default', '', '', NULL, NULL, 0),
(350, 'time_period', 'seconds', 'default', '', '', NULL, NULL, 0),
(351, 'time_period', 'name', 'default', '', '', NULL, NULL, 0),
(352, 'time_period', 'description', 'default', '', '', NULL, NULL, 0),
(353, 'total_available_product', 'The_Product_ID', 'default', '', '', NULL, NULL, 0),
(354, 'total_available_product', 'The_Product_Condition_ID', 'default', '', '', NULL, NULL, 0),
(355, 'total_available_product', 'The_Country_ID', 'default', '', '', NULL, NULL, 0),
(356, 'total_available_product', 'NetQty', 'default', '', '', NULL, NULL, 0),
(357, 'vehicle', 'id', 'default', '', '', NULL, NULL, 0),
(358, 'vehicle', 'make_id', 'default', '', '', NULL, NULL, 0),
(359, 'vehicle', 'vehicle_model_id', 'default', '', '', NULL, NULL, 0),
(360, 'vehicle', 'year', 'default', '', '', NULL, NULL, 0),
(361, 'vehicle_model', 'id', 'default', '', '', NULL, NULL, 0),
(362, 'vehicle_model', 'make_id', 'default', '', '', NULL, NULL, 0),
(363, 'vehicle_model', 'name', 'default', '', '', NULL, NULL, 0),
(364, 'vehicle_model', 'description', 'default', '', '', NULL, NULL, 0),
(365, 'vendor', 'id', 'default', '', '', NULL, NULL, 0),
(366, 'vendor', 'name', 'default', '', '', NULL, NULL, 0),
(367, 'vendor', 'description', 'default', '', '', NULL, NULL, 0),
(368, 'vendor', 'email_address', 'default', '', '', NULL, NULL, 0),
(369, 'vendor', 'website', 'default', '', '', NULL, NULL, 0),
(370, 'vendor', 'phone_number', 'default', '', '', NULL, NULL, 0),
(371, 'vendor', 'street_no', 'default', '', '', NULL, NULL, 0),
(372, 'vendor', 'street_name', 'default', '', '', NULL, NULL, 0),
(373, 'vendor', 'city', 'default', '', '', NULL, NULL, 0),
(374, 'vendor', 'state_id', 'default', '', '', NULL, NULL, 0),
(375, 'vendor', 'postcode', 'default', '', '', NULL, NULL, 0),
(376, 'vendor', 'po_box', 'default', '', '', NULL, NULL, 0),
(377, 'vendor_product_price', 'id', 'default', '', '', NULL, NULL, 0),
(378, 'vendor_product_price', 'product_id', 'default', '', '', NULL, NULL, 0),
(379, 'vendor_product_price', 'cost', 'default', '', '', NULL, NULL, 0),
(380, 'vendor_product_price', 'product_condition_id', 'default', '', '', NULL, NULL, 0),
(381, 'vendor_product_price', 'country_id', 'default', '', '', NULL, NULL, 0),
(382, 'vendor_product_price', 'start_date', 'default', '', '', NULL, NULL, 0),
(383, 'vendor_product_price', 'end_date', 'default', '', '', NULL, NULL, 0),
(384, 'vendor_product_price', 'reason_id', 'default', '', '', NULL, NULL, 0),
(385, 'work_history', 'id', 'default', '', '', NULL, NULL, 0),
(386, 'work_history', 'person_id', 'default', '', '', NULL, NULL, 0),
(387, 'work_history', 'start_date', 'default', '', '', NULL, NULL, 0),
(388, 'work_history', 'job_id', 'default', '', '', NULL, NULL, 0),
(389, 'work_history', 'end_date', 'default', '', '', NULL, NULL, 0),
(390, 'work_history', 'reason_id', 'default', '', '', NULL, NULL, 0),
(391, 'sf_config', 'sf_id', 'default', '', '', NULL, NULL, 0),
(392, 'sf_config', 'sf_table', 'default', '', '', NULL, NULL, 0),
(393, 'sf_config', 'sf_field', 'default', '', '', NULL, NULL, 0),
(394, 'sf_config', 'sf_type', 'default', '', '', NULL, NULL, 0),
(395, 'sf_config', 'sf_related', 'default', '', '', NULL, NULL, 0),
(396, 'sf_config', 'sf_label', 'default', '', '', NULL, NULL, 0),
(397, 'sf_config', 'sf_desc', 'default', '', '', NULL, NULL, 0),
(398, 'sf_config', 'sf_order', 'default', '', '', NULL, NULL, 0),
(399, 'sf_config', 'sf_hidden', 'default', '', '', NULL, NULL, 0),
(400, 'product', 'name', 'default', '', '', NULL, NULL, 0),
(401, 'product', 'description', 'default', '', '', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

CREATE TABLE IF NOT EXISTS `state` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `abbreviation` tinytext NOT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `state_country_idx` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=51 ;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`id`, `abbreviation`, `country_id`, `name`) VALUES
(1, 'AL', 1, 'Alabama'),
(2, 'AK', 1, 'Alaska'),
(3, 'AZ', 1, 'Arizona'),
(4, 'AR', 1, 'Arkansas'),
(5, 'CA', 1, 'California'),
(6, 'CO', 1, 'Colorado'),
(7, 'CT', 1, 'Connecticut'),
(8, 'DE', 1, 'Delaware'),
(9, 'FL', 1, 'Florida'),
(10, 'GA', 1, 'Georgia'),
(11, 'HI', 1, 'Hawaii'),
(12, 'ID', 1, 'Idaho'),
(13, 'IL', 1, 'Illinois'),
(14, 'IN', 1, 'Indiana'),
(15, 'IA', 1, 'Iowa'),
(16, 'KS', 1, 'Kansas'),
(17, 'KY', 1, 'Kentucky'),
(18, 'LA', 1, 'Louisiana'),
(19, 'ME', 1, 'Maine'),
(20, 'MD', 1, 'Maryland'),
(21, 'MA', 1, 'Massachusetts'),
(22, 'MI', 1, 'Michigan'),
(23, 'MN', 1, 'Minnesota'),
(24, 'MS', 1, 'Mississippi'),
(25, 'MO', 1, 'Missouri'),
(26, 'MT', 1, 'Montana'),
(27, 'NE', 1, 'Nebraska'),
(28, 'NV', 1, 'Nevada'),
(29, 'NH', 1, 'New Hampshire'),
(30, 'NJ', 1, 'New Jersey'),
(31, 'NM', 1, 'New Mexico'),
(32, 'NY', 1, 'New York'),
(33, 'NC', 1, 'North Carolina'),
(34, 'ND', 1, 'North Dakota'),
(35, 'OH', 1, 'Ohio'),
(36, 'OK', 1, 'Oklahoma'),
(37, 'OR', 1, 'Oregon'),
(38, 'PA', 1, 'Pennsylvania'),
(39, 'RI', 1, 'Rhode Island'),
(40, 'SC', 1, 'South Carolina'),
(41, 'SD', 1, 'South Dakota'),
(42, 'TN', 1, 'Tennessee'),
(43, 'TX', 1, 'Texas'),
(44, 'UT', 1, 'Utah'),
(45, 'VT', 1, 'Vermont'),
(46, 'VA', 1, 'Virginia'),
(47, 'WA', 1, 'Washington'),
(48, 'WV', 1, 'West Virginia'),
(49, 'WI', 1, 'Wisconsin'),
(50, 'WY', 1, 'Wyoming');

-- --------------------------------------------------------

--
-- Table structure for table `string_facet`
--

CREATE TABLE IF NOT EXISTS `string_facet` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores types of facets (specs) that are strings of text' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `string_facet`
--

INSERT INTO `string_facet` (`id`, `name`, `description`) VALUES
(1, 'Rocket Fuel', 'Fuel for a rocket sled.');

-- --------------------------------------------------------

--
-- Table structure for table `string_facet_value`
--

CREATE TABLE IF NOT EXISTS `string_facet_value` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `string_facet_id` bigint(20) unsigned NOT NULL,
  `value` tinytext NOT NULL,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `string_facet_id_fk` (`string_facet_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the allowable values of string facets that have restr /* comment truncated */ /*icted value sets. this way, we do not need separate tables for each string facet (which would have been required if string facets were implemented using set or enum)*/' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `string_facet_value`
--

INSERT INTO `string_facet_value` (`id`, `string_facet_id`, `value`, `name`) VALUES
(1, 1, 'Nitro', 'Nitro');

-- --------------------------------------------------------

--
-- Table structure for table `string_facet_value_vehicle`
--

CREATE TABLE IF NOT EXISTS `string_facet_value_vehicle` (
  `vehicle_id` bigint(20) unsigned NOT NULL,
  `string_facet_value_id` bigint(20) unsigned NOT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `vehicle_id_fk5555` (`vehicle_id`),
  KEY `string_facet_value_vehicle` (`string_facet_value_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `string_facet_value_vehicle`
--

INSERT INTO `string_facet_value_vehicle` (`vehicle_id`, `string_facet_value_id`, `id`) VALUES
(7, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `supervisor_pairing`
--

CREATE TABLE IF NOT EXISTS `supervisor_pairing` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) unsigned NOT NULL,
  `supervisor_id` bigint(20) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `reason_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `sup_fk1` (`supervisor_id`),
  KEY `reason_id_sup` (`reason_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores the supervisor pairings for employees. ' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `temporary_order`
--

CREATE TABLE IF NOT EXISTS `temporary_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `session_fk1_idx` (`session_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

-- --------------------------------------------------------

--
-- Table structure for table `temporary_order_product`
--

CREATE TABLE IF NOT EXISTS `temporary_order_product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `temporary_order_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `product_condition_id` bigint(20) unsigned NOT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  `quantity` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `temporary_order_fk123` (`temporary_order_id`),
  KEY `product_id_temporder` (`product_id`),
  KEY `country_id_temporder_idx` (`country_id`),
  KEY `cond_id_temporder_idx` (`product_condition_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=39 ;

-- --------------------------------------------------------

--
-- Table structure for table `time_period`
--

CREATE TABLE IF NOT EXISTS `time_period` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seconds` int(11) NOT NULL,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `time_period`
--

INSERT INTO `time_period` (`id`, `seconds`, `name`, `description`) VALUES
(1, 3600, 'Hour', 'Hour');

-- --------------------------------------------------------

--
-- Stand-in structure for view `total_available_product`
--
CREATE TABLE IF NOT EXISTS `total_available_product` (
`The_Product_ID` bigint(20) unsigned
,`The_Product_Condition_ID` bigint(20) unsigned
,`The_Country_ID` bigint(20) unsigned
,`NetQty` decimal(36,0)
);
-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE IF NOT EXISTS `vehicle` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vehicle_model_id` bigint(20) unsigned NOT NULL,
  `year` int(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `model_id_fk` (`vehicle_model_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores make, model, and year of vehicles' AUTO_INCREMENT=8 ;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`id`, `vehicle_model_id`, `year`) VALUES
(7, 3, 2013);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_model`
--

CREATE TABLE IF NOT EXISTS `vehicle_model` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `make_id` bigint(20) unsigned NOT NULL,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `make2model` (`make_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `vehicle_model`
--

INSERT INTO `vehicle_model` (`id`, `make_id`, `name`, `description`) VALUES
(3, 2, 'Rocket Sled', 'You''ll go fast with this');

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--

CREATE TABLE IF NOT EXISTS `vendor` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  `email_address` text NOT NULL,
  `website` text NOT NULL,
  `phone_number` tinytext NOT NULL,
  `street_no` tinytext NOT NULL,
  `street_name` tinytext NOT NULL,
  `city` tinytext NOT NULL,
  `state_id` bigint(20) unsigned NOT NULL,
  `postcode` tinytext NOT NULL,
  `po_box` tinytext,
  PRIMARY KEY (`id`),
  KEY `vendor_state_idx` (`state_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='provides information on each vendor. vendors are assumed to be more local and thus do not need localization. ' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `vendor`
--

INSERT INTO `vendor` (`id`, `name`, `description`, `email_address`, `website`, `phone_number`, `street_no`, `street_name`, `city`, `state_id`, `postcode`, `po_box`) VALUES
(1, 'Blargtech', 'Makes Blarg Technologies for Blarg Cars', 'blarg@blarg.com', 'blarg.com', '555-5555', '404 ', 'Blarg Street', 'Blarg', 1, '44444', 'Test');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_product_price`
--

CREATE TABLE IF NOT EXISTS `vendor_product_price` (
  `id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `cost` float unsigned NOT NULL,
  `product_condition_id` bigint(20) unsigned NOT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `reason_id` bigint(20) unsigned NOT NULL,
  `vendor_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `vendor_product_id_fk876123` (`product_id`),
  KEY `reason_id_price` (`reason_id`),
  KEY `vendor_cond_id_fk81_idx` (`product_condition_id`),
  KEY `vendor_country_id_fk1_idx` (`country_id`),
  KEY `vendor_vendor_idx` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='vendor product prices had the type for cost changed to prevent an error 150. stores a products price from a particular vendor. the price _id can be used to _identify whether or not the price has expired (in conjunction with the product_price_start_dates and the product_price_end_dates tables).';

--
-- Dumping data for table `vendor_product_price`
--

INSERT INTO `vendor_product_price` (`id`, `product_id`, `cost`, `product_condition_id`, `country_id`, `start_date`, `end_date`, `reason_id`, `vendor_id`) VALUES
(1, 1, 42, 1, 1, '2013-11-26', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `work_history`
--

CREATE TABLE IF NOT EXISTS `work_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `job_id` bigint(20) unsigned NOT NULL,
  `end_date` date DEFAULT NULL,
  `reason_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id_fk21` (`person_id`),
  KEY `job_id_fk12` (`job_id`),
  KEY `reason_id_workhist` (`reason_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the employee number, start date, and job _id for all e /* comment truncated */ /*mployees. */' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `work_history`
--

INSERT INTO `work_history` (`id`, `person_id`, `start_date`, `job_id`, `end_date`, `reason_id`) VALUES
(2, 21, '2013-11-26', 1, NULL, 1);

-- --------------------------------------------------------

--
-- Structure for view `branch_received_product`
--
DROP TABLE IF EXISTS `branch_received_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `branch_received_product` AS (select `branch_inventory_received_date`.`product_id` AS `Product_ID`,`branch_inventory_received_date`.`product_condition_id` AS `product_condition_ID`,`branch_inventory_received_date`.`country_id` AS `Country_ID`,sum(`branch_inventory_received_date`.`quantity`) AS `TotalQty` from `branch_inventory_received_date` group by `branch_inventory_received_date`.`product_id`,`branch_inventory_received_date`.`product_condition_id`,`branch_inventory_received_date`.`country_id`);

-- --------------------------------------------------------

--
-- Structure for view `branch_returned_product`
--
DROP TABLE IF EXISTS `branch_returned_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `branch_returned_product` AS (select `branch_inventory_return_product`.`product_id` AS `Product_ID`,`branch_inventory_return_product`.`product_condition_id` AS `product_Condition_ID`,`branch_inventory_return_product`.`country_id` AS `Country_ID`,sum(`branch_inventory_return_product`.`quantity`) AS `TotalQty` from `branch_inventory_return_product` group by `branch_inventory_return_product`.`product_id`,`branch_inventory_return_product`.`product_condition_id`,`branch_inventory_return_product`.`country_id`);

-- --------------------------------------------------------

--
-- Structure for view `customer_purchased_product`
--
DROP TABLE IF EXISTS `customer_purchased_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customer_purchased_product` AS (select `order_product`.`product_id` AS `Product_ID`,`order_product`.`product_condition_id` AS `Product_Condition_ID`,`order_product`.`country_id` AS `Country_ID`,sum(`order_product`.`quantity`) AS `TotalQty` from `order_product` group by `order_product`.`product_id`,`order_product`.`product_condition_id`,`order_product`.`country_id`);

-- --------------------------------------------------------

--
-- Structure for view `customer_returned_product`
--
DROP TABLE IF EXISTS `customer_returned_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customer_returned_product` AS (select `order_return_product`.`product_id` AS `Product_ID`,`order_return_product`.`product_condition_id` AS `Product_Condition_ID`,`order_return_product`.`country_id` AS `Country_ID`,sum(`order_return_product`.`quantity`) AS `TotalQty` from `order_return_product` group by `order_return_product`.`product_id`,`order_return_product`.`product_condition_id`,`order_return_product`.`country_id`);

-- --------------------------------------------------------

--
-- Structure for view `held_product`
--
DROP TABLE IF EXISTS `held_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `held_product` AS (select `temporary_order_product`.`product_id` AS `Product_ID`,`temporary_order_product`.`product_condition_id` AS `Product_Condition_ID`,`temporary_order_product`.`country_id` AS `Country_ID`,sum(`temporary_order_product`.`quantity`) AS `TotalQty` from `temporary_order_product` group by `temporary_order_product`.`product_id`,`temporary_order_product`.`product_condition_id`,`temporary_order_product`.`country_id`);

-- --------------------------------------------------------

--
-- Structure for view `total_available_product`
--
DROP TABLE IF EXISTS `total_available_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `total_available_product` AS (select `brec`.`Product_ID` AS `The_Product_ID`,`brec`.`product_condition_ID` AS `The_Product_Condition_ID`,`brec`.`Country_ID` AS `The_Country_ID`,((((ifnull(`brec`.`TotalQty`,0) - ifnull(`bret`.`TotalQty`,0)) - ifnull(`cpur`.`TotalQty`,0)) + ifnull(`cret`.`TotalQty`,0)) - ifnull(`held`.`TotalQty`,0)) AS `NetQty` from ((((`branch_received_product` `brec` left join `branch_returned_product` `bret` on(((`brec`.`Product_ID` = `bret`.`Product_ID`) and (`brec`.`Country_ID` = `bret`.`Country_ID`) and (`brec`.`product_condition_ID` = `bret`.`product_Condition_ID`)))) left join `customer_purchased_product` `cpur` on(((`brec`.`Product_ID` = `cpur`.`Product_ID`) and (`brec`.`Country_ID` = `cpur`.`Country_ID`) and (`brec`.`product_condition_ID` = `cpur`.`Product_Condition_ID`)))) left join `customer_returned_product` `cret` on(((`brec`.`Product_ID` = `cret`.`Product_ID`) and (`brec`.`Country_ID` = `cret`.`Country_ID`) and (`brec`.`product_condition_ID` = `cret`.`Product_Condition_ID`)))) left join `held_product` `held` on(((`brec`.`Product_ID` = `held`.`Product_ID`) and (`brec`.`product_condition_ID` = `held`.`Product_Condition_ID`) and (`brec`.`Country_ID` = `held`.`Country_ID`)))));

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bool_facet_value`
--
ALTER TABLE `bool_facet_value`
  ADD CONSTRAINT `job_bool_facet` FOREIGN KEY (`bool_facet_id`) REFERENCES `bool_facet` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `bool_facet_value_product`
--
ALTER TABLE `bool_facet_value_product`
  ADD CONSTRAINT `bool_facet_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `product_facet_bool` FOREIGN KEY (`bool_facet_value_id`) REFERENCES `bool_facet_value` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `bool_facet_value_vehicle`
--
ALTER TABLE `bool_facet_value_vehicle`
  ADD CONSTRAINT `bool_facet_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `vehicle_bool_facet` FOREIGN KEY (`bool_facet_value_id`) REFERENCES `bool_facet_value` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `branch`
--
ALTER TABLE `branch`
  ADD CONSTRAINT `branch_state` FOREIGN KEY (`state`) REFERENCES `state` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `branch_inventory_received_date`
--
ALTER TABLE `branch_inventory_received_date`
  ADD CONSTRAINT `branch_inventory_received_request` FOREIGN KEY (`branch_inventory_request_id`) REFERENCES `branch_inventory_request` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `cond_birc` FOREIGN KEY (`product_condition_id`) REFERENCES `product_condition` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `country_birc` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `person_id_fk16789` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  ADD CONSTRAINT `prod_id_fk1234g5678` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `branch_inventory_request`
--
ALTER TABLE `branch_inventory_request`
  ADD CONSTRAINT `branch_inventory_req_branch` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `employee_branch_inventory_re` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `vendor_req` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `branch_inventory_request_product`
--
ALTER TABLE `branch_inventory_request_product`
  ADD CONSTRAINT `cond_inventory_request` FOREIGN KEY (`product_condition_id`) REFERENCES `product_condition` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `country_inventory_request` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `product_inventory_request` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `request_id_fk1356` FOREIGN KEY (`branch_inventory_request_id`) REFERENCES `branch_inventory_request` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `branch_inventory_return`
--
ALTER TABLE `branch_inventory_return`
  ADD CONSTRAINT `person_id_fk2` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  ADD CONSTRAINT `reason_id_inventory` FOREIGN KEY (`reason_id`) REFERENCES `reason` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `return_id_inventory` FOREIGN KEY (`branch_inventory_request_id`) REFERENCES `branch_inventory_request` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `branch_inventory_return_product`
--
ALTER TABLE `branch_inventory_return_product`
  ADD CONSTRAINT `condition_id_fk234` FOREIGN KEY (`product_condition_id`) REFERENCES `product_condition` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `product_id_fk1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `returns` FOREIGN KEY (`branch_inventory_return_id`) REFERENCES `branch_inventory_return` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `return_country_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cash_payment`
--
ALTER TABLE `cash_payment`
  ADD CONSTRAINT `order_id_fk4321` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`);

--
-- Constraints for table `cc_payment`
--
ALTER TABLE `cc_payment`
  ADD CONSTRAINT `order_id_fk5431` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `payment_state` FOREIGN KEY (`state`) REFERENCES `state` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `department_job`
--
ALTER TABLE `department_job`
  ADD CONSTRAINT `department_id_fk` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  ADD CONSTRAINT `job_id_fk3` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`);

--
-- Constraints for table `employee_branch_history`
--
ALTER TABLE `employee_branch_history`
  ADD CONSTRAINT `branch_id_fk1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  ADD CONSTRAINT `person_id_fk3` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  ADD CONSTRAINT `reason_id_branchhist` FOREIGN KEY (`reason_id`) REFERENCES `reason` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `employee_clock`
--
ALTER TABLE `employee_clock`
  ADD CONSTRAINT `person_id_fk6543` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`);

--
-- Constraints for table `employee_reimbursement`
--
ALTER TABLE `employee_reimbursement`
  ADD CONSTRAINT `person_reimburse` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `reason_reimburse` FOREIGN KEY (`reason_id`) REFERENCES `reason` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `float_facet_value`
--
ALTER TABLE `float_facet_value`
  ADD CONSTRAINT `float_facet_value_fk1` FOREIGN KEY (`float_facet_id`) REFERENCES `float_facet` (`id`);

--
-- Constraints for table `float_facet_value_product`
--
ALTER TABLE `float_facet_value_product`
  ADD CONSTRAINT `float_facet_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `product_facet_float` FOREIGN KEY (`float_facet_value_id`) REFERENCES `float_facet_value` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `float_facet_value_vehicle`
--
ALTER TABLE `float_facet_value_vehicle`
  ADD CONSTRAINT `float_facet_vehicle_fk345` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `vehicle_float_facet_fk143` FOREIGN KEY (`float_facet_value_id`) REFERENCES `float_facet_value` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `int_facet_value`
--
ALTER TABLE `int_facet_value`
  ADD CONSTRAINT `int_facet_value_fk1` FOREIGN KEY (`int_facet_id`) REFERENCES `int_facet` (`id`);

--
-- Constraints for table `int_facet_value_product`
--
ALTER TABLE `int_facet_value_product`
  ADD CONSTRAINT `int_facet_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `product_facet_int` FOREIGN KEY (`int_facet_value_id`) REFERENCES `int_facet_value` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `int_facet_value_vehicle`
--
ALTER TABLE `int_facet_value_vehicle`
  ADD CONSTRAINT `int_facet_vehicle_fk345` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `vehicle_int_facet_fk143` FOREIGN KEY (`int_facet_value_id`) REFERENCES `int_facet_value` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `job_pay`
--
ALTER TABLE `job_pay`
  ADD CONSTRAINT `job_id_fk4` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  ADD CONSTRAINT `pay_period_fk2` FOREIGN KEY (`pay_period`) REFERENCES `time_period` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `pay_rate_fk2` FOREIGN KEY (`pay_rate_denom`) REFERENCES `time_period` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `job_posting`
--
ALTER TABLE `job_posting`
  ADD CONSTRAINT `branch_id_fk4537` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  ADD CONSTRAINT `job_id_fk4537` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  ADD CONSTRAINT `person_id_fk4537` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`);

--
-- Constraints for table `job_posting_filling`
--
ALTER TABLE `job_posting_filling`
  ADD CONSTRAINT `person_id_fk300` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  ADD CONSTRAINT `posting` FOREIGN KEY (`job_posting_id`) REFERENCES `job_posting` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `job_role`
--
ALTER TABLE `job_role`
  ADD CONSTRAINT `job_id_fk5` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  ADD CONSTRAINT `role_id_fk554433` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);

--
-- Constraints for table `make`
--
ALTER TABLE `make`
  ADD CONSTRAINT `make_mfr` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `manufacturer`
--
ALTER TABLE `manufacturer`
  ADD CONSTRAINT `manufacturer_state` FOREIGN KEY (`state_id`) REFERENCES `state` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `branch_id_fk3` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`),
  ADD CONSTRAINT `person_id_fk6` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`);

--
-- Constraints for table `order_cancellation`
--
ALTER TABLE `order_cancellation`
  ADD CONSTRAINT `order_id_fk2` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `reason_cancellation` FOREIGN KEY (`reason_id`) REFERENCES `reason` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `order_product`
--
ALTER TABLE `order_product`
  ADD CONSTRAINT `order_cond_fk123` FOREIGN KEY (`product_condition_id`) REFERENCES `product_condition` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `order_country_fk123` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `order_id_fk3` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `product_id_fk9` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `order_return`
--
ALTER TABLE `order_return`
  ADD CONSTRAINT `branch_order_return` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `employee_processing_return` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `order_id_fk14578967` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `order_return_reason` FOREIGN KEY (`reason_id`) REFERENCES `reason` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `order_return_product`
--
ALTER TABLE `order_return_product`
  ADD CONSTRAINT `product_id_fk34` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `return1` FOREIGN KEY (`order_return_id`) REFERENCES `order_return` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `ret_cond_fk123` FOREIGN KEY (`product_condition_id`) REFERENCES `product_condition` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `ret_country_fk124` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `order_shipping`
--
ALTER TABLE `order_shipping`
  ADD CONSTRAINT `fk_order_id190384523978` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `employee_shipping` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `shipping_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `password_hash`
--
ALTER TABLE `password_hash`
  ADD CONSTRAINT `person_id_fk5` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`);

--
-- Constraints for table `person`
--
ALTER TABLE `person`
  ADD CONSTRAINT `person_branch` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `person_state` FOREIGN KEY (`state_id`) REFERENCES `state` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `person_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `category` FOREIGN KEY (`product_category_id`) REFERENCES `product_category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `manufacturer_id_fk` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer` (`id`);

--
-- Constraints for table `product_price`
--
ALTER TABLE `product_price`
  ADD CONSTRAINT `price_product_condition` FOREIGN KEY (`condition_id`) REFERENCES `product_condition` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `price_product_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `price_product_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `product_string_facet_value`
--
ALTER TABLE `product_string_facet_value`
  ADD CONSTRAINT `product_id_fk6` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `string_facet_product_fk1` FOREIGN KEY (`string_facet_value_id`) REFERENCES `string_facet_value` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `product_vehicle`
--
ALTER TABLE `product_vehicle`
  ADD CONSTRAINT `product_id_fk3` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD CONSTRAINT `roleconstraint_1234566` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);

--
-- Constraints for table `state`
--
ALTER TABLE `state`
  ADD CONSTRAINT `state_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `string_facet_value`
--
ALTER TABLE `string_facet_value`
  ADD CONSTRAINT `string_facet_fk123454` FOREIGN KEY (`string_facet_id`) REFERENCES `string_facet` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `string_facet_value_vehicle`
--
ALTER TABLE `string_facet_value_vehicle`
  ADD CONSTRAINT `string_facet_value_vehicle` FOREIGN KEY (`string_facet_value_id`) REFERENCES `string_facet_value` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `vehicle_id_fk5555` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`);

--
-- Constraints for table `supervisor_pairing`
--
ALTER TABLE `supervisor_pairing`
  ADD CONSTRAINT `person_employee` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `reason_id_sup` FOREIGN KEY (`reason_id`) REFERENCES `reason` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `sup_fk1` FOREIGN KEY (`supervisor_id`) REFERENCES `person` (`id`);

--
-- Constraints for table `temporary_order`
--
ALTER TABLE `temporary_order`
  ADD CONSTRAINT `order_session` FOREIGN KEY (`session_id`) REFERENCES `ci_sessions` (`session_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `temporary_order_product`
--
ALTER TABLE `temporary_order_product`
  ADD CONSTRAINT `cond_id_temporder` FOREIGN KEY (`product_condition_id`) REFERENCES `product_condition` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `country_id_temporder` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `product_id_temporder` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `temporary_order_fk123` FOREIGN KEY (`temporary_order_id`) REFERENCES `temporary_order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD CONSTRAINT `model_id_fk` FOREIGN KEY (`vehicle_model_id`) REFERENCES `vehicle_model` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `vehicle_model`
--
ALTER TABLE `vehicle_model`
  ADD CONSTRAINT `make2model` FOREIGN KEY (`make_id`) REFERENCES `make` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `vendor`
--
ALTER TABLE `vendor`
  ADD CONSTRAINT `vendor_state` FOREIGN KEY (`state_id`) REFERENCES `state` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `vendor_product_price`
--
ALTER TABLE `vendor_product_price`
  ADD CONSTRAINT `reason_id_price` FOREIGN KEY (`reason_id`) REFERENCES `reason` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `vendor_cond_id_fk81` FOREIGN KEY (`product_condition_id`) REFERENCES `product_condition` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `vendor_country_id_fk1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `vendor_product_id_fk876123` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `vendor_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `work_history`
--
ALTER TABLE `work_history`
  ADD CONSTRAINT `job_id_fk12` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  ADD CONSTRAINT `person_id_fk21` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  ADD CONSTRAINT `reason_id_workhist` FOREIGN KEY (`reason_id`) REFERENCES `reason` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
