<%@ include file="jdbc.jsp" %>

<%
try {
    if (session.getAttribute("authenticatedUserId") != null) {
        getConnection();
        String sql = "UPDATE review SET reviewRating = ?, reviewDate = ?, reviewComment = ? WHERE customerId = ? AND productId = ?\r\n"
			+ "IF @@ROWCOUNT = 0\r\n"
			+ "INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (?,?,?,?,?);";
        PreparedStatement pstmt = con.prepareStatement(sql);

        pstmt.setString(1,(String) request.getParameter("rating"));
        pstmt.setTimestamp(2, new java.sql.Timestamp(System.currentTimeMillis()));
        pstmt.setString(3, (String) request.getParameter("comment"));
        pstmt.setString(4, (String) session.getAttribute("authenticatedUserId"));
        pstmt.setString(5, (String) request.getParameter("productId"));
        
	
		pstmt.setString(6,(String) request.getParameter("rating"));
        pstmt.setTimestamp(7, new java.sql.Timestamp(System.currentTimeMillis()));
        pstmt.setString(8, (String) session.getAttribute("authenticatedUserId"));
        pstmt.setString(9, (String) request.getParameter("productId"));
        pstmt.setString(10, (String) request.getParameter("comment"));
        
        pstmt.executeUpdate();
        response.sendRedirect("product.jsp?id=" + (String) request.getParameter("productId"));
    } else {
      response.sendRedirect("product.jsp?id=" + (String) request.getParameter("productId"));
    }

} catch (SQLException ex) {
    System.err.println(ex);
} finally {
    closeConnection();
}
%>