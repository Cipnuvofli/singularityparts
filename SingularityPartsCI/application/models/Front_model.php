<?php

class Front_model extends CI_Model
{
	function Helloworld_model()
	{
		parent::_construct();
	}
	function getData()
	{

		$query = $this->db->get('product');
		
			if ($query->num_rows() > 0)
			{
				return $query->result();
				
			}else{
				show_error('Database is empty!');
			}
		
	
	}
	function loginDB()
	{
		//are we already logged in?
		if($this->session->userdata('logged_in'))
		{
			redirect('');
		}
		
		//get the information
		$Email = $this->input->post('Email');
		$clear_pass = $this->input->post('Password');

		//query
		$this->db->select('person_id, hash, email');
		$this->db->from('person');
		$this->db->join('password_hash', 'person.id = password_hash.person_id');
		$this->db->where('email', $Email);
		$this->db->where('start_date <= CURDATE()');
		$this->db->where('(end_date > CURDATE() OR end_date IS NULL)');
		$sql = $this->db->get();

		//try to get the result
		$sql_results = $sql->result();
		

			
		//we have nothing; error handling goes here.
		if(empty($sql_results)) 
		{
			show_error('results empty');
			echo '<p>Login Failure</P>';
			echo '<a href = "Home.php">Return to home page</a>';
			$this->load->view("Front");
		}
		
		//get the 0th result (yes, this works)
		$sqlr = $sql_results[0];	
	
		//are we good?
		if($Email == $sqlr->email && password_verify($clear_pass, $sqlr->hash))
		{
			//start session
			//initially all we really need is the id of the person
			//and whether or not he/she is logged in.
			$newdata = array(
                   'person_id'  => $sqlr->person_id,
				   'first_name' => $sqlr->first_name,
				   'last_name' => $sqlr->last_name,
                   'logged_in' => TRUE
               );
			$this->session->set_userdata($newdata);
			
			//redirect to home page
			redirect("");
		}
		else
		{
			//redirect to home page
			redirect("");
		}
	
	}
	function logout()
	{
		//destroy the session
		$this->session->sess_destroy();
	
		//redirect to home page
		redirect("");
	}

	



}
?>