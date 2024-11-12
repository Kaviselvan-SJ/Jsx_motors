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

@WebServlet("/AvailableBooks")
public class AvailableBooks extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("username");
        String email = request.getParameter("email");

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
        out.println("<h3>User Details</h3>");
        out.println("<p>UserName: " + name + "</p>");
        out.println("<p>Email: " + email + "</p>");
        
        if(name==null || email==null) {
        	response.sendRedirect("index.html");
        }
        
        
        out.println("<hr>");
        out.println("<h3>Search Books</h3>");
        out.println("<form method='post' action='AvailableBooks?username=" + name + "&email=" + email + "'>");
        out.println("<input type='text' id='search' name='search' required style='padding: 8px; margin-right: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;'>");
        out.println("<button type='submit' style='background-color: #e74c3c; color: #fff; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-size: 14px;'>Search</button>");
        out.println("</form>");
        //out.println("<hr>");
        try {
            Connection con = DBConnect.connDB();
            String q = "SELECT * from books";
            PreparedStatement pstmt = con.prepareStatement(q);
            ResultSet rs = pstmt.executeQuery();
            
            int f=0;

            while (rs.next()) {
            	f=1;
                String bookName = rs.getString(1);
                String bookAuthor=rs.getString(2);
                String bookLink = rs.getString(3);
                String bookImage=rs.getString(4);
                
                out.println("<hr>");
                out.println("<h4>Book Details</h4>");
                out.println("<img src='"+bookImage+"' alt=\"No Image\" width=\"100\" height=\"100\">");
                out.println("<p><strong>Book Name:</strong> " + bookName + "</p>");
                out.println("<p><strong>Author:</strong> " + bookAuthor + "</p>");
                out.println("<button onclick=\"downloadBook('" + bookLink + "')\">Download</button>");
                
            }

            if(f==0) {
            	 out.println("<hr>");
            	out.println("<h4>No books available</h4>");
            }
            else {
	        	out.println("<hr>");
	        }
            
            out.println("<script>");
            out.println("function downloadBook(link) {");
            out.println("  window.location.href = link;");
            out.println("}");
            out.println("</script>");

          
            
            pstmt.close();
            con.close();

        } catch (Exception e) {
            out.print(e.getMessage());
        }
        out.println("</div></body></html>");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
    	response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("username");
        String email = request.getParameter("email");

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
        out.println("<script>");
        out.println("  function redirect1(username, email) {");
        out.println("    window.location.href = 'AvailableBooks?username=' + encodeURIComponent(username) + '&email=' + encodeURIComponent(email);");
        out.println("  }");
        out.println("</script>");
        out.println("</head><body>");

        out.println("<header>");
        out.println("<h1>Available Books <a href='index.html' style='float: right; margin-top: 10px; text-decoration: none; padding: 10px; background-color: #4caf50; color: #fff; border-radius: 5px; font-size:20px'>Logout</a></h1>");
        //out.println("<a href='login.html' style='float: right; margin-top: 10px; text-decoration: none; padding: 10px; background-color: #4caf50; color: #fff; border-radius: 5px;'>Logout</a>");
        out.println("</header>");
        
        out.println("<div class='container'>");
        out.println("<h3>User Details</h3>");
        out.println("<p>UserName: " + name + "</p>");
        out.println("<p>Email: " + email + "</p>");
        
//        if(name==null || email==null) {
//        	response.sendRedirect("login.html");
//        }
        
        
        out.println("<hr>");
        out.println("<h3>View Books</h3>");
        out.println("<form method='post' action='AvailableBooks'>");
        out.println("<button type='button' style='background-color: #3498db; color: #fff; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-size: 14px;' onclick='goBack()'>View All Books</button>");

        out.println("</form>");

      
        //out.println("<hr>");
        
        try {
        	
            Connection con = DBConnect.connDB();
            String s=request.getParameter("search");
            String q = "SELECT * from books WHERE bookname LIKE ? OR bookname LIKE ? OR bookname LIKE ?";
            PreparedStatement pq = con.prepareStatement(q);
            String s1=s+'%';
            String s2='%'+s;
            String s3='%'+s+'%';
            
            pq.setString(1,s1);
            pq.setString(2, s2);
            pq.setString(3, s3);
            
            ResultSet rs = pq.executeQuery();
            
            int f=0;

            while (rs.next()) {
            	f=1;
                String bookName = rs.getString(1);
                String bookAuthor=rs.getString(2);
                String bookLink = rs.getString(3);
                String bookImage=rs.getString(4);
                
                out.println("<hr>");
                out.println("<h4>Book Details</h4>");
                out.println("<img src='"+bookImage+"' alt=\"No Image\" width=\"100\" height=\"100\">");
                out.println("<p><strong>Book Name:</strong> " + bookName + "</p>");
                out.println("<p><strong>Author:</strong> " + bookAuthor + "</p>");
                out.println("<button onclick=\"downloadBook('" + bookLink + "')\">Download</button>");
                //out.println("<h4>"+bookLink+"</h4>");
                
            }

            if(f==0) {
            	 out.println("<hr>");
            	out.println("<h4>No books available</h4>");
            }
            else {
	        	out.println("<hr>");
	        }
           
           
            out.println("<script>");
            out.println("function goBack() {");
            out.println("  window.history.back();");
            out.println("}");
            out.println("function downloadBook(link) {");
            out.println("  window.location.href = link;");
            out.println("}");
            out.println("</script>");

         
            
            pq.close();
            con.close();

        } catch (Exception e) {
            out.print(e.getMessage());
        }

        out.println("</div></body></html>");
		
	}
}
