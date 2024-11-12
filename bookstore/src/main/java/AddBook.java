

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 * Servlet implementation class AddBook
 */

@WebServlet("/AddBook")
public class AddBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddBook() {
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
		
		String bookname=request.getParameter("bookname");
		String bookauthor=request.getParameter("authorname");
		String booklink=request.getParameter("booklink");
		String bookimage=request.getParameter("bookimage");
		
		
		try {
			Connection con=DBConnect.connDB();
			String q="INSERT INTO books(bookname,bookauthor,booklink,bookimage) VALUES (?,?,?,?)";
			PreparedStatement pq=con.prepareStatement(q);
			pq.setString(1, bookname);
			pq.setString(2, bookauthor);
			pq.setString(3, booklink);
			pq.setString(4, bookimage);
			pq.executeUpdate();
			
			out.println("<h2>Added Successfully</h2>");
			out.println("<h3>Go to...<a href=\"adminhome.html\">Admin menu</a></h3>");
		}
		catch(Exception e) {
			out.print(e.getMessage());
		}
	}

}
