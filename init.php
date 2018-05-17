<?php
include('header.php');
$result=mysql_query("SELECT * FROM productstock order by productid asc");
$result2=mysql_query("SELECT * FROM plotstatus");
$no=mysql_num_rows($result2);
if ($no<=0) {

while ($plot=mysql_fetch_array($result)) {
	$projectid=$plot['productid'];
	$totalstock=$plot['totalstock'];
	for ($i=1; $i <$totalstock ; $i++) { 
	mysql_query("INSERT INTO plotstatus(projectid,plotno)VALUES('$projectid','$i')");

	}
	
}

echo "<script>location.replace('index.php')</script>";
}elseif ($no>0) {
	echo "<script>alert('Stock Level is reconciled!')</script>";
	echo "<script>location.replace('index.php')</script>";
}