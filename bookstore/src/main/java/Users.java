

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/Users")
public class Users extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Users() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		String name=request.getParameter("username");
		String email=request.getParameter("email");
		String cl=request.getParameter("class");
		String password=request.getParameter("password");
		try {
			Connection con=DBConnect.connDB();
			String q="INSERT INTO users(name,email,class,password) VALUES(?,?,?,?)";
			PreparedStatement pq=con.prepareStatement(q);
			pq.setString(1, name);
			pq.setString(2, email);
			pq.setString(3, cl);
			pq.setString(4, password);
			pq.executeUpdate();
			out.println("<h1>Registered Successfully</h1>");
			out.println("<p>Go to...<a href='login.html'>Login page</a></p>");
		}
		catch(Exception e) {
			out.print(e.getMessage());
		}
	}

}
