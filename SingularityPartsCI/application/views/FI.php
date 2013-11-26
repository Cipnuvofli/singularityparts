<?php include "header.php"?>
<?php include "loginwindow.php";?>
<?php include "menu.php"?>

<?php echo validation_errors(); ?>

<?php

echo form_open('Cart/checkout'); 

echo '<p id = "COD">Cash on Delivery: <input type="checkbox" name="COD" value="COD"></p> ';
echo '<p id = "CC">Credit Card Number: <input type="text" name="CC"> </p>';
echo '<p id = "Security Code">Security Code: <input type = "text" name = "Code"> </p>';
echo '<p id = "Address1">Address1: <input type = "text" name = "Address1"></p>';
echo '<p id = "Address2">Address2: <input type = "text" name = "Address2"></p>';
echo '<p id = "City">City:  <input type = "text" name = "City"></p>';
?>
<p id="state"> State*:
<select name = "state">
	<option value="0">--Select--</option>
    <?php foreach($states as $state): ?>
	
		<?php echo "<option value=\"$state->state_id\">$state->state_name, $state->country_name</option>"; ?>
	<?php endforeach; ?>
</select>
<?php
echo '<p id = "Zipcode">Zipcode: <input type = "text" name = "Zipcode"></p>';
echo '<p id = "Phone">Phone Number: <input type = "text" name = "Phone"></p>';
?>

<?php echo form_submit('cart/Checkout', 'Confirm Checkout');?>



<?php include "footer.php"?>