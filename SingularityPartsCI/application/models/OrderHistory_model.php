<?php

class OrderHistory_model extends CI_Model
{
	/**
	 * Gets a list of non-cancelled orders
	 */
	function get_orders($person_id)
	{
		$sql_res = $this->db->query(
			'SELECT `order`.`id` as `order_id`, 
				`product`.`name` AS `product_name`, 
				`order_product`.`product_id` AS `product_id`, 
				`product_condition`.`name` AS `condition_name`, 
				`country`.`name` AS `country_name`, 
				`order_product`.`quantity` AS `quantity`, 
				`product_price`.`price` AS `unit_price`, 
				`order`.`order_date` AS `order_date`, 
				`branch`.`name` AS `branch_name` 
			FROM `order` 
				JOIN `order_product` 
					ON (`order_product`.`order_id` = `order`.`id`) 
				JOIN `product_price` 
					ON ( 
						`order_product`.`product_id` = `product_price`.`product_id` 
						AND `order_product`.`product_condition_id` = `product_price`.`condition_id` 
						AND `order_product`.`country_id` = `product_price`.`country_id` 
					) 
				JOIN `product_condition` 
					ON (
						`order_product`.`product_condition_id` = `product_condition`.`id`
					) 
				JOIN `country` 
					ON (
						`country`.`id` = `order_product`.`country_id`
					) 
				JOIN `branch` ON (`order`.`branch_id` = `branch`.`id`) 
				JOIN `product` ON (`product`.`id` = `order_product`.`product_id`) 

			WHERE (`product_price`.`start_date` <= `order`.`order_date`) 
				AND ( 
					`product_price`.`end_date` > `order`.`order_date` 
					OR `product_price`.`end_date` IS NULL 
				)
				AND (`order`.`id` NOT IN (
					SELECT `order_cancellation`.`order_id` FROM `order_cancellation`
					)
				)
				AND (`order`.`person_id` = ?)
			', array($person_id));
		return $sql_res->result();
	}
	
	/**
	 * Gets a list of returned items
	 */
	function get_returned_items($person_id)
	{
		$sql_res = $this->db->query(
			'SELECT `order`.`id` as `order_id`, 
				`product`.`name` AS `product_name`, 
				`order_product`.`product_id` AS `product_id`, 
				`product_condition`.`name` AS `condition_name`, 
				`country`.`name` AS `country_name`, 
				`order_product`.`quantity` AS `quantity`, 
				`product_price`.`price` AS `unit_price`, 
				`order`.`order_date` AS `order_date`, 
				`branch`.`name` AS `branch_name`, 
				`reason`.`name` AS `reason_name`,
			`order`.`order_date` AS `order_date`,
			`order_return`.`id` AS `return_id`,
			`order_return`.`return_date` AS `return_date`
			FROM `order_return`
				JOIN `order` ON (`order_return`.`order_id` = `order`.`id`)
				JOIN `order_product` 
					ON (`order_product`.`order_id` = `order`.`id`) 
				JOIN `product_price` 
					ON ( 
						`order_product`.`product_id` = `product_price`.`product_id` 
						AND `order_product`.`product_condition_id` = `product_price`.`condition_id` 
						AND `order_product`.`country_id` = `product_price`.`country_id` 
					) 
				JOIN `product_condition` 
					ON (
						`order_product`.`product_condition_id` = `product_condition`.`id`
					) 
				JOIN `country` 
					ON (
						`country`.`id` = `order_product`.`country_id`
					) 
				JOIN `branch` ON (`order`.`branch_id` = `branch`.`id`) 
				JOIN `product` ON (`product`.`id` = `order_product`.`product_id`)
				JOIN `reason` ON (`reason`.`id` = `order_return`.`reason_id`)

			WHERE (`product_price`.`start_date` <= `order`.`order_date`) 
				AND ( 
					`product_price`.`end_date` > `order`.`order_date` 
					OR `product_price`.`end_date` IS NULL 
				) 
				AND (`order`.`person_id` = ?)', array($person_id));
		
		return $sql_res->result();	
	}
	
	/**
	 * Gets cancelled orders for a person. 
	 */
	function get_cancelled_orders($person_id)
	{
		$sql_res = $this->db->query(
			'SELECT `order`.`id` as `order_id`, 
				`product`.`name` AS `product_name`, 
				`order_product`.`product_id` AS `product_id`, 
				`product_condition`.`name` AS `condition_name`, 
				`country`.`name` AS `country_name`, 
				`order_product`.`quantity` AS `quantity`, 
				`product_price`.`price` AS `unit_price`, 
				`order`.`order_date` AS `order_date`, 
				`branch`.`name` AS `branch_name`, 
				`reason`.`name` AS `reason_name`,
			`order`.`order_date` AS `order_date`,
			`order_cancellation`.`id` AS `cancellation_id`,
			`order_cancellation`.`cancellation_date` AS `cancellation_date`
			FROM `order_cancellation`
				JOIN `order` ON (`order_cancellation`.`order_id` = `order`.`id`)
				JOIN `order_product` 
					ON (`order_product`.`order_id` = `order`.`id`) 
				JOIN `product_price` 
					ON ( 
						`order_product`.`product_id` = `product_price`.`product_id` 
						AND `order_product`.`product_condition_id` = `product_price`.`condition_id` 
						AND `order_product`.`country_id` = `product_price`.`country_id` 
					) 
				JOIN `product_condition` 
					ON (
						`order_product`.`product_condition_id` = `product_condition`.`id`
					) 
				JOIN `country` 
					ON (
						`country`.`id` = `order_product`.`country_id`
					) 
				JOIN `branch` ON (`order`.`branch_id` = `branch`.`id`) 
				JOIN `product` ON (`product`.`id` = `order_product`.`product_id`)
				JOIN `reason` ON (`reason`.`id` = `order_cancellation`.`reason_id`)

			WHERE (`product_price`.`start_date` <= `order`.`order_date`) 
				AND ( 
					`product_price`.`end_date` > `order`.`order_date` 
					OR `product_price`.`end_date` IS NULL 
				) 
				AND (`order`.`person_id` = ?)', array($person_id));
		
		return $sql_res->result();	
		
	}
	
	function get_shipped_orders($person_id)
	{
		$this->db->select(
			'order.id AS order_id,
			order_shipping.shipping_date AS shipping_date,
			order_shipping.shipping_tracking AS shipping_tracking,
			order_shipping.shipping_method AS shipping_method'
		);
		$this->db->from('order');
		$this->db->join('order_shipping', 'order_shipping.order_id = order.id');
		$this->db->where('order.person_id', $person_id);
		$sql_res = $this->db->get();
		return $sql_res->result();
	}
}
?>