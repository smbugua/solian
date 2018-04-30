<?php
include('header.php');
//ADD CLAUSES
//PATINET
if ($_GET['action']=="aadpatient") {
	$name=$_POST['name'];
	$email=$_POST['email'];
	$tel=$_POST['tel'];
	$addr=$_POST['addr'];
	$town=$_POST['town'];
	$idno=$_POST['idno'];
	$sex=$_POST['sex'];
	$notes=$_POST['notes'];
	$pin=$_POST['pin'];
	$dob=$_POST['date'];
	$date=date('Y-m-d');
	mysql_query("INSERT INTO patients(name,address,town,email,tel,idno,sex,dob,notes,pin,datecreated)VALUES('$name','$addr','$town','$email','$tel','$idno','$sex','$dob','$notes','$pin','$date')");
	echo "<script>location.replace('patients.php')</script>";
}elseif ($_GET['action']=="addcondition") {
	$name=$_POST['name'];
	mysql_query("INSERT INTO medical_conditions(name)values('$name')");

	echo "<script>location.replace('medical_conditions.php')</script>";
}elseif ($_GET['action']=="adpatientmedical") {
	$patientid=$_REQUEST['patientid'];
	$conditionid=$_POST['conditionid'];
	$notes=$_POST['notes'];
	$year=$_POST['year'];
	mysql_query("INSERT INTO medical(patientid,conditionid,notes,year)values('$patientid','$conditionid','$notes','$year')");

	echo "<script>location.replace('patient_medical_conditions.php')</script>";

}elseif ($_GET['action']=="addpatientexam") {
	$date=$_POST['date'];
	$patientid=$_REQUEST['patientid'];
	$eye=$_POST['eye'];
	$staffid=$_POST['staffid'];
	$subjectiverx=$_POST['subjectiverx'];
	$notes=$_POST['notes'];
	$query="INSERT INTO patient_exams(dateadded,patientid,staffid,subjectiverx,notes,eye)VALUES('$date','$patientid','$staffid','$subjectiverx','$notes','$eye')";
	mysql_query($query);
	if (mysql_errno()) {
		echo mysql_error();
	}
	echo "<script>alert('Successfully Added!')</script>";
	echo "<script>location.replace('patientoverview.php?id=$patientid')</script>";


}elseif ($_GET['action']=="addcontactlens"){
	$date=$_POST['date'];
	$patientid=$_REQUEST['patientid'];
	$staffid=$_POST['staffid'];
	$prescription=$_POST['prescription'];
	$notes=$_POST['notes'];
	$eye=$_POST['eye'];
	$query="INSERT INTO contactlens(dateadded,patientid,staffid,prescription,notes,eye)VALUES('$date','$patientid','$staffid','$prescription','$notes','$eye')";
	echo "<script>alert('Successfully Added!')</script>";
	echo "<script>location.replace('patientoverview.php?id=$patientid')</script>";
	mysql_query($query);
	if (mysql_errno()) {
		echo mysql_error();
	}

}elseif ($_GET['action']=="additemtype") {
	$name=$_POST['name'];
	mysql_query("INSERT INTO itemtype(name)values('$name')");
	echo "<script>location.replace('itemtypes.php')</script>";
}elseif ($_GET['action']=="addproduct") {
	$name=$_POST['name'];
	$brand=$_POST['brandid'];
	$item=$_POST['productid'];
	mysql_query("INSERT INTO products(productname,brandid,itemtypeid)values('$name','$brand','$item')");
	echo "<script>alert('Successfully Added!')</script>";
	echo "<script>location.replace('products.php')</script>";

}elseif ($_GET['action']=="addbrand") {	
	$name=$_POST['name'];
	mysql_query("INSERT INTO brand(name)values('$name')");
	echo "<script>alert('Successfully Added!')</script>";
	echo "<script>location.replace('brands.php')</script>";
}elseif ($_GET['action']=="stockin") {
	//RECORD STOCK MOVE
	$id=$_REQUEST['id'];
	$stock=$_POST['stockin'];
	$cost=$_POST['cost'];
	$price=$_POST['price'];
	$date=$_POST['datea'];
	mysql_query("INSERT INTO productstockmoves(productid,stockmove,type)values('$id','$stock','0')");
	//UPDATE CURRENT STOCK
	/*
	1.get current stock total
	2.add new stock
	3.update table records
	*/
	$query="SELECT psm.id as id from productstockmoves psm  where psm.productid='$id' order by psm.daterecorded desc ";
	$row=mysql_fetch_array(mysql_query($query));
	$psmid=$row['id'];
	//update new stock levels
	$stockquery=mysql_query("SELECT * FROM productstock where productid='$id'");
	$row2=mysql_fetch_array($stockquery);
	$tot=$row2['tot'];	
	$newstock=$stock+$tot;
	$no=mysql_num_rows($stockquery);
	if ($no>0) {
		
	mysql_query("UPDATE productstock set totalstock ='$newstock' where productid='$id'");
	}elseif ($no<=0) {
	mysql_query("INSERT INTO productstock(productid,totalstock)VALUES('$id','$newstock')");
	}
	//record new prices in stock price
	mysql_query("INSERT INTO stockprice(productid,stockid,cost,price,dateadded)values('$id','$psmid','$cost','$price','$date')");
	echo "<script>alert('Successfully Added!')</script>";
	echo "<script>location.replace('stocklevels.php')</script>";
}elseif ($_GET['action']=="stockout") {
	$id=$_REQUEST['productid'];
	$stock=$_POST['stock'];
	mysql_query("INSERT INTO productstockmoves(productid,stockmove,type)values('$id','$stock','1')");
	echo "<script>location.replace('productstock.php')</script>";
}elseif ($_GET['action']=="addappointment") {
	$id=$_POST['patientid'];
	$date=$_POST['datescheduled'];
	$type=$_POST['type'];
	$notes=$_POST['notes'];
	mysql_query("INSERT INTO appointments(patientid,notes,type,datescheduled)values('$id','$notes','$type','$date')");
	echo "<script>alert('Successfully Added!')</script>";
	echo "<script>location.replace('appointments.php')</script>";
}elseif ($_GET['action']=="editpatient") {
	$name=$_POST['name'];
	$email=$_POST['email'];
	$tel=$_POST['tel'];
	$addr=$_POST['addr'];
	$town=$_POST['town'];
	$idno=$_POST['idno'];
	$sex=$_POST['sex'];
	$notes=$_POST['notes'];
	$dob=$_POST['date'];
	$id=$_REQUEST['id'];
	mysql_query("UPDATE patients set name='$name',address='$addr',town='$town',email='$email',tel='$tel',idno='$idno',sex='$sex',dob='$dob' where id='$id'");

///	echo "<script>location.replace('patients.php')</script>";
}elseif ($_GET['action']=="editproduct") {
	$id=$_REQUEST['id'];
	$name=$_REQUEST['name'];
	$brandid=$_REQUEST['brandid'];
	$productid=$_REQUEST['productid'];
	mysql_query("UPDATE products set productname='$name',itemtypeid='$productid',brandid='$brandid' where id='$id' ");
	echo "<script>location.replace('products.php')</script>";

}elseif ($_GET['action']=="editbrand") {
	$id=$_REQUEST['id'];
	$name=$_POST['name'];
	mysql_query("UPDATE brand set name='$name' where id='$id' ");
	echo "<script>location.replace('brands.php')</script>";
}elseif ($_GET['action']=="editproject") {
	$id=$_REQUEST['id'];
	$name=$_POST['name'];
	mysql_query("UPDATE itemtype set name='$name' where id='$id' ");
	echo "<script>location.replace('itemtypes.php')</script>";
}elseif ($_GET['action']=="delete_project") {
	$id=$_REQUEST['id'];
	mysql_query("DELETE FROM itemtype where id='$id'");
	echo "<script>location.replace('itemtypes.php')</script>";
}elseif ($_GET['action']=="delete_city") {
	$id=$_REQUEST['id'];
	mysql_query("DELETE FROM brand where id='$id'");
	echo "<script>location.replace('brands.php')</script>";
}elseif ($_GET['action']=="delete_patient") {
	$id=$_REQUEST['id'];
	mysql_query("UPDATE patients SET status='1' where id='$id'");
	echo "<script>location.replace('patients.php')</script>";
}





