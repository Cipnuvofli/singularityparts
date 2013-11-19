<?php
session_start();
if(isset($_SESSION['loggedin']))
{
        echo '<div id = "loginwindow">';
		echo '<p id = "UCAvatar"><img src="'.$_SESSION['Avatar'].'" alt = "User Avatar"></p>';
        echo '<p id =  "Username">Logged in as: '.$_SESSION['name'].'</p>';
       
        echo'<p class = "Stats">Successful Write-ins: '.$_SESSION['writeins'].'</p>';
        echo '<p class  = "Stats">Likes Received: '.$_SESSION['Likes received'].'</p>';
        echo '<p class  = "Stats">Post Count: '.$_SESSION['postcount'].'</p>';
        echo '<p class  = "Stats">Character Sheets: TODO</p>';
		
		echo '<p id = "Avatarchange"><a href = "personal.php">Edit my Profile</a></p>';
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
echo ' <a href="recovery.php">Forgot your Password?</a>     <a href="./register">Register</a> ';
echo '</div>';
echo '</div>';

}

?>