<?php
include('header.php');
$id=$_REQUEST['id'];
$it=mysql_fetch_array(mysql_query("SELECT * FROM itemtype where id='$id' "));
?>
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="itemtypes.php">Project Types</a> <a href="#" class="current">Edit Project Type</a> </div>
    <h1>Edit Project </h1>
  </div>
  <div class="container-fluid"><hr>
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-pencil"></i> </span>
            <h5>Edit Project </h5>
          </div>
          <div class="widget-content nopadding">
            <form id="form-wizard" action="patientclass.php?action=editproject&&id=<?php echo $id?>" class="form-horizontal" method="post">
              <div id="form-wizard-1" class="step">
                <div class="control-group">
                  <label class="control-label">Project  Name</label>
                  <div class="controls">
                    <input id="username" type="text" value="<?php echo $it['name']?>" name="name" />
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