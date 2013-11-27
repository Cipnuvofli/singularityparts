<?php
/**
 * At this point this class is pseudocode for inserting a new user. 
 * It performs no validation, form creation, etc.
 */
class User_Model extends CI_Model {

			function create_user()
			{			
				
				//$this->load->library('PasswordChecker');
				$data['first_name'] =  $this->input->post('Fname');
				$data['last_name'] =  $this->input->post('Lname');
				$data['email'] = $this->input->post('usrEmail');
				$month = $this->input->post('dobm');
				$day = $this->input->post('dobd');
				$year= $this->input->post('doby');
				$date = strtotime($day.'-'.$month.'-'.$year);
				$data['dob'] = date("Y-m-d", $date);
				$data['street_no'] = $this->input->post('street_no');
				$data['street_name'] = $this->input->post('street_name');
				$data['apt_or_suite_no'] = $this->input->post('apt_or_suite_no');
				$data['postcode'] = $this->input->post('postcode');
				$data['city'] = $this->input->post('city');
				$data['state_id'] = $this->input->post('state');
				$data['branch_id'] = $this->input->post('branch');
				$data['vehicle_id'] = $this->input->post('vehicle');
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
			
			function get_branches()
			{
				$this->db->select(
					'branch.id AS branch_id,
					branch.name AS branch_name,
					branch.streetno AS street_no,
					branch.streetname AS street_name,
					branch.city AS city_name,
					branch.postcode AS postcode,
					state.name AS state_name,
					country.name AS country_name,
					');
				$this->db->from('branch');
				$this->db->join('state', 'branch.state = state.id');
				$this->db->join('country', 'country.id = state.country_id');
				$query = $this->db->get();
				return $query->result();
			}
			
			function get_states()
			{
				$this->db->select(
					'state.id AS state_id,
					state.name AS state_name,
					country.name AS country_name');
				$this->db->from('state');
				$this->db->join('country', 'country.id = state.country_id');
				$query = $this->db->get();
				return $query->result();
			}
			
			function get_vehicles()
			{
				$this->db->select(
					'vehicle.id AS vehicle_id,
					make.name AS make_name,
					vehicle_model.name AS model_name,
					vehicle.year AS model_year');
				$this->db->from('vehicle');
				$this->db->join('vehicle_model', 'vehicle.vehicle_model_id = vehicle_model.id');
				$this->db->join('make', 'vehicle_model.make_id = make.id');
				$this->db->join('manufacturer', 'make.manufacturer_id = manufacturer.id');
				$query = $this->db->get();
				return $query->result();
			}
			
			function get_cancelable_orders()
			{
				$this->db->select('order.id AS order_id, order.order_date AS order_date');
				$this->db->from('order');
				$this->db->join('order_cancellation', 'order_cancellation.order_id = order.id', 'left outer');
				$this->db->join('order_shipping', 'order_shipping.order_id = order.id', 'left outer');
				$this->db->where('order_cancellation.order_id IS NULL');
				$this->db->where('order_shipping.order_id IS NULL');
				$this->db->where('order.branch_id IS NULL');
				return $this->db->get()->result();
			}
			
			function get_reasons()
			{
				$this->db->select('reason.id AS reason_id, reason.name AS reason_name');
				$this->db->from('reason');
				return $this->db->get()->result();
			}

			function change_name()
			{
				$data['first_name'] =  $this->input->post('Fname');
				$data['last_name'] =  $this->input->post('Lname');
				$data['middle_name'] =  $this->input->post('Mname');
				$this->db->where('person.id', $this->session->userdata('person_id'));
				$this->db->update('person', $data);
			}
			
			function change_address()
			{
				$data['street_no'] = $this->input->post('street_no');
				$data['street_name'] = $this->input->post('street_name');
				$data['apt_or_suite_no'] = $this->input->post('apt_or_suite_no');
				$data['postcode'] = $this->input->post('postcode');
				$data['city'] = $this->input->post('city');
				$data['state_id'] = $this->input->post('state');
				$this->db->where('person.id', $this->session->userdata('person_id'));
				$this->db->update('person', $data);
			}
			
			function change_branch()
			{
				$data['branch_id'] = $this->input->post('branch');
				$this->db->where('person.id', $this->session->userdata('person_id'));
				$this->db->update('person', $data);
			}
			
			function change_car()
			{
				$data['vehicle_id'] = $this->input->post('vehicle');
				$this->db->where('person.id', $this->session->userdata('person_id'));
				$this->db->update('person', $data);
			}
			
			function change_email()
			{
				$data['email'] =  $this->input->post('usrEmail');
				$this->db->where('person.id', $this->session->userdata('person_id'));
				$this->db->update('person', $data);
			}
			
			function change_password()
			{
				$person_id = $this->session->userdata('person_id');
				
				//expire old password
				$this->db->where('password_hash.person_id', $person_id);
				$this->db->where('password_hash.start_date <= CURDATE()');
				$this->db->where('(password_hash.end_date > CURDATE() OR password_hash.end_date IS NULL)');
				$this->db->update('password_hash', array('end_date'=>date('Y-m-d')));
				
				//make new password
				$clear_pass = $this->input->post('Pw');
				$hashed_pass = password_hash($clear_pass, PASSWORD_DEFAULT);
				$password_data = array(
					'person_id' => $person_id,
					'start_date' => date('Y-m-d'),
					//'end_date' => date('Y-m-d', $end_date),
					'hash' => $hashed_pass,
				);
				
				$this->db->insert('password_hash',$password_data);
			}
		
			function cancel_order()
			{
				$person_id = $this->session->userdata('person_id');
				$reason_id = $this->input->post('reason');
				$order_id = $this->input->post('order');
				$this->db->insert('order_cancellation', array(
					'order_id'=>$order_id, 
					'reason_id'=>$reason_id, 
					'cancellation_date' => date('Y-m-d'),
				));
			}
			
}	
?>