<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%
    
    
    session.invalidate();
    response.sendRedirect("http://localhost/webtech/logout.php");
   
    
        
    
    
%>
