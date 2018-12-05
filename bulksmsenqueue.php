<?php
require 'ak/src/AfricasTalking.php';
use AfricasTalking\SDK\AfricasTalking;
include('header.php');
// Set your app credentials
$smssettings=mysql_fetch_array(mysql_query("SELECT username , senderid,api from smssettings "));
// Specify your login credentials
$username   = $smssettings['username'];
$apikey     = $smssettings['api'];


// Initialize the SDK
$AT         = new AfricasTalking($username, $apiKey);

// Get the SMS service
$sms        = $AT->sms();

// Set the numbers you want to send to in international format
$q=mysql_query("SELECT name,mobile from contacts order by id asc  ");
while($query=mysql_fetch_array($q)){
$phone=$query['mobile'];
$name=$query['name'];
$msg=$_POST['msg'];
$recipients=$phone;
// And of course we want our recipients to know what we really do
$from = $smssettings['senderid'];

// Set your message
$message    =$msg;
// Set the enqueue flag to true, useful when you are sending high volumes
$enqueue    = true;

try {
    // Thats it, hit send and we'll take care of the rest
    $result = $sms->send([
        'to'      => $recipients,
        'message' => $message,
        'enqueue' => $enqueue,
        'from'    => $from
    ]);

    print_r($result);
} catch (Exception $e) {
    echo "Error: ".$e->getMessage();
}
}
?>