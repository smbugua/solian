<?php // rnfunctions.php
error_reporting(E_ALL ^ E_DEPRECATED);
$dbhost = 'localhost'; // Unlikely to require changing
$dbname = 'solian'; // Modify these...
$dbuser = 'root'; // ...variables according
$dbpass = ''; // ...to your installation
mysql_connect($dbhost, $dbuser, $dbpass) or die(mysql_error());
mysql_select_db($dbname) or die(mysql_error());
function sessionStart()
{
session_start();
}
function createTable($name, $query)
{
if (tableExists($name))
{
echo "Table '$name' already exists<br />";
}
else
{
queryMysql("CREATE TABLE $name($query)");
echo "Table '$name' created<br />";
}
}
function tableExists($name)
{
$result = queryMysql("SHOW TABLES LIKE '$name'");
return mysql_num_rows($result);
}
function queryMysql($query)
{
$result = mysql_query($query) or die(mysql_error());
return $result;
}
function destroySession()
{
$_SESSION=array();
if (session_id() != "" || isset($_COOKIE[session_name()]))
setcookie(session_name(), '', time()-2592000, '/');
session_destroy();
}
function sanitizeString($var)
{
$var = strip_tags($var);
$var = htmlentities($var);
$var = stripslashes($var);
return mysql_real_escape_string($var);
}


function processQuery($query)
{
    
    $result=queryMysql($query);
    return $result;
    
}
function getstock($id){
$stockquery=mysql_fetch_array(mysql_query("SELECT totalstock from productstock where productid='$id' "));
$stock=$stockquery['totalstock'];
return $stock;
}
function updatestock($id,$newstock){
mysql_query("UPDATE productstock set totalstock='$newstock' where productid='$id'");
}

function getInvoicePatient($invoiceid){
	$invoicequery=mysql_fetch_array(mysql_query("SELECT patientid from invoices where id='$invoiceid' "));
$p=$invoicequery['patientid'];
return $p;
}
function getSmsCount(){
	$stockquery=mysql_fetch_array(mysql_query("SELECT count(id) as smstot from messages "));
$stock=$stockquery['smstot'];
return $stock;
}

function longdate($timestamp)
{
return date("l F jS Y", $timestamp);
}

function customerInfo($var,$id){
	$info=mysql_fetch_array(mysql_query("SELECT $var from patients where id='$id' "));
	$var=$info[0];
	return $var;
}

?>
