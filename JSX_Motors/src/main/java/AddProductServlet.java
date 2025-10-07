import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String type = request.getParameter("type");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        String category = request.getParameter("category");
        String price = request.getParameter("price");
        String qty = request.getParameter("quantity");
        String fuel = request.getParameter("fuel_type");
        String origin = request.getParameter("origin");
        String image = request.getParameter("image_url");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsx", "root", "root");

            if("car".equals(type)) {
                PreparedStatement ps = con.prepareStatement("INSERT INTO cars (brand, model, price, quantity, fuel_type, origin, image_url) VALUES (?, ?, ?, ?, ?, ?, ?)");
                ps.setString(1, brand);
                ps.setString(2, model);
                ps.setBigDecimal(3, new java.math.BigDecimal(price));
                ps.setInt(4, Integer.parseInt(qty));
                ps.setString(5, fuel);
                ps.setString(6, origin);
                ps.setString(7, image);
                ps.executeUpdate();
                ps.close();
            } else {
                PreparedStatement ps = con.prepareStatement("INSERT INTO spares (brand, name, category, price, quantity, image_url) VALUES (?, ?, ?, ?, ?, ?)");
                ps.setString(1, brand);
                ps.setString(2, model);
                ps.setString(3, category);
                ps.setBigDecimal(4, new java.math.BigDecimal(price));
                ps.setInt(5, Integer.parseInt(qty));
                ps.setString(6, image);
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
