<?php


$conn = new mysqli("localhost","root","","webtek");

if(!$conn){
    echo "Error Connecting to DB " . $conn->error;
    die;
}