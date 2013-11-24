<?php
	class Front extends CI_controller{

	function __construct()
    {
        parent::__construct();
 
        /* Standard Libraries of codeigniter are required */
        $this->load->database();
        $this->load->helper('url');
        /* ------------------ */ 
 
 
	}
	
	function load_stuff()
	{
		$this->load->helper('form');
		$this->load->helper('html');
		$this->load->helper('url');
		$this->load->model('Front_model');
			
		$data['result'] = $this->Front_model->getData();
		$data['page_title'] = "Singularity Parts";

		$this->load->view('Front_view',$data);
	}
	
	function index()
	{
		$this->load_stuff();
    }
	function login()
	{
		$this->load_stuff();

		$this->form_validation->set_rules('Email','Email','required');
        $this->form_validation->set_rules('Password','Password','required');
				
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
		$this->load_stuff();
		$this->Front_model->logout();
	}
}
?>