<?php
 include('auth.php');
 ini_set('display_errors', 1);
 var_dump($_GET); 

 if ($_GET) {
 $phoneNumber = $_GET['phoneNumber'];
 $shortCode = $_GET['shortCode'];
 $keyword = $_GET['keyword'];
 $updateType = $_GET['updateType'];
 if($updateType == "Addition") {

  mysql_query("INSERT INTO receivedmessages(phoneno,message,shortcode)values('$phoneNumber','$keyword','$shortCode')");
 }
 elseif($updateType == "Deletion") {
  //Remove phoneNumber from subscribers' list
 }
 }	

