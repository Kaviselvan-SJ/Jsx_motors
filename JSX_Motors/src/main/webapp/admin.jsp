<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel - JSX Motors</title>
    <link rel="stylesheet" href="home.css"/>
    <style>
        body { background: #111; color: #fff; font-family: Arial; }
        .container { width: 90%; margin: auto; }
        h2 { color: var(--accent); margin-top: 20px; }
        form { background: #1a1a1a; padding: 20px; border-radius: 10px; margin-bottom: 20px; }
        input, select { margin: 8px; padding: 8px; border-radius: 5px; border: none; }
        button { padding: 8px 16px; border: none; border-radius: 6px; background: var(--accent); color: #fff; cursor: pointer; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #444; padding: 10px; text-align: center; }
        th { background: #222; color: var(--accent); }
        tr:nth-child(even) { background: #1a1a1a; }
        .delete-btn { background: red; color: white; padding: 5px 10px; border-radius: 5px; cursor: pointer; }
    </style>
</head>
<body>

    <!-- Navbar -->
    <header>
        <nav>
            <a href="home.html" class="logo">JSX<span>Motors</span></a>
            <ul class="nav-links">
                <li><a href="home.html">Home</a></li>
                <li><a href="foreignBrands.jsp">Foreign Brands</a></li>
                <li><a href="indianBrands.jsp">Indian Brands</a></li>
                <li><a href="spares.jsp">Spares</a></li>
                <li><a href="contact.jsp">Contacts</a></li>
                <li><a href="cart.jsp">Cart 🛒</a></li>
                <li><a href="admin.jsp" style="color: var(--accent);">Admin</a></li>
            </ul>
        </nav>
    </header>

    <div class="container">
        <h1>Admin Dashboard</h1>

        <!-- Add Product Form -->
        <h2>Add Product</h2>
        <form action="AddProductServlet" method="post">
            <label>Type:</label>
            <select name="type" required>
                <option value="car">Car</option>
                <option value="spare">Spare</option>
            </select><br>
            
            <label>Origin (Cars only):</label>
            <select name="origin">
                <option value="Indian">Indian</option>
                <option value="Foreign">Foreign</option>
                <option value="">N/A</option>
            </select><br>
            
            <input type="text" name="brand" placeholder="Brand" required>
            <input type="text" name="model" placeholder="Model / Spare Name" required>
            <input type="text" name="category" placeholder="Category (for spares)">
            <input type="number" name="price" placeholder="Price" required>
            <input type="number" name="quantity" placeholder="Quantity" required>
            <input type="text" name="fuel_type" placeholder="Fuel Type (Cars only)">
            <input type="text" name="image_url" placeholder="Image URL" required>
            <button type="submit">Add Product</button>
        </form>

        <!-- Display Products -->
        <h2>Products</h2>
        <table>
            <tr>
                <th>ID</th><th>Type</th><th>Brand</th><th>Model/Name</th><th>Category</th><th>Price</th><th>Qty</th><th>Delete</th>
            </tr>
            <%
                try {
                    Statement stmt = con.createStatement();
                    ResultSet rsCars = stmt.executeQuery("SELECT id, brand, model, price, quantity, origin, fuel_type FROM cars");
                    while(rsCars.next()) {
            %>
            <tr>
                <td><%= rsCars.getInt("id") %></td>
                <td>Car (<%= rsCars.getString("origin") %>)</td>
                <td><%= rsCars.getString("brand") %></td>
                <td><%= rsCars.getString("model") %></td>
                <td>-</td>
                <td>₹<%= rsCars.getBigDecimal("price") %></td>
                <td><%= rsCars.getInt("quantity") %></td>
                <td>
                    <form action="DeleteProductServlet" method="post">
                        <input type="hidden" name="id" value="<%= rsCars.getInt("id") %>">
                        <input type="hidden" name="type" value="car">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                    rsCars.close();

                    ResultSet rsSpares = stmt.executeQuery("SELECT id, brand, name, category, price, quantity FROM spares");
                    while(rsSpares.next()) {
            %>
            <tr>
                <td><%= rsSpares.getInt("id") %></td>
                <td>Spare</td>
                <td><%= rsSpares.getString("brand") %></td>
                <td><%= rsSpares.getString("name") %></td>
                <td><%= rsSpares.getString("category") %></td>
                <td>₹<%= rsSpares.getBigDecimal("price") %></td>
                <td><%= rsSpares.getInt("quantity") %></td>
                <td>
                    <form action="DeleteProductServlet" method="post">
                        <input type="hidden" name="id" value="<%= rsSpares.getInt("id") %>">
                        <input type="hidden" name="type" value="spare">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                    rsSpares.close();
                    stmt.close();
                } catch(Exception e) {
                    out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>

        <!-- Display Orders -->
        <h2>Orders</h2>
        <table>
            <tr>
                <th>Order ID</th><th>User Name</th><th>Email</th><th>Address</th><th>Product</th><th>Brand</th><th>Price</th><th>Date</th>
            </tr>
            <%
                try {
                    Statement stmt2 = con.createStatement();
                    ResultSet rsOrders = stmt2.executeQuery("SELECT * FROM orders ORDER BY order_date DESC");
                    while(rsOrders.next()) {
            %>
            <tr>
                <td><%= rsOrders.getInt("id") %></td>
                <td><%= rsOrders.getString("username") %></td>
                <td><%= rsOrders.getString("email") %></td>
                <td><%= rsOrders.getString("address") %></td>
                <td><%= rsOrders.getString("model") %></td>
                <td><%= rsOrders.getString("brand") %></td>
                <td>₹<%= rsOrders.getBigDecimal("price") %></td>
                <td><%= rsOrders.getTimestamp("order_date") %></td>
            </tr>
            <%
                    }
                    rsOrders.close();
                    stmt2.close();
                    con.close();
                } catch(Exception e) {
                    out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-container">
            <div class="footer-column">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="home.html">Home</a></li>
                    <li><a href="foreignBrands.jsp">Foreign Brands</a></li>
                    <li><a href="indianBrands.jsp">Indian Brands</a></li>
                    <li><a href="spares.jsp">Spares</a></li>
                    <li><a href="contact.jsp">Contact Us</a></li>
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
                    <a href="#">🌐</a> <a href="#">📘</a> <a href="#">🐦</a> <a href="#">📸</a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">&copy; 2025 JSX Motors. All Rights Reserved.</div>
    </footer>

</body>
</html>
