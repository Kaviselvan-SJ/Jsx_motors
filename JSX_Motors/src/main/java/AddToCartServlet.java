

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int itemId = Integer.parseInt(request.getParameter("itemId"));
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        String type = request.getParameter("type"); // "car" or "spare"
        double price = Double.parseDouble(request.getParameter("price"));

        HttpSession session = request.getSession();
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        boolean found = false;
        for (Map<String, Object> item : cart) {
            if ((int) item.get("itemId") == itemId && item.get("type").equals(type)) {
                int qty = (int) item.get("quantity");
                item.put("quantity", qty + 1);
                found = true;
                break;
            }
        }

        if (!found) {
            Map<String, Object> newItem = new HashMap<>();
            newItem.put("itemId", itemId);
            newItem.put("name", name);
            newItem.put("brand", brand);
            newItem.put("type", type);
            newItem.put("price", price);
            newItem.put("quantity", 1);
            cart.add(newItem);
        }

        session.setAttribute("cart", cart);

        response.sendRedirect("cart.jsp");
    }
}
