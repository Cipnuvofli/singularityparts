<?php
class Cart extends CI_Controller{

        function index()
        {
                include_once('Dashboard.php');
                $this->load->helper('form');
                $this->load->helper('html');
                $this->load->helper('url');
				$this->load->model('Cart_Model');
               
                //check if login ok
                if(!$this->session->userdata('logged_in') || !$this->session->userdata('person_id'))
                {
                        //insert real login fail code here
                        redirect('');
                }
               
                //load the standard models and views
                $this->load->model('Front_model');
                $data['customer_mode'] = Dashboard::is_mode_ok(FALSE);
                $data['store_mode'] = Dashboard::is_mode_ok(TRUE);
                $data['page_title'] = "Singularity Parts - Your Order History";
                $this->load->view('Front_view',$data);
               
                //load the cart information.
                $this->load->model('Cart_model');
                $this->Cart_model->get_product_for_vehicle_and_query(123, 'hello');
                echo('<br/><br/>');
                $this->Cart_model->get_product_for_vehicle_and_query(array(123, 234), 'hello');
				$this->load->view('cart_viewer');
        }
		function add($id, $quantity, $price, $name)
		{
			$data = array(
			'id' => $id,
			'qty' =>1,
			'price' => $price,
			'name' => $name
			);
			$this->cart->insert($data);
			redirect('cart');
		}
		function update()
		{
			$data = array(
               //'rowid' => array(),
               //'qty'   => array()
            );
			$this->cart->update($data); 
			redirect('cart');
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
