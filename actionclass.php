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
$prices=mysql_fetch_array(mysql_query("SELECT sp.price as price from stockprice sp inner join products p on p.id=sp.productid order by sp.dateadded desc limit 1 "));
//get pricing
$price=$prices['price'];
$total=$price*$quantity;
//get current invoice total
$invoice=mysql_fetch_array(mysql_query("SELECT i.totalcost as total from invoices i where i.id='$id' "));
//new total
$currentinvoicetotal=$invoice['total'];
$newtotl=$currentinvoicetotal+$total;
//insert iinvoice items
mysql_query("INSERT INTO invoiceitems(invoiceid,productid,unitprice,quantity,total)VALUES('$id','$productid','$price','$quantity','$total')");
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
$date=date('Y-m-d');
		// insert to receipts for each mode
		/*
		*1-MPesa Paybill
		*2-Cheque
		*3-Bank Ledger/Cash
		*4-Insuarance
		*/
//INSERT INTO RECEIPTS
if ($mode=="1") {
mysql_query("INSERT INTO receipts (invoiceid,amountdue,amountpaid,balance,paymentmethod,mpesa,recordedby,dateadded)VALUES('$id','$due','$paid','$bal','$mode','$ref','$user','$date')");
}elseif ($mode=="2") {
mysql_query("INSERT INTO receipts (invoiceid,amountdue,amountpaid,balance,paymentmethod,cheque,recordedby,dateadded)VALUES('$id','$due','$paid','$bal','$mode','$ref','$user','$date')");

}elseif ($mode=="3") {
mysql_query("INSERT INTO receipts (invoiceid,amountdue,amountpaid,balance,paymentmethod,bankledger,recordedby,dateadded)VALUES('$id','$due','$paid','$bal','$mode','$ref','$user','$date')");

}elseif ($mode=="4") {
mysql_query("INSERT INTO receipts (invoiceid,amountdue,amountpaid,balance,paymentmethod,insuarance,recordedby,dateadded)VALUES('$id','$due','$paid','$bal','$mode','$ref','$user','$date')");
}	
//update invoice status 1 is partial 2 is fully paid
		if ($bal>0) {
			# code...
			mysql_query("UPDATE invoices set status='1'where id='$id'");
		}elseif ($bal<=0) {
			mysql_query("UPDATE invoices set status='2'where id='$id'");

		}

echo "<script>alert('Payment Added!')</script>";
		echo "<script>location.replace('receipts.php')</script>";

}
?>