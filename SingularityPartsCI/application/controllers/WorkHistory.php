<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
 
class WorkHistory extends CI_Controller {
 
	private $hasFront = false;
	function __construct()
    {
        parent::__construct();
 
        //load stuff
        $this->load->database();
        $this->load->helper('url');
		$this->load->helper('form');
		$this->load->helper('html');
		$this->load->helper('url');
        $this->load->library('grocery_CRUD');
		
		//show stuff
		$this->showFront();
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
		$this->load->library('Grocery_CRUD');
		$this->load->model('RBAC_model');
		$this->showFront();
		
		//are we logged in?
		if(!$this->session->userdata('person_id') || !$this->session->userdata('logged_in'))
		{
			redirect('');
		}

		//do we have access?
		if(!$this->RBAC_model->has_permission(
				$this->session->userdata('person_id'), 
				'work_history',
				array(	
					'role_permission.can_read' => TRUE, 
					'role_permission.can_add'=>TRUE,
					'role_permission.can_modify' => TRUE,
					'role_permission.can_delete' => TRUE,
				)
			)
		)
		{
			redirect('');
		}
		
		//show stuff
		$this->showFront();
		$this->load->library('Grocery_CRUD');
        $this->grocery_crud->set_table('work_history');
        $output = $this->grocery_crud->render();
		$this->load->view('grocery_crud_view',$output);    
    }
}
 
