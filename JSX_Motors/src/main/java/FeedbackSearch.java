import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.xml.parsers.*;
import javax.xml.xpath.*;
import org.w3c.dom.*;

@WebServlet("/FeedbackSearch")
public class FeedbackSearch extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            File xmlFile = new File(System.getProperty("catalina.base") + File.separator + "feedbacks.xml");
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            org.w3c.dom.Document doc = builder.parse(xmlFile);

            XPath xpath = XPathFactory.newInstance().newXPath();

            // ⭐ Users with rating > 3
            NodeList highRatingNodes = (NodeList) xpath.evaluate("/feedbacks/feedback[rating>3]", doc, XPathConstants.NODESET);
            out.println("<h2>High Ratings (>3)</h2><ul>");
            for (int i = 0; i < highRatingNodes.getLength(); i++) {
                Element fb = (Element) highRatingNodes.item(i);
                String name = fb.getElementsByTagName("name").item(0).getTextContent();
                String rating = fb.getElementsByTagName("rating").item(0).getTextContent();
                out.println("<li>" + name + " (Rating: " + rating + ")</li>");
            }
            out.println("</ul>");

            

        } catch (Exception e) {
            throw new ServletException("Error processing feedback search", e);
        }
    }
}
