-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 26, 2013 at 10:40 AM
-- Server version: 5.6.13-log
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
-- Creation: Nov 12, 2013 at 05:36 AM
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
-- Creation: Nov 24, 2013 at 02:36 PM
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
-- Creation: Nov 25, 2013 at 07:21 PM
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
-- Creation: Nov 12, 2013 at 05:36 AM
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
-- Creation: Nov 21, 2013 at 02:43 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `branch_inventory_received_date`
--
-- Creation: Nov 19, 2013 at 03:03 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='logs who receives what in the back of the store and when. ' AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `branch_inventory_request`
--
-- Creation: Nov 24, 2013 at 02:31 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the request _id, branch_id, and order date of each inve /* comment truncated */ /*ntory request.*/' AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `branch_inventory_request_product`
--
-- Creation: Nov 19, 2013 at 03:04 AM
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores the products and quantities associated with each inve /* comment truncated */ /*ntory request*/' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `branch_inventory_return`
--
-- Creation: Nov 24, 2013 at 02:32 PM
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
-- Creation: Nov 19, 2013 at 03:04 AM
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
-- Creation: Nov 12, 2013 at 05:36 AM
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
-- Creation: Nov 26, 2013 at 01:59 PM
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
  KEY `order_id_fk5431` (`order_id`),
  KEY `payment_state_idx` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='this stores all credit card payments made. may or may not be /* comment truncated */ /* modified depending on use of library like stripe. */';

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--
-- Creation: Nov 12, 2013 at 05:37 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `country`
--
-- Creation: Nov 12, 2013 at 05:36 AM
--

CREATE TABLE IF NOT EXISTS `country` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `currency` varchar(3) NOT NULL,
  `two_letter_code` varchar(2) NOT NULL,
  `three_letter_code` varchar(3) NOT NULL,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

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
-- Creation: Nov 12, 2013 at 05:36 AM
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
-- Creation: Nov 12, 2013 at 05:36 AM
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
-- Creation: Nov 12, 2013 at 05:36 AM
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
-- Creation: Nov 12, 2013 at 05:36 AM
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
-- Creation: Nov 12, 2013 at 05:36 AM
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
-- Creation: Nov 12, 2013 at 05:36 AM
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
-- Creation: Nov 24, 2013 at 02:37 PM
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
-- Creation: Nov 26, 2013 at 04:36 PM
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
-- Creation: Nov 26, 2013 at 04:37 PM
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
-- Creation: Nov 12, 2013 at 05:37 AM
--

CREATE TABLE IF NOT EXISTS `int_facet` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `max` int(11) DEFAULT NULL,
  `min` int(11) DEFAULT NULL,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `int_facet_value`
--
-- Creation: Nov 24, 2013 at 02:37 PM
--

CREATE TABLE IF NOT EXISTS `int_facet_value` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `int_facet_id` bigint(20) unsigned NOT NULL,
  `value` int(11) NOT NULL,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `int_facet_value_idx` (`int_facet_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `int_facet_value_product`
--
-- Creation: Nov 26, 2013 at 04:36 PM
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
-- Creation: Nov 26, 2013 at 04:37 PM
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
-- Creation: Nov 12, 2013 at 05:37 AM
--

CREATE TABLE IF NOT EXISTS `job` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='includes name and description for all jobs' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `job_pay`
--
-- Creation: Nov 12, 2013 at 05:37 AM
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
-- Creation: Nov 12, 2013 at 05:37 AM
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
-- Creation: Nov 12, 2013 at 05:37 AM
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
-- Creation: Nov 24, 2013 at 06:41 PM
--

CREATE TABLE IF NOT EXISTS `job_role` (
  `job_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `job_id_fk5` (`job_id`),
  KEY `role_id_fk554433` (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the roles associated with each job.' AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `make`
--
-- Creation: Nov 23, 2013 at 06:24 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `manufacturer`
--
-- Creation: Nov 21, 2013 at 03:20 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `order`
--
-- Creation: Nov 24, 2013 at 04:13 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the customer, branch, and order number for each order /* comment truncated */ /*. */' AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Table structure for table `order_cancellation`
--
-- Creation: Nov 12, 2013 at 05:37 AM
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
-- Creation: Nov 19, 2013 at 03:07 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the products sold for an order. ' AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `order_return`
--
-- Creation: Nov 12, 2013 at 05:37 AM
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
-- Creation: Nov 19, 2013 at 03:07 AM
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
-- Creation: Nov 26, 2013 at 05:38 AM
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
-- Creation: Nov 23, 2013 at 08:57 PM
--

CREATE TABLE IF NOT EXISTS `password_hash` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `hash` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id_fk5` (`person_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Table structure for table `person`
--
-- Creation: Nov 23, 2013 at 06:14 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--
-- Creation: Nov 21, 2013 at 03:44 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='keeps a list of all products in stores. ' AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--
-- Creation: Nov 21, 2013 at 03:02 AM
--

CREATE TABLE IF NOT EXISTS `product_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='prov_ides a pseudo-directory tree for each product using two  /* comment truncated */ /*columns. a product category can have many children but only one parent. */' AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `product_condition`
--
-- Creation: Nov 12, 2013 at 05:37 AM
--

CREATE TABLE IF NOT EXISTS `product_condition` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `product_price`
--
-- Creation: Nov 19, 2013 at 02:05 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `product_string_facet_value`
--
-- Creation: Nov 12, 2013 at 05:37 AM
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
-- Creation: Nov 12, 2013 at 05:37 AM
--

CREATE TABLE IF NOT EXISTS `product_vehicle` (
  `product_id` bigint(20) unsigned NOT NULL,
  `vehicle_id` bigint(20) unsigned NOT NULL,
  KEY `vehicle_id_fk` (`vehicle_id`),
  KEY `product_id_fk3` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='keeps track of the vehicles that go with each product (if it cannot simply work on all of them)';

-- --------------------------------------------------------

--
-- Table structure for table `reason`
--
-- Creation: Nov 12, 2013 at 05:37 AM
--

CREATE TABLE IF NOT EXISTS `reason` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--
-- Creation: Nov 21, 2013 at 03:02 AM
--

CREATE TABLE IF NOT EXISTS `role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the names and descriptions of all roles. ' AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Table structure for table `role_permission`
--
-- Creation: Nov 12, 2013 at 05:37 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the specific permissions associated with each role. p /* comment truncated */ /*ermissions include:\n_read\n_add\n_modify\n_delete \n_xown - you can only exercise right x on your own rows\n_grant y - you can give others right y. */' AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Table structure for table `sf_config`
--
-- Creation: Nov 24, 2013 at 02:57 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=363 ;

-- --------------------------------------------------------

--
-- Table structure for table `state`
--
-- Creation: Nov 12, 2013 at 05:37 AM
--

CREATE TABLE IF NOT EXISTS `state` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `abbreviation` tinytext NOT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `state_country_idx` (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=51 ;

-- --------------------------------------------------------

--
-- Table structure for table `string_facet`
--
-- Creation: Nov 12, 2013 at 05:37 AM
--

CREATE TABLE IF NOT EXISTS `string_facet` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores types of facets (specs) that are strings of text' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `string_facet_value`
--
-- Creation: Nov 24, 2013 at 02:38 PM
--

CREATE TABLE IF NOT EXISTS `string_facet_value` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `string_facet_id` bigint(20) unsigned NOT NULL,
  `value` tinytext NOT NULL,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `string_facet_id_fk` (`string_facet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='stores the allowable values of string facets that have restr /* comment truncated */ /*icted value sets. this way, we do not need separate tables for each string facet (which would have been required if string facets were implemented using set or enum)*/' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `string_facet_value_vehicle`
--
-- Creation: Nov 26, 2013 at 04:38 PM
--

CREATE TABLE IF NOT EXISTS `string_facet_value_vehicle` (
  `vehicle_id` bigint(20) unsigned NOT NULL,
  `string_facet_value_id` bigint(20) unsigned NOT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `vehicle_id_fk5555` (`vehicle_id`),
  KEY `string_facet_value_vehicle` (`string_facet_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `supervisor_pairing`
--
-- Creation: Nov 12, 2013 at 05:37 AM
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
-- Creation: Nov 12, 2013 at 07:54 PM
--

CREATE TABLE IF NOT EXISTS `temporary_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `session_fk1_idx` (`session_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Table structure for table `temporary_order_product`
--
-- Creation: Nov 19, 2013 at 03:06 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

-- --------------------------------------------------------

--
-- Table structure for table `time_period`
--
-- Creation: Nov 12, 2013 at 05:37 AM
--

CREATE TABLE IF NOT EXISTS `time_period` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seconds` int(11) NOT NULL,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
-- Creation: Nov 23, 2013 at 06:30 PM
--

CREATE TABLE IF NOT EXISTS `vehicle` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vehicle_model_id` bigint(20) unsigned NOT NULL,
  `year` int(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `model_id_fk` (`vehicle_model_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores make, model, and year of vehicles' AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_model`
--
-- Creation: Nov 12, 2013 at 05:37 AM
--

CREATE TABLE IF NOT EXISTS `vehicle_model` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `make_id` bigint(20) unsigned NOT NULL,
  `name` tinytext NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `make2model` (`make_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--
-- Creation: Nov 21, 2013 at 03:27 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `vendor_product_price`
--
-- Creation: Nov 24, 2013 at 02:50 PM
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
  KEY `vendor_product_id_fk876123` (`product_id`),
  KEY `reason_id_price` (`reason_id`),
  KEY `vendor_cond_id_fk81_idx` (`product_condition_id`),
  KEY `vendor_country_id_fk1_idx` (`country_id`),
  KEY `vendor_vendor_idx` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='vendor product prices had the type for cost changed to prevent an error 150. stores a products price from a particular vendor. the price _id can be used to _identify whether or not the price has expired (in conjunction with the product_price_start_dates and the product_price_end_dates tables).';

-- --------------------------------------------------------

--
-- Table structure for table `work_history`
--
-- Creation: Nov 12, 2013 at 05:37 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='stores the employee number, start date, and job _id for all e /* comment truncated */ /*mployees. */' AUTO_INCREMENT=2 ;

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
