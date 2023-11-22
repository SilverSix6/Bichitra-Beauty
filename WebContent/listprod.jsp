<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<title>YOUR NAME Grocery</title>
	
	<%@ include file="headingdata.jsp" %>
</head>
<body class="primary">
<div class="container">
	
	<%@ include file="navbar.jsp"%>
	<%
	out.println(drawNavBar("listprod"));
	%>
	
	<h1>Search for the products you want to buy:</h1>

	<form method="get" action="listprod.jsp">
	<input type="text" name="productName" size="50">
	<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
	</form>


	<h2>All Products</h2>
	<table class='table table-striped'><tbody><tr><th></th><th>Product Name</th><th>Price</th></tr>
	<% // Get product name to search for
		String name = request.getParameter("productName");
				
		//Note: Forces loading of SQL Server driver
		try
		{	// Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		}
		catch (java.lang.ClassNotFoundException e)
		{
			out.println("ClassNotFoundException: " +e);
		}

		// Variable name now contains the search string the user entered
		// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!
		Connection con = null;
		String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
		String uid = "sa";
		String pw = "304#sa#pw";


		try{
			// Make the connection
			con = DriverManager.getConnection(url, uid, pw);
			String sql = "SELECT productId, productName, productPrice FROM product WHERE productName like CONCAT('%', ? ,'%')";
			PreparedStatement pStatement = con.prepareStatement(sql);
			pStatement.setNString(1, name);

			NumberFormat currFormat = NumberFormat.getCurrencyInstance();

			ResultSet rset = pStatement.executeQuery();
			// Print out the ResultSet
			while(rset.next()){
				// For each product create a link of the form
				// addcart.jsp?id=productId&name=productName&price=productPrice
				out.print("<tr><td><a href=\"addcart.jsp?id=" + rset.getString(1) + "&amp;name=" + rset.getString(2) + "&amp;price=" + rset.getString(3) + "\">Add to Cart</a></td><td><a href=\"product.jsp?id=" + rset.getString(1) + "\">" + rset.getString(2) + "</a></td><td>" + currFormat.format(rset.getDouble(3)) + "</td></tr>");
			}
			
		} catch (SQLException ex) {
			System.err.println(ex);
		} finally {
			try {
				// Close connection
				if (con != null)
					con.close();
			} catch (SQLException ex){
				System.err.println(ex);
			}
		}
		
		// Useful code for formatting currency values:
		// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		// out.println(currFormat.format(5.0);	// Prints $5.00
	%>
	</tbody></table>
</div">
</body>
</html>