<!DOCTYPE html>
<html lang="en">

<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>

<%@ include file="jdbc.jsp" %>

<head>
	<title>Bichitra Beauty</title>
	
	<%@ include file="headingdata.jsp" %>
	

</head>
<body class="primary">
	<div class="container">
		
		<%@ include file="navbar.jsp"%>
		<%
		out.println(drawNavBar("index", session));
		%>


		<br><br><br><br><br><br><br>
		<div class="container-fluid text">
			<h1 class="text-center">Bichitra Beauty</h1>
			<h5 class="text-center">Diversity and Self-Expression</h5>
		</div>
		
		<br><br><br>

		<h3 class="centrainer-fluid text">Recently Purchased Products:</h3>
		<%
			
			// Recently the 3 most recently purchased products
			getConnection();

			String sql = "SELECT TOP(3) P.productId, P.productName, P.productDesc, P.productPrice FROM product AS P JOIN orderProduct AS OP ON P.productId = OP.productId JOIN orderSummary AS OS ON OP.orderId = OS.orderId ORDER BY orderDate DESC;";
			PreparedStatement pStatement = con.prepareStatement(sql);

			ResultSet rset = pStatement.executeQuery();

			while(rset.next()) {
				NumberFormat currFormat = NumberFormat.getCurrencyInstance();

				out.println("<div class=\"col-sm-4\">");

				out.println("<img src=displayImage.jsp?id=" + rset.getString(1) + "> <br>");
				out.println("<h4>"+ rset.getString(2) +"</h4>");
				out.println("<p>"+ rset.getString(3) +"</p>");
				out.println("<h5>"+ currFormat.format(rset.getDouble(4)) +"</h5>");
				out.println("<a href=\"addcart.jsp?id="+ rset.getString(1) +"&amp;name="+ rset.getString(2) +"&amp;price="+ rset.getString(4) +"\">Add to Cart</a>");

				out.println("</div>");
			}

			closeConnection();
			

		%>
	</div>
</body>
</html>


