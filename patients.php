<?php
include('header.php');
$query="SELECT * from patients where status='0' order by  name asc";
$result=mysql_query($query);
?>
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Clients Details</a> </div>
    <h1>Clients Details</h1>
  </div>
  <div class="container-fluid">
    <hr>
    <div class="row-fluid">
      <div class="span12">

<div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
            <h5>Clients Details</h5>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Name</th>
                  <th>Town/City</th>
                  <th>Email</th>
                  <th>Tel</th>
                  <th>National ID</th>
                  <th>DOB</th>
                  <th>Dateadded</th>
                  <th>Details</th>
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
                  <td><?php echo $row['town']?></td>
                  <td><?php echo $row['email']?></td>
                  <td><?php echo $row['tel']?></td>
                  <td><?php echo $row['idno']?></td>
                  <td><?php echo $row['dob']?></td>
                  <td><?php echo $row['datecreated']?></td>                  
                  <td><a href="customerdash.php?id=<?php echo $row['id']?>" class="btn btn-success btn-mini"><i class="icon icon-file"></i> Details</a> </td>
                  <td><a href="editpatient.php?id=<?php echo $row['id']?>" class="btn btn-primary btn-mini"><i class="icon icon-edit"></i> Edit</a> </td>
                  <td><a href="patientclass.php?action=delete_patient&&id=<?php echo $row['id']?>" class="btn btn-danger btn-mini"><i class="icon icon-trash"></i> Delete</a> </td>
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