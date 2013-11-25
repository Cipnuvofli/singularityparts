<?php
class Register extends CI_controller{
	
	public static function has_access()
	{
		$CI = get_instance();
		// this is a weird one. 
		//the user is only supposed to be able to access iff he/she is not logged in.
		if(!$CI->session->userdata('person_id') || !$CI->session->userdata('logged_in')) return true;
		else return false;
	}
	
	public static function is_store_mode()
	{
		return FALSE;
	}
	
	public static function get_controller_name()
	{
		return 'Register';
	}

	private function load_register()
	{
		$this->load->helper('html');
        $this->load->helper('url');
        $this->load->helper('form');
        $this->load->model('user_model');
		
		
		$data['cars'] = $this->user_model->get_vehicles();
		$data['states'] = $this->user_model->get_states();
		$data['branches'] = $this->user_model->get_branches();
        $data['page_title'] = "Singularity Parts";
		
		$this->load->view('Register', $data);
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
        $this->load_register();
    }
               
                public function rp()
                {
                        $this->load->helper('form');
                        $this->load->library('form_validation');
                        $this->load->helper('url');
                        $this->load->helper('html');
                        $this->load->model('user_model');
                       
                        $data['title']="Registration";
                       
                        $this->form_validation->set_rules('Fname','Firstname','required');
                        $this->form_validation->set_rules('Lname','Lastname','required');
                        $this->form_validation->set_rules('usrEmail','Email','required');
                        $this->form_validation->set_rules('Pw','Password','required');
						$this->form_validation->set_rules('city','City','required');
						$this->form_validation->set_rules('street_no','Street Number','required');
						$this->form_validation->set_rules('street_name','Street Name','required');
						$this->form_validation->set_rules('postcode','Postcode','required');
						$this->form_validation->set_rules('branch', 'Branch', 'required|callback_check_select');
						$this->form_validation->set_rules('vehicle', 'Vehicle', 'callback_check_select');
						$this->form_validation->set_rules('state', 'State', 'callback_check_select');
						$this->form_validation->set_rules('dobm', 'BirthdayMonth', 'callback_check_select');
						$this->form_validation->set_rules('dobd', 'BirthdayDay', 'callback_check_select');
						$this->form_validation->set_rules('doby', 'BirthdayYear', 'callback_check_select');
												
                        if($this->form_validation->run() === FALSE)
                        {
                                $this->load_register();
								$this->load->view('Failure');
                        }
                        else
                        {
                                $this->user_model->create_user();
								$this->load_register();
                                $this->load->view('success');
                       
                        }
                }

        }
?>

