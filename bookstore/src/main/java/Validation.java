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

@WebServlet("/Validation")
public class Validation extends HttpServlet {
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
        out.println("function redirect1(username, email) {");
        out.println("  window.location.href = 'AvailableBooks?username=' + encodeURIComponent(username) + '&email=' + encodeURIComponent(email);");
        out.println("}");
        out.println("function redirect2() {");
        out.println("  window.location.href = 'login.html';");
        out.println("}");
        out.println("</script>");

        String name = request.getParameter("username");
        String password = request.getParameter("password");
        String email=request.getParameter("email");

        try {
            Connection con = DBConnect.connDB();
            String q = "SELECT name,email,password from users WHERE name=? AND email=? AND password=?";
            PreparedStatement pq = con.prepareStatement(q);
            pq.setString(1, name);
            pq.setString(2, email);
            pq.setString(3, password);
            ResultSet res = pq.executeQuery();
            int f = 0;

            while (res.next()) {
                f = 1;
                out.println("<h5>Redirecting in 3 seconds...</h5>");
                out.println("<script>setTimeout(function() { redirect1('" + name + "','" + email + "'); }, 3000);</script>");
            }

            if (f == 0) {
                out.println("<h4 style>Invalid login</h4>");
                out.println("<h5>Redirecting in 3 seconds...</h5>");
                out.println("<script>setTimeout(redirect2, 3000);</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            
        }

        out.println("</body></html>");
    }
}
