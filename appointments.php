<?php
include('header.php');
$query="SELECT a.id as id ,p.name as name,a.type as type ,a.notes as notes ,a.datescheduled as datea from appointments a inner join patients p on p.id=a.patientid order by a.datemodified desc";
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
            <a href="addappointment.php" class="btn btn-success">Add Appointment</a>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Customer Name</th>
                  <th>Appointment Type</th>
                  <th>Notes</th>
                  <th>Date</th>
                  <th>SMS</th>
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
                  <td><?php echo $row['type']?></td> 
                  <td><?php echo $row['notes']?></td>
                  <td><?php echo $row['datea']?></td>
                  <td><a href="smsrecall.php?id=<?php echo $row['id']?>" class="btn btn-info btn-mini"><i class="icon icon-phone-sign"></i> SMS </a> </td>                 
                  <td><a href="#" class="btn btn-primary btn-mini"><i class="icon icon-edit"></i> Edit</a> </td>
                  <td><a href="#" class="btn btn-danger btn-mini"><i class="icon icon-trash"></i> Delete</a> </td>
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