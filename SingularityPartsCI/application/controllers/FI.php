<?php

class FI extends CI_Controller
{

	function index()
	{
				include_once('Dashboard.php');
                $this->load->helper('form');
                $this->load->helper('html');
                $this->load->helper('url');
				$this->load->model('Cart_Model');
               
                //check if login ok
                if(!$this->session->userdata('logged_in') || !$this->session->userdata('person_id'))
                {
                        //insert real login fail code here
                        redirect('');
                }
               
                //load the standard models and views
                $this->load->model('Front_model');
                $data['customer_mode'] = Dashboard::is_mode_ok(FALSE);
                $data['store_mode'] = Dashboard::is_mode_ok(TRUE);
                $data['page_title'] = "Singularity Parts - Checkout";
                $this->load->view('FI',$data);
				print_r($this->cart->contents());
               
	}

 }
?>