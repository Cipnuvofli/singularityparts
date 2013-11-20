<?php
session_start();
if(isset($_SESSION['loggedin']))
{
        echo '<div id = "loginwindow">';
		echo '<p id = "info">'.echo anchor('Account Information', 'Account Information', 'title="Account Information"').'</p>';
		echo '<p id = "Orders">'.echo anchor('Orders', 'Orders', 'title="Orders"') .'</p>';
		//echo '<p id =  "Addproduct">'.echo anchor('Products', 'Products', 'title="Products"').'</p>';
		//echo '<p id = "Employees"> '.echo anchor('Employees', 'Employees', 'title="Employees"').'</p>';
		
		echo '<p id = "Login"><a href = "logout.php">Log out</a></p>';
        echo '</div>';
}

else
{
echo '<div id = "loginwindow">';
echo '<form action="Login.php" method="post">';
echo '<p id = "Username">Username: <input type="text" name="Username" /></p>';
echo ' <p id = "Password">Password: <input type="password" name="Password" /></p>';
echo ' <p id = "Login"><input type="submit" value="Log In" /></p>';
echo '</form>';
echo '<div id = "LoginLinks">';
echo anchor('Register', 'Register', 'title="Register"');
echo '</div>';
echo '</div>';

}

?>