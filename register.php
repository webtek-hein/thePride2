<?php

require 'admin/db.php';


$fname = $_POST['fname'];
$lname = $_POST['lname'];
$addr = $_POST['addr'];
$num = $_POST['num'];
$type = $_POST['type'];
$user = $_POST['username'];

$sql = "SELECT username FROM user";

$t = $conn->query($sql);
    while ($row = $t->fetch_assoc()) {
          if($row['username'] == $user){
              $m = "Username, Already Exist!";
              echo "
                <script type = 'text/javascript'>
                    alert('$m');
                    window.location.replace('index.php');
                </script>
             ";
          }
    }


$pass = $_POST['pass'];
if ($_POST['pass'] != $_POST['pass2']) {
    $m = "Password not Match!";
    echo "
            <script type = 'text/javascript'>
                alert('$m');
                window.location.replace('index.php#toregister');
            </script>
         ";
} else {
    $sql = "INSERT INTO user(firstname,lastname,address,contact_No,acctype,username,password,status) VALUES 
                ('$fname','$lname','$addr','$num','$type','$user','$pass','pending')";

    $r = $conn->query($sql);
    if (!$r) {
        var_dump($conn->error);
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

