<?php
	class Front extends CI_controller{
		function index()
		{
			$this->load->helper('html');
			$this->load->helper('url');
			$this->load->model('Front_model');

			
			$data['result'] = $this->Front_model->getData();
			$data['page_title'] = "Singularity Parts";

			$this->load->view('Front_view',$data);
	    }
		function login()
		{
				 $this->load->helper('form');
                        $this->load->library('form_validation');
                        $this->load->helper('url');
                        $this->load->helper('html');
                        $this->load->model('Front_model');
						
				$data['title']="Singularity Parts";

				$this->form_validation->set_rules('Email','Email','required');
                $this->form_validation->set_rules('Password','Password','required');
				
				if($this->form_validation->run() === FALSE)
                {
								
                                $this->load->view('Register');
								$this->load->view('Failure');
                }
                 else
                {
                                $this->Front_model->login();
                                $this->load->view('Front_view');
                                
                       
                }
		
		}
	}
?>