<!doctype html>
<%@ page import="java.sql.*" %>

<%
         Class.forName("com.mysql.jdbc.Driver");  
%>   

<%
    
    if(request.getParameter("ayd") != null){
        if(session.getAttribute("ayd") == null){

            try{
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/webtech","root","");
            Statement st = con.createStatement();
            int id = Integer.parseInt(request.getParameter("ayd"));
            ResultSet rs = st.executeQuery("SELECT * FROM user WHERE user_Id = '" + id + "' ");

            if(!rs.next()){
                }
                session = request.getSession();
                session.setAttribute("firstname", rs.getString("firstname"));
                session.setAttribute("ayd", id);
            }catch(Exception e){
                System.out.println("Error " + e.toString());
            }
        }
    }else if((session.getAttribute("ayd") != null) && (request.getParameter("ayd") == null)){
        //Do nothing
    }else{
        response.sendRedirect("http://localhost/webtech/directaccess.php");
    }
    
%>


<html lang="en">

<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href=" assets/img/apple-icon.png" />
    <link rel="icon" type="image/png" href=" assets/img/favicon.png" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>Material Dashboard by Creative Tim</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />
    <!-- Bootstrap core CSS     -->
    <link href=" assets/css/bootstrap.min.css" rel="stylesheet" />
    <!--  Material Dashboard CSS    -->
    <link href=" assets/css/material-dashboard.css?v=1.2.0" rel="stylesheet" />
    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href=" assets/css/demo.css" rel="stylesheet" />
    <!--     Fonts and icons     -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700,300|Material+Icons" rel='stylesheet'>
</head>

<body>
    <div class="wrapper">
        <div class="sidebar" data-color="purple" data-image=" assets/img/sidebar-1.jpg">
            <!--
        Tip 1: You can change the color of the sidebar using: data-color="purple | blue | green | orange | red"

        Tip 2: you can also add an image using data-image tag
    -->
            <div class="logo">
                <a class="simple-text">
                    <%= session.getAttribute("firstname") %>
                </a>
            </div>
            <div class="sidebar-wrapper">
                <ul class="nav">
                    <li >
                        <a href="requests.jsp">
                            <i class="material-icons">content_paste</i>
                            <p>Requests</p>
                        </a>
                    </li>
                    <li class="active">
                        <a href="addCars.jsp">
                            <i class="material-icons">person</i>
                            <p>Add Car</p>
                        </a>
                    </li>
                    <li>
                        <a href="cars.jsp">
                            <i class="material-icons">content_paste</i>
                            <p>My Cars</p>
                        </a>
                    </li>
                    <li>
                        <a href="transactions.jsp">
                            <i class="material-icons">content_paste</i>
                            <p>Transactions</p>
                        </a>
                    </li>
                    <li class="active-pro footer">
                        <a href="logout.jsp">
                            <i class="material-icons">unarchive</i>
                            <p>Logout</p>
                        </a>
                    </li>
                    
                    
                </ul>
            </div>
        </div>
        <div class="main-panel">
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header" data-background-color="purple">
                                    <h4 class="title">Add Car</h4>
                                    <p class="category">Add your cars</p>
                                </div>
                                <div class="card-content">
                                    <form action="addCarB.jsp" method="post">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Brand</label>
                                                    <input required type="text" name="brand" class="form-control" >
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Model</label>
                                                    <input required type="text" name="model" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">year</label>
                                                    <input required type="number" name="year" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Capacity</label>
                                                    <input required type="number" name="capacity" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Rent Price</label>
                                                    <input required type="number" name="rentprice" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Car Type</label>
                                                    <input required type="text" name="cartype" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Color</label>
                                                    <input required type="text" name="color" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">License Plate</label>
                                                    <input required type="text" name="licenseplate" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Mileage</label>
                                                    <input required type="text" name="mileage" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                        
                                        
                                        <button type="submit" class="btn btn-primary pull-right">Add Car</button>
                                        <div class="clearfix"></div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</body>
<!--   Core JS Files   -->
<script src=" assets/js/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src=" assets/js/bootstrap.min.js" type="text/javascript"></script>
<script src=" assets/js/material.min.js" type="text/javascript"></script>
<!--  Charts Plugin -->
<script src=" assets/js/chartist.min.js"></script>
<!--  Dynamic Elements plugin -->
<script src=" assets/js/arrive.min.js"></script>
<!--  PerfectScrollbar Library -->
<script src=" assets/js/perfect-scrollbar.jquery.min.js"></script>
<!--  Notifications Plugin    -->
<script src=" assets/js/bootstrap-notify.js"></script>
<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!-- Material Dashboard javascript methods -->
<script src=" assets/js/material-dashboard.js?v=1.2.0"></script>
<!-- Material Dashboard DEMO methods, don't include it in your project! -->
<script src=" assets/js/demo.js"></script>

</html>