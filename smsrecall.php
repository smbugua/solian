<?php
include('header.php');
// Be sure to include the file you've just downloaded
require_once('AfricasTalkingGateway.php');
$id=$_REQUEST['id'];
// Specify your login credentials
$username   = "smbugua";
$apikey     = "74acee8753dd77b4be356cb190c1dd22f6d993f86e2ecb24d092361617d83148";
// NOTE: If connecting to the sandbox, please use your sandbox login credentials
// Specify the numbers that you want to send to in a comma-separated list
// Please ensure you include the country code (+254 for Kenya in this case)
//$recipients = "+254722856900,+254728944815,+254724661481,+254716671496";
$q=mysql_query("SELECT p.tel as tel ,p.name as name,a.type as type ,a.datescheduled as datea from appointments a inner join patients p on p.id=a.patientid where a.id='$id' order by a.datemodified desc ");
while($query=mysql_fetch_array($q)){
$phone=$query['tel'];
$name=$query['name'];
$dateadded=$query['datea'];
$recipients=$phone;
// And of course we want our recipients to know what we really do
$message    ="Hello ".$name." your appointment on".$dateadded." has been booked.Solian Investments Thanks you for your Business!.";
//$from = "GALLERIA";
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
  $results = $gateway->sendMessage($recipients, $message);
            
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