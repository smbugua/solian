<?php
 include('auth.php');
 ini_set('display_errors', 1);
 if ($_POST) {
 $phoneNumber = $_POST['phoneNumber'];
 $shortCode = $_POST['shortCode'];
 $keyword = $_POST['keyword'];
 $updateType = $_POST['updateType'];
 if($updateType == "Addition") {

  mysql_query("INSERT INTO receivedmessages(phoneno,message,shortcode)values('$phoneNumber','$keyword','$shortCode')");
 }
 elseif($updateType == "Deletion") {
  //Remove phoneNumber from subscribers' list
 }
 }	

