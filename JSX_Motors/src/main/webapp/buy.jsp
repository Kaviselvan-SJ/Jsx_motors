<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Buy Product - JSX Motors</title>
  <link rel="stylesheet" href="home.css">
  <style>
    .buy-container {
      max-width: 700px;
      margin: 50px auto;
      padding: 30px;
      background: #1a1a1a;
      border-radius: 12px;
    }
    h2 { color: var(--accent); margin-bottom: 20px; }
    label { display: block; margin: 10px 0 5px; }
    input, textarea {
      width: 100%; padding: 10px; margin-bottom: 15px;
      border: 1px solid #555; border-radius: 6px; background: #333; color: white;
    }
    .submit-btn {
      padding: 10px 20px; border: none; border-radius: 8px;
      background: var(--accent); color: white; cursor: pointer;
    }
    .submit-btn:hover { background: #b91d2a; }
    .product-info { margin-bottom: 20px; background: #222; padding: 15px; border-radius: 8px; }
  </style>
</head>
<body>
  <header>
    <nav>
      <a href="index.jsp" class="logo">JSX<span>Motors</span></a>
      <ul class="nav-links">
        <li><a href="index.jsp">Home</a></li>
        <li><a href="foreignBrands.jsp">Foreign Brands</a></li>
        <li><a href="indianBrands.jsp">Indian Brands</a></li>
        <li><a href="spares.jsp">Spares</a></li>
        <li><a href="contact.jsp">Contacts</a></li>
        <li><a href="cart.jsp">Cart 🛒</a></li>
      </ul>
    </nav>
  </header>

  <div class="buy-container">
    <h2>Complete Your Purchase</h2>

    <!-- Product Info -->
    <div class="product-info">
      <p><strong>Product:</strong> <%= request.getParameter("brand") %> - <%= request.getParameter("name") %></p>
      <p><strong>Type:</strong> <%= request.getParameter("type") %></p>
      <p><strong>Price:</strong> ₹<%= request.getParameter("price") %></p>
    </div>

    <!-- Order Form -->
    <form action="buy" method="post">
      <input type="hidden" name="itemId" value="<%= request.getParameter("itemId") %>">
      <input type="hidden" name="type" value="<%= request.getParameter("type") %>">
      <input type="hidden" name="price" value="<%= request.getParameter("price") %>">
      <input type="hidden" name="name" value="<%= request.getParameter("name") %>">
      <input type="hidden" name="brand" value="<%= request.getParameter("brand") %>">

      <label>Full Name:</label>
      <input type="text" name="userName" required>

      <label>Email:</label>
      <input type="email" name="email" required>

      <label>Address:</label>
      <textarea name="address" rows="3" required></textarea>

      <button type="submit" class="submit-btn">Buy Now</button>
    </form>
  </div>

  <footer>
    <div class="footer-bottom">
      &copy; 2025 JSX Motors. All Rights Reserved.
    </div>
  </footer>
</body>
</html>
