<?php

if($this->session->userdata('logged_in'))
{
	include "Dashboard_view.php";
	
      /*  echo '<div id = "loginwindow">';
		echo '<p id = "Username">'.$this->session->userdata('first_name').' '.$this->session->userdata('last_name').'</p>';
		echo '<div id = "LoginLinks">';
		echo '<p id = "info">'. anchor('Account Information', 'Account Information', 'title="Account Information"').'</p>';
		echo '<p id = "Orders">'. anchor('OrderHistory', 'Orders', 'title="Orders"') .'</p>';
		echo '<p id = "Shopping Cart">'.anchor('Cart', 'Shopping Cart', 'title="Shopping Cart"').'</p>';
		echo '<p id =  "Addproduct">'. anchor('Product_gc', 'Product', 'title="Products"').'</p>';
		echo '<p id = "Employees"> '. anchor('Employees', 'Employees', 'title="Employees"').'</p>';
		echo '<p id = "Login">'.anchor("Front/logout", "logout", 'title="logout"').'</p>';
		echo '</div>';

        echo '</div>';*/
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
echo anchor('Register', 'Register', 'title="Register"');
echo '</div>';
echo '</div>';

}

?>