<?php
include('header.php');
$query="SELECT * from addressbook where status='0' order by  name asc";
$result=mysql_query($query);
?>
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Bulk SMS</a> </div>
    <h1>Bulk SMS</h1>
  </div>
  <div class="container-fluid">
    <hr>
    <div class="row-fluid">
      <div class="span12">

<div class="widget-box">
  <br>
  <div class="button-class">
              <form action="upload">
                
              </form>
            <a href="uploads/samples/sample.csv" class="btn btn-success">Download Sample File</a>
    </div>
    <br>
          <div class="widget-title"> <span class="icon"><i class="icon-th">
            
          </i></span>
            <h5>Blast SMS Address Book Details</h5>
          </div>

          <div class="widget-content nopadding">

            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Name</th>
                  <th>Other Names</th>
                  <th>Tel</th>
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
                  <td><?php echo $row['other_names']?></td>
                  <td><?php echo $row['phoneno']?></td>
                  <td><a href="patientclass.php?action=delete_addressbook&&id=<?php echo $row['id']?>" class="btn btn-danger btn-mini"><i class="icon icon-trash"></i> Delete</a> </td>
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