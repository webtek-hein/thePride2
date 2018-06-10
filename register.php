<?php

require 'admin/db.php';

$user = $_POST['username'];
$fname = $_POST['fname'];
$lname = $_POST['lname'];
$num = $_POST['num'];
$pass = $_POST['pass'];
$type = $_POST['type'];


if($_POST['pass'] != $_POST['pass2']){
    $m = "Password not Match!";
    echo "
            <script type = 'text/javascript'>
                alert('$m');
                window.location.replace('index.php#toregister');
            </script>
         ";
}else{
    $sql = "INSERT INTO user(username,first_Name,last_Name,password,acc_Type,status,contact_No) VALUES 
            ('$user','$fname','$lname','$pass','$type','pending','$num')";
    $r = $conn->query($sql);
    if(!$r){var_dump($conn->error);
        die;

        echo "
            <script type = 'text/javascript'>
                alert('$m');
                window.location.replace('index.php');
            </script>
         ";
    }

    $m = "Success!";
    echo "
            <script type = 'text/javascript'>
                alert('$m');
                window.location.replace('index.php');
            </script>
         ";
}

