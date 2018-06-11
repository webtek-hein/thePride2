<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%
   int id = Integer.parseInt(request.getParameter("rid"));
   
   
       
   
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/webtech",
            "root", "");


     String queryString = "UPDATE request SET status = 'cancelled' WHERE requestID = '" + id + " '";
    
     
     PreparedStatement ps = null;
     ps = con.prepareStatement(queryString);
     ps.executeUpdate();
     

     out.println("<script type=\"text/javascript\">");
     out.println("alert('Cancelled!!');");
     out.println("location='transactions.jsp';");
     out.println("</script>");
   
    
        
    
    
%>
