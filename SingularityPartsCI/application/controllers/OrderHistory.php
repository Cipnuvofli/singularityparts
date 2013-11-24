<?php
class OrderHistory extends CI_Controller{
	
	
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
		
		//now go to the view function
		$this->getData();
    }
	function getData()
	{
		$this->load->model('OrderHistory_model');
		$data['orders'] = $this->OrderHistory_model->get_orders($this->session->userdata('person_id'));
		$data['returns'] = $this->OrderHistory_model->get_returned_items($this->session->userdata('person_id'));
		$data['cancellations'] = $this->OrderHistory_model->get_cancelled_orders($this->session->userdata('person_id'));
		$this->load->view('OrderHistory_view', $data);
	}
	
}
?>