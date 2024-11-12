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

@WebServlet("/AdminMenu")
public class AdminMenu extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><head><title>Redirecting</title></head><body>");
        out.println("<script>");
        out.println("function redirect1() {");
        out.println("  window.location.href = 'adminhome.html';");
        out.println("}");
        out.println("function redirect2() {");
        out.println("  window.location.href = 'admin.html';");
        out.println("}");
        out.println("</script>");

        String name = request.getParameter("adminname");
        String password = request.getParameter("password");
       
       
        if ("admin".equals(name) && "temp".equals(password)) {
            out.println("<h5>Redirecting in 3 seconds...</h5>");
            out.println("<script>setTimeout(redirect1,3000);</script>");
        } else {
            out.println("<h4 style>Invalid login</h4>");
            out.println("<h5>Redirecting in 3 seconds...</h5>");
            out.println("<script>setTimeout(redirect2, 3000);</script>");
        }


       

        out.println("</body></html>");
    }
}
