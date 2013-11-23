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
		
		CRYPT_BLOWFISH or die ('<p>No Blowfish found.</p>');
		$Blowfish_Pre = '$2a$05$';
		$Blowfish_End = '$';
		if(isset($_SESSION['loggedin']))
		{
			die("Already Logged in!");

		}

		$Email = $this->input->post('Email');
		$data['Password'] = $this->input->post('Password');


		$this->db->select('person_id, salt, hash, email');
		$this->db->from('person');
		$this->db->join('password_hash', 'person.id = password_hash.person_id');
		$this->db->where('email', $Email);
		$this->db->where('start_date <= ', date('Y-m-d'));
		$this->db->where('(end_date > ? OR end_date IS NULL)', array(date('Y-m-d')));
		$sql = $this->db->get();
		show_error($this->db->last_query());
		/*$sqlr = $sql->result_array();
		log_message('debug', 'hello world from ci');
		log_message('debug', $sqlr->email);
		log_message('debug', $sqlr->salt);
		log_message ('debug', $sqlr->hash);
		log_message ('debug', $sqlr->person_id);
		
		
		$first_name = $sqlr->first_name;
		$last_name = $sqlr->last_name;

		$hashed_pass = crypt($data['Password'], $Blowfish_Pre.$sqlr->salt.$Blowfish_End);

		if($Email == $sqlr->email && $hashed_pass == $sqlr->hash.$sqlr->salt)
		{
			
			$_SESSION['loggedin'] = "YES";
			$_SESSION['email'] = $Email;
			
			$this->load->view("Front");
		}
		else
		{
			echo '<p>Login Failure</P>';
			echo '<a href = "Home.php">Return to home page</a>';
			$this->load->view("Front");
			
		}*/
		/*
		mysql_close($con);
		*/
			
	}
	function logout()
	{
	
	
	}



}
?>