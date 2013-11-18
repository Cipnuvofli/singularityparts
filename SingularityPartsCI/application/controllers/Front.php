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
	}
?>