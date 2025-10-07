import java.io.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String id = request.getParameter("id");
        String type = request.getParameter("type");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsx", "root", "root");

            if("car".equals(type)) {
                PreparedStatement ps = con.prepareStatement("DELETE FROM cars WHERE id=?");
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                ps.close();
            } else {
                PreparedStatement ps = con.prepareStatement("DELETE FROM spares WHERE id=?");
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                ps.close();
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("admin.jsp");
    }
}
