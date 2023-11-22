<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
	<title>Bichitra Beauty Shipment Processing</title>

	<%@ include file="headingdata.jsp" %>
</head>
<body>
<div class="container">     
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	String orderId = (String) request.getParameter("orderId");
	
	try {
		getConnection();

		// TODO: Check if valid order id in database
		String sql = "SELECT COUNT(orderId) FROM orderSummary WHERE orderId = ?;";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1,orderId);
		ResultSet rset = pstmt.executeQuery();
		rset.next();

		if(rset.getInt(1) != 1)
			return;

		// TODO: Start a transaction (turn-off auto-commit)
		con.setAutoCommit(false);

		// TODO: Retrieve all items in order with given id
		sql = "SELECT productId, quantity, price FROM orderProduct WHERE orderId = ?;";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, orderId);
		rset = pstmt.executeQuery();

		// TODO: Create a new shipment record.
		sql = "INSERT INTO shipment (shipmentDate, shipmentDesc, warehouseId) VALUES (?,?,?);";
		pstmt = con.prepareStatement(sql);
		pstmt.setTimestamp(1, new java.sql.Timestamp(System.currentTimeMillis()));
		pstmt.setString(2, "");
		pstmt.setString(3, "1");
		pstmt.executeUpdate();
		System.out.println(1);
		
		 while(rset.next()){
			// TODO: For each item verify sufficient quantity available in warehouse 1.
			sql = "SELECT quantity FROM productInventory WHERE productId = ? AND warehouseId = 1;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rset.getString(1));
			ResultSet rset2 = pstmt.executeQuery();
			rset2.next();
			
			// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
			if(rset.getInt(2) > rset2.getInt(1)){ // if quantity requested > inventory
				con.rollback();
				out.println("<h4>Shipment not done. Insufficient inventory for product id: "+ rset.getInt(1) +"</h4>");
				return;
			}

			sql = "UPDATE productInventory SET quantity = ? WHERE productId = ? AND warehouseId = 1;";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rset2.getInt(1) - rset.getInt(2)); // productInventory - quantity requested
			pstmt.setString(2, rset.getString(1));
			pstmt.executeUpdate();

			out.println("<h5>Ordered product: "+ rset.getInt(1) +" Qty: "+ rset.getInt(2) +" Previous inventory: "+ rset2.getInt(1) +" New inventory: "+ (rset2.getInt(1) - rset.getInt(2)) +"</h5>");
			con.commit();
		}		
		out.println("<h4>Shipment Successfully rocessed</h4>");
		// TODO: Auto-commit should be turned back on
		con.setAutoCommit(true);
	} catch (SQLException ex) {
		System.err.println(ex);
	} finally {
		closeConnection();
	}
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</div>
</body>
</html>
