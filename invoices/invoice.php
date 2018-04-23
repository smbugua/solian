<?php
include('../auth.php');
include('../src/InvoicePrinter.php');
$id=$_REQUEST['id'];
$main=mysql_fetch_array(mysql_query("SELECT * FROM settings"));
$company_name=$main['main_name'];
$company_location=$main['main_location'];
$company_tel=$main['main_tel'];
$company_address=$main['main_address'];
$email=$main['email'];
$inv=mysql_fetch_array(mysql_query("SELECT i.invoicenumber as invoicenumber,i.dateadded as dateadded,p.name as name,i.totalcost as invoicetotal ,i.status as status ,p.address as paddress,p.town as ptown ,p.tel as ptel,p.email as pemail  from invoices i inner join patients p on p.id=i.patientid where i.id='$id'"));
$count=$inv['invoicenumber'];
$result=mysql_query("SELECT p.productname as productname, it.name as itemtypename ,b.name as brandname , itms.quantity as quantity , itms.unitprice as price ,itms.total as totalcost  from products p inner join itemtype it on it.id=p.itemtypeid inner join brand b on b.id=p.brandid inner join invoiceitems itms on itms.productid=p.id inner join invoices i on i.id=itms.invoiceid where i.id='$id'");

$total=$inv['invoicetotal'];
$tax=.16*$total;
$subtotal=$total-$tax;
$status=$inv['status'];
$no=$inv['invoicenumber'];
$invoice = new Konekt\PdfInvoice\InvoicePrinter();

  /* Header Settings */
  $invoice->setLogo("images/solian-logo.jpg");
  $invoice->setColor("#AA3939");
  $invoice->setType("Sale Invoice");
  $invoice->setReference($inv['invoicenumber']);
  $invoice->setDate($inv['dateadded']);
  //$invoice->setTime(date('h:i:s A',time()));
  $invoice->setDue(date('M dS ,Y',strtotime('+3 months')));
  $invoice->setFrom(array("Seller Name",$company_name,$company_location,$company_address,$company_tel));
  $invoice->setTo(array("Purchaser Name",$inv['name'],$inv['paddress'],$inv['ptel'],$inv['pemail']));
  /* Adding Items in table */
  while ($row=mysql_fetch_array($result)) {
   $producttax=$row['price']*.16;
  $invoice->addItem($row['productname'],$row['itemtypename'],$row['quantity'],$producttax,$row['price'],0,$row['totalcost']); 
  }
  /* Add totals */
  $invoice->addTotal("Total",$subtotal);
  $invoice->addTotal("VAT 16%",$tax);
  $invoice->addTotal("Total due",$total,true);
  /* Set badge */ 
  if ($status=="0") {
    
  $invoice->addBadge("UnPaid");
  }elseif ($status=="1") {
    
  $invoice->addBadge("Partial Payment Paid");
  }elseif ($status=="2") {
   
  $invoice->addBadge("Payment Paid");
  }elseif ($status=="5") {
   
  $invoice->addBadge("Cancelled");
  }
  /* Add title */
  $invoice->addTitle("Freedom To Live");
  /* Add Paragraph */
  $invoice->addParagraph("Real Estate | Investments | Asset Management | Project Development");
  /* Set footer note */
  $invoice->setFooternote("SOLIAN INVESTMENTS LTD");
  /* Render */
  $invoice->render('Invoice'.$no.'.pdf','I'); /* I => Display on browser, D => Force Download, F => local path save, S => return document path */
?>
