<?php
class Cart extends CI_Controller{

	function index()
	{
		$this->load->helper('form');
		$this->load->helper('html');
		$this->load->helper('url');
		
		//check if login ok
		if(!$this->session->userdata('logged_in') || !$this->session->userdata('person_id'))
		{
			//insert real login fail code here
			redirect('');
		}
		
		//load the standard models and views
		$this->load->model('Front_model');
		$data['page_title'] = "Singularity Parts - Your Order History";
		$this->load->view('Front_view',$data);
		
		//load the cart information. 
		$this->load->model('Cart_model');
		$this->Cart_model->get_product_for_vehicle_and_query(123, 'hello');
		echo('<br/><br/>');
		$this->Cart_model->get_product_for_vehicle_and_query(array(123, 234), 'hello');
	}
	
}
?>