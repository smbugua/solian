<?php
include('header.php');
$query="SELECT p.id as id,p.productname as name ,b.name as brandname ,it.name as itemtypename from products p inner join brand b on p.brandid=b.id inner join itemtype it on it.id=p.itemtypeid order by  p.productname asc";
$result=mysql_query($query);
?>
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Appointment Details</a> </div>
    <h1>Appointment Details</h1>
  </div>
  <div class="container-fluid">
    <hr>
    <div class="row-fluid">
      <div class="span12">

<div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
            <h5>Appointments Details</h5>
            <a href="addproduct.php" class="btn btn-success">Add Appointment</a>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Customer Name</th>
                  <th>Appointment Type</th>
                  <th>Date</th>
                  <th>Recall</th>
                  <th>Edit</th>
                  <th>Delete</th>
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
                  <td><?php echo $row['brandname']?></td> 
                  <td><?php echo $row['itemtypename']?></td>
                  <td><a href="addstock.php?id=<?php echo $row['id']?>" class="btn btn-default btn-mini"><i class="icon icon-truck"></i> Restock</a> </td>                 
                  <td><a href="editproduct.php?id=<?php echo $row['id']?>" class="btn btn-primary btn-mini"><i class="icon icon-edit"></i> Edit</a> </td>
                  <td><a href="actionclass.php?action=delete_patient&&id=<?php echo $row['id']?>" class="btn btn-danger btn-mini"><i class="icon icon-trash"></i> Delete</a> </td>
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