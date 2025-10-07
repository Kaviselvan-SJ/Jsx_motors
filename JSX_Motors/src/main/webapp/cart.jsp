<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="dbConnection.jsp" %>
<%@ page import="java.util.*,java.text.DecimalFormat" %>
<%
    List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
    DecimalFormat df = new DecimalFormat("0.00");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Shopping Cart - JSX Motors</title>
  <link rel="stylesheet" href="home.css" />
  <style>
    table { width: 100%; border-collapse: collapse; margin: 20px 0; }
    th, td { border: 1px solid #444; padding: 10px; text-align: center; }
    th { background: var(--accent); color: #fff; }
    .remove-btn {
      background: red;
      color: white;
      border: none;
      padding: 6px 12px;
      border-radius: 5px;
      cursor: pointer;
    }
    .remove-btn:hover { background: darkred; }
  </style>
</head>
<body>
  <!-- Navbar -->
  <header>
    <nav>
      <a href="index.jsp" class="logo">JSX<span>Motors</span></a>
      <ul class="nav-links">
        <li><a href="home.html">Home</a></li>
        <li><a href="foreignBrands.jsp">Foreign Brands</a></li>
        <li><a href="indianBrands.jsp">Indian Brands</a></li>
        <li><a href="spares.jsp">Spares</a></li>
        <li><a href="#">Contacts</a></li>
        <li><a href="cart.jsp" style="color: var(--accent);">Cart 🛒</a></li>
      </ul>
    </nav>
  </header>

  <section>
    <div class="section-title">
      <h2>Your Cart</h2>
    </div>

    <%
      if (cart == null || cart.isEmpty()) {
    %>
      <p>Your cart is empty!</p>
    <%
      } else {
        double total = 0;
    %>
      <table>
        <tr>
          <th>Item</th>
          <th>Brand</th>
          <th>Type</th>
          <th>Price</th>
          <th>Quantity</th>
          <th>Subtotal</th>
          <th>Action</th>
        </tr>
        <%
          for (Map<String, Object> item : cart) {
              int itemId = (int) item.get("itemId");
              String name = (String) item.get("name");
              String brand = (String) item.get("brand");
              String type = (String) item.get("type");
              double price = (double) item.get("price");
              int quantity = (int) item.get("quantity");
              double subtotal = price * quantity;
              total += subtotal;
        %>
        <tr>
          <td><%= name %></td>
          <td><%= brand %></td>
          <td><%= type %></td>
          <td>₹<%= df.format(price) %></td>
          <td><%= quantity %></td>
          <td>₹<%= df.format(subtotal) %></td>
          <td>
            <form action="removeFromCart" method="post">
              <input type="hidden" name="itemId" value="<%= itemId %>">
              <input type="hidden" name="type" value="<%= type %>">
              <button type="submit" class="remove-btn">Remove</button>
            </form>
          </td>
        </tr>
        <% } %>
        <tr>
          <td colspan="5"><b>Total</b></td>
          <td colspan="2">₹<%= df.format(total) %></td>
        </tr>
      </table>
    <% } %>
  </section>

  <!-- Footer -->
  <footer>
    <div class="footer-container">
      <div class="footer-column">
        <h4>Quick Links</h4>
        <ul>
          <li><a href="home.html">Home</a></li>
          <li><a href="foreignBrands.jsp">Foreign Brands</a></li>
          <li><a href="indianBrands.jsp">Indian Brands</a></li>
          <li><a href="#">Spares</a></li>
          <li><a href="#">Contact Us</a></li>
        </ul>
      </div>
      <div class="footer-column">
        <h4>Contact Us</h4>
        <p>Email: support@jsxmotors.com</p>
        <p>Phone: +91 98765 43210</p>
        <p>Address: JSX Motors HQ, Bangalore, India</p>
      </div>
      <div class="footer-column">
        <h4>Follow Us</h4>
        <div class="social-icons">
          <a href="#">🌐</a>
          <a href="#">📘</a>
          <a href="#">🐦</a>
          <a href="#">📸</a>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      &copy; 2025 JSX Motors. All Rights Reserved.
    </div>
  </footer>
</body>
</html>
