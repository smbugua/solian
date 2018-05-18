<?php
include('header.php');
// Be sure to include the file you've just downloaded
require_once('AfricasTalkingGateway.php');
$id=$_REQUEST['receiptid'];
// Specify your login credentials
$username   = "Newmove";
$apikey     = "b7632588b2b1717cd825fc2561c1a701c7c8b3e15c626380dc03be9fc0049d89";
// NOTE: If connecting to the sandbox, please use your sandbox login credentials
// Specify the numbers that you want to send to in a comma-separated list
// Please ensure you include the country code (+254 for Kenya in this case)
//$recipients = "+254722856900,+254728944815,+254724661481,+254716671496";
$q=mysql_query("SELECT p.tel as tel ,p.name as name ,r.amountpaid as paid, r.dateadded as dateadded ,i.patientid as pid from receipts r inner join invoices i on i.id=r.invoiceid inner join patients p on p.id=i.patientid where r.id='$id' ");
while($query=mysql_fetch_array($q)){
$phone=$query['tel'];
$name=$query['name'];
$paid=$query['paid'];
$dateadded=$query['dateadded'];
$recipients=$phone;
// And of course we want our recipients to know what we really do
$message    ="Hello ".$name." your payment of ".$paid." to on ".$dateadded." has been received.Solian Investments Thanks you for your Business!.";
$patientid=$query['pid'];
$user=$_SESSION['user'];
mysql_query("INSERT iNTO  messages(clientid,msg,tel,sender)values('$patientid','$message','$phone','$user')");
$from = "SOLIAN";
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
  $results = $gateway->sendMessage($recipients, $message,$from);
            
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
 echo "<script>location.replace('receipts.php')</script>";
// DONE!!! 
?>