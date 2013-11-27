<?php
class SelfServiceArea extends CI_controller{
	
	public static function has_access()
	{
		$CI = get_instance();
		if($CI->session->userdata('person_id') && $CI->session->userdata('logged_in')) return true;
		else return false;
	}
	
	public static function is_store_mode()
	{
		return FALSE;
	}
	
	public static function get_controller_name()
	{
		return 'Self Service Area';
	}

	private function load_helpers()
	{
		$this->load->helper('html');
        $this->load->helper('url');
        $this->load->helper('form');
        $this->load->model('user_model');
		$this->load->library('form_validation');
	}
	
	private function load_self_svc_area()
	{
		$this->load_helpers();	
		
		$data['cars'] = $this->user_model->get_vehicles();
		$data['states'] = $this->user_model->get_states();
		$data['branches'] = $this->user_model->get_branches();
		$data['cancelable_orders'] = $this->user_model->get_cancelable_orders();
		$data['reasons'] = $this->user_model->get_reasons();
        $data['page_title'] = "Singularity Parts";
		
		$this->load->view('Self_Service_Area', $data);
	}
	
	function check_select($post_string)
	{
		
		if($post_string == '0')
		{
			$this->form_validation->set_message('check_select', 'Need to select something in %s');
			return false;
		}
		else return true;
	}
	
	function index()
    {
        $this->load_self_svc_area();
    }
               
   
   public function cancelorder()
   {
		$this->load_helpers();
		$this->form_validation->set_rules('order','Order','callback_check_select');
        $this->form_validation->set_rules('reason','Reason','callback_check_select');
		if($this->form_validation->run() === FALSE)
        {
            $this->load_self_svc_area();
			$this->load->view('Failure');
        }
        else
        {
            $this->user_model->cancel_order();
			$this->load_self_svc_area();
            $this->load->view('success');
        }
   }
   
	public function namechange()
	{
		$this->load_helpers();
		$this->form_validation->set_rules('Fname','Firstname','required');
        $this->form_validation->set_rules('Lname','Lastname','required');
		if($this->form_validation->run() === FALSE)
        {
            $this->load_self_svc_area();
			$this->load->view('Failure');
        }
        else
        {
            $this->user_model->change_name();
			$this->load_self_svc_area();
            $this->load->view('success');
        }
	}
	
	public function addresschange()
	{
		$this->load_helpers();
		$this->form_validation->set_rules('city','City','required');
		$this->form_validation->set_rules('street_no','Street Number','required');
		$this->form_validation->set_rules('street_name','Street Name','required');
		$this->form_validation->set_rules('postcode','Postcode','required');
		$this->form_validation->set_rules('state', 'State', 'callback_check_select');
		if($this->form_validation->run() === FALSE)
        {
            $this->load_self_svc_area();
			$this->load->view('Failure');
        }
        else
        {
            $this->user_model->change_address();
			$this->load_self_svc_area();
            $this->load->view('success');
        }
	}
	
	public function emailchange()
	{
		$this->load_helpers();
		$this->form_validation->set_rules('usrEmail','Email','required');
		if($this->form_validation->run() === FALSE)
        {
            $this->load_self_svc_area();
			$this->load->view('Failure');
        }
        else
        {
            $this->user_model->change_email();
			$this->load_self_svc_area();
            $this->load->view('success');
        }
	}
	
	public function passwordchange()
	{
		$this->load_helpers();
        $this->form_validation->set_rules('Pw','Password','required');
		if($this->form_validation->run() === FALSE)
        {
            $this->load_self_svc_area();
			$this->load->view('Failure');
        }
        else
        {
            $this->user_model->change_password();
			$this->load_self_svc_area();
            $this->load->view('success');
        }
						
	}
	
	public function branchchange()
	{
		$this->load_helpers();
		$this->form_validation->set_rules('branch', 'Branch', 'required|callback_check_select');
		if($this->form_validation->run() === FALSE)
        {
            $this->load_self_svc_area();
			$this->load->view('Failure');
        }
        else
        {
            $this->user_model->change_branch();
			$this->load_self_svc_area();
            $this->load->view('success');
        }
						
	}
	
	public function vehiclechange()
	{
		$this->load_helpers();
		$this->form_validation->set_rules('vehicle', 'Vehicle', 'callback_check_select');
		if($this->form_validation->run() === FALSE)
        {
            $this->load_self_svc_area();
			$this->load->view('Failure');
        }
        else
        {
            $this->user_model->change_car();
			$this->load_self_svc_area();
            $this->load->view('success');
        }
	}
}
?>

