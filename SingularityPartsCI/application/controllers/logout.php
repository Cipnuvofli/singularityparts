<?php
class Logout extends CI_Controller {
	function loadStuff()
	{
		//load helpers
		$this->load->helper('form');
		$this->load->helper('html');
		$this->load->helper('url');
		$this->load->model('Front_model');
		$this->load->library('form_validation');
		$this->load->library('ControllerList');
		
		//load views
		$data['result'] = $this->Front_model->getData();
		$data['page_title'] = "Singularity Parts";
		
			//get all controllers
		$controllers = $this->controllerlist->getControllers();
		$store_controller_arr = array();
		$customer_controller_arr = array();
		
		//do any have the methods we need
		foreach($controllers as $controller_name=>$controller)
		{
			//we have found it
			if(in_array('has_access', $controller) 
				&& in_array('get_controller_name', $controller) 
				&& in_array('is_store_mode', $controller))
			{
				//obtain methods
				$ctrl = new ReflectionClass($controller_name);
				$has_access = $ctrl->getMethod('has_access');
				$get_controller_name = $ctrl->getMethod('get_controller_name');
				$is_store_mode = $ctrl->getMethod('is_store_mode');
				
				//invoke methods
				$access_result = $has_access->invoke(null);
				$printable_name = $get_controller_name->invoke(null);
				$store_mode = $is_store_mode->invoke(null);
				
				//we have access
				if($access_result)
				{
					//add to name
					$controller_value = array(
						'print_name' => $printable_name, 
						'link_name'=>$controller_name
					);
					
					//add to appropriate mode
					if($store_mode)
						$store_controller_arr[] = $controller_value;
					else
						$customer_controller_arr[] = $controller_value;
				}
			}
		}
		
		//load the dashboard view
		$data['store_controller_arr'] = $store_controller_arr;
		$data['customer_controller_arr'] = $customer_controller_arr;
		
		$this->load->view('Front_view',$data);
	}
	function logout()
	{
		//load helpers
		$this->loadStuff();
			
		//load front view
		$data['result'] = $this->Front_model->getData();
		$data['page_title'] = "Singularity Parts";
		$this->load->view('Front_view',$data);
		
		$this->Front_model->logout();
	}
	public static function has_access()
	{
	$CI = get_instance();
		
		//check if login ok
		if(!$CI->session->userdata('logged_in') || !$CI->session->userdata('person_id'))
		{
			return false;
		}
		else 
		{
			return true;
		}
	}
	public static function get_controller_name()
	{
		echo 'Logout';
	}
	public static function is_store_mode()
	{
		return FALSE;
	}
}	
?>