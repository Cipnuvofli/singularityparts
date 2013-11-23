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
		$this->db->where('start_date <= CURDATE()');
		$this->db->where('(end_date > CURDATE() OR end_date IS NULL)');
		$sql = $this->db->get();

		//try to get the result
		$sql_results = $sql->result();
		if(empty($sql_results)) 
		{
			show_error('results empty');
			echo '<p>Login Failure</P>';
			echo '<a href = "Home.php">Return to home page</a>';
			$this->load->view("Front");
		}
		
		//get the 0th result (yes, this works)
		$sqlr = $sql_results[0];
		
		//print the 0th result
		print_r($sqlr);
		
		//hash the password?
		$hashed_pass = crypt($data['Password'], $Blowfish_Pre.$sqlr->salt.$Blowfish_End);
		
		//debugging
		echo("<br/>");
		echo("<br/>");
		
		//the hashed pass
		echo($hashed_pass);
		echo("<br/>");
		echo("<br/>");
		
		//the one from the DB
		echo($sqlr->hash.$sqlr->salt);
		
		if($Email == $sqlr->email && $hashed_pass == $sqlr->hash.$sqlr->salt)
		{
			//show_error('login ok');
			$_SESSION['loggedin'] = "YES";
			$_SESSION['email'] = $Email;
			
			$this->load->view("Front");
		}
		else
		{
			//show_error('login bad');
			echo '<p>Login Failure</P>';
			echo '<a href = "Home.php">Return to home page</a>';
			$this->load->view("Front");
			
		}
		
		/*
		mysql_close($con);
		*/
	
			
	}
	function logout()
	{
	
	
	}



}
?>