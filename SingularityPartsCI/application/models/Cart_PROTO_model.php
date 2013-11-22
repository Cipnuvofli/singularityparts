<?php 
	/*
		 * TODO: 
		 * 0. The actual user interface and the controller. 
		 * 1. Create a way to easily update the temporary_order 
			and temporary_order_product tables as the shopping cart changes. 
			These tables are used to help reduce the chance of a product being "sold out" 
			before the user gets to it. Note that unless the user remains pretty active on the site,
			the quantities will not be real-time (so the UI should have a "quantities current as of DATETIME" disclaimer).
		 * 2. Turning a shopping cart order into an order in the order and order_product tables,
			and deleting the corresponding shopping cart order. (transaction)
		 * 3. Adding payment
		 * 4. Calculating tax and shipping
		 *
		 *
		 * WHAT IS READY FOR TESTING:
		 * 1. retrieving product ids for a person
		 * 2. retrieving product ids for a vehicle
		 * 3. narrowing a list of product ids with search terms (in name or description)
		 * 4. retrieving facets for a product (name and value)
		 * 5. 
		 */
	class Shopping_PROTO_model extends CI_Model
	{
	
		public function _construct()
		{
			
			parent::_construct();
		}
		
		/**
		 * Gets all product IDs.
		 */
		public function get_all_product_ids()
		{
			$query = $this->db->get('product');
			return array_values($query->result());
		}
		
		/**
		 * gets the info on a product from the product table ONLY
		 * The fields are named the same as in the product table. 
		 * use something like the following
		 * foreach ($query->result() as $row)
		 * {
		 *		//for each field
		 * 		echo $row->description;
		 * }
		 */
		public function get_product_info($product_id)
		{
			return $this->db->get_where('product', array('id' => $product_id));
		}
		
		/**
		 * Gets all products that are designed for a specific person's vehicle
		 */
		 public function get_product_ids_for_person($person_id)
		{
			//get vehicles for person
			$this->db->select('vehicle_id');
			$this->db->from('person');
			$this->db->where('id', $person_id);
			$query = $this->db->get();			
			$vehicle_results = array_values($query->result());
			
			if(empty($vehicle_results)) return array();
			else return get_product_ids_for_vehicle($vehicle_results);
		}
		 
		/**
		 * Gets all products that are designed for specific vehicles
		 */
		public function get_product_ids_for_vehicle($vehicle_ids)
		{
			$this->db->select('product_id');
			$this->db->from('product_vehicle');
			$this->db->where_in('vehicle_id', $vehicle_ids);
			$query = $this->db->get();
			return array_values($query->result);
		}
		
		/**
		 * Searches for text in a list of products
		 */
		public function search_for_text($product_list, $text)
		{
			$this->db->select('product_id');
			$this->db->from('product');
			$this->db->where_in('id', $product_list);
			$this->db->where('(name LIKE ? OR description LIKE ?)', array($text, $text));
			$query = $this->db->get();
			return array_values($query->result);
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
			return $query;
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
			return $query;
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
			return $query;
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
			return $query;
		}
		 
		/**
		 * Gets the current chain-wide price options for a product, 
		 * along with the currently available branch-specific quantities. Fields returned:
		 * condition_name
		 * condition_id
		 * country_name
		 * country_id
		 * price
		 * net_qty
		 * 
		 */
		public function get_price_and_qty_options_for_product($product_id, $branch_id)
		{
			$this->db->select('product_condition.name AS condition_name, 
				product_condition.id AS condition_id, 
				country.name AS country_name, country.id AS country_id,
				product_price.price AS product_price, 
				total_available_product.netqty AS net_qty');
			$this->db->from('product_price');
			$this->db->join('product_condition', 'product_condition.id = product_price.product_condition_id');
			$this->db->join('country', 'country.id = product_price.country_id');
			$this->db->join('total_available_product', 
				'(country.id = total_available_product.the_country_id AND 
				product_condition.id = total_available_product.the_product_condition_id AND
				product_price.product_id = total_available_product.the_product_id)');
			$this->db->where('product_price.product_id', $product_id);
			$this->db->where('product_price.start_date <= CURDATE()');
			$this->db->where('(product_price.end_date > CURDATE() OR product_price.end_date IS NULL)');
			$query = $this->db->get();
			return $query;
		}
		
	}
	
?>