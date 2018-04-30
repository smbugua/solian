<?php
include('header.php');
$id=$_REQUEST['id'];
$main=mysql_fetch_array(mysql_query("SELECT * FROM settings"));
$company_name=$main['main_name'];
$company_location=$main['main_location'];
$company_tel=$main['main_tel'];
$company_address=$main['main_address'];
$email=$main['email'];
$inv=mysql_fetch_array(mysql_query("SELECT * from patients  where id='$id'"));

$result=mysql_query("SELECT it.name as project,p.plotno as plotno , p.price as plotprice ,p.dateallocated as dateallocated from plots p inner join itemtype it on it.id=p.projectid inner join patients pp on pp.id=p.customerid where p.customerid='$id' ");



?>

<div id="content-header">
    <div id="breadcrumb"> <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#">Billing</a> <a href="#" class="current">invoice</a> </div>
    <h1>Plot Allocation</h1>
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
                      <td class="width30">Name</td>
                      <td class="width70"><strong><input type="text" name="invoiceno" value="<?php echo $inv['name']?>" readonly=""></strong></td>
                    </tr>
                    <tr>
                      <td>Address</td>
                      <td><strong><input type="text" name="dateadded" value="<?php echo $inv['address']?>" readonly=""></strong></td>
                    </tr>
                    <td class="width30">Town:</td>
                    <td class="width70">
                     <input type="text" name="name" value="<?php echo $inv['town']?>" readonly="">

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
                   <a href="#myAlert" data-toggle="modal" class="btn btn-success pull-right"><i class="icon icon-plus"></i> Allocate PLot</a> 
                    
                    <tr>
                      <th class="head0">Project</th>
                      <th class="head1">Plot No</th>
                      <th class="head1">Price</th>
                      <th class="head2">Date Allocated</th>
                    </tr>
                  </thead>
                  <tbody>
                      <?php while($row=mysql_fetch_array($result)){?>
                    <tr>
                      <th class="right"><?php echo $row[0]?></th>
                      <th class="right"><?php echo $row[1]?></th>
                      <th class="right"><?php echo $row[2]?></th>
                      <th class="right"><?php echo $row[3]?></th>
                    </tr>
                    <?php }?>
                    
                  </tbody>
                </table>
                <div class="pull-right">
                  <h4><span></h4>
                  <br>
                  <a class="btn btn-primary btn-large pull-right" href="allocations.php">Plot Allocations </a></div></div>
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
                <h3>Allocate Plot </h3>
              </div>

              <div class="modal-body">
                <form method="post" action="actionclass.php?action=allocateplot&&clientid=<?php echo $id?>">
                   <div class="control-group">
                  <label class="control-label">Project</label>
                  <div class="controls">
                    <select name="project" class="form-control">
                    <?php
                    $productresult=mysql_query("SELECT id,productname from products");
                    while($productrow=mysql_fetch_array($productresult)){
                    ?>  
                    <option value="<?php echo $productrow[0]?>"><?php echo $productrow[1]?></option>
                    <?php }?> 
                    </select>

                  <label class="control-label">PLot No</label>
                    <input type="text" name="plotno" class="form-control">
                  <label class="control-label">Price</label>
                    <input type="text" name="price" class="form-control">
                  <label class="control-label">Date Allocated</label>
                    <input type="date" name="datea" value="<?php echo date('Y-m-d')?>" class="form-control">
                   </div>
                </div>
                </div>
              <div class="modal-footer"> <button type="submit" class="btn btn-primary" >Confirm</button> </div>
            </form>
            </div>

<script src="js/jquery.min.js"></script> 
<script src="js/jquery.ui.custom.js"></script> 
<script src="js/bootstrap.min.js"></script> 
<script src="js/jquery.peity.min.js"></script> 
<script src="js/matrix.interface.js"></script> 
<script src="js/matrix.popover.js"></script>
</body>

</html>