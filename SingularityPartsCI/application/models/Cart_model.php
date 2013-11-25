<?php 
	/*
		 * TODO: 
		 * 0. The actual user interface and the controller. 
		 * 
		 * 2. Turning a shopping cart order into an order in the order and order_product tables,
			and deleting the corresponding shopping cart order. (transaction)
		 * 3. Adding payment
		 *
		 * WHAT NEEDS TESTING:
		 * 1. retrieving products given vehicle(s), a query string, both, or neither
		 * 4. retrieving facets for a product (name and value)
		 * 5. updating the temporary_order and temporary_order_product tables as the shopping cart changes. 
			These tables are used to help reduce the chance of a product being "sold out" 
			before the user gets to it. Note that unless the user remains pretty active on the site,
			the quantities will not be real-time (so the UI should have a "quantities current as of DATETIME" disclaimer).
		 * 
		 * NOTES:
		 * The query string functions are vulnerable to SQL injection 
		 * if the query string contains anything other than A-Za-z0-9 and spaces. 
		 * 
		 * I am not sure if the correct join is being used for the product retrieval functions involving vehicles. 
		 * Basically, products without vehicles (i.e. have no entries in the product_vehicle table) should be retrieved
		 * as well as products that match any of the vehicle(s) given.
		 * 
		 * These queries have not been tested other than a brief 
		 * "echo with sample values filled in and copy to Workbench for basic syntax checking"
		 */
	class Cart_model extends CI_Model
	{
		/**
		 * Returns the base query for obtaining a product list.
		 */
		
		public function GenerateProductStubs()
		{
			$this->db->select('*');
			$this->db->from('product, product_price');
			$this->db->where('`product`.`id` = `product_price`.`product_id`');
			$products = $this->db->get();
			$result = $products->result();
			echo '</br>';
			if ($products->num_rows() > 0)
			{
				foreach($result as $row)
				{
					echo '<hr/>';
					echo '<p = "name">Name: '.$row->name.'</p>';
					echo '<p = "description">Description: '.$row->description.'</p>';
					echo '<p = "dimensions">Dimensions:'.$row->length_meters.'x'.$row->width_meters.'x'.$row->height_meters.' meters</p>';
					echo '<p = "weight">Weight: '.$row->weight_kilograms.' Kilograms</p>';
					echo '<p = "price">Price: '.$row->price.' USD </p>';
					echo '<a href = "Cart/add/'.$row->id.'/1/'.$row->price.'/'.$row->name.'">Add to Cart</a>';
					echo '<hr/>';
				}
			}
		
		}
		public function GenerateProductStubsCategory($category)
		{
			$this->db->select('*');
			$this->db->from('product, product_price');
			$this->db->where('`product`.`id` = `product_price`.`product_id` and `product`.`category` = `$category`');
			$products = $this->db->get();
			$result = $products->result();
			echo '</br>';
			if ($products->num_rows() > 0)
			{
				foreach($result as $row)
				{
					echo '<hr/>';
					echo '<p = "name">Name: '.$row->name.'</p>';
					echo '<p = "description">Description: '.$row->description.'</p>';
					echo '<p = "dimensions">Dimensions:'.$row->length_meters.'x'.$row->width_meters.'x'.$row->height_meters.' meters</p>';
					echo '<p = "weight">Weight: '.$row->weight_kilograms.' Kilograms</p>';
					echo '<p = "price">Price: '.$row->price.' USD </p>';
					echo '<a href = "Cart/add/'.$row->id.'/1/'.$row->price.'/'.$row->name.'">Add to Cart</a>';
					echo '<hr/>';
				}
			}
		
		}
		 
		public function get_base_product_query()
		{
			return 
				'SELECT `product`.`id` AS `product_id`, 
					`manufacturer`.`name` AS `manufacturer_name`,
					`product`.`name` AS `product_name`,
					`product`.`description` AS `product_description`,
					`product_category`.`name` AS `category_name`,
					`product_category`.`id` AS `category_id`,
					`product`.`length_meters` AS `length_meters`,
					`product`.`width_meters` AS `width_meters`, 
					`product`.`height_meters` AS `height_meters`,
					`product`.`weight_kilograms` AS `weight_kilograms`,
					`product`.`barcode` AS `barcode`,
					`product_price`.`price` AS `product_price`,
					`product_condition`.`name` AS `condition_name`,
					`product_condition`.`id` AS `condition_id`,
					`country`.`id` AS `country_id`,
					`country`.`name` AS `country_name`,
					`total_available_product`.`netqty` AS `quantity_available`
				FROM `product`
					JOIN `total_available_product` 
						ON (`product`.`id` = `total_available_product`.`the_product_id`)
					JOIN `manufacturer` 
						ON (`product`.`manufacturer_id` = `manufacturer`.`id`)
					JOIN `product_category` 
						ON (`product_category`.`id` = `product`.`product_category_id`)
					JOIN `product_price`
						ON (
							`product_price`.`product_id` = `product`.`id`
							AND `product_price`.`condition_id` = `total_available_product`.`the_product_condition_id`
							AND `product_price`.`country_id` = `total_available_product`.`the_country_id`
						)
					JOIN `country` ON (`country`.`id` = `product_price`.`country_id`)
					JOIN `product_condition` ON (`product_condition`.`id` = `product_price`.`condition_id`)
			';
		}
		
		/**
		 * Gets all product IDs matching a vehicle and a query string
		 * To reduce chances of SQL injection, 
		 * the query string should only consist of alphanumerics and spaces.
		 * (the last thing in the brackets was a space)
		 */
		public function get_product_for_vehicle_and_query($vehicle_id, $query)
		{
			if(is_array($vehicle_id)) {
				$vehicle_id_list = '(' . implode(', ', $vehicle_id) . ')';
			}
			else
			{
				$vehicle_id_list = '(' . $vehicle_id . ')';
			}
			$base_query = $this->get_base_product_query();
			$base_query = $base_query . 
			"LEFT OUTER JOIN `product_vehicle`
				ON (`product_vehicle`.`product_id` = `product`.`id`)
			WHERE (
				`product_vehicle`.`vehicle_id` IN $vehicle_id_list
					OR `product_vehicle`.`vehicle_id` IS NULL)
				AND (`product`.`name` LIKE '%$query%' OR `product`.`description` LIKE '%$query%')
			";
			$sql_result = $this->db->query($base_query);
			return $sql_result->result();
		}
		
		/**
		 * Gets products for vehicles. 
		 */
		public function get_product_for_vehicle($vehicle_id)
		{
			if(is_array($vehicle_id)) {
				$vehicle_id_list = '(' . implode(', ', $vehicle_id) . ')';
			}
			else
			{
				$vehicle_id_list = '(' . $vehicle_id . ')';
			}
			$base_query = $this->get_base_product_query();
			$base_query = $base_query . 
			"LEFT OUTER JOIN `product_vehicle`
				ON (`product_vehicle`.`product_id` = `product`.`id`)
			WHERE (`product_vehicle`.`vehicle_id` IN $vehicle_id_list
				OR `product_vehicle`.`vehicle_id` IS NULL);
			";
			$sql_result = $this->db->query($base_query);
			return $sql_result->result();
		}
		
		/**
		 * Gets all product IDs matching a query string
		 * To reduce chances of SQL injection, 
		 * the query string should only consist of alphanumerics and spaces. 
		 * (the last thing in the brackets was a space)
		 */
		public function get_product_for_query($query)
		{
			$base_query = $this->get_base_product_query();
			$base_query = $base_query . 
			"
				WHERE (`product`.`name` LIKE '%$query%' OR `product`.`description` LIKE '%$query%')
			";
			$sql_result = $this->db->query($base_query);
			return $sql_result->result();
		}
		
		/**
		 * This is a base function to call to retrieve data about all products
		 */
		public function get_all_products()
		{
			$base_query = $this->get_base_product_query();
			$sql_result = $this->db->query($base_query);
			return $sql_result->result();
		}
		
		/**
		 * Gets the bool facet values for a product. The array elements are facet_name and facet_value. 
		 * You will need to use something like the following to go through it:
		 * foreach ($query->result() as $row)
		 * {
		 * 		echo $row->facet_name;
		 * 		echo $row->facet_value;
		 * }
		 */
		public function get_bool_values_for_product($product_id)
		{
			$this->db->select('bool_facet.name AS facet_name, 
				bool_facet_value.value AS facet_value');
			$this->db->from('bool_facet_value_product');
			$this->db->join('bool_facet_value', 
				'bool_facet_value.id = bool_facet_value_product.bool_facet_value_id');
			$this->db->join('bool_facet', 'bool_facet_value.bool_facet_id = bool_facet.id');
			$this->db->where('bool_facet_value_product.product_id', $product_id);
			$query = $this->db->get();
			return $query->result();
		}
		
		/**
		 * Gets the int facet values for a product. The array elements are facet_name and facet_value. 
		 * You will need to use something like the following to go through it:
		 * foreach ($query->result() as $row)
		 * {
		 * 		echo $row->facet_name;
		 * 		echo $row->facet_value;
		 * }
		 */
		public function get_int_values_for_product($product_id)
		{
			$this->db->select('int_facet.name AS facet_name, 
				int_facet_value.value AS facet_value');
			$this->db->from('int_facet_value_product');
			$this->db->join('int_facet_value', 
				'int_facet_value.id = int_facet_value_product.int_facet_value_id');
			$this->db->join('int_facet', 'int_facet_value.int_facet_id = int_facet.id');
			$this->db->where('int_facet_value_product.product_id', $product_id);
			$query = $this->db->get();
			return $query->result();
		}
		
		/**
		 * Gets the float facet values for a product. The array elements are facet_name and facet_value. 
		 * You will need to use something like the following to go through it:
		 * foreach ($query->result() as $row)
		 * {
		 * 		echo $row->facet_name;
		 * 		echo $row->facet_value;
		 * }
		 */
		public function get_float_values_for_product($product_id)
		{
			$this->db->select('float_facet.name AS facet_name, 
				float_facet_value.value AS facet_value');
			$this->db->from('float_facet_value_product');
			$this->db->join('float_facet_value', 
				'float_facet_value.id = float_facet_value_product.float_facet_value_id');
			$this->db->join('float_facet', 
				'float_facet_value.float_facet_id = float_facet.id');
			$this->db->where('float_facet_value_product.product_id', $product_id);
			$query = $this->db->get();
			return $query->result();
		}
		
		/**
		 * Gets the string facet values for a product. The array elements are facet_name and facet_value. 
		 * You will need to use something like the following to go through it:
		 * foreach ($query->result() as $row)
		 * {
		 * 		echo $row->facet_name;
		 * 		echo $row->facet_value;
		 * }
		 */
		public function get_string_values_for_product($product_id)
		{
			$this->db->select('string_facet.name AS facet_name, 
				string_facet_value.value AS facet_value');
			$this->db->from('string_facet_value_product');
			$this->db->join('string_facet_value', 
				'string_facet_value.id = string_facet_value_product.string_facet_value_id');
			$this->db->join('string_facet', 
				'string_facet_value.string_facet_id = string_facet.id');
			$this->db->where('string_facet_value_product.product_id', $product_id);
			$query = $this->db->get();
			return $query->result();
		}
		 
	/**
	 * Gets or creates a temporary order for a session
	 * The handling of the returned id if the order already exists 
	 * has not yet been tested.
	 */
    public function get_temporary_order($session_id)
     {
       //check if order exists
       $this->db->select('id');
       $this->db->from('temporary_order');
       $this->db->where('session_id', $session_id);
       $query = $this->db->get();
	   $res_arr = $query->result();
       if(count($res_arr) >= 1) 
	   {
			$first_entry=$res_arr[0];
			return $first_entry->id;
       }
	   
       //else insert new temporary_order
       $this->db->insert('temporary_order', array('session_id' => $session_id));
       return $this->db->insert_id();

     }
     
	 /**
	  * Removes a temporary order from the table
	  */
     public function remove_temporary_order($session_id)
     {
       $order_id = get_temporary_order($session_id);
       $this->db->delete('temporary_order_product', array('temporary_order_id'=>$order_id));
       $this->db->delete('temporary_order', array('id'=>$order_id));
     }
     
     /**
      * updates a row in a temporary order
      */ 
    public function update_temporary_order($session_id, $product_id, $condition_id, $country_id, $qty)
     {
       //create the temporary order if it does not exist
       $order_id = get_temporary_order($session_id);
       
        //the fields to change
        $record = array('temporary_order_id'=>$order_id, 
          'product_id'=>$product_id, 
          'condition_id'=>$condition_id, 
          'country_id' =>$country_id, 
          'quantity' => $qty
         );
       
       //check if data exists
       $this->db->select('*');
       $this->db->from('temporary_order_product');
       $this->db->where('temporary_order_id', $order_id);
       $this->db->where('product_id', $product_id);
       $query = $this->db->get();
       
       //data DNE
       if($query->num_rows() < 1)
       {
         $this->db->insert('temporary_order_product', $record);
       }
       
       //data exists
       else {
         $this->db->update('temporary_order_product', $record);
       }
       
     }  
     
     /**
	  * Removes a product from a temporary order 
	  */
     public function remove_product_from_temporary_order($session_id, $product_id)
     {
       //create the temporary order if it does not exist
       $order_id = get_temporary_order($session_id);
       
       //check if data exists
       $conditions = array('product_id'=>$product_id, 'temporary_order_id' => $order_id);
       $this->db->delete('temporary_order_id', $conditions);
       
     }
     
     /**
	  * Clears a temporary order. 
	  */
     public function clear_temporary_order($session_id)
     {
         $this->db->delete('temporary_order_product', 
           array('order_id'=>get_temporary_order($session_id)));
     }
	 
	 /**
	  * Performs a transaction to create a real order 
	  * TODO: is this the right way to do this?
	  */
	 public function make_real_order($is_cod, $session_id, $branch_id, $person_id)
	 {
		$this->db->trans_start();
		
		//data for new order
		$insert_data =  array(
			'is_cod'=>$is_cod,
			'is_remote'=>TRUE,
			'person_id'=>$person_id,
			'order_date'=>date('Y-m-d'),
		);
		//this is supposed to be a != null check
		if($branch_id)
		{
			$insert_data['branch_id'] = $branch_id;
		}
		
		//create the real order
		$this->db->insert('order', $insert_data);
		$real_order_id = $this->db->insert_id();
		
		//get temporary order products
		$order_id = get_temporary_order($session_id);
		$sql_res = $this->db->get_where('temporary_order_product', array('temporary_order_id' => $order_id));
		$results = $sql_res->result();
		foreach($results as $row)
		{
				//add to real order
				$real_insert_data = array(
					'order_id' => $real_order_id,
					'product_id' => $row->product_id,
					'product_condition_id' => $row->product_condition_id,
					'country_id' => $row->country_id,
					'quantity' => $row->quantity,
				);
				$this->db->insert('order_product', $real_insert_data);
		}
		$this->db->trans_complete();
	 }
	}
	
?>