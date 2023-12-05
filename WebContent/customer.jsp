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
	out.println(drawNavBar("customer", session));
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
		pstmt.setString(1, userName);
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
		

		out.println("<h1>Your Orders:</h1>");

		out.println("<table class=\"table table-striped secondary\">");
		out.println("<tr><th>Order Id</th><th>Order Date</th><th>Total Amount</th></tr>");

		sql = "SELECT OS.orderId, OS.orderDate, SUM(OP.price * OP.quantity) as totalAmount\n" +
				"FROM ordersummary AS OS JOIN orderproduct AS OP ON OS.orderId = OP.orderId\n" +
				"WHERE OS.customerId = ?\n" +
				"GROUP BY OS.orderId, OS.orderDate;";

		pstmt = con.prepareStatement(sql);

		pstmt.setNString(1, rset.getString(1));

		rset = pstmt.executeQuery();


		sql = "SELECT OP.productId, OP.quantity, OP.Price\n" +
				"FROM orderProduct AS OP \n" +
				"WHERE OP.orderId = ?;";

		PreparedStatement statement = con.prepareStatement(sql);

		// For each order in the ResultSet
		while (rset.next()) {
			out.println("<tr><td>"+ rset.getString(1) +"</td><td>"+ rset.getString(2) +"</td><td>$"+ rset.getString(3) +"</td></tr>");
			// Print out the order summary information

			// Write a query to retrieve the products in the order
			//   - Use a PreparedStatement as will repeat this query many times
			statement.setInt(1, rset.getInt(1));
			ResultSet rst2 = statement.executeQuery();
			out.println("<tr align=\"right\"><td><table class=\"table table-bordered table-striped secondary\"><tbody>");
			out.println("<tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
			while (rst2.next()){
				// For each product in the order
				// Write out product information
				out.println("<tr><td>"+ rst2.getString(1) +"</td><td>"+ rst2.getString(2) +"</td><td>$"+ rst2.getString(3) +"</td></tr>");
			}
			out.println("</tbody></table></td></tr>");
		}
		out.println("</table>");


	} catch (SQLException ex) {
		System.err.println(ex);
	} finally {
		closeConnection();
	}
	%>

</div>
</body>
</html>

