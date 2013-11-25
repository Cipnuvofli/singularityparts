<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class OrderHistory extends CI_Controller{
	
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
		return 'View Your Order History';
	}
	
	function index()
	{
		include_once('Dashboard.php');
		$this->load->helper('form');
		$this->load->helper('html');
		$this->load->helper('url');
		
		if(!self::has_access()) redirect('');
		
		//load the standard models and views
		$this->load->model('Front_model');
		$data['page_title'] = "Singularity Parts - Your Order History";
		$data['customer_mode'] = Dashboard::is_mode_ok(FALSE);
		$data['store_mode'] = Dashboard::is_mode_ok(TRUE);
		$this->load->view('Front_view',$data);
		
		//now go to the view function
		$this->getData();
    }
	function getData()
	{
		$this->load->model('OrderHistory_model');
		$data['orders'] = $this->OrderHistory_model->get_orders($this->session->userdata('person_id'));
		$data['shipped_orders'] = $this->OrderHistory_model->get_shipped_orders($this->session->userdata('person_id'));
		$data['returns'] = $this->OrderHistory_model->get_returned_items($this->session->userdata('person_id'));
		$data['cancellations'] = $this->OrderHistory_model->get_cancelled_orders($this->session->userdata('person_id'));
		$this->load->view('OrderHistory_view', $data);
	}
	
}
?>