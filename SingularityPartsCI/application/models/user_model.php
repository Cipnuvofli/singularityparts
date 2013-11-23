<?php
/**
 * At this point this class is pseudocode for inserting a new user. 
 * It performs no validation, form creation, etc.
 */
class User_Model extends CI_Model {

			function create_user()
			{			
				$this->load->library('PasswordChecker');
				$data['first_name'] =  $this->input->post('Fname');
				$data['last_name'] =  $this->input->post('Lname');
				$data['email'] = $this->input->post('usrEmail');
				$month = $this->input->post('dobm');
				$day = $this->input->post('dobd');
				$year= $this->input->post('doby');
				$date = strtotime($day.'-'.$month.'-'.$year);
				$data['dob'] = date("Y-m-d", $date);
				$country = $this->input->post('Country');
				$data['state_id'] = $this->input->post('state');
				$data['branch_id'] = 1;
				$data['vehicle_id'] = 1;
				if($country === "United States")
				{
					$data['state_id'] = $this->input->post('state');
				}
				$this->db->insert('person', $data);
				
	
				$person_id = $this->db->insert_id();
						
				$clear_pass = $this->input->post('Pw');
				$hashed_pass = password_hash($clear_pass, PASSWORD_DEFAULT);
				
				$start_date = strtotime("now");
				
				//$days_to_expire = $this->passwordchecker->checkStrength($clear_pass);
				//$end_date = strtotime("+'$days_to_expire' days");
				$password_data = array(
					'person_id' => $person_id,
					'start_date' => date('Y-m-d'),
					//'end_date' => date('Y-m-d', $end_date),
					'hash' => $hashed_pass,
										);
				
				$this->db->insert('password_hash',$password_data);
			
		
			}

		/**
		 * This is pseudocode for creating a user.
		 * Form inputs (REQUIRED unless stated otherwise):
		 * Date of birth (REQUIRED; values returned by post MUST be numbers)
		 * month - can be select box or input box
		 * day - can be select box or input box
		 * year - can be select box or input box
		 *
		 * Email address (REQUIRED):
		 * email_address - an input box for the address
		 * email_type - a combo box with contact_info_type information. 
		 *	Values returned by post MUST be numeric (the id), 
		 *	but the information displayed to the user should be the name of the contact type.
		 *
		 * Address (all input boxes except for state and address_type):
		 * street_no 
		 * street_name 
		 * apt_or_suite_no (NOT required)
		 * city
		 * state - should display State,Country to the user; 
			values returned by post MUST be numeric (the ids from state table)				
		 * postcode
		 * po_box (NOT required)
		 * address_type - same as email_type
		 *
		 * phone number:
		 * phone_number: similar to email_address
		 * phone_type: same as email_type
 		 *
		 * branch preference:
		 * branch_id: combo box with all of the branches and their addresses. id returned by post should be the branch id. 
		 */
		 function create_userproto(){ 
			
			//DOB
			$mth = $this->input->post('month');
			$day = $this->input->post('day');
			$year = $this->input->post('year');
			//TODO: check that this is right. 
			$dob = strtotime($mth . '/' . $day . '/'. $year);
			
			//total person data
			$person_data = array(
				'first_name' => $this->input->post('first_name'),
				'user_name' => mb_tolower($this->input->post('user_name')),
				'last_name' => $this->input->post('last_name'),
				'middle_name' => $this->input->post('middle_name'),
				'dob' => date('Y-m-d', $dob),
			);
			
			//insert person
			$this->db->insert('person', $person_data);
			$person_id = $this->db->insert_id();
			
			//password 
			$clear_pass = $this->input->post('password');
			$hashed_pass = password_hash($clear_pass, PASSWORD_DEFAULT);
			$start_date = strtotime("now");
			$days_to_expire = $this->PasswordChecker->checkStrength($clear_pass);
			$end_date = strtotime("+$days_to_expire days");
			$password_data = array(
				'person_id' => $person_id,
				'start_date' => date('Y-m-d', $start_date),
				'end_date' => date('Y-m-d', $end_date),
				'hash' => $hashed_pass,
			);
			$this->db->insert('password_hash', $password_data);
			
			//email
			$email_data = array(
				'email' => $this->input->post('email_address'),
				'contact_info_type_id' => $this->input->post('email_type'),
			);
			$this->db->insert('email_address', $email_data);
			$email_id = $this->db->insert_id();
			
			//email join table
			$email_join_data = array(
				'email_address_id' => $email_id,
				'person_id' => $person_id,
			);
			$this->db->insert('email_address_person', $email_join_data);
			
			//address
			$addr_data = array(
				'street_no' => $this->input->post('street_no'),
				'street_name' => $this->input->post('street_name'),
				'apt_or_suite_no' => $this->input->post('apt_or_suite_no'),
				'city' => $this->input->post('city'),
				'state' => $this->input->post('state'),
				'postcode' => $this->input->post('postcode'),
				'po_box' => $this->input->post('street_no'),
				'contact_info_type_id' => $this->input->post('address_type'),
			);
			$this->db->insert('address', $addr_data);
			$address_id = $this->db->insert_id();
			
			//address join table
			$address_join_data = array(
				'address_id' => $address_id,
				'person_id' => $person_id,
			);
			$this->db->insert('address_person', $address_join_data);
			
			//phone number
			$phone_data = array(
				'phone_number' => $this->input->post('phone_number'),
				'contact_info_type_id' => $this->input->post('phone_type'),
			);
			$this->db->insert('phone_number', $phone_data);
			$phone_id = $this->db->insert_id();
			
			//phone join table
			$phone_join_data = array(
				'phone_number_id' => $phone_id,
				'person_id' =>$person_id,
			);
			$this->db->insert('person_phone_number', $phone_join_data);
			
			//branch join table
			$branch_join_data = array(
				'branch_id' => $this->input->post('branch_id'),
				'person_id' => $person_id 
			);
			$this->db->insert('branch_join_data');
			//TODO: return stuff?
		} 
			
}	
?>