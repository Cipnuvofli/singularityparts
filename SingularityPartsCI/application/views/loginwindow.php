<?php

if(isset($_SESSION['loggedin']))
{
        echo '<div id = "loginwindow">';
		//echo '<h1>First and Last Name</h1>';
		echo '<p id = "info">'. anchor('Account Information', 'Account Information', 'title="Account Information"').'</p>';
		echo '<p id = "Orders">'. anchor('Orders', 'Orders', 'title="Orders"') .'</p>';
		//echo '<p id =  "Addproduct">'. anchor('Products', 'Products', 'title="Products"').'</p>';
		//echo '<p id = "Employees"> '. anchor('Employees', 'Employees', 'title="Employees"').'</p>';
		
		echo '<p id = "Login"><a href = "index.php/logout">Log out</a></p>';
        echo '</div>';
}

else
{
echo '<div id = "loginwindow">';
echo '<form action="index.php/login" method="post">';
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