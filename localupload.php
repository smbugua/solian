<?php
include('header.php');
/*
* iTech Empires:  How to Import Data from CSV File to MySQL Using PHP Script
* Version: 1.0.0
* Page: Import.PHP
*/

// Database Connection
require 'dbconn.php';

$message = "";
if (isset($_POST)) {
    $allowed = array('csv');

    $date = new DateTime();
    $datetime= $date->getTimestamp();
    $filename = $_FILES['file']['name'];
    $ext = pathinfo($filename, PATHINFO_EXTENSION);
    if (!in_array($ext, $allowed)) {
        // show error message
        $message = 'Invalid file type, please use .CSV file!';
        echo "<script>alert('Invalid file type, please use .CSV file!')</script>";
    echo "<script>location.replace('addressbook.php')</script>";
    } else {

        //move_uploaded_file($_FILES["file"]["tmp_name"], "uploads/" . $_FILES['file']['name'].$datetime);
        move_uploaded_file($_FILES["file"]["tmp_name"], "uploads/" . $_FILES['file']['name'].$datetime);

        //$file = "uploads/" . $_FILES['file']['name'];
        $file = "uploads/" . $_FILES['file']['name'].$datetime;

        $query = <<<eof
        LOAD DATA LOCAL INFILE '$file'
         INTO TABLE contacts
         FIELDS TERMINATED BY ','
         IGNORE 1 LINES
        (name,mobile,email)
eof;

        echo "<script>alert('CSV file successfully imported!')</script>";

    echo "<script>location.replace('addressbook.php')</script>";
        if (!$result = mysqli_query($con, $query)) {
            exit(mysqli_error($con));          

    echo "<script>location.replace('addressbook.php')</script>";
        }
        $message = "CSV file successfully imported!";
    }
}