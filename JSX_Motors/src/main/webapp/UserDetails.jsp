<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*,java.io.*,javax.xml.transform.*,javax.xml.transform.stream.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>All Registered Users & Feedback</title>
  <style>
    .container {
      max-width: 900px;
      margin: 40px auto;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-family: Arial, sans-serif;
      background-color: #f9f9f9;
    }
    h2 {
      text-align: center;
      color: #007bff;
      margin-bottom: 20px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 30px;
    }
    th, td {
      padding: 10px;
      border: 1px solid #ccc;
      text-align: left;
    }
    th {
      background-color: #007bff;
      color: white;
    }
    tr:nth-child(even) {
      background-color: #f2f2f2;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>All Registered Users</h2>
    <table>
      <tr>
        <th>User ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Age</th>
      </tr>
      <%
        // DB connection details
        String DB_URL = "jdbc:mysql://localhost:3306/jsx_motors";
        String DB_USER = "root";
        String DB_PASS = "root";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT user_id, name, email, age FROM users");

            while (rs.next()) {
      %>
      <tr>
        <td><%= rs.getInt("user_id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getInt("age") %></td>
      </tr>
      <%
            }
            conn.close();
        } catch (Exception e) {
            out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
        }
      %>
    </table>


    <%
      try {
          // Path to XML and XSL
          String xmlPath = System.getProperty("catalina.base") + File.separator + "feedbacks.xml";
          String xslPath = application.getRealPath("feedbacks.xsl");

          // Create transformer
          TransformerFactory factory = TransformerFactory.newInstance();
          Transformer transformer = factory.newTransformer(new StreamSource(new File(xslPath)));

          // Transform XML → HTML
          StringWriter sw = new StringWriter();
          transformer.transform(new StreamSource(new File(xmlPath)), new StreamResult(sw));

          out.println(sw.toString());  // Output HTML table
      } catch (Exception e) {
          out.println("<p>Error loading feedbacks: " + e.getMessage() + "</p>");
      }
    %>
  </div>
</body>
</html>
