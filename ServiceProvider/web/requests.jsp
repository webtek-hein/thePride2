<%@ page import="java.sql.*" %>

<%
         Class.forName("com.mysql.jdbc.Driver");  
%> 


<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="  assets/img/apple-icon.png" />
    <link rel="icon" type="image/png" href="  assets/img/favicon.png" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>Material Dashboard by Creative Tim</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />
    <!-- Bootstrap core CSS     -->
    <link href="  assets/css/bootstrap.min.css" rel="stylesheet" />
    <!--  Material Dashboard CSS    -->
    <link href="  assets/css/material-dashboard.css?v=1.2.0" rel="stylesheet" />
    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="  assets/css/demo.css" rel="stylesheet" />
    <!--     Fonts and icons     -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700,300|Material+Icons" rel='stylesheet'>
</head>

<body>
    <div class="wrapper">
        <div class="sidebar" data-color="purple" data-image="  assets/img/sidebar-1.jpg">
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
                    <li>
                        <a href="dashboard.jsp">
                            <i class="material-icons">dashboard</i>
                            <p>Dashboard</p>
                        </a>
                    </li>
                    <li >
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
                    <li class="active-pro footer">
                        <a href="logout.jsp">
                            <i class="material-icons">unarchive</i>
                            <p>Logout</p>
                        </a>
                    </li>
                    <li class="active">
                        <a href="requests.jsp">
                            <i class="material-icons">content_paste</i>
                            <p>Requests</p>
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
                                    <h4 class="title">My Cars</h4>
                                </div>
                                <div class="card-content table-responsive">
                                    <table class="table">
                                        <thead class="text-primary">
                                            <th>Requestor</th>
                                            <th>Brand</th>
                                            <th>Model</th>
                                            <th>Rent Start</th>
                                            <th>Rent End</th>
                                        </thead>
                                        <tbody>
                                            <%
                                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/webtech","root","");

                                                Statement st = con.createStatement();
                                                Integer id =(Integer) session.getAttribute("ayd");
                                                

                                                ResultSet rs = st.executeQuery("SELECT user.firstname,brand,model,user.lastname,request.*,rentStartdate,rentEnddate FROM vehicle inner join request on request.vehicleID = vehicle.vehicleID inner join user on user.user_Id = request.userID WHERE spID = '" + id + " '");
                                                if(rs.next()){
                                                    out.println("1");
                                                    rs.beforeFirst();
                                                        while(rs.next()){
                                                            out.println("<tr><td>" + rs.getString("firstname"));
                                                            out.println("</td><td>" + rs.getString("brand"));
                                                            out.println("</td><td>" + rs.getString("model"));
                                                            out.println("</td><td>" + rs.getString("rentStartDate"));
                                                            out.println("</td><td>" + rs.getString("rentEnddate"));
                                                            out.println("</td></tr>");

                                                        }
                                                }else{
                                                    out.println("No Requests"); 
                                                   
                                                }
                                            %>
                                        </tbody>
                                    </table>
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
<script src="  assets/js/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src="  assets/js/bootstrap.min.js" type="text/javascript"></script>
<script src="  assets/js/material.min.js" type="text/javascript"></script>
<!--  Charts Plugin -->
<script src="  assets/js/chartist.min.js"></script>
<!--  Dynamic Elements plugin -->
<script src="  assets/js/arrive.min.js"></script>
<!--  PerfectScrollbar Library -->
<script src="  assets/js/perfect-scrollbar.jquery.min.js"></script>
<!--  Notifications Plugin    -->
<script src="  assets/js/bootstrap-notify.js"></script>
<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!-- Material Dashboard javascript methods -->
<script src="  assets/js/material-dashboard.js?v=1.2.0"></script>
<!-- Material Dashboard DEMO methods, don't include it in your project! -->
<script src="  assets/js/demo.js"></script>

</html>