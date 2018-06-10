<?php


require 'admin/db.php';
session_start();



$user = $_POST['username'];
$pass = $_POST['password'];


$sql = "SELECT username,password,acctype,user_Id FROM user WHERE username = ? AND password = ?";
$st = $conn->prepare($sql);
$st->bind_param('ss',$user,$pass);
$st->execute();
$res = $st->get_result();
$r = $res->fetch_row();

if($res->num_rows > 0){
    $_SESSION['username'] = $user;
    $_SESSION['userType'] = $r[2];
    $_SESSION['id'] = $r[2];
    if($r[2] == "Admin"){
        header('Location:admin/dashboard.php');
    }elseif ($r[2] == "Service Provider"){
        header('Location: //localhost:8080/ServiceProvider/dashboard.jsp?ayd='. $r[3]);
    }elseif ($r[2] == "Client"){
        header('Location:NODE');
    }else{
        $m = "Who Are You?!";
        echo "
            <script type = 'text/javascript'>
                alert('$m');
                window.location.replace('index.php');
            </script>
         ";
    }

}else{
    $m = "Wrong Credentials!";
    echo "
            <script type = 'text/javascript'>
                alert('$m');
                window.location.replace('index.php');
            </script>
         ";
}
