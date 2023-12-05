<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<%@ include file="jdbc.jsp" %>

<%! 
public void saveCart(HashMap<String, ArrayList<Object>> productList, String customerId){
	String sqlDelete = "DELETE FROM incart WHERE customerId = ?\r\n";
	String sqlAdd = "INSERT INTO incart(customerId, productId, quantity, price) VALUES (?,?,?,?);";
	try {
		getConnection();
		
		// Remove all previous products in cart
		PreparedStatement pstmt = con.prepareStatement(sqlDelete);
		pstmt.setString(1,customerId);
		pstmt.executeUpdate();

		// Add current shopping cart
		pstmt = con.prepareStatement(sqlAdd);

		for(ArrayList<Object> product: productList.values()) {

			pstmt.setString(1,customerId);
			pstmt.setString(2,(String)product.get(0));
			pstmt.setInt(3,(Integer)product.get(3));
			pstmt.setString(4,(String)product.get(2));

			pstmt.executeUpdate();
		}
	} catch(SQLException ex) {
		System.err.println(ex);
	} finally {
		closeConnection();
	}
}
%>

<%! 
public HashMap<String, ArrayList<Object>> loadCart(String customerId){
	HashMap<String, ArrayList<Object>> productList = new HashMap<String, ArrayList<Object>>();
	String sql = "SELECT C.productId, P.productName, C.price, C.quantity \r\n"
		+ "FROM incart AS C JOIN product AS P ON C.productId = P.productId\r\n"
		+ "WHERE C.customerId = ?;";
	try {
		getConnection();

		PreparedStatement pstmt = con.prepareStatement(sql);

		pstmt.setNString(1,customerId);

		ResultSet rset = pstmt.executeQuery();
		while (rset.next()) {
			ArrayList<Object> product = new ArrayList<Object>();
			product.add(rset.getString(1));
			product.add(rset.getString(2));
			product.add(rset.getString(3));
			product.add(rset.getInt(4));
			productList.put(rset.getString(1),product);
		}

	} catch(SQLException ex){
		System.err.println(ex);
	} finally {
		closeConnection();
	}
	return productList;
}
%>