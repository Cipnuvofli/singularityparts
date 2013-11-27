<?php include "header.php"?>
<?php include "menu.php"?>
	<?php echo validation_errors(); ?>

<div name="Namechange">
	<h3>Change Name</h3>
	<?php echo form_open('SelfServiceArea/namechange'); ?>
		First Name*:<br/>
		<input type="text" name="Fname"/><br/>
		Middle Name:<br/>
		<input type="text" name="Mname"/><br/>
		Last Name*:<br/>
		<input type="text" name="Lname"/><br/>
	<?php echo form_submit('namechange', 'Submit Name Change'); ?>
	<?php echo '</form>'; ?>
</div>

<div name="branch">
	<h3>Change Branch</h3>
	<?php echo form_open('SelfServiceArea/branchchange'); ?>
	<p id="branch"> 
		Branch*:
	<select name = "branch">
		<option value="0">--Select--</option>
		<?php foreach($branches as $branch): ?>
			<?php echo "<option value=\"$branch->branch_id\">
				$branch->street_no $branch->street_name; $branch->city_name, $branch->state_name, $branch->country_name, $branch->postcode
				</option>"; ?>
		<?php endforeach; ?>
	</select>
	<?php echo form_submit('branchchange', 'Submit Branch Change'); ?>
	<?php echo '</form>'; ?>
	</p>
</div>

<div name="car">
	<h3>Change Car</h3>
	<?php echo form_open('SelfServiceArea/vehiclechange'); ?>
	<p id="car">
		Car:
	<select name = "vehicle">
		<option value="0">--Select--</option>
		<?php foreach($cars as $car): ?>
			<?php echo "<option value=\"$car->vehicle_id\">$car->make_name $car->model_name $car->model_year</option>"; ?>
		<?php endforeach; ?>
	</select>
	<?php echo form_submit('carchange', 'Submit Car Change'); ?>
	<?php echo '</form>'; ?>
	</p>
</div>

<div name="address">
	<h3>Change Address</h3>
	<?php echo form_open('SelfServiceArea/addresschange'); ?>
	<p id="street_no">Street Number*: <input type="text" name="street_no"></p>
	<p id="street_name">Street Name*: <input type="text" name="street_name"></p>
	<p id="apt_or_suite_no">Apartment or Suite Number: <input type="text" name="apt_or_suite_no"></p>                               
	<p id = "City">City*: <input type="text" name="city"></p>
	<p id="state"> State*:
	<select name = "state">
		<option value="0">--Select--</option>
		<?php foreach($states as $state): ?>
			<?php echo "<option value=\"$state->state_id\">$state->state_name, $state->country_name</option>"; ?>
		<?php endforeach; ?>
	</select>
	</p>
	<p id="postcode">Postcode*: <input type="text" name="postcode"></p> 
	<?php echo form_submit('addrchange', 'Submit Address Change'); ?>
	<?php echo '</form>'; ?>
</div>	

<div name="email">
	<h3>Change Email</h3>
	<?php echo form_open('SelfServiceArea/emailchange'); ?>
	<p id = "Email">E-mail*: <input type="email" name="usrEmail"></p>
	<?php echo form_submit('emailchange', 'Submit Email Change'); ?>
	<?php echo '</form>'; ?>
</div>

<div name="password">
	<h3>Change Password</h3>
	<?php echo form_open('SelfServiceArea/passwordchange'); ?>
	<p id = "Passkey">Password*: <input type="password" name = "Pw"></p>
	<?php echo form_submit('passchange', 'Submit Password Change'); ?>
	<?php echo '</form>'; ?>
</div>

<div name = "CancelOrder">
	<h3>Cancel Order</h3>
	<?php echo form_open('SelfServiceArea/cancelorder'); ?>
	<p id="order"> 
		Order to Cancel*:
	<select name = "order">
		<option value="0">--Select--</option>
		<?php foreach($cancelable_orders as $order): ?>
			<?php echo "<option value=\"$order->order_id\">$order->order_id; $order->order_date</option>"; ?>
		<?php endforeach; ?>
	
	</select>
	<select name = "reason">
		<option value="0">--Select--</option>
		<?php foreach($reasons as $reason): ?>
			<?php echo "<option value=\"$reason->reason_id\">$reason->reason_name</option>"; ?>
		<?php endforeach; ?>
	</select>
	<?php echo form_submit('CancelOrder', 'Cancel Order'); ?>
	<?php echo '</form>'; ?>
	</p>
</div>


<?php include "footer.php"?>

