<?php
$id=$_GET['id'];
include('header.php');
$c=mysql_fetch_array(mysql_query("SELECT p.name as clientname,p.tel as clienttel,p.pin as krapin ,p.idno as idno, p.email as clientemail from patients p  where p.id='$id' "));
$invoicecount=mysql_fetch_array(mysql_query("SELECT COUNT(*) as c from invoices where patientid='$id' "));
$paidinvoicecount=mysql_fetch_array(mysql_query("SELECT COUNT(*) as c from invoices where patientid='$id' and status='2'"));
$partpaidinvoicecount=mysql_fetch_array(mysql_query("SELECT COUNT(*) as c from invoices where patientid='$id' and status='1'"));
$upinvoicecount=mysql_fetch_array(mysql_query("SELECT COUNT(*) as c from invoices where patientid='$id' and status='0'"));
$voidedinvoicecount=mysql_fetch_array(mysql_query("SELECT COUNT(*) as c from invoices where patientid='$id' and status='5'"));
$query=mysql_query("SELECT r.id as id, p.name as name,r.amountdue as tot ,r.amountpaid as amountpaid,r.balance as balance , pm.mode as mode,r.dateadded as dateadded, inv.invoicenumber as invno from receipts r inner join invoices inv on inv.id=r.invoiceid inner join patients p on p.id=inv.patientid inner join paymentmodes pm on pm.id=r.paymentmethod  where p.id='$id' order by r.datemodified DESC limit 10 ");

$amounts=mysql_fetch_array(mysql_query("SELECT SUM(r.amountpaid) as paid ,SUM(r.amountdue) as dues ,sum(r.balance) as balances   from receipts r  inner join  invoices inv on inv.id=r.invoiceid where  inv.patientid='$id' "));


$query2=mysql_query("SELECT * FROM invoices where patientid='$id' order by id desc limit 10");


$query3=mysql_query("SELECT it.name as project,p.plotno as plotno , p.price as plotprice ,p.dateallocated as dateallocated , pp.name as clientname from plots p inner join itemtype it on it.id=p.projectid inner join patients pp on pp.id=p.customerid  ");
?>


<!--End-breadcrumbs-->

<!--Action boxes-->
  <div class="container-fluid">
    <div class="quick-actions_homepage">
      <ul class="quick-actions">
        <li class="bg_lb"> <a href="#"> <i class="icon-user"></i> <span class="label label-important"></span><?php echo $c['clientname']?></a> </li>
        <li class="bg_lg"> <a href="#"> <i class="icon-signal"></i> <?php echo $c['clienttel']?></a> </li>       
         <li class="bg_ls"> <a href="#"> <i class="icon-money"></i><span class="label label-success"></span>Total Invoices Raised <?php echo $invoicecount['c']?>  </a> </li>
        <li class="bg_lg"> <a href="#"> <i class="icon-money"></i> Fully Paid Invoices <?php echo $paidinvoicecount['c']?>  </a> </li>
        <li class="bg_lb"> <a href="#"> <i class="icon-money"></i> Part Paid Invoices <?php echo $partpaidinvoicecount['c']?>  </a> </li>
        <li class="bg_lo"> <a href="#"> <i class="icon-money"></i> UnPaid Invoices <?php echo $upinvoicecount['c']?>  </a> </li>
        <li class="bg_ly"> <a href="#"> <i class="icon-money"></i> Voided Invoices <?php echo $voidedinvoicecount['c']?>  </a> </li>

      </ul>
    </div>
<!--End-Action boxes-->    

<!--Chart-box-->    
    <div class="row-fluid">
      <div class="widget-box">
        <div class="widget-title bg_lg"><span class="icon"><i class="icon-signal"></i></span>
          <h5>Payments Made</h5>
        </div>
        <div class="widget-content" >
          <div class="row-fluid">
            <div class="span9">
              <table class="table table-bordered data-table">
                <thead>
                  <td>Invoice Number</td>
                  <td>Amount Due</td>
                  <td>Amount Paid</td>
                  <td>Balance</td>
                  <td>Payment Mode</td>
                  <td>Date Paid</td>
                  <td>Receipt</td>
                </thead>
                <tbody>
                 <?php while ($r=mysql_fetch_array($query)){?>
                 <tr>
                   <td><?php echo $r['invno']?></td>
                   <td><?php echo $r['tot']?></td>
                   <td><?php echo $r['amountpaid']?></td>
                   <td><?php echo $r['balance']?></td>
                   <td><?php echo $r['mode']?></td>
                   <td><?php echo $r['dateadded']?></td>
                   <td><a href="viewreceipt.php?id=<?php echo $r['id']?>" class="btn btn-success btn-mini" ><i class="fa fa-print"> </i> Print</a> </td>
                 </tr>
                 <?php }?> 
                </tbody>
                
              </table>
                
              </div>
          
            <div class="span3">
              <ul class="site-stats">
                <li class="bg_lb"><a href="billclient.php?id=<?php echo $id?>"> <i class="icon-credit-card"></i> <strong></strong> <small>Bill Client</small></a></li>
                <li class="bg_lb"><a href="allocate.php?id=<?php echo $id?>"><i class="icon-plus"></i> <strong></strong> <small>New Allocation </small></a> </li>
                <li class="bg_lg"><i class="icon-shopping-cart"></i> <strong><?php echo $amounts['paid']?></strong> <small>Total Paid In</small></li>
                <li class="bg_lo"><i class="icon-repeat"></i> <strong><?php echo $amounts['balances']?> </strong> <small>Total Balances</small></li>
                <li class="bg_ls"><i class="icon-money"></i> <strong><?php echo $amounts['dues']?> </strong> <small>Total Orders</small></li>
                <li class="bg_ly"><a href="editpatient.php?id=<?php echo $id?>"> <i class="icon-user"></i> <strong> 1</strong> <small>Edit Client</small></a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
<!--End-Chart-box--> 
    <hr/>
    <div class="row-fluid">
      <div class="span6">
        <div class="widget-box">
          <div class="widget-title bg_ly" data-toggle="collapse" href="#collapseG2"><span class="icon"><i class="icon-chevron-down"></i></span>
            <h5>Latest Invoices</h5>
          </div>
          <div class="widget-content nopadding collapse in" id="collapseG2">
              <table class="table table-bordered data-table">
                <thead>
                  <th>Invoice Number</th>
                  <th>Amount Due</th>
                  <th>Status</th>
                  <th>Date Added</th>
                </thead>
                <tbody>
                  <?php while($inv=mysql_fetch_array($query2)){
                    $status=$inv['status'];
                    ?>
                  <tr>
                    <td><?php echo $inv['invoicenumber']?></td>
                    <td><?php echo $inv['totalcost']?></td>
                    <?php if($status=0){

                      echo "<td>Unpaid</td>";
                    }elseif ($status=1) {
                      echo "<td>Partially Paid</td>";
                    }elseif ($status=2) {
                      echo "<td>Fully Paid</td>";
                    }elseif ($status=5) {
                      echo "<td>Voided Invoice</td>";
                    }
                      ?>
                    <td><?php echo $inv['dateadded']?></td>
                  </tr>
                  <?php }?>
                  
                </tbody>
                
              </table>



                
            
          </div>
          <a href="clientinvoices.php?id=<?php echo $id?>" class="btn btn-primary">View All</a>
        </div>
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-ok"></i></span>
            <h5>Plot Allocations</h5>
          </div>
          <div class="widget-content">
            <div class="todo">
              <table class="table table-bordered data-table">
                <thead>
                  <th>Project Details</th>
                  <th>Plot Number</th>
                  <th>Price</th>
                  <th>Date Added</th>
                </thead>
                <tbody>
                  <?php while($inv2=mysql_fetch_array($query3)){
                    ?>
                  <tr>
                    <td><?php echo $inv2['project']?></td>
                    <td><?php echo $inv2['plotno']?></td>
                    <td><?php echo $inv2['plotprice']?></td>
                   <td><?php echo $inv2['dateallocated']?></td>
                  </tr>
                  <?php }?>
                  
                </tbody>
                
              </table>

            </div>
          </div>
        </div>
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"><i class="icon-ok"></i></span>
            <h5></h5>
          </div>
          <div class="widget-content">
            <ul class="unstyled">
           
            </ul>
          </div>
        </div>
        <div class="widget-box">
          <div class="widget-title bg_lo"  data-toggle="collapse" href="#collapseG3" > <span class="icon"> <i class="icon-chevron-down"></i> </span>
            
          </div>
          <div class="widget-content nopadding updates collapse in" id="collapseG3">
           
          </div>
        </div>
        
      </div>
      <div class="span6">
        <div class="widget-box widget-chat">
          <div class="widget-title bg_lb"> <span class="icon"> <i class="icon-comment"></i> </span>
            <h5>Chat & SMS Option</h5>
          </div>
          <div class="widget-content nopadding collapse in" id="collapseG4">
            <div class="chat-users panel-right2">
              <div class="panel-title">
                <h5>Online Users</h5>
              </div>
              <div class="panel-content nopadding">
                <ul class="contact-list">
                  <li id="user-Alex" class="online"><a href=""><img alt="" src="img/demo/av1.jpg" /> <span><?php echo $user?></span></a></li>
              </div>
            </div>
            <div class="chat-content panel-left2">
              <div class="chat-messages" id="chat-messages">
                <div id="chat-messages-inner">
                  <table class="table table-bordered data-table">
                    <thead>
                      <th>Message</th>
                      <th>Sent By</th>
                      <th>Date sent</th>
                    </thead>
                    <tbody>
                      <tr>
                        <td>test</td>
                        <td>test</td>
                        <td>test</td>
                      </tr>
                    </tbody>
                  </table>

                </div>
              </div>
              <div class="chat-message well">
                <button class="btn btn-success">Send</button>
                <span class="input-box">
                <input type="text" name="msg-box" id="msg-box" />
                </span> </div>
            </div>
          </div>
        </div>
        <div class="widget-box">
          <div class="widget-title"><span class="icon"><i class="icon-user"></i></span>
            <h5>Our Partner (Box with Fix height)</h5>
          </div>
          <div class="widget-content nopadding fix_hgt">
            <ul class="recent-posts">
              <li>
                <div class="user-thumb"> <img width="40" height="40" alt="User" src="img/demo/av1.jpg"> </div>
                <div class="article-post"> <span class="user-info">John Deo</span>
                  <p>Web Desginer &amp; creative Front end developer</p>
                </div>
              </li>
              <li>
                <div class="user-thumb"> <img width="40" height="40" alt="User" src="img/demo/av2.jpg"> </div>
                <div class="article-post"> <span class="user-info">John Deo</span>
                  <p>Web Desginer &amp; creative Front end developer</p>
                </div>
              </li>
              <li>
                <div class="user-thumb"> <img width="40" height="40" alt="User" src="img/demo/av4.jpg"> </div>
                <div class="article-post"> <span class="user-info">John Deo</span>
                  <p>Web Desginer &amp; creative Front end developer</p>
                </div>
            </ul>
          </div>
        </div>
        <div class="accordion" id="collapse-group">
          <div class="accordion-group widget-box">
            <div class="accordion-heading">
              <div class="widget-title"> <a data-parent="#collapse-group" href="#collapseGOne" data-toggle="collapse"> <span class="icon"><i class="icon-magnet"></i></span>
                <h5>Accordion Example 1</h5>
                </a> </div>
            </div>
            <div class="collapse in accordion-body" id="collapseGOne">
              <div class="widget-content"> It has multiple paragraphs and is full of waffle to pad out the comment. Usually, you just wish these sorts of comments would come to an end. </div>
            </div>
          </div>
          <div class="accordion-group widget-box">
            <div class="accordion-heading">
              <div class="widget-title"> <a data-parent="#collapse-group" href="#collapseGTwo" data-toggle="collapse"> <span class="icon"><i class="icon-magnet"></i></span>
                <h5>Accordion Example 2</h5>
                </a> </div>
            </div>
            <div class="collapse accordion-body" id="collapseGTwo">
              <div class="widget-content">And is full of waffle to It has multiple paragraphs and is full of waffle to pad out the comment. Usually, you just wish these sorts of comments would come to an end.</div>
            </div>
          </div>
          <div class="accordion-group widget-box">
            <div class="accordion-heading">
              <div class="widget-title"> <a data-parent="#collapse-group" href="#collapseGThree" data-toggle="collapse"> <span class="icon"><i class="icon-magnet"></i></span>
                <h5>Accordion Example 3</h5>
                </a> </div>
            </div>
            <div class="collapse accordion-body" id="collapseGThree">
              <div class="widget-content"> Waffle to It has multiple paragraphs and is full of waffle to pad out the comment. Usually, you just </div>
            </div>
          </div>
        </div>
        <div class="widget-box collapsible">
          <div class="widget-title"> <a data-toggle="collapse" href="#collapseOne"> <span class="icon"><i class="icon-arrow-right"></i></span>
            <h5>Toggle, Open by default, </h5>
            </a> </div>
          <div id="collapseOne" class="collapse in">
            <div class="widget-content"> This box is opened by default, paragraphs and is full of waffle to pad out the comment. Usually, you just wish these sorts of comments would come to an end. </div>
          </div>
          <div class="widget-title"> <a data-toggle="collapse" href="#collapseTwo"> <span class="icon"><i class="icon-remove"></i></span>
            <h5>Toggle, closed by default</h5>
            </a> </div>
          <div id="collapseTwo" class="collapse">
            <div class="widget-content"> This box is now open </div>
          </div>
          <div class="widget-title"> <a data-toggle="collapse" href="#collapseThree"> <span class="icon"><i class="icon-remove"></i></span>
            <h5>Toggle, closed by default</h5>
            </a> </div>
          <div id="collapseThree" class="collapse">
            <div class="widget-content"> This box is now open </div>
          </div>
        </div>
        <div class="widget-box">
          <div class="widget-title">
            <ul class="nav nav-tabs">
              <li class="active"><a data-toggle="tab" href="#tab1">Tab1</a></li>
              <li><a data-toggle="tab" href="#tab2">Tab2</a></li>
              <li><a data-toggle="tab" href="#tab3">Tab3</a></li>
            </ul>
          </div>
          <div class="widget-content tab-content">
            <div id="tab1" class="tab-pane active">
              <p>And is full of waffle to It has multiple paragraphs and is full of waffle to pad out the comment. Usually, you just wish these sorts of comments would come to an end.multiple paragraphs and is full of waffle to pad out the comment.</p>
              <img src="img/demo/demo-image1.jpg" alt="demo-image"/></div>
            <div id="tab2" class="tab-pane"> <img src="img/demo/demo-image2.jpg" alt="demo-image"/>
              <p>And is full of waffle to It has multiple paragraphs and is full of waffle to pad out the comment. Usually, you just wish these sorts of comments would come to an end.multiple paragraphs and is full of waffle to pad out the comment.</p>
            </div>
            <div id="tab3" class="tab-pane">
              <p>And is full of waffle to It has multiple paragraphs and is full of waffle to pad out the comment. Usually, you just wish these sorts of comments would come to an end.multiple paragraphs and is full of waffle to pad out the comment. </p>
              <img src="img/demo/demo-image3.jpg" alt="demo-image"/></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!--end-main-container-part-->

<!--Footer-part-->

<?php include('footer.php') ?>

<script src="js/jquery.dataTables.min.js"></script> 


</script>
</body>
</html>
