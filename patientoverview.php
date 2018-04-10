<?php
include('header.php');
$id=$_REQUEST['id'];
$p=mysql_fetch_array(mysql_query("SELECT name from patients where id='$id'"));
$exams=mysql_query("SELECT * FROM patient_exams where patientid='$id'");
$lens=mysql_query("SELECT * FROM contactlens where patientid='$id'");
?>

 <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i>Patient Overview </a> <a href="#" class="current"><?php echo $p['name']?></a> </div>
  </div>
  <div class="container-fluid">
    <hr>
    <h4><?php echo $p['name']?></h4>
    <div class="row-fluid">
      <div class="span12">

<div class="widget-box">
           <h4>	Examinitions</h4>
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
            <h5>Patient Examinitions</h5>

            <a href="addexaminition.php?id=<?php echo $id?>" class="btn btn-success btn-xs"><i class="icon icon-book ">Add Examinition Record</i></a>
          </div>

          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Eye</th>
                  <th>Subjective RX</th>
                  <th>Notes</th>
                  <th>Dateadded</th>
                  <th>Logged By</th>
                  <th>Edit</th>
                  <th>Delete</th>
                </tr>
              </thead>
              <tbody>
              <?php 
              $no=0;
              while($row=mysql_fetch_array($exams)){?>
                <tr class="gradeX">
                <?php
                $no++;
                ?>
                  <td><?php echo $no?></td>
                  <td><?php echo $row['eye']?></td>
                  <td><?php echo $row['subjectiverx']?></td>
                  <td><?php echo $row['notes']?></td>
                  <td><?php echo $row['dateadded']?></td> 
                  <td><?php echo $row['staffid']?></td>                 
                  <td><a href="editexam.php?id=<?php echo $row['id']?>" class="btn btn-primary btn-mini"><i class="icon icon-edit"></i> Edit</a> </td>
                  <td><a href="actionclass.php?action=delete_exam&&id=<?php echo $row['id']?>" class="btn btn-danger btn-mini"><i class="icon icon-trash"></i> Delete</a> </td>
                </tr>
                <?php }?>
              </tbody>
            </table>
          </div>
        </div>
      </div>


      <div class="widget-box">
           <h4>Contact Lens</h4>
          <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
            <h5>Patient Conact Lens</h5>

            <a href="addcontactlens.php?id=<?php echo $id?>" class="btn btn-success btn-xs"><i class="icon icon-book ">Add Contact Lens Record</i></a>
          </div>

          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Eye</th>
                  <th>Prescription</th>
                  <th>Notes</th>
                  <th>Logged By</th>
                  <th>Dateadded</th>
                  <th>Edit</th>
                  <th>Delete</th>
                </tr>
              </thead>
              <tbody>
              <?php 
              $no=0;
              while($row=mysql_fetch_array($lens)){?>
                <tr class="gradeX">
                <?php
                $no++;
                ?>
                  <td><?php echo $no?></td>
                  <td><?php echo $row['eye']?></td>
                  <td><?php echo $row['prescription']?></td>
                  <td><?php echo $row['notes']?></td>
                  <td><?php echo $row['staffid']?></td>
                  <td><?php echo $row['dateadded']?></td>                  
                  <td><a href="editexam.php?id=<?php echo $row['id']?>" class="btn btn-primary btn-mini"><i class="icon icon-edit"></i> Edit</a> </td>
                  <td><a href="actionclass.php?action=delete_exam&&id=<?php echo $row['id']?>" class="btn btn-danger btn-mini"><i class="icon icon-trash"></i> Delete</a> </td>
                </tr>
                <?php }?>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    <!-- Modals -->

<?php include('footer.php');?>


  </div>

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