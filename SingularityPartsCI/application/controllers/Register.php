<?php
	class Register extends CI_controller{
		function index()
		{
			$this->load->helper('html');
			$this->load->helper('url');
			$this->load->helper('form');
			$this->load->model('user_model');

		
			$data['page_title'] = "Singularity Parts";

			$this->load->view('Register', $data);
	    }
		
		public function rp()
		{
			$this->load->helper('form');
			$this->load->library('form_validation');
			$this->load->helper('url');
			$this->load->helper('html');
			$this->load->model('user_model');
			
			$data['title']="Registration";
			
			$this->form_validation->set_rules('name','name','required');
			$this->form_validation->set_rules('usrEmail','Email','required');
			$this->form_validation->set_rules('Pw','Password','required');
			
			if($this->form_validation->run() === FALSE)
			{
				$this->load->view('/Register');
			}
			else
			{
				$this->user_model->create_user();
				$this->load->view('Register/success');
			
			}
		}

	}
?>