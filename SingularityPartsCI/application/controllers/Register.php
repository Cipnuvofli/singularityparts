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
                       
                        $this->form_validation->set_rules('Fname','Firstname','required');
                        $this->form_validation->set_rules('Lname','Lastname','required');
                        $this->form_validation->set_rules('usrEmail','Email','required');
                        $this->form_validation->set_rules('Pw','Password','required');
                       
                        if($this->form_validation->run() === FALSE)
                        {
								
                                $this->load->view('Register');
								$this->load->view('Failure');
                        }
                        else
                        {
                                $this->user_model->create_user();
                                $this->load->view('Register');
                                $this->load->view('success');
                       
                        }
                }

        }
?>

