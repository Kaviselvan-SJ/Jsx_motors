import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/jsx_motors";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                if (rs.getString("password").equals(password)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("username", rs.getString("name"));
                    session.setAttribute("userId", rs.getInt("user_id"));

                    response.sendRedirect("home.html");
                } else {
                    response.getWriter().println("<h3>Incorrect password. <a href='Login.jsp'>Try again</a></h3>");
                }
            } else {
                response.getWriter().println("<h3>No account found. <a href='SignUp.jsp'>Sign up</a></h3>");
            }

            conn.close();
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
