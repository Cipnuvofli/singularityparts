<?php
 
 class OrderShip_model extends CI_model
 {
 
	/**
	 * marks an order as shipped
	 */
	function mark_shipped()
	{
		$order_id = $this->input->post('order_id');
		$ship_date = $this->input->post('sdy') .'-' . $this->input->post('sdm') . '-' . $this->input->post('sdd');
		$tracking = $this->input->post('tracking');
		$method = $this->input->post('method');
		$rate = $this->input->post('rate');
		$person = $this->session->userdata('person_id');
		$this->db->insert('order_shipping', array(
			'order_id' => $order_id,
			'shipping_date'=> $ship_date,
			'shipping_tracking' => $tracking,
			'shipping_method' => $method,
			'shipping_rate'=>$rate,
			'person_id' => $person
		));
	}
	
	function get_remote_orders()
	{
		$this->db->select('order_id');
		$this->db->from('order');
		$this->db->join('order_shipping', 'order_shipping.order_id = order.id', 'left outer');
		$this->db->where('(order_shipping.order_id IS NULL)');
		$this->db->where('(order.branch_id IS NULL)');
		$query = $this->db->get();
		return $query->result();
	}
}
?>