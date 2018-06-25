<?php
include('header.php');
$id=$_REQUEST['id'];
$main=mysql_fetch_array(mysql_query("SELECT * FROM settings"));
$query=mysql_query("SELECT invoicenumber , totalcost,id from invoices where id='$id' ");
$query2=mysql_query("SELECT r.id as id, p.name as name,r.amountdue as tot ,r.amountpaid as amountpaid,r.balance as balance , pm.mode as mode,r.dateadded as dateadded from receipts r inner join invoices inv on inv.id=r.invoiceid inner join patients p on p.id=inv.patientid inner join paymentmodes pm on pm.id=r.paymentmethod where r.invoiceid='$id' order by r.datemodified DESC  ");
$r=mysql_fetch_array($query);
  $invid=$r['id'];

?>

<div id="content-header">
    <div id="breadcrumb"> <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#">Billing</a> <a href="#" class="current">Customer Statement</a> </div>
 
  </div>
  <div class="container-fluid"><hr>
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-briefcase"></i> </span>
            <h5 >Client Name : <?php echo customerInfo('name',$id) ?></h5>
          </div>
          <div class="widget-content">
            <div class="row-fluid">
              <div class="span6">
                <table class="">
                  <tbody>
                    <tr>
                      <td><h4>Client Tel: <?php echo customerInfo('tel',$id) ?></h4></td>
                    </tr>
                    <tr>
                      <td>Client Address: <?php echo customerInfo('address',$id) ?></td>
                    </tr>
                    <tr>
                      <td>Client Email: <?php echo customerInfo('email',$id) ?></td>
                    </tr>
                    <tr>
                      <td>Town: <?php echo customerInfo('town',$id) ?></td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="span6">
 
              </div>
            </div>
            <div class="row-fluid">
              <div class="span12">
                <h4> ACCOUNTS <?php echo $r['invoicenumber'] ?></h4>
                <table class="table table-bordered table-invoice-full">
                  <thead>
                    <th>Invoice No</th>
                    <th>Total Amount Due</th>
                    <th>Amount Paid</th>
                    <th>Balance</th>
                    <th>Paymet Method</th>
                  </thead>
                  <tbody>
                  	<?php while($r2=mysql_fetch_array($query2)){
                    
                      ?>
<tr>
                    <td><?php echo  $r['invoicenumber'] ;?></td>
                    <td><?php echo  $r['totalcost'] ;?></td>
                    <td><?php echo  $r2['amountpaid'] ;?></td>
                    <td><?php echo  $r2['balance'] ;?></td>
                    <td><?php echo  $r2['mode'] ;?></td>
                    </tr>
                    <?php } ?>
                  </tbody>
                </table>
              </div>
            </div>