<?php

if($this->session->userdata('logged_in'))
{
        echo '<div id = "loginwindow">';
		
		echo '<p id = "Login">';
		echo anchor('Front/logout', 'Log out', '');
		echo '</p>';
		
		if(isset($customer_mode) && $customer_mode) {
			echo '<p id="customer_dashboard">';
			echo anchor('Dashboard/customer_mode', 'Customer Dashboard', '');
			echo '</p>';
		}
		if(isset($store_mode) && $store_mode) 
		{
			echo '<p id="customer_dashboard">';
			echo anchor('Dashboard/store_mode', 'Store Dashboard', '');
			echo '</p>';
		}
        echo '</div>';
}

else
{
echo '<div id = "loginwindow">';
echo form_open('Front/login');
echo '<p id = "Email">Email: <input type="text" name="Email" /></p>';
echo ' <p id = "Password">Password: <input type="password" name="Password" /></p>';
echo ' <p id = "Login"><input type="submit" value="Log In" /></p>';
echo '</form>';
echo '<div id = "LoginLinks">';
echo anchor('Register', 'Register', '');
echo '</div>';
echo '</div>';

}


?>