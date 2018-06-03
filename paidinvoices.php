<?php
include('header.php');
$query="SELECT inv.id as id, inv.totalcost as tot ,inv.dateadded as dateadded,p.name as name , p.tel as tel from invoices inv inner join patients p on p.id=inv.patientid where inv.status='2' order by  inv.dateadded  asc";
$result=mysql_query($query);
?>
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Invoices</a> </div>
    <h1>Paid Invoices Details</h1>
  </div>
  <div class="container-fluid">
    <hr>
    <div class="row-fluid">
      <div class="span12">

<div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
            <h5>Invoice Details</h5>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Client Name</th>
                  <th>Client Tel</th>
                  <th>Total Cost</th>
                  <th>Dateadded</th>
                  <th>Payment Plan</th>
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
                  <td><?php echo $row['tel']?></td>
                  <td><?php echo $row['tot']?></td>
                  <td><?php echo $row['dateadded']?></td>               
                  <td><a href="invoiceplan.php?id=<?php echo $row['id']?>" class="btn btn-success btn-mini"><i class="icon icon-money"></i> Payment Plan</a> </td>             
                  <td><a href="invoice.php?id=<?php echo $row['id']?>" class="btn btn-primary btn-mini"><i class="icon icon-camera-retro"></i> View</a> </td> 
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