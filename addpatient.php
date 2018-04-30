 <?php
include('header.php');
 ?>

 <div class="container-fluid"><hr>
    <div class="row-fluid">
      <div class="col-md-12">
      <!--New Span -->
      <div class="col-md-6">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-info-sign"></i> </span>
            <h5>Add Client Detaiils</h5>
          </div>
          <div class="widget-content nopadding">
            <form class="form-horizontal" method="post" action="patientclass.php?action=aadpatient" name="basic_validate" id="basic_validate" novalidate="novalidate">
              <div class="control-group">
                <label class="control-label">Client Name</label>
                <div class="controls">
                  <input type="text" class="form-control" name="name" id="required">
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">Client Email</label>
                <div class="controls">
                  <input type="email" class="form-control" name="email" id="email">
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">KRA PIN</label>
                <div class="controls">
                  <input type="text" class="form-control" name="pin" id="pin">
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">Address</label>
                <div class="controls">
                  <input type="text" name="addr" class="form-control" required="" >                  
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">Town/City</label>
                <div class="controls">
                  <input type="text" name="town" class="form-control" required="" >                  
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">Phone</label>
                <div class="controls">
                  <input type="text" name="tel" required="" class="form-control">                  
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">Id No</label>
                <div class="controls">
                  <input type="text" name="idno" class="form-control" required="">                  
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">Sex</label>
                <div class="controls">
                <select name="sex" >
                  <option value="Male">Male</option>
                  <option value="female">Female</option>
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
                <label class="control-label">Date Of Birth</label>
                <div class="controls">
                  <input type="date" name="date" id="date">
                </div>
              </div>            
             </div>
               <div class="form-actions">
                <button type="submit" value="Validate" class="btn btn-success">Submit</button>
                </div>
            </form>
          </div>
          </div>
          </div>

        </div>
        <!---new span- -->
    