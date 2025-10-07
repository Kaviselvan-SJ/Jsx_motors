	
	import java.io.IOException;
	import java.sql.*;
	import javax.servlet.*;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.*;
	
	@WebServlet("/signup")
	public class SignupServlet extends HttpServlet {

	    private static final String DB_URL = "jdbc:mysql://localhost:3306/jsx_motors";
	    private static final String DB_USER = "root";
	    private static final String DB_PASS = "root";

	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        int userId = Integer.parseInt(request.getParameter("userId"));
	        String name = request.getParameter("name");
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");
	        int age = Integer.parseInt(request.getParameter("age"));

	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

	            PreparedStatement check = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
	            check.setString(1, email);
	            ResultSet rs = check.executeQuery();

	            if (rs.next()) {
	                response.getWriter().println("<h3>Email already exists. <a href='Login.jsp'>Login here</a></h3>");
	                return;
	            }

	            PreparedStatement stmt = conn.prepareStatement(
	              "INSERT INTO users (user_id, name, email, password, age) VALUES (?, ?, ?, ?, ?)");
	            stmt.setInt(1, userId);
	            stmt.setString(2, name);
	            stmt.setString(3, email);
	            stmt.setString(4, password);
	            stmt.setInt(5, age);

	            stmt.executeUpdate();
	            conn.close();

	            // Forward user details to JSP
	            request.setAttribute("userId", userId);
	            request.setAttribute("name", name);
	            request.setAttribute("email", email);
	            request.setAttribute("age", age);
	            RequestDispatcher rd = request.getRequestDispatcher("UserDetails.jsp");
	            rd.forward(request, response);

	        } catch (Exception e) {
	            response.getWriter().println("Error: " + e.getMessage());
	        }
	    }
	}

