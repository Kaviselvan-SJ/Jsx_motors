

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ViewBooksAdmin
 */
@WebServlet("/ViewBooksAdmin")
public class ViewBooksAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewBooksAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		
		out.println("<html><head><title>Available Books</title>");
        out.println("<style>");
        out.println("body {font-family: Arial, sans-serif;margin: 20px;padding: 0;background-color: #f4f4f4;}");
        out.println("header {background-color: #333;color: #fff;padding: 10px;text-align: center;}");
        out.println(".container {max-width: 800px;margin: 20px auto;background-color: #fff;padding: 20px;border-radius: 5px;box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);}");
        out.println("h3, h4 {color: #333;}");
        out.println("hr {margin: 15px 0;border: 0;border-top: 1px solid #ccc;}");
        out.println("p {margin: 10px 0;}");
        out.println("button {background-color: #4caf50;color: #fff;padding: 10px 15px;border: none;border-radius: 4px;cursor: pointer;font-size: 14px;}");
        out.println("button:hover {background-color: #45a049;}");
        out.println("</style>");
        out.println("</head><body>");

        out.println("<header>");
        out.println("<h1>Available Books <a href='index.html' style='float: right; margin-top: 10px; text-decoration: none; padding: 10px; background-color: #4caf50; color: #fff; border-radius: 5px; font-size:20px'>Logout</a></h1>");
        //out.println("<a href='login.html' style='float: right; margin-top: 10px; text-decoration: none; padding: 10px; background-color: #4caf50; color: #fff; border-radius: 5px;'>Logout</a>");
        out.println("</header>");
        
        out.println("<div class='container'>");   
        out.println("<h3>Delete Book</h3>");
        out.println("<form method='post' action='ViewBooksAdmin'>");
        out.println("<label for='deleteBookName'>Book Name:</label>");
        out.println("<input type='text' id='deleteBookName' name='deleteBookName' required style='padding: 8px; margin-right: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;'>");
        out.println("<button type='submit' style='background-color: #e74c3c; color: #fff; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-size: 14px;'>Delete</button>");
        out.println("</form>");


        
		
		try {
			Connection con=DBConnect.connDB();
			String q1="SELECT * from books";
			PreparedStatement pq1=con.prepareStatement(q1);
			ResultSet rs=pq1.executeQuery();
			int f=0;

	        while (rs.next()) {
	            f=1;
	            String bookName = rs.getString(1);
	            String bookAuthor=rs.getString(2);
	            String bookLink = rs.getString(3);
	            String bookImage=rs.getString(4);
	            
	             
	            out.println("<hr>");
	            out.println("<h4>Book Details</h4>");
	            out.println("<img src='"+bookImage+"' alt=\"Girl in a jacket\" width=\"100\" height=\"100\">");
	            out.println("<p><strong>Book Name:</strong> " + bookName + "</p>");
	            out.println("<p><strong>Author:</strong> " + bookAuthor + "</p>");     
	               
	        }

	        if(f==0) {
	            out.println("<hr>");
	            out.println("<h4>No books available</h4>");
	        }
	        else {
	        	out.println("<hr>");
	        }
	        
	        pq1.close();
	        con.close();
			
		}
		catch(Exception e) {
			out.print(e.getMessage());
		}
		
		out.println("</div></body></html>");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		 String deleteBookName = request.getParameter("deleteBookName");
	        if (deleteBookName != null && !deleteBookName.isEmpty()) {
	            try {
	                Connection con = DBConnect.connDB();
	                String deleteQuery = "DELETE FROM books WHERE bookName = ?";
	                PreparedStatement deleteStatement = con.prepareStatement(deleteQuery);
	                deleteStatement.setString(1, deleteBookName);

	                int rowsAffected = deleteStatement.executeUpdate();

	                if (rowsAffected > 0) {
	                    out.println("<p style='color: green;'>Book '" + deleteBookName + "' deleted successfully!</p>");
	                } else {
	                    out.println("<p style='color: red;'>Book '" + deleteBookName + "' not found!</p>");
	                }

	                deleteStatement.close();
	                con.close();
	            } catch (Exception e) {
	                out.print(e.getMessage());
	            }
	        }
	}

}
