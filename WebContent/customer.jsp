<!DOCTYPE html>
<html lang="en">
<head>
	<title>Customer Page</title>
	
	<%@ include file="headingdata.jsp" %>
</head>
<body class="primary">
<div class="container">

	<%@ include file="auth.jsp"%>
	<%@ page import="java.text.NumberFormat" %>
	<%@ include file="jdbc.jsp" %>

	<%@ include file="navbar.jsp"%>
	<%
	out.println(drawNavBar("customer"));
	%>

	<h1>Your Information:</h1>

	<%
		String userName = (String) session.getAttribute("authenticatedUser");
	%>

	<%
	// TODO: Print Customer information
	String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userId FROM customer WHERE userId = ?;";

	try {
		getConnection();

		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, "arnold");
		ResultSet rset = pstmt.executeQuery();
		rset.next();

		out.println("<table class=\"table table-striped\">");
		out.println("<tr><th>Id</th><td>"+ rset.getString(1) +"</td></tr>");
		out.println("<tr><th>First Name</th><td>"+ rset.getString(2) +"</td></tr>");
		out.println("<tr><th>Last Name</th><td>"+ rset.getString(3) +"</td></tr>");
		out.println("<tr><th>Email</th><td>"+ rset.getString(4) +"</td></tr>");
		out.println("<tr><th>Phone</th><td>"+ rset.getString(5) +"</td></tr>");
		out.println("<tr><th>Address</th><td>"+ rset.getString(6) +"</td></tr>");
		out.println("<tr><th>City</th><td>"+ rset.getString(7) +"</td></tr>");
		out.println("<tr><th>State</th><td>"+ rset.getString(8) +"</td></tr>");
		out.println("<tr><th>Postal Code</th><td>"+ rset.getString(9) +"</td></tr>");
		out.println("<tr><th>Country</th><td>"+ rset.getString(10) +"</td></tr>");
		out.println("<tr><th>User Id</th><td>"+ rset.getString(11) +"</td></tr>");
		out.println("</table>");
		
	} catch(SQLException ex) {
		System.err.println(ex);
	} finally {
		closeConnection();
	}
	

	// Make sure to close connection
	%>

</div>
</body>
</html>

