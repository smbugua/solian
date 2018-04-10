<?php
include('header.php');
$id=$_REQUEST['id'];
$query="SELECT p.id as id,p.productname as name ,b.name as brandname ,it.name as itemtypename  from products p inner join brand b on p.brandid=b.id inner join itemtype it on it.id=p.itemtypeid  where p.id='$id' order by  p.productname asc";

$result=mysql_query($query);
$p=mysql_fetch_array($result);
$productname=$p['name'];
$brandname=$p['brandname'];
$itemtypename=$p['itemtypename'];
$res=mysql_query("SELECT totalstock from productstock where productid='$id'");
$c=mysql_fetch_array($res);
$no=mysql_num_rows($res);

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
            <form id="form-wizard" action="patientclass.php?action=stockin&&id=<?php echo $id?>" class="form-horizontal" method="post">
              <div id="form-wizard-1" class="step">
                         
                <div class="control-group">
                  <label class="control-label">Product Name</label>
                  <div class="controls">
                    <input id="text" type="text" name="name" value="<?php echo $productname?>" readonly="" />
                  </div>
                </div>
                  <div class="control-group">
                  <label class="control-label">Product Type</label>
                  <div class="controls">
                  <input id="text" type="text" name="name" value="<?php echo $itemtypename?>" readonly="" />
                  </div>
                </div> 
                  <div class="control-group">
                  <label class="control-label">Brand</label>
                  <div class="controls">
                  <input id="text" type="text" name="name" value="<?php echo $brandname?>" readonly="" />
                  </div>
              </div>

                 <div class="control-group">
                  <label class="control-label">Current Stock On Hand</label>
                  <div class="controls">
                  	<?php
					if ($no<=0) {
						$stock=0;
						echo "
                  <input id='text' type='text' name='current' value='$stock'  readonly='' />";
					}elseif ($no>0) {
						
					$stock=$c['totalstock'];

						echo "
                  <input id='text' type='text' name='current' value='$stock'  readonly='' />";
					}


                  	?>
                  </div>
              </div>
                 <div class="control-group">
                  <label class="control-label">Stock In</label>
                  <div class="controls">
                  <input id="text" type="text" name="stockin" required="" />
                  </div>
              </div>
                 <div class="control-group">
                  <label class="control-label">Cost</label>
                  <div class="controls">
                  <input id="text" type="text" name="cost" required="" />
                  </div>
              </div>
                 <div class="control-group">
                  <label class="control-label">Selling Price</label>
                  <div class="controls">
                  <input id="text" type="text" name="price" required="" />
                  </div>
              </div>
              <div class="control-group">
                  <label class="control-label">Date</label>
                  <div class="controls">
                  <input id="text" type="date" name="datea" value="<?php echo date('Y-m-d')?>" required="" />
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