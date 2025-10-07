<%@ page import="java.sql.*" %>
<%
    Connection con = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/carsdb", "root", "root"
        );
    } catch(Exception e) {
        out.println("<p style='color:red'>Database connection error: " + e.getMessage() + "</p>");
    }
%>
