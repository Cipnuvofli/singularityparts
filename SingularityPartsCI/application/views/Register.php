<?php include "header.php"?>
<?php include "menu.php"?>
 
<div id = "Registration form">

<?php echo validation_errors(); ?>

<?php echo form_open('Register/rp'); ?>

<p id = "name">
	First Name*:<br/>
	<input type="text" name="Fname"/><br/>
	Middle Name:<br/>
	<input type="text" name="Mname"/><br/>
	Last Name*:<br/>
	<input type="text" name="Lname"/><br/>
</p>
<p id = "DOB">Date of Birth*:<br/>
	Month:<br/>
	<select name="dobm">
		<option value="0">--Select--</option>
		<?php $months = range(1, 12); foreach($months as $month): ?>
			<?php echo "<option value=\"$month\">$month</option>"; ?>
		<?php endforeach; ?>
	</select><br/>
	Day:<br/>
	<select name="dobd">
		<option value="0">--Select--</option>
		<?php $days = range(1, 31); foreach($days as $day): ?>
			<?php echo "<option value=\"$day\">$day</option>"; ?>
		<?php endforeach; ?>
	</select><br/>
	Year:<br/>
	<select name="doby">
		<option value="0">--Select--</option>
		<?php $years = array_reverse(range(1900, date("Y"))); foreach($years as $year): ?>
			<?php echo "<option value=\"$year\">$year</option>"; ?>
		<?php endforeach; ?>
	</select><br/>
</p>  
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
</p>
<p id="car">
Car:
<select name = "vehicle">
	<option value="0">--Select--</option>
    <?php foreach($cars as $car): ?>
		<?php echo "<option value=\"$car->vehicle_id\">$car->make_name $car->model_name $car->model_year</option>"; ?>
	<?php endforeach; ?>
</select>
</p>
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
</p> 
 <p id = "Email">E-mail*: <input type="email" name="usrEmail"></p>
<p id = "Passkey">Password*: <input type="password" name = "Pw"></p>
<p id = "Register"><input type="submit" value="Register" /></p>
</div>


<?php include "footer.php"?>

