<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");

String sql = "SELECT productName, productPrice, productImageURL, productDesc FROM product WHERE productId = ?;";
try{
    getConnection();

    PreparedStatement statement = con.prepareStatement(sql);
    statement.setString(1,productId);
    ResultSet rset = statement.executeQuery();
    rset.next();

    out.println("<h1>"+ rset.getString(1) +"</h1><br>");

    // TODO: If there is a productImageURL, display using IMG tag
    if(rset.getString(3) != null)
        out.println("<img src=\""+ rset.getString(3) +"\">");

    // TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
    out.println("<img src=displayImage.jsp?id=" + productId + "> <br>");

    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    out.println("<h5>Price: "+ currFormat.format(rset.getDouble(2)) +"</h5>"); // Price
    out.println("<h5>Product Id:"+ productId +" </h5>"); //ProductId

    // TODO: Add links to Add to Cart and Continue Shopping
    out.println("<h5><a href=\"listprod.jsp\">Continue Shopping</h5>");
    out.println("<h5><a href=\"addcart.jsp?id=" + productId + "&amp;name=" + rset.getString(1) + "&amp;price=" + rset.getString(2) + "\">Add to Cart</a></h5>");
} catch (SQLException ex) {
    System.err.println(ex);
} finally {
    closeConnection();
}
%>

</body>
</html>

