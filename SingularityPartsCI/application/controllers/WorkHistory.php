<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
 
class WorkHistory extends CI_Controller {
	
	public static function has_access()
	{
		$CI = get_instance();
		
		//check if login ok
		if(!$CI->session->userdata('logged_in') 
			|| !$CI->session->userdata('person_id')) return false;
			
		//check access control
		$CI->load->model('RBAC_model');
		if(!$CI->RBAC_model->has_permission(
				$CI->session->userdata('person_id'), 
				'work_history',
				array(	
					'role_permission.can_read' => TRUE, 
					'role_permission.can_add'=>TRUE,
					'role_permission.can_modify' => TRUE,
					'role_permission.can_delete' => TRUE,
				)
			)
		) return false;
		else return true;
	}
	
	public static function is_store_mode()
	{
		return TRUE;
	}
	
	public static function get_controller_name()
	{
		return 'View Work History';
	}
	
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
		
		//do we have access
		if(!self::has_access())
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
 
