<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<title>YOUR NAME Grocery Order List</title>

	<%@ include file="headingdata.jsp" %>
</head>
<body class="primary">
<div class="container">
	
	<%@ include file="navbar.jsp"%>
	<%
	out.println(drawNavBar("listorder", session));
	%>
	
	<h1>Order List</h1>

	<%
		//Note: Forces loading of SQL Server driver
		try
		{	// Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		}
		catch (java.lang.ClassNotFoundException e)
		{
			out.println("ClassNotFoundException: " +e);
		}

		// Useful code for formatting currency values:
		// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		// out.println(currFormat.format(5.0);  // Prints $5.00

		// Make connection
		String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
		String uid = "sa";
		String pw = "304#sa#pw";
		Connection con = null;

		try {
			con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();
			// Write query to retrieve all order summary records
			out.println("<table class=\"table table-striped secondary\"><tbody>");
			out.println("<tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");

			ResultSet rst = stmt.executeQuery("SELECT OS.orderId, OS.orderDate, OS.customerId, C.firstName, C.lastName, SUM(OP.price * OP.quantity) as totalAmount\n" +
					"FROM ordersummary AS OS JOIN orderproduct AS OP ON OS.orderId = OP.orderId\n" +
					"    JOIN CUSTOMER AS C ON C.customerId = OS.customerId\n" +
					"GROUP BY OS.orderId, OS.orderDate, OS.customerId, C.firstname, C.lastname;");

			String sql = "SELECT OP.productId, OP.quantity, OP.Price\n" +
					"FROM orderProduct AS OP \n" +
					"WHERE OP.orderId = ?;";

			PreparedStatement statement = con.prepareStatement(sql);

			// For each order in the ResultSet
			while (rst.next()) {
				out.println("<tr><td>"+ rst.getString(1) +"</td><td>"+ rst.getString(2) +"</td><td>"+ rst.getString(3) +"</td><td>"+ rst.getString(4) + " " + rst.getString(5) +"</td><td>$" + rst.getString(6) + "</td></tr>");
				// Print out the order summary information

				// Write a query to retrieve the products in the order
				//   - Use a PreparedStatement as will repeat this query many times
				statement.setInt(1, rst.getInt(1));
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
			out.println("</tbody></table>");
		} catch (SQLException ex) {
			System.err.println("SQLException: " + ex);
		} finally {
			try {
				if (con != null)
					con.close();
			} catch (Exception e){
				System.err.println("SQLException: " + e);
			}
		}
	%>	
</div>
</body>
</html>

