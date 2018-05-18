<?php
include ('header.php');
$invoiceid=$_REQUEST['id'];
//insert into payment plans
$period=$_POST['period'];
$installements=$_POST['installments'];
$planid=$_POST['planid'];

mysql_query("INSERT INTO invoice_paymentplan(invoiceid,period,planid)VALUES('$invoiceid','$period','$planid')");
$last_id=mysql_insert_id();
//insert into installements
for ($i=1; $i <=$period ; $i++) { 
	$date=date("Y-m-d", strtotime("$i months"));
	mysql_query("INSERT INTO invoice_installments(invoiceplanid,installment,datedue)values('$last_id','$installements','$date')");
	echo "<script>location.replace('unpaidinvoices.php')</script>";
}