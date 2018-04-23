<?php
include('header.php');
$id=$_REQUEST['id'];
$b=mysql_fetch_array(mysql_query("SELECT name from brand where id='$id' "));
?>
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="brands.php">City</a> <a href="#" class="current">Add City</a> </div>
    <h1>Add City</h1>
  </div>
  <div class="container-fluid"><hr>
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-pencil"></i> </span>
            <h5>Add Cities Details</h5>
          </div>
          <div class="widget-content nopadding">
            <form id="form-wizard" action="patientclass.php?action=editbrand&&id=<?php echo $id?>" class="form-horizontal" method="post">
              <div id="form-wizard-1" class="step">
                <div class="control-group">
                  <label class="control-label">City/Town Name</label>
                  <div class="controls">
                    <input id="username" type="text" name="name" value="<?php echo $b['name']?>" />
                  </div>
                </div>
                  
              
              </div>
          
              <div class="form-actions">
                <button class="btn btn-primary btn-xs" type="submit">Submit</button>
                <div id="status"></div>
              </div>
              <div id="submitted"></div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

































<?php include('footer.php');?>