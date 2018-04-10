<?php
include('header.php');
$id=$_REQUEST['id'];
$main=mysql_fetch_array(mysql_query("SELECT * FROM settings"));
$company_name=$main['main_name'];
$company_location=$main['main_location'];
$company_tel=$main['main_tel'];
$company_address=$main['main_address'];
$email=$main['email'];
$inv=mysql_fetch_array(mysql_query("SELECT i.invoicenumber as invoicenumber,i.dateadded as dateadded,p.name as name,i.totalcost as invoicetotal from invoices i inner join patients p on p.id=i.patientid where i.id='$id'"));
$count=$inv['invoicenumber'];
$result=mysql_query("SELECT p.productname as productname, it.name as itemtypename ,b.name as brandname , itms.quantity as quantity , itms.unitprice as price ,itms.total as totalcost  from products p inner join itemtype it on it.id=p.itemtypeid inner join brand b on b.id=p.brandid inner join invoiceitems itms on itms.productid=p.id inner join invoices i on i.id=itms.invoiceid where i.id='$id'");

$total=$inv['invoicetotal'];

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
                   <a href="#myAlert" data-toggle="modal" class="btn btn-success pull-right"><i class="icon icon-plus"></i> Add Item</a> 
                    
                    <tr>
                      <th class="head0">Porduct</th>
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
                      <th class="right"><?php echo $row[0]?></th>
                      <th class="right"><?php echo $row[1]?></th>
                      <th class="right"><?php echo $row[2]?></th>
                      <th class="right"><?php echo $row[3]?></th>
                      <th class="right"><?php echo $row[4]?></th>
                      <th class="right"><?php echo $row[5]?></th>
                    </tr>
                    <?php }?>
                    
                  </tbody>
                </table>
                <div class="pull-right">
                  <h4><span>Amount Due:</span><?php echo $total ?></h4>
                  <br>
                  <a class="btn btn-primary btn-large pull-right" href="unpaidinvoices.php">Submit Invoice</a> </div></div>
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

<!-- modal -->

        <div id="myAlert" class="modal hide">
              <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button">×</button>
                <h3>Add Billing Item</h3>
              </div>

              <div class="modal-body">
                <form method="post" action="actionclass.php?action=addinvoiceitem&&invoiceid=<?php echo $id?>">
                   <div class="control-group">
                  <label class="control-label">Product</label>
                  <div class="controls">
                    <select name="product" class="form-control">
                    <?php
                    $productresult=mysql_query("SELECT id,productname from products");
                    while($productrow=mysql_fetch_array($productresult)){
                    ?>  
                    <option value="<?php echo $productrow[0]?>"><?php echo $productrow[1]?></option>
                    <?php }?> 
                    </select>
                    <input type="text" name="quantity" class="form-control">
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
</body>

</html>