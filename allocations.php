<?php
include('header.php');
$result=mysql_query("SELECT it.name as project,p.plotno as plotno , p.price as plotprice ,p.dateallocated as dateallocated , pp.name as clientname from plots p inner join itemtype it on it.id=p.projectid inner join patients pp on pp.id=p.customerid  ");
?>

 <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i>Client Overview </a> <a href="#" class="current">Plot Allocations</a> </div>
  </div>
  <div class="container-fluid">
    <hr>
    <div class="row-fluid">
      <div class="span12">

<div class="widget-box">
           <h4>	Plot Allocations</h4>
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
            <h5>Plots Allocation List</h5>

              </div>

          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Name</th>
                  <th>Project</th>
                  <th>Plot no </th>
                  <th>Price</th>
                  <th>Date Allocated</th>
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
                  <td><?php echo $row['clientname']?></td>
                  <td><?php echo $row['project']?></td>
                  <td><?php echo $row['plotno']?></td>
                  <td><?php echo $row['plotprice']?></td>
                  <td><?php echo $row['dateallocated']?></td>
                </tr>
                <?php }?>
              </tbody>
            </table>
          </div>
        </div>
      </div>


    <!-- Modals -->



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