<?php
include('header.php');
$query="SELECT r.id as id, p.name as name,r.amountdue as tot ,r.amountpaid as amountpaid,r.balance as balance , pm.mode as mode,r.dateadded as dateadded from receipts r inner join invoices inv on inv.id=r.invoiceid inner join patients p on p.id=inv.patientid inner join paymentmodes pm on pm.id=r.paymentmethod order by r.datemodified DESC ";
$result=mysql_query($query);
?>
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Receipts</a> </div>
    <h1>Receipts Details</h1>
  </div>
  <div class="container-fluid">
    <hr>
    <div class="row-fluid">
      <div class="span12">

<div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
            <h5>Receipts Details</h5>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Patient Name</th>
                  <th>Amount Due</th>
                  <th>Amount Paid</th>
                  <th>Balance</th>
                  <th>Payment Mode</th>s
                  <th>Datepaid</th>
                  <th>View</th>
                </tr>
              </thead>
              <tbody>
              <?php 
              $no=0;
              while($row=mysql_fetch_array($result)){?>
                <tr class="gradeX">
                <?php
                $no++;
                ?>
                  <td><?php echo $no?></td>
                  <td><?php echo $row['name']?></td>
                  <td><?php echo $row['tot']?></td>
                  <td><?php echo $row['amountpaid']?></td>
                  <td><?php echo $row['balance']?></td>
                  <td><?php echo $row['mode']?></td>
                  <td><?php echo $row['dateadded']?></td>                  
                  <td><a href="smsreceipt.php?receiptid=<?php echo $row['id']?>" class="btn btn-primary btn-mini"><i class="icon icon-phone-sign"></i> SMS</a> </td>
                </tr>
                <?php }?>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>

<?php include('footer.php');?>
</div>
<!--Footer-part-->
<!--end-Footer-part-->

</body>
</html>

<script src="js/jquery.min.js"></script> 
<script src="js/jquery.ui.custom.js"></script> 
<script src="js/bootstrap.min.js"></script> 
<script src="js/select2.min.js"></script> 
<script src="js/jquery.dataTables.min.js"></script> 
<script src="js/matrix.tables.js"></script>