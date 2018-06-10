<?php


$conn = new mysqli("localhost","root","","webtech");

if(!$conn){
    echo "Error Connecting to DB " . $conn->error;
    die;
}