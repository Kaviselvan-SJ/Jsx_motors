<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <body>
      <h2>Feedback Summary</h2>
      <table border="1" cellpadding="6" cellspacing="0">
        <tr>
          <th>ID</th><th>Name</th><th>Email</th>
          <th>Subject</th><th>Message</th><th>Rating</th>
        </tr>
        <xsl:for-each select="feedbacks/feedback">
          <tr>
            <td><xsl:value-of select="@id"/></td>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="email"/></td>
            <td><xsl:value-of select="subject"/></td>
            <td><xsl:value-of select="message"/></td>
            <td><xsl:value-of select="rating"/></td>
          </tr>
        </xsl:for-each>
      </table>
    </body>
  </html>
</xsl:template>

</xsl:stylesheet>
