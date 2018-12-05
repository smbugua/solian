<?php
include('header.php');
// Be sure to include the file you've just downloaded
require_once('AfricasTalkingGateway.php');
$id=$_REQUEST['id'];
$smssettings=mysql_fetch_array(mysql_query("SELECT username , senderid,api from smssettings "));
// Specify your login credentials
$username   = $smssettings['username'];
$apikey     = $smssettings['api'];
// NOTE: If connecting to the sandbox, please use your sandbox login credentials
// Specify the numbers that you want to send to in a comma-separated list
// Please ensure you include the country code (+254 for Kenya in this case)
//$recipients = "+254722856900,+254728944815,+254724661481,+254716671496";
$q=mysql_query("SELECT name,mobile from contacts order by id asc  ");
while($query=mysql_fetch_array($q)){
$phone=$query['mobile'];
$name=$query['name'];
$msg=$_POST['msg'];
$recipients=$phone;
// And of course we want our recipients to know what we really do
$message    =$msg;
$from = $smssettings['senderid'];

$patientid=$query['pid'];
$user=$_SESSION['user'];
$enqueue    = true;
//mysql_query("INSERT iNTO  messages(clientid,msg,tel,sender)values('$patientid','$message','$phone','$user')");
// Create a new instance of our awesome gateway class
$gateway    = new AfricasTalkingGateway($username, $apikey);
// NOTE: If connecting to the sandbox, please add the sandbox flag to the constructor:
/*************************************************************************************
             ****SANDBOX****
$gateway    = new AfricasTalkingGateway($username, $apiKey, "sandbox");
**************************************************************************************/
// Any gateway error will be captured by our custom Exception class below, 
// so wrap the call in a try-catch block
try 
{ 
  // Thats it, hit send and we'll take care of the rest. 
  $results = $gateway->sendMessage($recipients, $message,$from,$enqueue);
            
  foreach($results as $result) {
    // status is either "Success" or "error message"
    echo " Number: " .$result->number;
    echo " Status: " .$result->status;
    echo " MessageId: " .$result->messageId;
    echo " Cost: "   .$result->cost."\n";
  }
}
catch ( AfricasTalkingGatewayException $e )
{
  echo "Encountered an error while sending: ".$e->getMessage();
}
}
  echo "<script>alert('SMS Sent!')</script>";
 echo "<script>location.replace('appointments.php')</script>";
// DONE!!! 
?>