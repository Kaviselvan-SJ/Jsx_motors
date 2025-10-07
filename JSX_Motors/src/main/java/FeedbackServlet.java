import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.xml.XMLConstants;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.validation.*;
import org.w3c.dom.*;

@WebServlet("/feedbackServlet")
public class FeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Save XML outside WAR so it persists
            String xmlPath = System.getProperty("catalina.base") + File.separator + "feedbacks.xml";
            File xmlFile = new File(xmlPath);
         // Print the resolved path in the terminal
            System.out.println("Looking for feedback.xml at: " + xmlFile.getAbsolutePath());
            // XSD stays inside webapp (you put it in webapp/)
            String xsdPath = getServletContext().getRealPath("/feedbacks.xsd");

            // Create XML file if it doesn't exist
            if (!xmlFile.exists()) {
                try (PrintWriter writer = new PrintWriter(xmlFile)) {
                    writer.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                    writer.println("<feedbacks></feedbacks>");
                }
            }

            // Parse existing XML
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            dbf.setNamespaceAware(true);
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(xmlFile);

            // Read form inputs
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String subject = req.getParameter("subject");
            String message = req.getParameter("message");
            String rating = req.getParameter("rating");

            // Create feedback node
            Element root = doc.getDocumentElement();
            Element feedback = doc.createElement("feedback");
            feedback.setAttribute("id", "F" + System.currentTimeMillis());

            Element n = doc.createElement("name");
            n.setTextContent(name);
            feedback.appendChild(n);

            Element e = doc.createElement("email");
            e.setTextContent(email);
            feedback.appendChild(e);

            Element s = doc.createElement("subject");
            s.setTextContent(subject);
            feedback.appendChild(s);

            Element m = doc.createElement("message");
            m.setTextContent(message);
            feedback.appendChild(m);

            Element r = doc.createElement("rating");
            r.setTextContent(rating);
            feedback.appendChild(r);

            root.appendChild(feedback);

            // Validate XML against XSD BEFORE saving
            SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = sf.newSchema(new File(xsdPath));
            Validator validator = schema.newValidator();
            validator.validate(new DOMSource(doc));

            // Save only if valid
            Transformer t = TransformerFactory.newInstance().newTransformer();
            t.setOutputProperty(OutputKeys.INDENT, "yes");
            t.transform(new DOMSource(doc), new StreamResult(xmlFile));

            resp.getWriter().println("✅ Feedback submitted & validated successfully. File saved at: " + xmlPath);
        } catch (Exception ex) {
            resp.getWriter().println("❌ Error: " + ex.getMessage());
        }
    }
}
