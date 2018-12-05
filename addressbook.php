<?php
include('header.php');
$query="SELECT * from contacts order by  name asc";
$result=mysql_query($query);
?>
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Bulk SMS</a> </div>
    <h1>Bulk SMS</h1>
  </div>
  <div class="container-fluid">
    <hr>
      <div class="row-fluid">
    <div class="span6">
      

  <div class="widget-box">
      <div class="widget-title"> <span class="icon"><i class="icon-th">
            
          </i></span>
            <h5>Bulk SMS Actions</h5>
        </div>
            <div class="widget-content nopadding">

          <table class="table table-bordered ">
            <thead></thead>
            <tbody>
              <tr>
               <form enctype="multipart/form-data" method="post" action="upload.php">
              <td> <label>Upload a CSV file with phone details </label></td>
              <td><input name="file" id="upload" type="file" accept=".csv" class="left"  /><button type="submit"  class="btn-danger" >Upload File</button></td>
               </form>
             </tr>
             <tr>
               <td> <label>Download a Sample csv file </label></td>
               <td><a href="uploads/samples/sample.csv" class="btn btn-success">Download Sample File</a></td>
             </tr>
            </tbody>
  </table>
          </div>

    </div>
  </div>  
  <div class="span6">
      

  <div class="widget-box">
      <div class="widget-title"> <span class="icon"><i class="icon-th">
            
          </i></span>
            <h5>Enter Message to Queue</h5>
        </div>
            <div class="widget-content nopadding">

          <table class="table table-bordered ">
            <thead></thead>
            <tbody>
              <tr>
               <form enctype="multipart/form-data" method="post" action="bulksms.php">
              <td> <label>Message</label></td>
              <td><textarea cols="15" rows="5"  name="msg"> </textarea></td>
             </tr>
             <tr>
               <td> <label>Queue messages for sending </label></td>
               <td><button  class="btn btn-success" type="submit">Send</button></td>
               </form>
             </tr>
            </tbody>
  </table>
          </div>

    </div>
  </div>
  </div>
<div class="row-fluid">
  <div class="span12">

    <div class="widget-box">
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
                  <th>Mobile</th>
                  <th>Email</th>
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
                  <td><?php echo $row['mobile']?></td>
                  <td><?php echo $row['email']?></td>
                  <td><a href="patientclass.php?action=delete_contact&&id=<?php echo $row['id']?>" class="btn btn-danger btn-mini"><i class="icon icon-trash"></i> Delete</a> </td>
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