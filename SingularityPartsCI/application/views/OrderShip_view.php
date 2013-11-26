 
<div id = "ShipForm">

<?php echo validation_errors(); ?>
<p id="order_id"> Order*:
<select name = "order_id">
	<option value="0">--Select--</option>
    <?php foreach($orders as $order): ?>
	
		<?php echo "<option value=\"$order->order_id\">$order->order_id</option>"; ?>
	<?php endforeach; ?>
</select>
</p>
<?php echo form_open('Order_Ship/submit'); ?>
<p id = "shipdate">Ship Date*:<br/>
	Month:<br/>
	<select name="sdm">
		<option value="0">--Select--</option>
		<?php $months = range(1, 12); foreach($months as $month): ?>
			<?php echo "<option value=\"$month\">$month</option>"; ?>
		<?php endforeach; ?>
	</select><br/>
	Day:<br/>
	<select name="sdd">
		<option value="0">--Select--</option>
		<?php $days = range(1, 31); foreach($days as $day): ?>
			<?php echo "<option value=\"$day\">$day</option>"; ?>
		<?php endforeach; ?>
	</select><br/>
	Year:<br/>
	<select name="sdy">
		<option value="0">--Select--</option>
		<?php $years = array_reverse(range(1900, date("Y"))); foreach($years as $year): ?>
			<?php echo "<option value=\"$year\">$year</option>"; ?>
		<?php endforeach; ?>
	</select><br/>
</p>  

<p id="tracking">Tracking #*: <input type="text" name="tracking"></p>
<p id="method">Method*: <input type="text" name="method"></p>
<p id="rate">Rate*: <input type="text" name="rate"></p> 
<?php echo form_submit('Submit', 'Submit'); ?>
</div>

