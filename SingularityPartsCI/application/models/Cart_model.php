<?php 
	
	class Cart_model extends CI_Model
	{
		//Performs Database interactions.
		function checkoutdb()
       { 
			$cod = $this->input->post('COD');
			$is_cod = (isset($cod) && $cod);
            $amountDue = $this->cart->total();
			$order_date = date('Y-m-d');
			$branch_id = null;
			$person_id = $this->session->userdata('person_id');
			$session_id = $this->session->userdata('session_id');
			$order_id = $this->make_real_order($is_cod, $session_id, $branch_id, $person_id);
			
			if(!$is_cod)
			{
                $ccdata['security_code'] =  $this->input->post('Code');
				$ccdata['amount'] = $amountDue;
				$ccdata['billing_address1'] = $data['address1'];
				$ccdata['billing_address2'] = $data['address'];
				$ccdata['billing_name'] = $data['name'];
				$ccdata['City'] = $data['City'];
				$ccdata['state'] = $data['State'];
				$ccdata['postcode'] = $data['zipcode'];
				$ccdata['exp_date'] = $this->input->post('exp_year') . '-' .$this->input->post('exp_month'). '-1' ;
				$clear_cc = $this->input->post('CC');
				$trim_cc = trim($clear_cc);
				$ccdata['cc_number'] = $trim_cc;
				$ccdata['order_id'] = $order_id;
				$this->db->insert('cc_payments', $ccdata);
			}	
			
        }
		
		/**
		 * Finishes loading information into a product result
		 */
		public function GenerateProductStubsForResult($products)
		{
			foreach($products as $row)
			{
				//whether or not we have started to print out the specs paragraph
				$has_printed_spec_p = false;
				
				echo '<hr/>';
					
				/*
				 * print standard attributes 
				 * (name, description, dimensions, weight)
				 */
				echo '<p name= "name">';
				echo 'Name: '.$row->product_name.'</p>';
				echo '<p name= "description">Description: ';
				echo $row->product_description.'</p>';
				echo '<p name= "dimensions">Dimensions: ';
				echo $row->length_meters.'x'.
					$row->width_meters.'x'.
					$row->height_meters.' meters</p>';
				echo '<p name= "weight">Weight: '.
					$row->weight_kilograms.' Kilograms</p>';
				echo '<p name= "manufacturer">Manufacturer: ';
					echo $row->manufacturer_name.'</p>';
				
				//print boolean facets
				$bool_facets = $this->get_bool_values_for_product($row->product_id);
				//we have some
				if(!empty($bool_facets))
				{
					//print out opening stuff if required
					if(!$has_printed_spec_p)
					{
						echo '<p name="Specs"> Additional Specs:';
						echo '<ul name="Specs">';
						$has_printed_spec_p = true;
					}
					foreach($bool_facets as $facet)
					{
						if($facet->facet_value)
							echo '<li>'.$facet->facet_name .': Yes </li>';
						else
							echo '<li>'.$facet->facet_name .': No </li>';
					}
				}
				
				//print integer specs
				$int_facets = $this->get_int_values_for_product($row->product_id);
				//we have some
				if(!empty($int_facets))
				{
					//print out opening stuff if required
					if(!$has_printed_spec_p)
					{
						echo '<p name="Specs"> Additional Specs:';
						echo '<ul name="Specs">';
						$has_printed_spec_p = true;
					}
					foreach($int_facets as $facet)
					{
						echo '<li>'.$facet->facet_name .': '.$facet->facet_value .'</li>';
					}
				}
				
				//print float specs
				$float_facets = $this->get_float_values_for_product($row->product_id);
				//we have some
				if(!empty($float_facets))
				{
					//print out opening stuff if required
					if(!$has_printed_spec_p)
					{
						echo '<p name="Specs"> Additional Specs:';
						echo '<ul name="Specs">';
						$has_printed_spec_p = true;
					}
					foreach($float_facets as $facet)
					{
						echo '<li>'.$facet->facet_name .': '.$facet->facet_value .'</li>';
					}	
				}
				
				//print string specs
				$string_facets = $this->get_string_values_for_product($row->product_id);
				if(!empty($string_facets))
				{
					//print out opening stuff if required
					if(!$has_printed_spec_p)
					{
						echo '<p name="Specs"> Additional Specs:';
						echo '<ul name="Specs">';
						$has_printed_spec_p = true;
					}
					foreach($string_facets as $facet)
					{
						echo '<li>'.$facet->facet_name .': '.$facet->facet_value .'</li>';
					}
				}
				//print closing tags
				if($has_printed_spec_p)
				{
					echo '</ul></p>';
				}
				
				//print price, country, condition, available qty
				echo '<p name= "price">Price: '.$row->product_price.' USD </p>';
				echo '<p name= "CountryofOrigin">Country of Origin: '.$row->country_name .'</p>';
				echo '<p name= "Condition"> Condition: '.$row->condition_name .'</p>';
				
				//offer to add to cart
				if($row->quantity_available > 0)
				{
					echo '<p name= "Quantity"> Quantity Available as of '; 
					echo date('Y-m-d H:i:s') . ' ' . date('T') . ': ';
					echo $row->quantity_available.'</p>';
					echo '<p>';
					echo anchor(
						'Cart/add/'.$row->product_id. '/' 
						.$row->condition_id . '/' . $row->country_id, 
						'Add to Cart', 
						'title="Your Cart"');
					echo '</p>';
				}
				else
				{
					echo '<p name= "Quantity"> Out of Stock as of '; 
					echo date('Y-m-d H:i:s') . ' ' . date('T');
					echo '</p>';
				}
				echo '<hr/>';
			}	
		}
		 
		/**
		 * Returns the base product query STRING. 
		 * DOES NOT perform query. 
		 */
		private function get_base_product_query()
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
					LEFT OUTER JOIN `product_vehicle` ON (`product`.`id` = `product_vehicle`.`product_id`)
			';
		}
		
		function is_unsigned_int($id)
		{
			return (is_int($id) && intval($id) >= 0);
		}
		
		/**
		 * This is the main product retrieval function. 
		 * This actually performs the query.
		 * $args is an array with any of the following:
		 * 'category_id' - either one category_id or an array of category_id
		 * 'vehicle_id' - either one vehicle_id or an array of vehicle_id
		 * 'search_string' - a string that the user types in a search box
		 * 'product_id' 
		 * 'condition_id'
		 * 'country_id' 
		 *
		 * The values returned can be found in get_base_product_query(), 
		 * but as of now they are:
		 * product_id (internal use only)
		 * manufacturer_name
		 * product_name
		 * product_description
		 * category_name
		 * category_id (internal use only)
		 * length_meters
		 * width_meters 
		 * height_meters
		 * weight_kilograms
		 * barcode
		 * product_price
		 * condition_name
		 * condition_id (internal use only)
		 * country_id (internal use only)
		 * country_name
		 * quantity_available
		 */
		function get_products($args)
		{
			//get the main query
			$has_where = false;
			$base_query = $this->get_base_product_query();
			$data_arr = array();
			
			//we have a vehicle; let's try to add it.
			if(isset($args['vehicle_id']))
			{
				//get the vehicle(s)
				$vehicle_id = $args['vehicle_id'];
				
				//get array of vehicles
				if(!is_array($vehicle_id)) 
				{
					$vehicle_id_list = array($vehicle_id);
				}
				else $vehicle_id_list = $vehicle_id;
			
				//check that vehicle ids are sane
				if(array_filter($vehicle_id_list, array($this, 'is_unsigned_int')))
				{
					//make the id string
					$vehicle_id_str = '('.implode(',', $vehicle_id_list).')';
					
					//append to the query string
					if(!$has_where)
					{
						$base_query = $base_query . 'WHERE(';
						$has_where = TRUE;
					}
					//otherwise, assume there exists a where string and add an 'and'
					else
					{
						$base_query = $base_query . 'AND';
					}
					
					//append conditions to the query string
					$base_query = $base_query . 
						"(`product_vehicle`.`vehicle_id` IN $vehicle_id_str OR `product_vehicle`.`vehicle_id` IS NULL)";
				}
			}
			
			//we have a search string
			if(isset($args['search_string']))
			{
				$search_string = $args['search_string'];
					
				//formulate query arguments
				$like_str = '%'.$search_string.'%';
				$data_arr[] = $like_str;
				$data_arr[] = $like_str;
				$data_arr[] = $like_str;
				$data_arr[] = $like_str;
				$data_arr[] = $like_str;
			
				//append to the query string
				if(!$has_where)
				{
					$base_query = $base_query . 'WHERE(';
					$has_where = TRUE;
				}
				//otherwise, assume there exists a where string and add an 'and'
				else
				{
					$base_query = $base_query . 'AND';
				}
				
				//continue formulating query string
				$base_query = $base_query . '(`product`.`name` LIKE ? 
					OR `product`.`description` LIKE ?
					OR `manufacturer`.`name` LIKE ? 
					OR `product_condition`.`name` LIKE ? 
					OR `country`.`name` LIKE ?';
				
				//we have a part number; add to query
				if($this->is_unsigned_int($search_string))
				{
					$data_arr[] = intval($search_string);
					$base_query = $base_query . 'OR `product`.`id` = ?)';
				}
				//otherwise just add the closing )
				else $base_query = $base_query . ')';
			}
			
			//we have a category; let's try to add it.
			if(isset($args['category_id']))
			{
				//get the category(ies)
				$category_id = $args['category_id'];
				
				//get array of categories
				if(!is_array($category_id)) 
				{
					$category_id_list = array($category_id);
				}
				else $category_id_list = $category_id;
			
				//check that category ids are sane
				if(array_filter($category_id_list, array($this, 'is_unsigned_int')))
				{
					//make the id string
					$category_id_str = '('.implode(',', $category_id_list).')';
					
					//append to the query string
					if(!$has_where)
					{
						$base_query = $base_query . 'WHERE(';
						$has_where = TRUE;
					}
					//otherwise, assume there exists a where string and add an 'and'
					else
					{
						$base_query = $base_query . 'AND';
					}
					
					//append conditions to the query string
					$base_query = $base_query . 
						"(`product`.`category_id` IN $category_id_str)";
				}
			}
			
			//we have a country; let's try to add it.
			if(isset($args['country_id']))
			{
				//get the country(s)
				$country_id = $args['country_id'];
				
				//get array of countrys
				if(!is_array($country_id)) 
				{
					$country_id_list = array($country_id);
				}
				else $country_id_list = $country_id;
			
				//check that country ids are sane
				if(array_filter($country_id_list, array($this, 'is_unsigned_int')))
				{
					//make the id string
					$country_id_str = '('.implode(',', $country_id_list).')';
					
					//append to the query string
					if(!$has_where)
					{
						$base_query = $base_query . 'WHERE(';
						$has_where = TRUE;
					}
					//otherwise, assume there exists a where string and add an 'and'
					else
					{
						$base_query = $base_query . 'AND';
					}
					
					//append conditions to the query string
					$base_query = $base_query . 
						"(`product_price`.`country_id` IN $country_id_str)";
				}
			}
			
			//we have a condition; let's try to add it.
			if(isset($args['condition_id']))
			{
				//get the condition(s)
				$condition_id = $args['condition_id'];
				
				//get array of conditions
				if(!is_array($condition_id)) 
				{
					$condition_id_list = array($condition_id);
				}
				else $condition_id_list = $condition_id;
			
				//check that condition ids are sane
				if(array_filter($condition_id_list, array($this, 'is_unsigned_int')))
				{
					//make the id string
					$condition_id_str = '('.implode(',', $condition_id_list).')';
					
					//append to the query string
					if(!$has_where)
					{
						$base_query = $base_query . 'WHERE(';
						$has_where = TRUE;
					}
					//otherwise, assume there exists a where string and add an 'and'
					else
					{
						$base_query = $base_query . 'AND';
					}
					
					//append conditions to the query string
					$base_query = $base_query . 
						"(`product_price`.`condition_id` IN $condition_id_str)";
				}
			}
			
			//we have a product; let's try to add it.
			if(isset($args['product_id']))
			{
				//get the product(s)
				$product_id = $args['product_id'];
				
				//get array of products
				if(!is_array($product_id)) 
				{
					$product_id_list = array($product_id);
				}
				else $product_id_list = $product_id;
			
				//check that product ids are sane
				if(array_filter($product_id_list, array($this, 'is_unsigned_int')))
				{
					//make the id string
					$product_id_str = '('.implode(',', $product_id_list).')';
					
					//append to the query string
					if(!$has_where)
					{
						$base_query = $base_query . 'WHERE(';
						$has_where = TRUE;
					}
					//otherwise, assume there exists a where string and add an 'and'
					else
					{
						$base_query = $base_query . 'AND';
					}
					
					//append products to the query string
					$base_query = $base_query . 
						"(`product_price`.`product_id` IN $product_id_str)";
				}
			}
		
			if($has_where) $base_query = $base_query . ')';
			$results = $this->db->query($base_query, $data_arr);
			return $results->result();
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
			$this->db->from('product_string_facet_value');
			$this->db->join('string_facet_value', 
				'string_facet_value.id = product_string_facet_value.string_facet_value_id');
			$this->db->join('string_facet', 
				'string_facet_value.string_facet_id = string_facet.id');
			$this->db->where('product_string_facet_value.product_id', $product_id);
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
       $order_id = $this->get_temporary_order($session_id);
       $this->db->delete('temporary_order_product', array('temporary_order_id'=>$order_id));
       $this->db->delete('temporary_order', array('id'=>$order_id));
     }
     
     /**
      * updates a row in a temporary order
      */ 
    public function update_temporary_order($session_id, $product_id, $condition_id, $country_id, $qty)
     {
		if($qty == null || $qty <= 0) 
		{
			$this->remove_product_from_temporary_order($session_id, $product_id, $condition_id, $country_id);
			return;
		}
       //create the temporary order if it does not exist
       $order_id = $this->get_temporary_order($session_id);
       
        //the fields to change
        $record = array('temporary_order_id'=>$order_id, 
          'product_id'=>$product_id, 
          'product_condition_id'=>$condition_id, 
          'country_id' =>$country_id, 
          'quantity' => $qty
         );
       
       //check if data exists
       $this->db->select('*');
       $this->db->from('temporary_order_product');
       $this->db->where('temporary_order_id', $order_id);
       $this->db->where('product_id', $product_id);
	   $this->db->where('product_condition_id', $condition_id);
	   $this->db->where('country_id', $country_id);
       $query = $this->db->get();
       
       //data DNE
       if($query->num_rows() < 1)
       {
         $this->db->insert('temporary_order_product', $record);
       }
       
       //data exists
       else {
		 $this->db->where('temporary_order_id', $order_id);
         $this->db->where('product_id', $product_id);
	     $this->db->where('product_condition_id', $condition_id);
		 $this->db->where('country_id', $country_id);
         $this->db->update('temporary_order_product', $record);
       }
       
     }  
     
     /**
	  * Removes a product from a temporary order 
	  */
     public function remove_product_from_temporary_order($session_id, $product_id, $condition_id, $country_id)
     {
       //create the temporary order if it does not exist
       $order_id = $this->get_temporary_order($session_id);
       
       //check if data exists
       $conditions = array('product_id'=>$product_id, 
			'product_condition_id' =>$condition_id, 
			'temporary_order_id' => $order_id,
			'country_id' => $country_id
		);
       $this->db->delete('temporary_order_product', $conditions);
       
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
		$order_id = $this->get_temporary_order($session_id);
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
		//delete temporary order stuff
		$this->db->delete('temporary_order', array('session_id'=>$session_id));
		$this->db->trans_complete();
		if ($this->db->trans_status() === FALSE)
		{
			$this->db->trans_rollback();
			show_error('trans failed');
		}
		else 
		{
			$this->db->trans_commit();
			return $real_order_id;
		}
	 }
	 
	 public function get_price($product_id, $condition_id, $country_id)
	 {
		$this->db->select('price');
		$this->db->from('product_price');
		$this->db->where('product_id', $product_id);
		$this->db->where('condition_id', $condition_id);
		$this->db->where('country_id', $country_id);
		$this->db->where('start_date <= CURDATE()');
		$this->db->where('(end_date > CURDATE() OR end_date IS NULL)');
		$res = $this->db->get();
		if($res->num_rows() <= 0) return -1;
		else return $res->row()->price;
	 }
	 public function get_max_quantity($product_id, $condition_id, $country_id)
	 {
		$this->db->select('netqty');
		$this->db->from('total_available_product');
		$this->db->where('the_product_id', $product_id);
		$this->db->where('the_product_condition_id', $condition_id);
		$this->db->where('the_country_id', $country_id);
		$res = $this->db->get();
		if($res->num_rows() <= 0) return 0;
		else return $res->row()->NetQty;
	 }
	 
	 function get_name($product_id)
	 {
		$this->db->select('name');
		$this->db->from('product');
		$this->db->where('product.id', $product_id);
		$res = $this->db->get();
		if($res->num_rows() <= 0) return null;
		else return $res->row()->name;
	 }
	}
	
?>