<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
 
class Role extends CI_Controller {
 
	private $hasFront = false;
	function __construct()
    {
        parent::__construct();
 
        //load stuff
        $this->load->database();
		$this->load->helper('form');
		$this->load->helper('html');
		$this->load->helper('url');
        $this->load->library('grocery_CRUD');
		
		//show stuff
		$this->showFront();
    }
	
	/**
	 * Returns true if we have access.
	 */
	public static function has_access()
	{
		$CI = get_instance();
		$CI->load->model('RBAC_model');
		if(!$CI->RBAC_model->has_permission(
				$CI->session->userdata('person_id'), 
				'role',
				array(	
					'role_permission.can_read' => TRUE, 
					'role_permission.can_add'=>TRUE,
					'role_permission.can_modify' => TRUE,
					'role_permission.can_delete' => TRUE,
					'role_permission.can_grant_add'=>TRUE,
					'role_permission.can_grant_modify'=>TRUE,
					'role_permission.can_grant_read'=>TRUE,
					'role_permission.can_grant_delete'=>TRUE,
				)
			)
		)
		{
			return false;
		}
		else return true;
	}
	
	public static function is_store_mode()
	{
		return TRUE;
	}
	
	/**
	 * Returns a printable name for the controller.
	 */ 
	public static function get_controller_name()
	{
		return 'Role';
	}
	
	function showFront()
	{
		include_once('Dashboard.php');
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
		$this->load->library('Grocery_CRUD');
		$this->load->model('RBAC_model');
		$this->showFront();
		
		//are we logged in?
		if(!$this->session->userdata('person_id') || !$this->session->userdata('logged_in')) redirect('');

		//do we have access?
		if(!self::has_access()) redirect('');
		
		//load view
		$this->load->library('Grocery_CRUD');
        $this->grocery_crud->set_table('role');
        $output = $this->grocery_crud->render();
		$this->load->view('grocery_crud_view',$output);
    }
}
 
