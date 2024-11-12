

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DBconnect
 */
@WebServlet("/DBConnect")
public class DBConnect extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public static Connection connDB() {
		Connection con=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","root");
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	   
   }

}
