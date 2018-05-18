<?php
include('header.php');
if ($_GET['action']=="addinvoice") {
$patientid=$_POST['patientid'];
$dateadded=$_POST['dateadded'];
$invoicenumber=$_POST['invoiceno'];
mysql_query("INSERT INTO invoices(patientid,dateadded,invoicenumber)VALUES('$patientid','$dateadded','$invoicenumber')");
$last_id = mysql_insert_id();
echo "<script>location.replace('billing.php?id=$last_id')</script>";
}elseif ($_GET['action']=="addinvoiceitem") {
$id=$_REQUEST['invoiceid'];
$productid=$_POST['product'];
$quantity=$_POST['quantity'];
$plotid=$_POST['plotno'];
$prices=mysql_fetch_array(mysql_query("SELECT sp.price as price from stockprice sp inner join products p on p.id=sp.productid order by sp.dateadded desc limit 1 "));
//get pricing
$price=$_POST['price'];
$total=$price*$quantity;
//get current invoice total
$invoice=mysql_fetch_array(mysql_query("SELECT i.totalcost as total from invoices i where i.id='$id' "));
//new total
$currentinvoicetotal=$invoice['total'];
$newtotl=$currentinvoicetotal+$total;
$date=date('Y-m-d');
$clientid=getInvoicePatient($id);
//insert iinvoice items
mysql_query("INSERT INTO invoiceitems(invoiceid,productid,unitprice,quantity,total,plotid)VALUES('$id','$productid','$price','$quantity','$total','$plotid')");
//set plot as assigned to customer and 
mysql_query("UPDATE plotstatus set status=1 where id='$plotid'");
mysql_query("INSERT INTO plot_customers(clientid,plotid,dateadded)values('$clientid','$plotid','$date')");
//SET NEW STOCK
$currentstock=getstock($productid);
$newstock=$currentstock-$quantity;
updatestock($productid,$newstock);
//update invoice total
mysql_query("UPDATE invoices SET totalcost='$newtotl' where id='$id'");
echo "<script>alert('Product Added!')</script>";
echo "<script>location.replace('billing.php?id=$id')</script>";
}elseif ($_GET['action']=="addpayment") {
//get posted values
$id=$_REQUEST['invoiceid'];
$due=$_POST['due'];
$ref=$_POST['ref'];
$mode=$_POST['mode'];
$bal=$_POST['bal'];
$paid=$_POST['paid'];	
$user=$_SESSION['user'];
$date=$_POST['date'];
		// insert to receipts for each mode
		/*
		*1-MPesa Paybill
		*2-Cheque
		*3-Bank Ledger/Cash
		*4-wire
		*/
//INSERT INTO RECEIPTS
if ($mode=="1") {
mysql_query("INSERT INTO receipts (invoiceid,amountdue,amountpaid,balance,paymentmethod,mpesa,recordedby,dateadded)VALUES('$id','$due','$paid','$bal','$mode','$ref','$user','$date')");
}elseif ($mode=="2") {
mysql_query("INSERT INTO receipts (invoiceid,amountdue,amountpaid,balance,paymentmethod,cheque,recordedby,dateadded)VALUES('$id','$due','$paid','$bal','$mode','$ref','$user','$date')");

}elseif ($mode=="3") {
mysql_query("INSERT INTO receipts (invoiceid,amountdue,amountpaid,balance,paymentmethod,bankledger,recordedby,dateadded)VALUES('$id','$due','$paid','$bal','$mode','$ref','$user','$date')");

}elseif ($mode=="4") {
mysql_query("INSERT INTO receipts (invoiceid,amountdue,amountpaid,balance,paymentmethod,wire,recordedby,dateadded)VALUES('$id','$due','$paid','$bal','$mode','$ref','$user','$date')");
}	
//update invoice status 1 is partial 2 is fully paid
		if ($bal>0) {
			# code...
			mysql_query("UPDATE invoices set status='1'where id='$id'");
		}elseif ($bal<=0) {
			mysql_query("UPDATE invoices set status='2'where id='$id'");

		}
/*
*set status on installments table to paid
*
**/
$getinst=mysql_fetch_array(mysql_query("SELECT ii.id as id   from invoice_installments ii inner join invoice_paymentplan ip on ip.id=ii.invoiceplanid where ip.invoiceid='$id' and ii.status='0' order by ii.id asc LIMIT 1"));
$inst=$getinst[0];
mysql_query("UPDATE invoice_installments set status=1 where id='$inst'");



echo "<script>alert('Payment Added!')</script>";
		echo "<script>location.replace('receipts.php')</script>";

}elseif ($_GET['action']=="void") {
	$id=$_REQUEST['id'];
	mysql_query("UPDATE invoices set status='5' where id='$id'");
	echo "<script>alert('Invoice Voided!')</script>";
		echo "<script>location.replace('voidedinvoices.php')</script>";
}elseif ($_GET['action']=="allocateplot") {
	$clientid=$_REQUEST['clientid'];
	$projectid=$_POST['project'];
	$plotno=$_POST['plotno'];
	$price=$_POST['price'];
	$dateadded=$_POST['datea'];
	mysql_query("INSERT INTO plots(customerid,projectid,plotno,price,dateallocated)values('$clientid','$projectid','$plotno','$price','$dateadded')");
	
		echo "<script>location.replace('allocate.php?id=$clientid')</script>";	

}
?>