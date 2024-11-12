import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewUsers")
public class ViewUsers extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ViewUsers() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        try {
            Connection con = DBConnect.connDB();
            int userCount = 0;
            String countQuery = "SELECT COUNT(*) from users";
            PreparedStatement countStatement = con.prepareStatement(countQuery);
            ResultSet countResult = countStatement.executeQuery();
            while (countResult.next()) {
                userCount = countResult.getInt(1);
            }

           
            out.println("<html>");
            out.println("<head>");
            out.println("<link rel='stylesheet' type='text/css' href='viewusers.css'>");
            out.println("</head>");
            out.println("<body>");
            
            out.println("<header style=\"background-color: #333;color: #fff;padding: 10px;text-align: center;\">");
            out.println("<h1>LIST OF USERS</h1>");
            out.println("</header>");
            out.println("<div class='container'>");
            out.println("<h4>Total Users: " + userCount + "</h4>");

            
            String q = "SELECT name,email,class from users";
            PreparedStatement pq = con.prepareStatement(q);
            ResultSet userResult = pq.executeQuery();
            out.println("<h3>List of Users: </h3>");
            out.println("<table>");
            out.println("<tr><th>Name</th><th>Email</th><th>Class</th></tr>");
            while (userResult.next()) {
                out.println("<tr>");
                out.println("<td>" + userResult.getString("name") + "</td>");
                out.println("<td>" + userResult.getString("email") + "</td>");
                out.println("<td>" + userResult.getString("class") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
