<?php
require_once('auth.php');
session_start();
if(isset($_SESSION['loggedIn']))
{
if(($_SESSION['loggedIn'])==true)
{
$user=$_SESSION['user'];
$year=date('Y');
  $query=mysql_query("select account_type as usr from users where username='$user'");
      $row = mysql_fetch_assoc($query);
    if ($row['usr']=='0') {

$main="SELECT * FROM settings";
$mainquery=mysql_fetch_array(mysql_query($main));
$yr1=date('Y');
$loc=$mainquery['main_name'];
//$abal=mysql_fetch_array(mysql_query("SELECT available_balance as a from cashtransactions where fyr='$yr1' ORDER BY id DESC LIMIT 1"));
//$bal=$abal['a'];
$yr=date('d-m-Y');
//$msg=mysql_query("SELECT COUNT(id) FROM messages WHERE touser='$user' && status='0'");
//$no=mysql_num_rows($msg);
//if (file_exists("img/$user.jpg")){
  //  $image="img/$user.jpg";
    //}else
    //$image="img/avatar.png";
echo <<<HeaderFunction
<!DOCTYPE html>
<html lang="en">
<head>
<title>Techcube Land Solution</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="css/fullcalendar.css" />
<link rel="stylesheet" href="css/matrix-style.css" />
<link rel="stylesheet" href="css/matrix-media.css" />
<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="css/jquery.gritter.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
</head>
<body>

<!--Header-part-->
<div id="header">
  <h1><a href="dashboard.html">Matrix Optical</a></h1>
</div>
<!--close-Header-part--> 


<!--top-Header-menu-->
<div id="user-nav" class="navbar navbar-inverse">
  <ul class="nav">
    <li  class="dropdown" id="profile-messages" ><a title="" href="#" data-toggle="dropdown" data-target="#profile-messages" class="dropdown-toggle"><i class="icon icon-user"></i>  <span class="text">Welcome $user</span><b class="caret"></b></a>
      <ul class="dropdown-menu">
        <li><a href="#"><i class="icon-user"></i> My Profile</a></li>
        <li class="divider"></li>
        <li><a href="#"><i class="icon-check"></i> My Tasks</a></li>
        <li class="divider"></li>
        <li><a href="logout.php"><i class="icon-key"></i> Log Out</a></li>
      </ul>
    </li>
    <li class="dropdown" id="menu-messages"><a href="#" data-toggle="dropdown" data-target="#menu-messages" class="dropdown-toggle"><i class="icon icon-envelope"></i> <span class="text">Messages</span> <span class="label label-important">5</span> <b class="caret"></b></a>
      <ul class="dropdown-menu">
        <li><a class="sAdd" title="" href="#"><i class="icon-plus"></i> new message</a></li>
        <li class="divider"></li>
        <li><a class="sInbox" title="" href="#"><i class="icon-envelope"></i> inbox</a></li>
        <li class="divider"></li>
        <li><a class="sOutbox" title="" href="#"><i class="icon-arrow-up"></i> outbox</a></li>
        <li class="divider"></li>
        <li><a class="sTrash" title="" href="#"><i class="icon-trash"></i> trash</a></li>
      </ul>
    </li>
    <li class=""><a title="" href="settings.php"><i class="icon icon-cog"></i> <span class="text">Settings</span></a></li>
    <li class=""><a title="" href="logout.php"><i class="icon icon-share-alt"></i> <span class="text">Logout</span></a></li>
  </ul>
</div>
<!--close-top-Header-menu-->
<!--start-top-serch-->
<div id="search">
  <input type="text" placeholder="Search here..."/>
  <button type="submit" class="tip-bottom" title="Search"><i class="icon-search icon-white"></i></button>
</div>
<!--close-top-serch-->
<!--sidebar-menu-->
<div id="sidebar"><a href="#" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>
  <ul>
    <li class="active"><a href="index.php"><i class="icon icon-home"></i> <span>Dashboard</span></a> </li>
    <!--li> <a href="charts.html"><i class="icon icon-signal"></i> <span>Charts &amp; graphs</span></a> </li>
    <li> <a href="widgets.html"><i class="icon icon-inbox"></i> <span>Widgets</span></a> </li>
    <li><a href="tables.html"><i class="icon icon-th"></i> <span>Tables</span></a></li>
    <li><a href="grid.html"><i class="icon icon-fullscreen"></i> <span>Full width</span></a></li-->
    <li class="submenu"> <a href="#"><i class="icon icon-user"></i> <span>Customers</span> <span class="label label-important"></span></a>
      <ul>
        <li><a href="leads.php">Shortcode Lists</a></li>
        <li><a href="patients.php">Customer Lists</a></li>
        <li><a href="addpatient.php">Add Customer</a></li>
        <li><a href="searchpatient.php">Search Customer</a></li>
        <li><a href="allocations.php">Plot Allocations</a></li>
      </ul>
    </li>
    <li class="submenu"> <a href="#"><i class="icon icon-glass"></i> <span>Reception</span> <span class="label label-important"></span></a>
      <ul>
        <li><a href="appointments.php">Apppointments</a></li>
        <!--li><a href="recallls.php">Recalls</a></li-->
      </ul>
    </li>
   <li class="submenu"> <a href="#"><i class="icon icon-money"></i> <span>Accounting</span> <span class="label label-important"></span></a>
      <ul>
        <li><a href="searchpatient.php">Add Invoice</a></li>
        <li><a href="allinvoices.php">All Invoice</a></li>
        <li><a href="unpaidinvoices.php">UnPaid Invoices</a></li>
        <li><a href="partpaidinvoices.php">Partially Paid Invoices</a></li>
        <li><a href="paidinvoices.php">Paid Invoices</a></li>
        <li><a href="voidedinvoices.php">Voided Invoice</a></li>
        <li><a href="receipts.php">Receipts</a></li>
      </ul>
    </li>
    <li class="submenu"> <a href="#"><i class="icon icon-info-sign"></i> <span>Inventory</span> <span class="label label-important"></span></a>
      <ul>
        <li><a href="products.php">Plots</a></li>
        <li><a href="stocklevels.php">Stock</a></li>
        <li><a href="itemtypes.php">Land Projects</a></li>
        <li><a href="brands.php">Cities</a></li>
      </ul>
    </li>
    <li class="content"> <span>Monthly Bandwidth Transfer</span>
      <div class="progress progress-mini progress-danger active progress-striped">
        <div style="width: 77%;" class="bar"></div>
      </div>
      <span class="percent">77%</span>
      <div class="stat">21419.94 / 14000 MB</div>
    </li>
    <li class="content"> <span>Disk Space Usage</span>
      <div class="progress progress-mini active progress-striped">
        <div style="width: 87%;" class="bar"></div>
      </div>
      <span class="percent">87%</span>
      <div class="stat">604.44 / 4000 MB</div>
    </li>
  </ul>
</div>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.html" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a></div>
  </div>
<!--End-breadcrumbs-->



<script src="js/excanvas.min.js"></script> 
<script src="js/jquery.min.js"></script> 
<script src="js/jquery.ui.custom.js"></script> 
<script src="js/bootstrap.min.js"></script> 
<script src="js/jquery.flot.min.js"></script> 
<script src="js/jquery.flot.resize.min.js"></script> 
<script src="js/jquery.peity.min.js"></script> 
<script src="js/fullcalendar.min.js"></script> 
<script src="js/matrix.js"></script> 
<script src="js/matrix.dashboard.js"></script> 
<script src="js/jquery.gritter.min.js"></script> 
<script src="js/matrix.interface.js"></script> 
<script src="js/matrix.chat.js"></script> 
<script src="js/jquery.validate.js"></script> 
<script src="js/matrix.form_validation.js"></script> 
<script src="js/jquery.wizard.js"></script> 
<script src="js/jquery.uniform.js"></script> 
<script src="js/select2.min.js"></script> 
<script src="js/matrix.popover.js"></script> 
<script src="js/jquery.dataTables.min.js"></script> 
<script src="js/matrix.tables.js"></script> 

<script type="text/javascript">
  // This function is called from the pop-up menus to transfer to
  // a different page. Ignore if the value returned is a null string:
  function goPage (newURL) {

      // if url is empty, skip the menu dividers and reset the menu selection to default
      if (newURL != "") {
      
          // if url is "-", it is this page -- reset the menu:
          if (newURL == "-" ) {
              resetMenu();            
          } 
          // else, send page to designated URL            
          else {  
            document.location.href = newURL;
          }
      }
  }

// resets the menu selection upon entry to this page:
function resetMenu() {
   document.gomenu.selector.selectedIndex = 2;
}
</script>
</body>
</html>
HeaderFunction;

}
echo <<< logOut
<script type="text/javascript">;
function logOut()
{
    location.replace('logOut.php');
}
 </script>
logOut;
}
else
{
echo <<< Home
    <script>
    location.replace("login.php");
    </script>
Home;
}
}
else
{
    echo <<< Home
    <script>
    location.replace("login.php");
    </script>
Home;
}
?>