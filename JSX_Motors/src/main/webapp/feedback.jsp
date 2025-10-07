<%@ page
	import="javax.xml.parsers.*,javax.xml.transform.*,javax.xml.transform.stream.*,javax.xml.transform.dom.*,org.w3c.dom.*,java.io.*,javax.xml.xpath.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
<title>Feedback - JSX Motors</title>
<link rel="stylesheet" href="home.css" />
<style>
.feedback-section {
	max-width: 900px;
	margin: 40px auto;
	padding: 30px;
	background: #1a1a1a;
	border-radius: 12px;
	color: white;
}

.feedback-form {
	display: grid;
	gap: 15px;
}

.feedback-form input, .feedback-form textarea, .feedback-form select {
	padding: 12px;
	border: 1px solid #444;
	border-radius: 8px;
	background: #222;
	color: white;
}

.feedback-form button {
	background: var(--accent);
	padding: 12px;
	border: none;
	border-radius: 8px;
	color: white;
	cursor: pointer;
}

.feedback-form button:hover {
	background: #b91d2a;
}

.summary {
	margin-top: 30px;
	background: #222;
	padding: 20px;
	border-radius: 8px;
}
</style>
</head>
<body>
	<header>
		<nav>
			<a href="home.jsp" class="logo">JSX<span>Motors</span></a>
			<ul class="nav-links">
				<li><a href="home.html">Home</a></li>
				<li><a href="foreignBrands.jsp">Foreign Brands</a></li>
				<li><a href="indianBrands.jsp">Indian Brands</a></li>
				<li><a href="spares.jsp">Spares</a></li>
				<li><a href="feedback.jsp" style="color: var(--accent);">Feedback</a></li>
				<li><a href="cart.jsp">Cart 🛒</a></li>
			</ul>
		</nav>
	</header>

	<section class="feedback-section">
		<h2>Share Your Feedback</h2>

		<!-- Feedback Form -->
		<form method="post" class="feedback-form">
			<input type="text" name="name" placeholder="Your Name" required>
			<input type="email" name="email" placeholder="Your Email" required>
			<input type="text" name="subject" placeholder="Subject" required>
			<textarea name="message" placeholder="Your Message" required></textarea>
			<select name="rating" required>
				<option value="">Rate Us</option>
				<option value="1">1 - Poor</option>
				<option value="2">2 - Fair</option>
				<option value="3">3 - Good</option>
				<option value="4">4 - Very Good</option>
				<option value="5">5 - Excellent</option>
			</select>
			<button type="submit">Submit Feedback</button>
		</form>

		<%
		String xmlPath = System.getProperty("catalina.base") + File.separator + "feedbacks.xml";
		
		String xslPath = application.getRealPath("/feedbacks.xsl");
		String xsdPath = application.getRealPath("/feedbacks.xsd");

		File xmlFile = new File(xmlPath);
		if (!xmlFile.exists()) {
			try (PrintWriter writer = new PrintWriter(xmlFile)) {
				writer.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				writer.println("<feedbacks></feedbacks>");
			}
		}
		// Handle form submission
		if ("POST".equalsIgnoreCase(request.getMethod())) {
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String subject = request.getParameter("subject");
			String message = request.getParameter("message");
			String rating = request.getParameter("rating");

			try {
				DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
				DocumentBuilder db = dbf.newDocumentBuilder();
				Document doc = db.parse(xmlFile);

				Element root = doc.getDocumentElement();
				Element fb = doc.createElement("feedback");

				// Auto-generate ID: F001, F002...
				int count = root.getElementsByTagName("feedback").getLength() + 1;
				fb.setAttribute("id", "F" + String.format("%03d", count));

				Element e1 = doc.createElement("name");
				e1.setTextContent(name);
				fb.appendChild(e1);
				Element e2 = doc.createElement("email");
				e2.setTextContent(email);
				fb.appendChild(e2);
				Element e3 = doc.createElement("subject");
				e3.setTextContent(subject);
				fb.appendChild(e3);
				Element e4 = doc.createElement("message");
				e4.setTextContent(message);
				fb.appendChild(e4);
				Element e5 = doc.createElement("rating");
				e5.setTextContent(rating);
				fb.appendChild(e5);

				root.appendChild(fb);

				TransformerFactory tf = TransformerFactory.newInstance();
				Transformer t = tf.newTransformer();
				t.transform(new DOMSource(doc), new StreamResult(xmlFile));

				out.println("<p style='color:lightgreen;'>Feedback submitted successfully!</p>");
			} catch (Exception ex) {
				out.println("<p style='color:red;'>Error saving feedback: " + ex.getMessage() + "</p>");
			}
		}

		// Show Feedback Summary with XSLT
		try {
			TransformerFactory tf = TransformerFactory.newInstance();
			Transformer transformer = tf.newTransformer(new StreamSource(xslPath));
			transformer.transform(new StreamSource(xmlFile), new StreamResult(out));
		} catch (Exception e) {
			out.println("<p style='color:red;'>Error generating summary: " + e.getMessage() + "</p>");
		}

		// Example XPath: ratings > 3
		try {
			DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			Document doc = db.parse(xmlFile);
			XPath xpath = XPathFactory.newInstance().newXPath();
			 NodeList nodes = (NodeList) xpath.evaluate("/feedbacks/feedback[rating>3]", doc, XPathConstants.NODESET);

			out.println("<div class='summary'><h3>Users with Ratings > 3</h3><ul>");
		    for (int i = 0; i < nodes.getLength(); i++) {
		        Element fb = (Element) nodes.item(i);
		        String name = fb.getElementsByTagName("name").item(0).getTextContent();
		        String rating = fb.getElementsByTagName("rating").item(0).getTextContent();
		        out.println("<li>" + name + " (Rating: " + rating + ")</li>");
		    }
		    out.println("</ul></div>");
		} catch (Exception e) {
			out.println("<p style='color:red;'>XPath error: " + e.getMessage() + "</p>");
		}
		%>
	</section>

	<footer>
		<div class="footer-bottom">&copy; 2025 JSX Motors. All Rights
			Reserved.</div>
	</footer>
</body>
</html>
