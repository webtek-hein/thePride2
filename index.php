<?php
session_start();
if(isset($_SESSION['username'])){
    if($_SESSION['userType'] == "Admin"){
        header('Location:admin/dashboard.php');
    }elseif ($_SESSION['userType'] == "Service Provider"){
        header('Location: //localhost:8080/ServiceProvider/requests.jsp');
    }elseif ($_SESSION['userType'] == "Client"){
        header('Location: //localhost:2000/index');
    }
}
?>

<!DOCTYPE html>
    <head>
        <meta charset="UTF-8" />
        <!-- <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">  -->
        <title>Login</title>
        <link rel="shortcut icon" href="../favicon.ico">
        <link rel="stylesheet" type="text/css" href="css/style2.css" />
		<link rel="stylesheet" type="text/css" href="css/animate-custom.css" />
    </head>
    <body>
        <div class="container">
            <br>
            <br>
            <br>
            <br>

            <section>
                <div id="container_demo" >
                    <!-- hidden anchor to stop jump http://www.css3create.com/Astuce-Empecher-le-scroll-avec-l-utilisation-de-target#wrap4  -->
                    <a class="hiddenanchor" id="toregister"></a>
                    <a class="hiddenanchor" id="tologin"></a>
                    <div id="wrapper">
                        <div id="login" class="animate form">
                            <form  action="login.php" method="post">
                                <h1>CARS <strong>2</strong> GO</span></h1>
                                <p> 
                                    <label for="username" class="uname" data-icon="u" > Username </label>
                                    <input id="username" name="username" required="required" type="text" placeholder=""/>
                                </p>
                                <p> 
                                    <label for="password" class="youpasswd" data-icon="p"> Your password </label>
                                    <input id="password" name="password" required="required" type="password" placeholder="" />
                                </p>
                                <p class="login button"> 
                                    <input type="submit" value="Login" /> 
								</p>
                                <p class="change_link">
									Not a member yet ?
									<a href="#toregister" class="to_register">Join us</a>
								</p>
                            </form>
                        </div>

                        <div id="register" class="animate form">
                            <form  action="register.php" autocomplete="on" method="post">
                                <h1> Sign up </h1>
                                <p>
                                    <label for="usernamesignup" class="uname" data-icon="u">First Name</label>
                                    <input id="usernamesignup" name="fname" required="required" type="text" placeholder="" />
                                </p>
                                <p>
                                    <label for="usernamesignup" class="uname" data-icon="u">Last Name</label>
                                    <input id="usernamesignup1" name="lname" required="required" type="text" placeholder="" />
                                </p>
                                <p>
                                    <label for="usernamesignup" class="uname" data-icon="u">Address</label>
                                    <input id="usernamesignup2" name="addr" required="required" type="text" placeholder="" />
                                </p>
                                <p>
                                    <label for="usernamesignup" class="uname" data-icon="u">Contact No</label>
                                    <input id="usernamesignup2" name="num" required="required" type="text" placeholder="" />
                                </p>
                                <div class="styled-select slate">
                                    <select name="type" class="form-control">
                                        <option value="Service Provider">Service Provider</option>
                                        <option value="Client">Client</option>
                                    </select>
                                </div>
                                <p>
                                    <label for="usernamesignup" class="uname" data-icon="u">Username</label>
                                    <input id="usernamesignup3" name="username" required="required" type="text" placeholder="" />
                                </p>
                                <p> 
                                    <label for="passwordsignup" class="youpasswd" data-icon="p">Your password </label>
                                    <input id="passwordsignup4" name="pass" required="required" type="password" placeholder=""/>
                                </p>
                                <p> 
                                    <label for="passwordsignup_confirm" class="youpasswd" data-icon="p">Please confirm your password </label>
                                    <input id="passwordsignup_confirm5" name="pass2" required="required" type="password" placeholder=""/>
                                </p>


                                <p class="signin button"> 
									<input type="submit" id="sub" value="Sign up"/>
								</p>
                                <p class="change_link">  
									Already a member ?
									<a href="#tologin" class="to_register"> Go and log in </a>
								</p>
                            </form>
                        </div>
						
                    </div>
                </div>  
            </section>
        </div>
    </body>
</html>