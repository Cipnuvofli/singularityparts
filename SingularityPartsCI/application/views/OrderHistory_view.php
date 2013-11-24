<!-- orders -->
<h2>Orders</h2>
<table id="orders">
	<tr>
		<th>Order ID</th>
		<th>Product ID</th>
		<th>Product Name</th>
		<th>Condition</th>
		<th>Country</th>
		<th>Quantity</th>
		<th>Unit Price</th>
		<th>Date</th>
		<th>Branch</th>
	</tr>
	<?php foreach($orders as $row): ?>
	<tr>
		<td><?php echo $row->order_id; ?></td>
		<td><?php echo $row->product_id; ?></td>
		<td><?php echo $row->product_name; ?></td>
		<td><?php echo $row->condition_name; ?></td>
		<td><?php echo $row->country_name; ?></td>
		<td><?php echo $row->quantity; ?></td>
		<td><?php echo $row->unit_price; ?></td>
		<td><?php echo $row->order_date; ?></td>
		<td><?php echo $row->branch_name; ?></td>
	</tr>
	<?php endforeach; ?>
</table>

<!-- shipped orders -->
<h2>Shipped Orders</h2>
<table id="shipped">
<tr>
		<th>Order ID</th>
		<th>Shipping Tracking</th>
		<th>Shipping Method</th>
		<th>Shipping Date</th>
	</tr>
	<?php foreach($shipped_orders as $row): ?>
	<tr>
		<td><?php echo $row->order_id; ?></td>
		<td><?php echo $row->shipping_tracking; ?></td>
		<td><?php echo $row->shipping_method; ?></td>
		<td><?php echo $row->shipping_date; ?></td>
	</tr>
	<?php endforeach; ?>
</table>

<!-- cancellations -->
<h2>Cancellations</h2>
<table id="cancellations">
	<tr>
		<th>Cancellation ID</th>
		<th>Order ID</th>
		<th>Product ID</th>
		<th>Product Name</th>
		<th>Condition</th>
		<th>Country</th>
		<th>Quantity</th>
		<th>Unit Price</th>
		<th>Cancellation Date</th>
		<th>Order Date</th>
		<th>Branch</th>
		<th>Reason</th>
	</tr>
	<?php foreach($cancellations as $row): ?>
	<tr>
		<td><?php echo $row->cancellation_id; ?></td>
		<td><?php echo $row->order_id; ?></td>
		<td><?php echo $row->product_id; ?></td>
		<td><?php echo $row->product_name; ?></td>
		<td><?php echo $row->condition_name; ?></td>
		<td><?php echo $row->country_name; ?></td>
		<td><?php echo $row->quantity; ?></td>
		<td><?php echo $row->unit_price; ?></td>
		<td><?php echo $row->cancellation_date; ?></td>
		<td><?php echo $row->order_date; ?></td>
		<td><?php echo $row->branch_name; ?></td>
		<td><?php echo $row->reason_name; ?></td>
	</tr>
	<?php endforeach; ?>
</table>

<!-- cancellations -->
<h2>Returns</h2>
<table id="returns">
	<tr>
		<th>Return ID</th>
		<th>Order ID</th>
		<th>Product ID</th>
		<th>Product Name</th>
		<th>Condition</th>
		<th>Country</th>
		<th>Quantity</th>
		<th>Unit Price</th>
		<th>Return Date</th>
		<th>Order Date</th>
		<th>Branch</th>
		<th>Reason</th>
	</tr>
	<?php foreach($returns as $row): ?>
	<tr>
		<td><?php echo $row->return_id; ?></td>
		<td><?php echo $row->order_id; ?></td>
		<td><?php echo $row->product_id; ?></td>
		<td><?php echo $row->product_name; ?></td>
		<td><?php echo $row->condition_name; ?></td>
		<td><?php echo $row->country_name; ?></td>
		<td><?php echo $row->quantity; ?></td>
		<td><?php echo $row->unit_price; ?></td>
		<td><?php echo $row->return_date; ?></td>
		<td><?php echo $row->order_date; ?></td>
		<td><?php echo $row->branch_name; ?></td>
		<td><?php echo $row->reason_name; ?></td>
	</tr>
	<?php endforeach; ?>
</table>
