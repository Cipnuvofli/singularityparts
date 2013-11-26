<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Order_Ship extends CI_Controller{
	
	public static function has_access()
	{
		$CI = get_instance();
		if(!$CI->session->userdata('person_id') || 
			!$CI->session->userdata('logged_in')) return false;
		$CI->load->model('RBAC_model');
		if(!$CI->RBAC_model->has_permission(
				$CI->session->userdata('person_id'), 
				'order_shipping',
				array(	
					'role_permission.can_modify' => TRUE,
					
				)
			)
		)
		{
			return false;
		}
		else return true;
	}
	
	public static function is_store_mode()
	{
		return TRUE;
	}
	
	public static function get_controller_name()
	{
		return 'Ship An Order';
	}
	
	function loadStuff()
	{
		include_once('Dashboard.php');
		$this->load->helper('form');
		$this->load->helper('html');
		$this->load->helper('url');
		$this->load->model('OrderShip_model');

		if(!self::has_access()) redirect('');
		
	}
	
	function showStuff()
	{
		//load the standard models and views
		$this->load->model('Front_model');
		$data['page_title'] = "Singularity Parts - Your Order History";
		$data['customer_mode'] = Dashboard::is_mode_ok(FALSE);
		$data['store_mode'] = Dashboard::is_mode_ok(TRUE);
		$this->load->view('Front_view',$data);
		
		//now create the form
		
		$order_info['orders'] = $this->OrderShip_model->get_remote_orders();
		$this->load->view('OrderShip_view', $order_info);
	}
	function index()
	{
			$this->loadStuff();
			$this->showStuff();
	
    }
	
	function check_select($post_string)
	{
		
		if($post_string == '0')
		{
			$this->form_validation->set_message('check_select', 'Need to select something in %s');
			return false;
		}
		else return true;
	}
	
	function check_float($post_ufloat)
	{
		if(!is_float($post_ufloat) || floatval($post_ufloat) <= 0.0)
		{
			$this->form_validation->set_message('check_float', 'Need a number that is > 0 in %s');
			return false;
		}
		else return true;
	}
	
	function submit()
	{
		$this->loadStuff();
		$this->load->library('form_validation');
		$this->form_validation->set_rules('order_id', 'Order', 'callback_check_select');
		$this->form_validation->set_rules('sdm', 'ShipMonth', 'callback_check_select');
		$this->form_validation->set_rules('sdd', 'ShipDay', 'callback_check_select');
		$this->form_validation->set_rules('sdy', 'ShipYear', 'callback_check_select');
		$this->form_validation->set_rules('rate', 'Rate', 'required|callback_unsigned_float');
		$this->form_validation->set_rules('tracking', 'Tracking', 'required');
		$this->form_validation->set_rules('method', 'Method', 'required');
		
		if($this->form_validation->run() === TRUE)
			$this->OrderShip_model->mark_shipped();
		$this->showStuff();
	}
	
}
?>