<?php
include('header.php');
$id=$_REQUEST['id'];
$main=mysql_fetch_array(mysql_query("SELECT * FROM settings"));
$query=mysql_query("SELECT invoicenumber , totalcost,id from invoices where patientid='$id'");



?>

<div id="content-header">
    <div id="breadcrumb"> <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#">Billing</a> <a href="#" class="current">Customer Statements</a> </div>
 
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
                <h4>OPEN ACCOUNTS</h4>
                <table class="table table-bordered table-invoice-full">
                  <thead>
                    <th>Invoice No</th>
                    <th>Total Amount</th>
                    <th>Amount Paid</th>
                    <th>Amount Due</th>
                    <th>Paymet Plan</th>
                  </thead>
                  <tbody>
                    <?php while($r=mysql_fetch_array($query)){
                      $invid=$r['id'];
                      ?>

                    <td><?php echo $r['invoicenumber'] ;?></td>
                    <td><?php echo $r['totalcost']?></td>
                    <td><?php echo paidAmount($invid);?></td>
                    <td><?php echo unpaidAmount($invid)?></td>
                    <td><?php echo paymentPlan($invid)?></td>
                    <?php } ?>
                  </tbody>
                </table>
              </div>
            </div>
            <div class="row-fluid">
              <div class="span12">
                <h4>Closed ACCOUNTS</h4>
                <table class="table table-bordered table-invoice-full">
                  <thead>
                    <th>Account No</th>
                    <th>Invoice No</th>
                    <th>Total Amount</th>
                    <th>Amount Paid</th>
                    <th>Amount Due</th>
                    <th>Paymet Plan</th>
                  </thead>
                  <tbody>
                    <?php while($r=mysql_fetch_array($query)){
                      $invid=$r['id'];
                      ?>
                    <td><?php echo $r['invoicenumber'] ;?></td>
                    <td><?php echo $r['totalcost']?></td>
                    <td><?php echo paidAmount($invid);?></td>
                    <td><?php echo unpaidAmount($invid)?></td>
                    <td><?php echo paymentPlan($invid)?></td>
                    <?php } ?>
                  </tbody>
                </table>
              </div>
            </div>

