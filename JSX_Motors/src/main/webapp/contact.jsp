<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Contact Us - JSX Motors</title>
  <link rel="stylesheet" href="home.css" />
  <style>
    .contact-section {
      max-width: 900px;
      margin: 50px auto;
      padding: 30px;
      background: #1a1a1a;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.4);
    }
    .contact-section h2 {
      color: var(--accent);
      margin-bottom: 15px;
      text-align: center;
    }
    .contact-section p {
      text-align: center;
      margin-bottom: 25px;
    }
    .contact-form {
      display: grid;
      gap: 15px;
    }
    .contact-form input, .contact-form textarea {
      padding: 12px;
      border: 1px solid #444;
      border-radius: 8px;
      background: #222;
      color: white;
      font-size: 16px;
      width: 100%;
    }
    .contact-form textarea { resize: vertical; height: 120px; }
    .contact-form button {
      background: var(--accent);
      border: none;
      padding: 12px;
      border-radius: 8px;
      color: white;
      font-weight: bold;
      cursor: pointer;
      transition: background 0.3s;
    }
    .contact-form button:hover {
      background: #b91d2a;
    }
    .contact-info {
      margin-top: 30px;
      text-align: center;
    }
    .contact-info p { margin: 5px 0; }
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
        <li><a href="contact.jsp" style="color: var(--accent);">Contacts</a></li>
        <li><a href="cart.jsp">Cart 🛒</a></li>
      </ul>
    </nav>
  </header>

  <!-- Contact Form Section -->
  <section class="contact-section">
    <h2>Get in Touch</h2>
    <p>We’d love to hear from you! Fill out the form below and we’ll get back to you soon.</p>
    
    <form action="contactFormServlet" method="post" class="contact-form">
      <input type="text" name="name" placeholder="Your Name" required>
      <input type="email" name="email" placeholder="Your Email" required>
      <input type="text" name="subject" placeholder="Subject" required>
      <textarea name="message" placeholder="Your Message" required></textarea>
      <button type="submit">Send Message</button>
    </form>

    <!-- Static Contact Info -->
    <div class="contact-info">
      <h3>Our Office</h3>
      <p>Email: support@jsxmotors.com</p>
      <p>Phone: +91 98765 43210</p>
      <p>Address: JSX Motors HQ, Bangalore, India</p>
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
