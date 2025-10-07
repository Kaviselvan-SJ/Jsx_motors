<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="dbConnection.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Spares - JSX Motors</title>
<link rel="stylesheet" href="home.css" />
<style>
.spares-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 20px;
	margin: 20px 0;
}

.spare-card {
	background: #1a1a1a;
	border: 1px solid var(--gray);
	border-radius: 12px;
	padding: 15px;
	text-align: center;
	transition: transform 0.3s ease;
}

.spare-card:hover {
	transform: translateY(-5px);
}

.spare-card img {
	width: 100%;
	height: 160px;
	object-fit: cover;
	border-radius: 8px;
	margin-bottom: 10px;
}

.spare-card h3 {
	color: var(--accent);
	margin-bottom: 5px;
}

.spare-card p {
	margin: 4px 0;
}

.buy-btn, .cart-btn {
	display: inline-block;
	margin-top: 8px;
	padding: 8px 16px;
	border: none;
	border-radius: 6px;
	font-weight: bold;
	cursor: pointer;
}

.buy-btn {
	background: var(--accent);
	color: white;
}

.buy-btn:hover {
	background: #b91d2a;
}

.cart-btn {
	background: #333;
	color: white;
}

.cart-btn:hover {
	background: #555;
}

.buy-btn:disabled, .cart-btn:disabled {
	background: gray;
	cursor: not-allowed;
}
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
				<li><a href="spares.jsp" style="color: var(--accent);">Spares</a></li>
				<li><a href="contact.jsp">Contacts</a></li>
				<li><a href="cart.jsp">Cart 🛒</a></li>
			</ul>
		</nav>
	</header>

	<!-- Page Content -->
	<section>
		<div class="section-title">
			<h2>Car Spares & Accessories</h2>
			<p>High-quality automotive spares for all brands</p>
		</div>
		<div class="spares-grid">
			<%
			try {
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM spares");
				while (rs.next()) {
			%>
			<div class="spare-card">
				<img src="<%=rs.getString("image_url")%>"
					alt="<%=rs.getString("name")%>">
				<h3><%=rs.getString("name")%></h3>
				<p>
					Brand:
					<%=rs.getString("brand")%></p>
				<p>
					Category:
					<%=rs.getString("category")%></p>
				<p>
					Price: ₹<%=rs.getBigDecimal("price")%></p>

				<form action="buy.jsp" method="get" style="display: inline;">
					<input type="hidden" name="itemId" value="<%=rs.getInt("id")%>">
					<input type="hidden" name="brand"
						value="<%=rs.getString("brand")%>"> <input type="hidden"
						name="model" value="<%=rs.getString("name")%>"> <input
						type="hidden" name="price" value="<%=rs.getString("price")%>">
					<input type="hidden" name="type" value="spare">

					<button type="submit" class="buy-btn"
						<%=(rs.getInt("quantity") == 0) ? "disabled" : ""%>>
						<%=(rs.getInt("quantity") == 0) ? "Out of Stock" : "Buy Now"%>
					</button>
				</form>


				<form action="addToCart" method="post">
					<input type="hidden" name="spareId" value="<%=rs.getInt("id")%>">
					<button type="submit" class="cart-btn"
						<%=(rs.getInt("quantity") == 0) ? "disabled" : ""%>>🛒
						Add to Cart</button>
				</form>
			</div>
			<%
			}
			rs.close();
			stmt.close();
			con.close();
			} catch (Exception e) {
			out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
			}
			%>
		</div>
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
					<li><a href="spares.jsp">Spares</a></li>
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
					<a href="#">🌐</a> <a href="#">📘</a> <a href="#">🐦</a> <a
						href="#">📸</a>
				</div>
			</div>
		</div>
		<div class="footer-bottom">&copy; 2025 JSX Motors. All Rights
			Reserved.</div>
	</footer>
</body>
</html>
