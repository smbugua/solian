<?php
include('header.php');
$id=$_REQUEST['id'];
$main=mysql_fetch_array(mysql_query("SELECT * FROM settings"));
$company_name=$main['main_name'];
$company_location=$main['main_location'];
$company_tel=$main['main_tel'];
$company_address=$main['main_address'];
$email=$main['email'];
$inv=mysql_fetch_array(mysql_query("SELECT count(id) as ids from invoices"));
$count=$inv['ids'];
$count2=$count+1;
$result=mysql_query("SELECT id,name from patients where id ='$id'");
?>
<div id="content-header">
    <div id="breadcrumb"> <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#">Billing</a> <a href="#" class="current">invoice</a> </div>
    <h1>Invoice</h1>
  </div>
  <div class="container-fluid"><hr>
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-briefcase"></i> </span>
            <h5 ><?php echo $company_name ?></h5>
          </div>
          <div class="widget-content">
            <div class="row-fluid">
              <div class="span6">
                <table class="">
                  <tbody>
                    <tr>
                      <td><h4><?php echo $company_name ?></h4></td>
                    </tr>
                    <tr>
                      <td><?php echo $company_tel ?></td>
                    </tr>
                    <tr>
                      <td><?php echo $company_address ?></td>
                    </tr>
                    <tr>
                      <td><?php echo $company_location ?></td>
                    </tr>
                    <tr>
                      <td ><?php echo $email?></td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="span6">
                <table class="table table-bordered table-invoice">
                  <tbody>
                    <tr>
                    <tr>
                      <form action="actionclass.php?action=addinvoice" method="post">
                      <td class="width30">Invoice ID:</td>
                      <td class="width70"><strong><input type="text" name="invoiceno" value="<?php echo "INV-".$count2."-".date('Y')?>" readonly=""></strong></td>
                    </tr>
                    <tr>
                      <td>Issue Date:</td>
                      <td><strong><input type="date" name="dateadded" value="<?php echo date('Y-m-d')?>"></strong></td>
                    </tr>
                    <td class="width30">Client:</td>
                    <td class="width70">
                      <select name="patientid">
                        <?php while($patient=mysql_fetch_array($result)) {?>
                          <option value="<?php echo $patient[0]?>"><?php echo $patient[1] ?> </option>
                        <?php }?>
                      </select>

                    </td>
                  </tr>
                  <tr>
                    <td></td>
                    <td><button class="btn btn-primary pull-right" type="submit">Next</button></td>
                  </tr>
                    </tbody>
                  </form>
                </table>
              </div>
            </div>
            <!--div class="row-fluid">
              <div class="span12">
                <table class="table table-bordered table-invoice-full">
                  <thead>
                    <tr>
                      <th class="head0">Type</th>
                      <th class="head1">Desc</th>
                      <th class="head0 right">Qty</th>
                      <th class="head1 right">Price</th>
                      <th class="head0 right">Amount</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>Firefox</td>
                      <td>Ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae</td>
                      <td class="right">2</td>
                      <td class="right">$150</td>
                      <td class="right"><strong>$300</strong></td>
                    </tr>
                    <tr>
                      <td>Chrome Plugin</td>
                      <td>Tro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt u eos et accusamus et iusto odio dignissimos ducimus  deleniti atque</td>
                      <td class="right">1</td>
                      <td class="right">$1,200</td>
                      <td class="right"><strong>$1,2000</strong></td>
                    </tr>
                    <tr>
                      <td>Safari App</td>
                      <td>Rro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt u expedita distinctio</td>
                      <td class="right">2</td>
                      <td class="right">$850</td>
                      <td class="right"><strong>$1,700</strong></td>
                    </tr>
                    <tr>
                      <td>Opera App</td>
                      <td>Orro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut</td>
                      <td class="right">3</td>
                      <td class="right">$850</td>
                      <td class="right"><strong>$2,550</strong></td>
                    </tr>
                    <tr>
                      <td>Netscape Template</td>
                      <td>Vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque</td>
                      <td class="right">5</td>
                      <td class="right">$50</td>
                      <td class="right"><strong>$250</strong></td>
                    </tr>
                  </tbody>
                </table>
                <table class="table table-bordered table-invoice-full">
                  <tbody>
                    <tr>
                      <td class="msg-invoice" width="85%"><h4>Payment method: </h4>
                        <a href="#" class="tip-bottom" title="Wire Transfer">Wire transfer</a> |  <a href="#" class="tip-bottom" title="Bank account">Bank account #</a> |  <a href="#" class="tip-bottom" title="SWIFT code">SWIFT code </a>|  <a href="#" class="tip-bottom" title="IBAN Billing address">IBAN Billing address </a></td>
                      <td class="right"><strong>Subtotal</strong> <br>
                        <strong>Tax (5%)</strong> <br>
                        <strong>Discount</strong></td>
                      <td class="right"><strong>$7,000 <br>
                        $600 <br>
                        $50</strong></td>
                    </tr>
                  </tbody>
                </table>
                <div class="pull-right">
                  <h4><span>Amount Due:</span> $7,650.00</h4>
                  <br>
                  <a class="btn btn-primary btn-large pull-right" href="">Pay Invoice</a> </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!--Footer-part-->

<?php include('footer.php') ?>
</div>
<!--end-Footer-part--> 
<script src="js/jquery.min.js"></script> 
<script src="js/jquery.ui.custom.js"></script> 
<script src="js/bootstrap.min.js"></script> 
</body>
</html>