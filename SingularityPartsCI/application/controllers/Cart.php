<?php
class Cart extends CI_Controller{
		function loadStuff()
		{
			include_once('Dashboard.php');
			$this->load->helper('form');
			$this->load->helper('html');
			$this->load->helper('url');
			$this->load->model('Cart_model');
               
			//check if login ok
			if(!$this->session->userdata('logged_in') || !$this->session->userdata('person_id'))
			{
				redirect('');
			}
               
			//load the standard models and views
			$this->load->model('Front_model');
			$data['customer_mode'] = Dashboard::is_mode_ok(FALSE);
			$data['store_mode'] = Dashboard::is_mode_ok(TRUE);
			$data['page_title'] = "Singularity Parts - Your Order History";
			$this->load->view('Front_view',$data);
		}
		
		function index()
        {
                $this->loadStuff();
                //load the cart information.
                $this->load->model('Cart_model');
                
				$this->load->view('cart_viewer', $this->get_max_quantities());
        }
		
		/** 
		 * Adjusts maximum quantities shown to the user.
		 */
		function get_max_quantities()
		{
			$data = array();
			foreach($this->cart->contents() as $items)
			{
				
				//get new qty, product id, condition id, country id
				$curr_qty = $items['qty'];
				$product_id = $items['id'];
				$condition_id = $items['options']['condition_id'];
				$country_id = $items['options']['country_id'];
				
				//check if in bounds
				$max_qty = $this->Cart_model->get_max_quantity($product_id, $condition_id, $country_id);
	
				$data['max_qty'][$items['rowid']] = $max_qty + $curr_qty;
				
			}
			return $data;
		}
		
		function add($product_id, $condition_id, $country_id)
		{
			$this->loadStuff();
			$price = $this->Cart_model->get_price($product_id, $condition_id, $country_id);
			$available_qty = $this->Cart_model->get_max_quantity($product_id, $condition_id, $country_id);
			$name = $this->Cart_model->get_name($product_id);
			
			//error handling
			if($price === null || $available_qty === null || $name === null) redirect('cart');
			if($available_qty <= 0) redirect('cart');
			
			//check if already in cart
			foreach ($this->cart->contents() as $items)
			{
				if($items['id'] == $product_id 
					&& isset($items['options']['condition_id']) 
					&& $items['options']['condition_id'] == $condition_id 
					&& isset($items['options']['country_id']) 
					&& $items['options']['country_id'] == $country_id)
				{
					redirect('cart');
				}
			}
			
			//insert into cart
			$qty = 1;
			$data = array(
				'id' => $product_id,
				'qty' =>$qty,
				'price' => $price,
				'name' => $name,
				'options' =>array(
					'condition_id'=>$condition_id,
					'country_id'=>$country_id,
				)
			);
			$this->cart->insert($data);
			
			//insert into db
			$session_id = $this->session->userdata('session_id');
			$this->Cart_model->update_temporary_order($session_id, $product_id, $condition_id, $country_id, $qty);
			
			//redirect
			redirect('cart');
		}
		function update()
		{
			$this->loadStuff();
			$session_id = $this->session->userdata('session_id');
			foreach($this->cart->contents() as $items)
			{
				
				//get new qty, product id, condition id, country id
				$curr_qty = $items['qty'];
				$new_qty = $this->input->post($items['rowid']);
				$product_id = $items['id'];
				$condition_id = $items['options']['condition_id'];
				$country_id = $items['options']['country_id'];
				
				//check if in bounds
				$max_qty = $this->Cart_model->get_max_quantity($product_id, $condition_id, $country_id);
				
				//not in bounds: cap at what we have.
				if($new_qty > $max_qty + $curr_qty) 
				{
					$reset_qty = $curr_qty + $max_qty;
					if($curr_qty < 0 || $max_qty < 0) $reset_qty = 0;
					
					//update data
					$data = array(
						'rowid' => $items['rowid'],
						'qty'=> $reset_qty,
					);
					$this->cart->update($data);
					//update temporary order
					$this->Cart_model->update_temporary_order(
						$session_id, $product_id, $condition_id, $country_id, $reset_qty);
					continue;
				}
					
				//update data
				$data = array(
					'rowid' => $items['rowid'],
					'qty' => $new_qty,
				);	
				$this->cart->update($data); 
				
				//update temporary order
				$this->Cart_model->update_temporary_order(
					$session_id, $product_id, $condition_id, $country_id, $new_qty); 
			}	
			redirect('cart');
		}
		function checkout()
		{
			    
                        $this->load->helper('form');
                        $this->load->library('form_validation');
                        $this->load->helper('url');
                        $this->load->helper('html');
                        $this->load->model('user_model');
						$this->load->model('Cart_model');
				
                        $data['title']="Checkout";
						$data['COD'] = $this->input->post('COD');
						
					   
					   if(!isset($data['COD']))
					   {
						$this->form_validation->set_rules('CC','Credit Card Number','required');
                        $this->form_validation->set_rules('Code','Security Code','required|max_length[3]');
					   }
                        $this->form_validation->set_rules('Address','Address','required');
						$this->form_validation->set_rules('City','City','required');
						$this->form_validation->set_rules('state','State','required');
						$this->form_validation->set_rules('Zipcode','Zipcode','required|numeric');
						$this->form_validation->set_rules('Country','Country','required');
						$this->form_validation->set_rules('Phone','Phone', 'required');
												
                        if($this->form_validation->run() === FALSE)
                        {
								$this->load->view('Failure');
                        }
                        else
                        {
                                $this->Cart_model->checkoutdb();
                                $this->load->view('success');
                       
                        }
						//Purge Shopping cart
						redirect('Front');

		}
			public static function has_access()
			{
				$CI = get_instance();
				
				//check if login ok
				if(!$CI->session->userdata('logged_in') 
					|| !$CI->session->userdata('person_id')) return false;
				else return true;
			}
			
			public static function is_store_mode()
			{
				return FALSE;
			}
			
			public static function get_controller_name()
			{
				return 'Shopping Cart';
			}
	

       
}
?>
