<?php
include('header.php');
//get product TYPES
$productquery=mysql_query("SELECT id,name FROM itemtype ORDER BY  name ASC");
//GET BRANDS
$brands=mysql_query("SELECT id,name FROM brand ORDER BY name ASC");
?>
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="products.php">Products</a> <a href="#" class="current">Add Product Form</a> </div>
    <h1>Product Details</h1>
  </div>
  <div class="container-fluid"><hr>
    <div class="row-fluid">
      
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-pencil"></i> </span>
            <h5>Product Details</h5>
          </div>
          <div class="widget-content nopadding">
            <form id="form-wizard" action="patientclass.php?action=addproduct" class="form-horizontal" method="post">
              <div id="form-wizard-1" class="step">
                         
                <div class="control-group">
                  <label class="control-label">Product Name</label>
                  <div class="controls">
                    <input id="text" type="text" name="name" />
                  </div>
                </div>
                  <div class="control-group">
                  <label class="control-label">Product Type</label>
                  <div class="controls">
                  <select name="productid" class="form-control">
                 <?php while($r=mysql_fetch_array($productquery)){

                    echo "<option value='$r[0]'>$r[1]</option>";

                  }?>
                  </select>
                  </div>
                </div> 
                  <div class="control-group">
                  <label class="control-label">Brand</label>
                  <div class="controls">
                  <select name="brandid" class="form-control">
                 <?php while($b=mysql_fetch_array($brands)){

                    echo "<option value='$b[0]'>$b[1]</option>";

                  }?>
                  </select>
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