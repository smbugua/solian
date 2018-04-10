<?php // logout.php
include_once 'auth.php';
if (isset($_SESSION['user']))
{
destroySession();
echo "<div class='main'>You have been logged out. Please " .
"<a href='index.php'>click here</a> to refresh the screen.";
echo "<script type='text/javascript'>location.replace('login.php')</script>";
}
else 
{
	echo "<div class='main'><br />" .
"You cannot log out because you are not logged in";
echo "<script type='text/javascript'>location.replace('login.php')</script>";
}
?>
<br /><br /></div></body></html>