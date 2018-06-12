<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("rid"));
   
   
       
   
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/webtech",
            "root", "");


     String queryString = "UPDATE request SET status = 'finished' WHERE requestID = '" + id + " '";
    
     
     PreparedStatement ps = null;
     ps = con.prepareStatement(queryString);
     ps.executeUpdate();
     
     int vid = Integer.parseInt(request.getParameter("vID"));
     
     String queryString2 = "UPDATE vehicle SET vehicleStatus = 'available' WHERE vehicleID = '" + vid + " '";
    
     
     ps = null;
     ps = con.prepareStatement(queryString2);
     ps.executeUpdate();
     
     
     session = request.getSession();
     Integer ayd =(Integer) session.getAttribute("ayd");
     int uid = Integer.parseInt(request.getParameter("uID"));
     
     String q = "INSERT INTO transaction(spID,clientID,status,vehicleID,requestID) VALUES(?,?,?,?,?)";
     
     ps = null;
     ps = con.prepareStatement(q);
     ps.setInt(1, ayd);
     ps.setInt(2, uid);
     ps.setString(3, "finished");
     ps.setInt(4, vid);
     ps.setInt(5, id);
    
     ps.executeUpdate();
     
     
     out.println("<script type=\"text/javascript\">");
     out.println("alert('Finished!!');");
     out.println("location='transactions.jsp';");
     out.println("</script>");
   
    
        
    
    
%>
