<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<title>YOUR NAME Grocery Order Processing</title>

	<%@ include file="headingdata.jsp" %>
</head>
<body>
<div class="container">
<% 
	// Get customer id
	String custId = request.getParameter("customerId");
	@SuppressWarnings({"unchecked"})
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");


	

	// Make connection
	Connection con = null;
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw";



	try {
		// Determine if valid customer id was entered
		// If either are not true, display an error message	
		int userid = Integer.parseInt(custId);


		con = DriverManager.getConnection(url,uid,pw);
		String sql = "SELECT COUNT(customerId) FROM customer WHERE customerId = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1,userid);
		ResultSet rset = pstmt.executeQuery();
		rset.next();
		
		if(rset.getInt(1) == 0)
			throw new NumberFormatException();


		// Determine if there are products in the shopping cart
		if(productList.isEmpty())
			throw new Exception();

		double orderTotal = 0;

		// Save order information to database
		sql = "INSERT INTO ordersummary(orderDate, totalAmount, customerId) VALUES (?, 0, ?)";
		pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
		pstmt.setTimestamp(1, new java.sql.Timestamp(System.currentTimeMillis()));
		pstmt.setInt(2, userid);
		pstmt.executeUpdate();

		// Use retrieval of auto-generated keys.
		ResultSet keys = pstmt.getGeneratedKeys();
		keys.next();
		int orderId = keys.getInt(1);
		
	
		// Insert each item into OrderProduct table using OrderId from previous INSERT
		sql = "INSERT INTO orderproduct(orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
		pstmt = con.prepareStatement(sql);

		// Here is the code to traverse through a HashMap
		// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		while (iterator.hasNext())
		{ 
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			String productId = (String) product.get(0);
			String price = (String) product.get(2);
			double pr = Double.parseDouble(price);
			int qty = ( (Integer)product.get(3)).intValue();

			pstmt.setInt(1, orderId);
			pstmt.setString(2, productId);
			pstmt.setInt(3, qty);
			pstmt.setDouble(4, pr);

			pstmt.executeUpdate();

			orderTotal += pr * (double)qty;
		}

		// Update total amount for order record
		sql = "UPDATE ordersummary SET totalAmount = ? WHERE orderId = ?";
		pstmt = con.prepareStatement(sql);

		pstmt.setDouble(1, orderTotal);
		pstmt.setInt(2, orderId);
		pstmt.executeUpdate();
		
		// Print out order summary
		out.println("<h1>Your Order Summary</h1>");
		sql = "SELECT OP.productId, P.productName, OP.quantity, OP.price, OP.quantity * OP.price AS subtotal " +
			"FROM orderProduct AS OP JOIN product AS P ON OP.productId = P.productId " +
			"WHERE OP.orderId = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1,orderId);
		rset = pstmt.executeQuery();
		
		out.println("<table><tbody><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
		while (rset.next()){
			out.println("<tr><td>" + rset.getString(1) + "</td>");
			out.println("<td>" + rset.getString(2) + "</td>");
			out.println("<td>" + rset.getString(3) + "</td>");
			out.println("<td>" + rset.getString(4) + "</td>");
			out.println("<td>" + rset.getString(5) + "</td></tr>");
		} 
		out.println("<tr><th>Order Total:</th><td>" + orderTotal + "</td></tr>");
		out.println("</tbody></table>");

		out.println("<h1>Order Completed!<h1><br><h1>Your order is on the way</h1>");
		out.println("<h1>Order Confirmation Number: " + orderId + "</h1>");
		out.println("<h1>Customer ID: " + custId + "</h1>");


		// Clear cart if order placed successfully
		session.removeAttribute("productList");

	} catch (SQLException ex) {
		System.err.println(ex); 
	} catch (NumberFormatException ex) {
		out.println("<h1>Invalid userid. Either The input is not a number, or the entered user does not exist</h1>");
	} catch (Exception ex) {
		out.println("<h1>Your shopping cart is empty!</h1>");
	}
	finally {
		try {
			if (con != null)
				con.close();
		} catch (SQLException ex) {
			System.err.println(ex);
		}
	}
		
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>


</div>
</body>
</html>

