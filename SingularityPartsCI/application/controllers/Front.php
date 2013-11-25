<?php
	
	class Front extends CI_controller{

	function loadStuff()
	{
		//load helpers
		$this->load->helper('form');
		$this->load->helper('html');
		$this->load->helper('url');
		$this->load->model('Front_model');
		$this->load->library('form_validation');
		$this->load->model('Cart_model');
		
		include_once('Dashboard.php');
		
		//load views
		$data['result'] = $this->Front_model->getData();
		$data['page_title'] = "Singularity Parts";
		$data['customer_mode'] = Dashboard::is_mode_ok(FALSE);
		$data['store_mode'] = Dashboard::is_mode_ok(TRUE);
		$this->load->view('Front_view',$data);
		$this->load->view('content');
		
		
	}
	function index()
	{
		$this->loadStuff();
		
   }
	function login()
	{
		$this->loadStuff();
		
		//set form validation rules
		$this->form_validation->set_rules('Email','Email','required');
        $this->form_validation->set_rules('Password','Password','required');
				
		//apply validation rules
		if($this->form_validation->run() === FALSE)
        {					
            $this->load->view('Register');
			$this->load->view('Failure');
        }
        else
        {
            $this->Front_model->loginDB();                       
        }
		
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
}
?>