<?php
include('header.php');
$query="SELECT p.name as name,it.name as itemtypename,b.name as brandname,ps.totalstock as stock  FROM productstock ps inner join products p on p.id=ps.productid inner join brand b on b.id=p.brandid inner join itemtype it on it.id=p.itemtypeid order by p.name ASC";
$result=mysql_query($query);
?>
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Product Stock</a> </div>
    <h1>Product Stock</h1>
  </div>
  <div class="container-fluid">
    <hr>
    <div class="row-fluid">
      <div class="span12">

<div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
            <h5>Product Details</h5>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Name</th>
                  <th>Product Type Name</th>
                  <th>Brand Name</th>
                  <th>Stock</th>
                  <th>Audit</th>
                  <th>Edit</th>
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
                  <td><?php echo $row['stock']?></td>
                  <td><a href="stockaudit.php?id=<?php echo $row['id']?>" class="btn btn-default btn-mini"><i class="icon icon-truck"></i> Restock</a> </td>                 
                  <td><a href="editstocklevel.php?id=<?php echo $row['id']?>" class="btn btn-primary btn-mini"><i class="icon icon-edit"></i> Edit</a> </td>
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