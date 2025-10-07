<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="dbConnection.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Indian Car Brands - JSX Motors</title>
<link rel="stylesheet" href="home.css" />
<style>
.brand-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 25px;
}

.car-card {
	background: #1a1a1a;
	border: 1px solid var(--gray);
	border-radius: 12px;
	padding: 20px;
	text-align: center;
	transition: transform 0.3s ease;
}

.car-card:hover {
	transform: translateY(-5px);
}

.car-card img {
	width: 100%;
	height: 180px;
	object-fit: cover;
	border-radius: 10px;
	margin-bottom: 15px;
}

.car-card h3 {
	color: var(--accent);
	margin-bottom: 10px;
}

.car-card p {
	margin: 5px 0;
}

.buy-btn, .cart-btn {
	margin: 5px 4px;
	padding: 10px 20px;
	border: none;
	border-radius: 6px;
	font-weight: bold;
	cursor: pointer;
	transition: background 0.3s;
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
				<li><a href="indianBrands.jsp" style="color: var(--accent);">Indian
						Brands</a></li>
				<li><a href="spares.jsp">Spares</a></li>
				<li><a href="contact.jsp">Contacts</a></li>
				<li><a href="cart.jsp">Cart 🛒</a></li>
			</ul>
		</nav>
	</header>

	<!-- Page Content -->
	<section>
		<div class="section-title">
			<h2>Indian Car Brands</h2>
			<p>Trusted and affordable Indian automotive excellence</p>
		</div>
		<div class="brand-grid">
			<%
			try {
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM cars WHERE origin='Indian'");
				while (rs.next()) {
					int stock = rs.getInt("quantity");
			%>
			<div class="car-card">
				<img src="<%=rs.getString("image_url")%>"
					alt="<%=rs.getString("brand")%>">
				<h3><%=rs.getString("brand")%>
					-
					<%=rs.getString("model")%></h3>
				<p>
					Fuel:
					<%=rs.getString("fuel_type")%></p>
				<p>
					Price: ₹<%=rs.getString("price")%></p>

				<!-- Buy Button -->
				<!-- Buy Button Form -->
				<form action="buy.jsp" method="get" style="display: inline;">
					<input type="hidden" name="itemId" value="<%=rs.getInt("id")%>">
					<input type="hidden" name="brand"
						value="<%=rs.getString("brand")%>"> <input type="hidden"
						name="model" value="<%=rs.getString("model")%>"> <input
						type="hidden" name="price" value="<%=rs.getString("price")%>">
					<input type="hidden" name="type" value="car">
					<button type="submit" class="buy-btn"
						<%=(stock == 0) ? "disabled" : ""%>>
						<%=(stock == 0) ? "Out of Stock" : "Buy Now"%>
					</button>
				</form>


				<!-- Add to Cart Form -->
				<form action="addToCart" method="post" style="display: inline;">
					<input type="hidden" name="itemId" value="<%=rs.getInt("id")%>">
					<input type="hidden" name="name"
						value="<%=rs.getString("model")%>"> <input type="hidden"
						name="brand" value="<%=rs.getString("brand")%>"> <input
						type="hidden" name="type" value="car"> <input
						type="hidden" name="price" value="<%=rs.getString("price")%>">
					<button type="submit" class="cart-btn"
						<%=(stock == 0) ? "disabled" : ""%>>🛒 Add to Cart</button>
				</form>
			</div>
			<%
			}
			rs.close();
			stmt.close();
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
