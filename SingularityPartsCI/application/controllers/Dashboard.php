<?php

/**
 * This is a simple administrative dashboard. 
 * What it does:
 * 1. Finds all controllers in the application, and their methods 
 *    (using Peter Prins' ControllerList.php from
 *     https://raw.github.com/pprins/CI_ListControllers/master/Controllerlist.php )
 * 2. Goes through all of the controllers found, searching for ones with the following methods:
 *		a. has_access() - returns true if the current user has access, false otherwise.
 * 		b. get_controller_name() - returns a name for the controller suitable for the user.
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
		$this->load->library('ControllerList');
	}
	
	function showFront()
	{
		if($this->hasFront) return;
		
		//load stuff
		$this->load->model('Front_model');
		
		//show stuff
		$data['result'] = $this->Front_model->getData();
		$data['page_title'] = "Singularity Parts";
		$this->load->view('Front_view',$data);
		
		$this->hasFront = true;
	}
	
	function index()
	{
		//load stuff and show front
		$this->loadStuff();
		$this->showFront();
		
		//get all controllers
		$controllers = $this->controllerlist->getControllers();
		$controller_arr = array();
		
		//do any have the methods we need
		foreach($controllers as $controller_name=>$controller)
		{
			//we have found it
			if(in_array('has_access', $controller) && in_array('get_controller_name', $controller))
			{
				//obtain methods
				$ctrl = new ReflectionClass($controller_name);
				$has_access = $ctrl->getMethod('has_access');
				$get_controller_name = $ctrl->getMethod('get_controller_name');
				
				//invoke methods
				$access_result = $has_access->invoke(null);
				$printable_name = $get_controller_name->invoke(null);
				
				//we have access
				if($access_result)
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
		
		//load the dashboard view
		$data['controller_arr'] = $controller_arr;
		$this->load->view('Dashboard_view', $data);
	}
}

?>