<?php

/**
 * This is a simple administrative dashboard. 
 * What it does:
 * 1. Finds all controllers in the application, and their methods 
 *    (using Peter Prins' ControllerList.php from
 *     https://raw.github.com/pprins/CI_ListControllers/master/Controllerlist.php )
 * 2. Goes through all of the controllers found, searching for ones with the following static methods:
 *		a. has_access() - returns true if the current user has access, false otherwise.
 * 		b. get_controller_name() - returns a name for the controller suitable for the user.
 * 		c. is_store_mode() - returns true if part of store mode; false if part of customer mode.
 * 3. Calls those methods, and saves the controllers for which has_access() returned true
 * 4. Passes the urls and the names of the controllers that passed through step 3 to the Dashboard_view.
 */
class Dashboard extends CI_Controller {
	private $hasFront = false;
	
	function loadStuff()
	{
		$this->load->helper('url');
		$this->load->helper('form');
		$this->load->helper('html');
		$this->load->model('Cart_model');
		$this->load->library('ControllerList');
	}
	
	public static function is_mode_ok($is_store_mode)
	{
		$controller_arr = self::get_dash_data($is_store_mode);
		if(empty($controller_arr)) return false;
		else return true;
	}
	
	private static function get_dash_data($should_be_store_mode)
	{
		$CI = get_instance();
		$CI->load->library('ControllerList');
		
		//get all controllers
		$controllers = $CI->controllerlist->getControllers();
		$controller_arr = array();
		
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
				if($access_result && $store_mode == $should_be_store_mode)
				{
					//add to name
					$controller_value = array(
						'print_name' => $printable_name, 
						'link_name'=>$controller_name
					);
					$controller_arr[] = $controller_value;
				}
			}
		}
		return $controller_arr;
	}
	
	function customer_mode()
	{
		$this->loadStuff();
		$this->showFront();
		
		$controller_arr = self::get_dash_data(FALSE);
		$data['customer_controller_arr'] = $controller_arr;
		if(empty($controller_arr)) redirect('');
		else $this->load->view('Dashboard_view', $data);
		
	}
	
	function store_mode()
	{
		$this->loadStuff();
		$this->showFront();
		
		$controller_arr = self::get_dash_data(TRUE);
		$data['store_controller_arr'] = $controller_arr;
		if(empty($controller_arr)) redirect('');
		else $this->load->view('Dashboard_view', $data);
	}
	
	function showFront()
	{
		if($this->hasFront) return;
		
		//load stuff
		$this->load->model('Front_model');
		
		//show stuff
		$data['result'] = $this->Front_model->getData();
		$data['page_title'] = "Singularity Parts";
		$data['customer_mode'] = Dashboard::is_mode_ok(FALSE);
		$data['store_mode'] = Dashboard::is_mode_ok(TRUE);
		$this->load->view('Front_view',$data);
		$this->hasFront = true;
	}
	
	function index()
	{
		//load stuff and show front
		$this->loadStuff();
		$this->showFront();
		
		//assume customer mode
		$this->customer_mode();
		
	}
}

?>