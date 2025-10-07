<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Order Confirmation</title>
  <link rel="stylesheet" href="home.css">
</head>
<body>
  <div style="max-width:600px; margin:50px auto; padding:30px; background:#1a1a1a; border-radius:12px; text-align:center;">
    <h2 style="color:var(--accent);"><%= request.getAttribute("message") %></h2>
    <p><strong>Name:</strong> <%= request.getAttribute("userName") %></p>
    <p><strong>Email:</strong> <%= request.getAttribute("email") %></p>
    <p><strong>Address:</strong> <%= request.getAttribute("address") %></p>
    <p><strong>Item Type:</strong> <%= request.getAttribute("type") %></p>
    <p><strong>Total Price:</strong> ₹<%= request.getAttribute("price") %></p>
    <a href="index.jsp" style="display:inline-block;margin-top:20px;padding:10px 20px;background:var(--accent);color:white;border-radius:8px;text-decoration:none;">Continue Shopping</a>
  </div>
</body>
</html>
