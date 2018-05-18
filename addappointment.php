<?php
include('header.php');
//get product TYPES
$productquery=mysql_query("SELECT id,name FROM itemtype ORDER BY  name ASC");
//GET BRANDS
$brands=mysql_query("SELECT id,name FROM brand ORDER BY name ASC");
?>
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="appointments.php">Appointments</a> <a href="#" class="current">Add Appointment Form</a> </div>
    <h1>Appointment Details</h1>
  </div>
  <div class="container-fluid"><hr>
    <div class="row-fluid">
      
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-pencil"></i> </span>
            <h5>Appointment Details</h5>
          </div>
          <div class="widget-content nopadding">
            <form id="form-wizard" action="patientclass.php?action=addappointment" class="form-horizontal" method="post">
              <div id="form-wizard-1" class="step">
                         
                <div class="control-group">
                  <label class="control-label">Customer Name</label>
                  <div class="controls">
                        <select name="patientid" class="form-control">
                    <?php
                    $productresult=mysql_query("SELECT id,name from patients");
                    while($productrow=mysql_fetch_array($productresult)){
                    ?>  
                    <option value="<?php echo $productrow[0]?>"><?php echo $productrow[1]?></option>
                    <?php }?> 
                    </select>
                  </div>
                </div>
                  <div class="control-group">
                  <label class="control-label">Appointment Type</label>
                  <div class="controls">
                  <select name="type" class="form-control">
                 <option value="Enquiry">Enquiry</option>
                 <option value="Consultation">Consultation</option>
                 <option value="Payment">Payment</option>
                  </select>
                  </div>
                </div> 
                  <div class="control-group">
                  <label class="control-label">Notes</label>
                  <div class="controls">
                  <textarea name="notes" cols="7" rows="5"></textarea>
                  </div>
                </div> 
                  <div class="control-group">
                  <label class="control-label">Date Scheduled</label>
                  <div class="controls">
                  <input type="date" name="datescheduled" value="<?php echo date('Y-m-d')?>">
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