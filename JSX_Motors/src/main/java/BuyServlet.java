

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/buy")
public class BuyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        int itemId = Integer.parseInt(request.getParameter("itemId"));
        String type = request.getParameter("type");
        double price = Double.parseDouble(request.getParameter("price"));

        Connection con = null;
        PreparedStatement insertOrder = null;
        PreparedStatement updateStock = null;

        try {
            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to DB
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/carsdb", "root", "root"
            );

            con.setAutoCommit(false); // Start transaction

            // 1. Insert into orders table
            String sqlOrder = "INSERT INTO orders " +
                              "(user_name, email, address, item_id, item_type, quantity, total_price, order_date) " +
                              "VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";

            insertOrder = con.prepareStatement(sqlOrder);
            insertOrder.setString(1, userName);
            insertOrder.setString(2, email);
            insertOrder.setString(3, address);
            insertOrder.setInt(4, itemId);
            insertOrder.setString(5, type);
            insertOrder.setInt(6, 1);
            insertOrder.setDouble(7, price);
            insertOrder.executeUpdate();

            // 2. Reduce stock in respective table
            String table = type.equalsIgnoreCase("car") ? "cars" : "spares";
            String sqlStock = "UPDATE " + table + " SET quantity = quantity - 1 WHERE id = ? AND quantity > 0";

            updateStock = con.prepareStatement(sqlStock);
            updateStock.setInt(1, itemId);

            int updated = updateStock.executeUpdate();

            if (updated == 0) {
                con.rollback();
                request.setAttribute("message", "❌ Out of stock! Purchase failed.");
                request.getRequestDispatcher("buyConfirmation.jsp").forward(request, response);
                return;
            }

            con.commit();

            // ✅ Success response
            request.setAttribute("message", "✅ Order placed successfully!");
            request.setAttribute("userName", userName);
            request.setAttribute("email", email);
            request.setAttribute("address", address);
            request.setAttribute("price", price);
            request.setAttribute("type", type);

            request.getRequestDispatcher("buyConfirmation.jsp").forward(request, response);

        } catch (Exception e) {
            try {
                if (con != null) con.rollback();
            } catch (Exception ignored) {}
            throw new ServletException("Buy failed", e);
        } finally {
            try { if (insertOrder != null) insertOrder.close(); } catch (Exception ignored) {}
            try { if (updateStock != null) updateStock.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
