<?php
include('header.php');
$user=$_SESSION['user'];

$id=$_REQUEST['id']
?>
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="patients.php">Patients</a> <a href="#" class="current">Examinition Form</a> </div>
    <h1>Patient Examinition</h1>
  </div>
  <div class="container-fluid"><hr>
    <div class="row-fluid">
      
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-pencil"></i> </span>
            <h5>Patient Details</h5>
          </div>
          <div class="widget-content nopadding">
            <form id="form-wizard" action="patientclass.php?action=addpatientexam&&patientid=<?php echo $id?>" class="form-horizontal" method="post">
              <div id="form-wizard-1" class="step">
                <div class="control-group">
                  <label class="control-label">Eye</label>
                  <div class="controls">
                  <select name="eye" class="form-control">
                    <option value="RIGHT"> Right</option>
                    <option value="LEFT"> Left</option>
                  </select>
                  </div>
                </div>            
                <div class="control-group">
                  <label class="control-label">Subjective RX</label>
                  <div class="controls">
                    <input id="text" type="text" name="subjectiverx" />
                  </div>
                </div>
                <div class="control-group">
                  <label class="control-label">Notes</label>
                  <div class="controls">
                    <textarea name="notes" cols="7" rows="5"></textarea>
                  </div>
                </div> 
                <div class="control-group">
                  <label class="control-label">Staff Assigned</label>
                  <div class="controls">
                    <input id="text" type="text" readonly="" name="staffid" value="<?php echo $user?>" />
                  </div>
                </div> 
                <div class="control-group">
                  <label class="control-label">Date</label>
                  <div class="controls">
                    <input type="date" name="date" value="<?php echo date('Y-m-d')?>">
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