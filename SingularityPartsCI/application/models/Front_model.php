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
	function login()
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


		$sql = $this->db->query("SELECT first_name, last_name, salt, hash, email FROM person, password_hash WHERE email = $Email");

		$first_name = $sql->first_name;
		$last_name = $sql->last_name;

		$hashed_pass = crypt($data['Password'], $Blowfish_Pre.$sql->salt.$Blowfish_End);

		if($Email == $sql->email && $hashed_pass == $sql->hash.$sql->salt)
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
			
		}
		mysql_close($con);
			
			
	}
	function logout()
	{
	
	
	}



}
?>