<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%
    session = request.getSession();
    Integer id =(Integer) session.getAttribute("ayd");
    String brand = request.getParameter("brand");
    String model = request.getParameter("model");
    int year = Integer.parseInt(request.getParameter("year"));
    int capacity = Integer.parseInt(request.getParameter("capacity"));
    String rentprice = request.getParameter("rentprice");
    String carType = request.getParameter("cartype");
    String color = request.getParameter("color");
    String licenseplate = request.getParameter("licenseplate");
    String mileage = request.getParameter("mileage");
  
   // Statement stmt = null;
   
   
       
   
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/webtech",
            "root", "");


     String queryString = "INSERT INTO vehicle(brand,model,year,capacity,rent_Price,carType,color,licensePlate,currentMileage,vehicleStatus,spID) "
             + "            VALUES(?,?,?,?,?,?,?,?,?,?,?)";
    
     
     PreparedStatement ps = null;
     ps = con.prepareStatement(queryString);
     ps.setString(1, brand);
     ps.setString(2, model);
     ps.setInt(3, year);
     ps.setInt(4, capacity);
     ps.setString(5, rentprice);
     ps.setString(6, carType);
     ps.setString(7, color);
     ps.setString(8, licenseplate);
     ps.setString(9, mileage);
     ps.setString(10, "available");
     ps.setInt(11, id);
    
     ps.executeUpdate();
     

     out.println("<script type=\"text/javascript\">");
     out.println("alert('Car Successfully Added!');");
     out.println("location='addCars.jsp';");
     out.println("</script>");
   
    
        
    
    
%>
