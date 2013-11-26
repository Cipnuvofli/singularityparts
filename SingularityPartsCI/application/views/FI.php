<?php include "header.php"?>
<?php include "loginwindow.php";?>
<?php include "menu.php"?>

<?php echo validation_errors(); ?>

<?php

echo form_open('Cart/checkout'); 

echo '<p id = "COD">Cash on Delivery: <input type="checkbox" name="COD" value="COD"></p> ';
echo '<p id = "CC">Credit Card Number: <input type="text" name="CC"> </p>';
echo '<p id = "Security Code">Security Code: <input type = "text" name = "Code"> </p>';
echo '<p id = "Address">Address: <input type = "text" name = "Address"></p>';
echo '<p id = "City">City:  <input type = "text" name = "City"></p>';
echo '<p id = "State">State:  <input type = "text" name = "State"></p>';
echo '<p id = "Zipcode">Zipcode: <input type = "text" name = "Zipcode"></p>';
echo '<p id = "Country">Country: <input type = "text" name = "Country"></p>';
echo '<p id = "Phone">Phone Number: <input type = "text" name = "Phone"></p>';



echo form_submit('cart/Checkout', 'Confirm Checkout');


?>


<?php include "footer.php"?>