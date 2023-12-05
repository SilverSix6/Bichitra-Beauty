<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
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
	out.println(drawNavBar("listprod", session));
	%>
	
	<h1>Search for the products you want to buy:</h1>

	<form method="get" action="listprod.jsp">
	<input type="text" name="productName" size="50">
	<select id="category" name="Category">
		<option value="category">Category:</option>
		<% 
			// Get all orders
			
			//Note: Forces loading of SQL Server driver
			try
			{	// Load driver class
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			}
			catch (java.lang.ClassNotFoundException e)
			{
				out.println("ClassNotFoundException: " +e);
			}

			getConnection();

			String sql = "SELECT categoryName FROM category";
			PreparedStatement pStatement = con.prepareStatement(sql);

			ResultSet rset = pStatement.executeQuery();

			while(rset.next()) {
				out.print("<option value=\""+ rset.getString(1) +"\">"+ rset.getString(1) +"</option>");
			}
			closeConnection();
		%>	
	</select>
	<input type="submit" value="Submit"><input type="reset" value="Reset">
	</form>


	<h2>All Products</h2>
	<table class='table table-striped'><tbody><tr><th></th><th>Product Name</th><th>Price</th></tr>
	<% // Get product name to search for
		String name = request.getParameter("productName");
		String category = request.getParameter("Category");

		getConnection();

		if (java.util.Objects.equals(category, "category") || category == null){
			sql = "SELECT productId, productName, productPrice FROM product WHERE productName like CONCAT('%', ? ,'%')";
			pStatement = con.prepareStatement(sql);
			pStatement.setNString(1, name);
		} else {
			sql = "SELECT productId, productName, productPrice FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName like CONCAT('%', ? ,'%') AND categoryName = ?";
			pStatement = con.prepareStatement(sql);
			pStatement.setNString(1, name);
			pStatement.setNString(2, category);
		}

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		rset = pStatement.executeQuery();
		// Print out the ResultSet
		while(rset.next()){
			// For each product create a link of the form
			// addcart.jsp?id=productId&name=productName&price=productPrice
			out.print("<tr><td><a href=\"addcart.jsp?id=" + rset.getString(1) + "&amp;name=" + rset.getString(2) + "&amp;price=" + rset.getString(3) + "\">Add to Cart</a></td><td><a href=\"product.jsp?id=" + rset.getString(1) + "\">" + rset.getString(2) + "</a></td><td>" + currFormat.format(rset.getDouble(3)) + "</td></tr>");
		}

		closeConnection();

		// Useful code for formatting currency values:
		// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		// out.println(currFormat.format(5.0);	// Prints $5.00
	%>
	</tbody></table>
</div">
</body>
</html>