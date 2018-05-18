<?php
include('header.php');
$id=$_REQUEST['id'];
$main=mysql_fetch_array(mysql_query("SELECT * FROM settings"));
$company_name=$main['main_name'];
$company_location=$main['main_location'];
$company_tel=$main['main_tel'];
$company_address=$main['main_address'];
$email=$main['email'];
$inv=mysql_fetch_array(mysql_query("SELECT i.invoicenumber as invoicenumber,i.dateadded as dateadded,p.name as name,i.totalcost as invoicetotal ,i.status as status  from invoices i inner join patients p on p.id=i.patientid where i.id='$id'"));
$count=$inv['invoicenumber'];
$result=mysql_query("SELECT p.productname as productname, it.name as itemtypename ,b.name as brandname , itms.quantity as quantity , itms.unitprice as price ,itms.total as totalcost  from products p inner join itemtype it on it.id=p.itemtypeid inner join brand b on b.id=p.brandid inner join invoiceitems itms on itms.productid=p.id inner join invoices i on i.id=itms.invoiceid where i.id='$id'");

$total=$inv['invoicetotal'];
$tax=.16*$total;
$subtotal=$total-$tax;
$status=$inv['status'];

?>

<div id="content-header">
    <div id="breadcrumb"> <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#">Billing</a> <a href="#" class="current">invoice</a> </div>
    <h1>Invoice</h1>
  </div>
  <div class="container-fluid"><hr>
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-briefcase"></i> </span>
            <h5 ><?php echo $company_name ?></h5>
          </div>
          <div class="widget-content">
            <div class="row-fluid">
              <div class="span6">
                <table class="">
                  <tbody>
                    <tr>
                      <td><h4><?php echo $company_name ?></h4></td>
                    </tr>
                    <tr>
                      <td><?php echo $company_tel ?></td>
                    </tr>
                    <tr>
                      <td><?php echo $company_address ?></td>
                    </tr>
                    <tr>
                      <td><?php echo $company_location ?></td>
                    </tr>
                    <tr>
                      <td ><?php echo $email?></td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="span6">
                <table class="table table-bordered table-invoice">
                  <tbody>
                    <tr>
                    <tr>
                      <form action="actionclass.php?action=addinvoiceitems" method="post">
                      <td class="width30">Invoice ID:</td>
                      <td class="width70"><strong><input type="text" name="invoiceno" value="<?php echo $count ?>" readonly=""></strong></td>
                    </tr>
                    <tr>
                      <td>Issue Date:</td>
                      <td><strong><input type="date" name="dateadded" value="<?php echo $inv['dateadded']?>" readonly=""></strong></td>
                    </tr>
                    <td class="width30">Patient:</td>
                    <td class="width70">
                     <input type="text" name="name" value="<?php echo $inv['name']?>" readonly="">

                    </td>
                  </tr>
                    </tbody>
                  </form>
                </table>
              </div>
            </div>
            <div class="row-fluid">
              <div class="span12">
                <table class="table table-bordered table-invoice-full">
                  <thead>
                    
                    <tr>
                      <th class="head0">Product</th>
                      <th class="head1">Product Type</th>
                      <th class="head0 right">Brand</th>
                      <th class="head0 right">Qty</th>
                      <th class="head1 right">Price</th>
                      <th class="head0 right">Amount</th>
                    </tr>
                  </thead>
                  <tbody>
                      <?php while($row=mysql_fetch_array($result)){?>
                    <tr>
                      <td class="right"><?php echo $row[0]?></td>
                      <td class="right"><?php echo $row[1]?></td>
                      <td class="right"><?php echo $row[2]?></td>
                      <td class="right"><?php echo $row[3]?></td>
                      <td class="right"><?php echo $row[4]?></td>
                      <td class="right"><?php echo $row[5]?></td>
                    </tr>
                    <?php }?>
                    
                  </tbody>
                </table>
                <table class="table table-bordered table-invoice-full">
                  <tbody>
                    <tr>
                      <td class="msg-invoice" width="85%"><h4>Payment methods: </h4>
                        <a href="#" class="tip-bottom" title="Wire Transfer">Wire transfer</a> |  <a href="#" class="tip-bottom" title="Bank account">Bank account #</a> |  <a href="#" class="tip-bottom" title="SWIFT code">M-Pesa </a></td>
                      <td class="right"><strong>Subtotal</strong> <br>
                        <strong>Tax (16%)</strong> <br>
                        <strong>Total</strong></td>
                      <td class="right"><strong><?php echo $subtotal?> <br>
                        <?php echo $tax?> <br>
                        <?php echo $total?></strong></td>
                    </tr>
                  </tbody>
                </table>
                <div class="pull-left">
                     <a href="invoices/invoice.php?id=<?php echo $id?>"  class="btn btn-info btn-large pull-right" target="_blank" ><i class="icon icon-print"></i> Print Invoice</a> 
                </div>
                <div class="pull-right">
                  <h4><span>Amount Due:</span><?php echo $total ?></h4>
                  <br>
                    <?php if($status=="0" || $status=="1"){?>
                    <a href="#myAlert" data-toggle="modal" class="btn btn-danger btn-large pull-right"><i class="icon icon-money"></i> Pay Invoice</a> 
                    <?php 
                  }elseif ($status=="2") {?>
                     <div class="alert alert-success alert-block"> <a class="close" data-dismiss="alert" href="#">×</a>
              <h4 class="alert-heading">Paid Invoice!</h4>
              Invoice is already Paid</div>
                  <?php }elseif($status=="5"){?>
                     <div class="alert alert-warning alert-block"> <a class="close" data-dismiss="alert" href="#">×</a>
              <h4 class="alert-heading">Voided Invoice!</h4>
              Invoice is Cancelled</div>
              <?php }?>
                
                     </div>

                   </div>
                   <br>
              
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!--Footer-part-->

<?php include('footer.php') ?>
</div>
<!--end-Footer-part--> 

<?php
//balances
$b=mysql_fetch_array(mysql_query("SELECT balance from receipts where invoiceid='$id' order by datemodified desc limit 1"));
$bal=$b['balance'];
$checker=mysql_fetch_array(mysql_query("SELECT i.status as status,totalcost FROM  invoices i where i.id='$id' "));
$statuscheck=$checker['status'];
$totaldue=$checker['totalcost'];

?>

<!-- modal -->

        <div id="myAlert" class="modal hide">
              <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button">×</button>
                <h3>Add Payment Details</h3>
              </div>

              <div class="modal-body">
                <form method="post" action="actionclass.php?action=addpayment&&invoiceid=<?php echo $id?>">
                   <div class="control-group">
                  <label class="control-label">Payment Method</label>
                  <div class="controls">
                    <select name="mode" class="form-control">
                    <?php
                    $productresult=mysql_query("SELECT id,mode from paymentmodes");
                    while($productrow=mysql_fetch_array($productresult)){
                    ?>  
                    <option value="<?php echo $productrow[0]?>"><?php echo $productrow[1]?></option>
                    <?php }?> 
                    </select>
                    <label>Amount Due</label>
                    <?php
                    if ($statuscheck=="0") {
                    ?> 
                    <input type="text" id="due" name="due" class="form-control" readonly="" value="<?php echo $totaldue?>">
                    <?php }
                    elseif($statuscheck=="1") {?>

                    <input type="text" id="due" name="due" class="form-control" readonly="" value="<?php echo $bal?>">
                    <?php }?>
                    <label>Amount Paid</label>
                    <input type="text" name="paid" id="paid" class="form-control" onkeyup="calc()" required="true">
                    <label>Balance</label>
                    <input type="text" name="bal" id="bal" min="0" class="form-control" readonly="">
                    <label>Refference</label>
                    <input type="text" name="ref" class="form-control" required="true">
                    <label>Date Paid<span style="color:green"  > (Click on Down Arrow to change)</span> </label>
                    <input type="date" name="date" class="form-control" value="<?php echo date('Y-m-d')?>" required="true">
                   </div>
                </div>
              
                  
                </div>
              <div class="modal-footer"> <button type="submit" class="btn btn-primary" >Confirm</button> </div>
            </div>



<script src="js/jquery.min.js"></script> 
<script src="js/jquery.ui.custom.js"></script> 
<script src="js/bootstrap.min.js"></script> 
<script src="js/jquery.peity.min.js"></script> 
<script src="js/matrix.interface.js"></script> 
<script src="js/matrix.popover.js"></script>

<script type="text/javascript">
  function calc() {
    var due=document.getElementById('due').value;
    var paid=document.getElementById('paid').value;
    document.getElementById('bal').value=parseInt(due)-parseInt(paid);

  }

</script>

</body>

</html>