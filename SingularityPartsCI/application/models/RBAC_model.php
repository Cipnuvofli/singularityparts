<?php

/**
 * A basic class for Role-Based Access Control (RBAC). 
 * This class DOES NOT currently support Hierarchies or Separation of Duty. 
 * Right now, each job can have many roles, 
 * and each role can have many permissions.
 * Permissions are in the role_permission table and consist of the aptly-named:
 * 'can_read' 
 * 'can_add'
 * 'can_modify'
 * 'can_delete'
 * 'can_grant_add'
 * 'can_grant_read'
 * 'can_grant_modify'
 * 'can_grant_delete'
 *
 * along with the name of the table and the id of the role. 
 * The permissions for each job are stored in the job_role table. 
 */
class RBAC_model extends CI_model
{
	 function __construct()
    {
        // Call the Model constructor
        parent::__construct();
    }
	
	/*
	 * Adds a new role given a name and description. 
	 */
	public function add_role($role_name, $role_description)
	{
		//see if the role exists
		$this->db->select('*');
		$this->db->from('role');
		$this->db->where('name', $role_name);
		$this->db->get();
		
		//it exists; update and return
		if(count($query->result()) > 0)
		{
			$data = array(
				'role_description' => $role_description,
			);
			$this->db->where('name', $role_name);
			$this->db->update('role', $data);
			return;
		}
		
		//add the role
		$data = array(
			'name' => $role_name,
			'description' => $role_description
		);
		$this->db->insert($data);
	}
	
	public function add_role_job($role_id, $job_id)
	{
		$data = array(
			'role_id' => $role_id,
			'job_id' => $job_id,
		);	
		$this->db->insert('job_role', $data);
	}
	
	/**
	 * Gets the permissions of a role for a table or model, 
	 * given the role ID, the table/model name, and an array with any of the following keys (values of these keys are boolean):
	 * 'can_read' 
	 * 'can_add'
	 * 'can_modify'
	 * 'can_delete'
	 * 'can_grant_add'
	 * 'can_grant_read'
	 * 'can_grant_modify'
	 * 'can_grant_delete'
	 * The array MUST NOT have any other keys, and the array MUST NOT have any non-boolean values.
	 * Returns true if the user has a role that has all of the permissions for the table, otherwise false.
	 */
	public function has_permission($person_id, $table_name, $permissions)
	{
		$roles = get_roles($person_id);
		$this->db->select('*');
		$this->db->from('role_permission');
		$this->db->where('table_name', $table_name);
		 foreach ($permissions as $key => $val) {
			$this->db->where($key, $val);
		}
		$this->db->where_in('role_id', $roles);
		$this->db->get();
		$num_results = count($query->result());
		return ($num_results > 0);
	}
	
	/**
	 * Gets the roles given a person ID. 
	 */
	public function get_roles($person_id)
	{
		$jobs = get_jobs_by_person($person_id);
		$this->db->select('role_id');
		$this->db->from('job_role');
		foreach($jobs as $job)
		{
			$this->db->or_where('job_id', $job);
		}
		$this->db->get();
		return array_values($query->result());
	}
	
	/**
	 * Gets the jobs by person ID.
	 */
	public function get_jobs_by_person($person_id)
	{
		$this->db->select('job_id');
		$this->db->from('work_history');
		$curr_date = date('Y-m-d');
		$this->db->where('person_id=? AND start_date <=? AND(end_date>? OR end_date IS NULL)', array(
			$person_id, $curr_date, $curr_date
		));
		$this->db->get();
		return array_values($query->result());
		
	}
	
	
	
	/**
	 * Changes the permissions of a role for a table or model, 
	 * given the role ID, the table/model name, and an array with ALL of the following booleans:
	 * 'can_read' 
	 * 'can_add'
	 * 'can_modify'
	 * 'can_delete'
	 * 'can_grant_add'
	 * 'can_grant_read'
	 * 'can_grant_modify'
	 * 'can_grant_delete'
	 */
	public function change_permission($role_id, $table_id, $permissions)
	{
		//try to update the data
		$this->db->where('role_id', $role_id);
		$this->db->where('table_name', $table_name);
		$this->db->update('role_permission', $permissions); 
		$affected_rows = $this->db->affected_rows;
		if($affected_rows > 0) return;
		
		//add to the table
		$permissions['role_id'] = $role_id;
		$permissions['table_name'] = $table_name;
		$this->db->insert('role_permission', $permissions);
	}
}
?>