<?php include "header.php"?>
<?php include "loginwindow.php";?>
<?php include "menu.php"?>

<?php echo validation_errors(); ?>

<?php

echo form_open('Cart/checkout'); 

echo '<p id = "COD">Cash on Delivery(Makes CCN, Expiration Date, and Security Code Unnecessary): <input type="checkbox" name="COD" value="COD"></p> ';
echo '<p id = "CC">Credit Card Number: <input type="text" name="CC"> </p>';
echo '<p>(Warning: This site is a proof of concept and currently not PCI-DSS Compliant. CCNS are currently stored in CLEARTEXT, and COD use is Encouraged. For the sake of simplicity, if you enter a random alphanumeric string, it will accept that as the CCN.)</p>';
echo '<p id = "exp_date">Expiration Date: <select name="exp_month" id="exp_month"><option value="01">1&nbsp;-&nbsp;January</option><option value="02">2&nbsp;-&nbsp;February</option><option value="03">3&nbsp;-&nbsp;March</option><option value="04">4&nbsp;-&nbsp;April</option><option value="05">5&nbsp;-&nbsp;May</option><option value="06">6&nbsp;-&nbsp;June</option><option value="07">7&nbsp;-&nbsp;July</option><option value="08">8&nbsp;-&nbsp;August</option><option value="09">9&nbsp;-&nbsp;September</option><option value="10">10&nbsp;-&nbsp;October</option><option value="11">11&nbsp;-&nbsp;November</option><option value="12">12&nbsp;-&nbsp;December</option></select>&nbsp;<select name="exp_year" id="exp_year"><option value="13">2013</option><option value="14">2014</option><option value="15">2015</option><option value="16">2016</option><option value="17">2017</option><option value="18">2018</option><option value="19">2019</option><option value="20">2020</option><option value="21">2021</option><option value="22">2022</option><option value="23">2023</option></select>'; 
echo '<p id = "Security Code">Security Code: <input type = "text" name = "Code"> </p>';
echo '<p id = "Address">Address: <input type = "text" name = "Address"></p>';
echo '<p id = "City">City:  <input type = "text" name = "City"></p>';
echo '<p id="state"> State:<select name = "state"><option value="0">--Select--</option>';
     foreach($states as $state)
	 {
		echo '<option value="'.$state->state_id.'">'.$state->state_name.",".$state->country_name.'</option>"';
	 }
	
		

echo '</select>';
echo '</p>';
echo '<p id = "Zipcode">Zipcode: <input type = "text" name = "Zipcode"></p>';
echo '<p id = "Country">Country: <input type = "text" name = "Country"></p>';
echo '<p id = "Phone">Phone Number: <input type = "text" name = "Phone"></p>';



echo form_submit('cart/Checkout', 'Confirm Checkout');


?>


<?php include "footer.php"?>