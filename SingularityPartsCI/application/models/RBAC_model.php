<?php

/**
 * A basic class for Role-Based Access Control (RBAC). 
 * This class DOES NOT currently support Hierarchies or Separation of Duty. 
 * Right now, each job can have many roles, 
 * and each role can have many permissions.
 * Permissions are in the role_permission table and consist of the aptly-named:
 * 'role_permission.can_read' 
 * 'role_permission.can_add'
 * 'role_permission.can_modify'
 * 'role_permission.can_delete'
 * 'role_permission.can_grant_add'
 * 'role_permission.can_grant_read'
 * 'role_permission.can_grant_modify'
 * 'role_permission.can_grant_delete'
 *
 * along with the name of the table and the id of the role. 
 * The permissions for each job are stored in the job_role table. 
 
 * Summary of the algorithm:
Find current work history of person (select from work_history)
Get known role for current work history (join with job_role)
Get permissions for roles (join on role_permission)
narrow down by required permissions, date constraints, etc.
if we have rows, then we are good.
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
	 * 'role_permission.can_read' 
	 * 'role_permission.can_add'
	 * 'role_permission.can_modify'
	 * 'role_permission.can_delete'
	 * 'role_permission.can_grant_add'
	 * 'role_permission.can_grant_read'
	 * 'role_permission.can_grant_modify'
	 * 'role_permission.can_grant_delete'
	 * The array MUST NOT have any other keys, and the array MUST NOT have any non-boolean values.
	 * Returns true if the user has a role that has all of the permissions for the table, otherwise false.
	 */
	public function has_permission($person_id, $table_name, $permissions)
	{
		$this->db->select('*');
		$this->db->from('work_history');
		
		//get jobs
		$this->db->join('job_role', 'work_history.job_id = job_role.job_id');
		
		//get role entries
		$this->db->join('role_permission', 'role_permission.role_id = job_role.role_id');
		$this->db->where('table_name', $table_name);
		 foreach ($permissions as $key => $val) {
			$this->db->where($key, $val);
		}
		$this->db->where('(start_date <= CURDATE())');
		$this->db->where('(end_date > CURDATE() or end_date IS NULL)');
		$this->db->where('work_history.person_id', $person_id);
		$query = $this->db->get();
		echo $this->db->last_query();
		$num_results = count($query->result());
		return ($num_results > 0);
	}
	
	/**
	 * Changes the permissions of a role for a table or model, 
	 * given the role ID, the table/model name, and an array with ALL of the following booleans:
	 * 'role_permission.can_read' 
	 * 'role_permission.can_add'
	 * 'role_permission.can_modify'
	 * 'role_permission.can_delete'
	 * 'role_permission.can_grant_add'
	 * 'role_permission.can_grant_read'
	 * 'role_permission.can_grant_modify'
	 * 'role_permission.can_grant_delete'
	 */
	public function change_permission($role_id, $table_id, $permissions)
	{
		//try to update the data
		//todo: right order of ci commands?
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