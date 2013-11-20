<?php include "header.php"?>
<?php include "menu.php"?>
  
<div id = "Registration form">

<?php echo validation_errors(); ?>

<form action="Register/rp" method = "post">

<p id = "name">Enter your Name: <input type="text" name="name"></p>
 <p id = "Email"> Enter your E-mail: <input type="email" name="usrEmail"></p>
<p id = "Passkey">Enter Your Password: <input type="password" name = "Pw"></p>
<p id = "Register"><input type="submit" value="Register" /></p>'
</div>


<?php include "footer.php"?>

