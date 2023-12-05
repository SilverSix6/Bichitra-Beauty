<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <title>Ray's Grocery - Product Information</title>
    
    <%@ include file="headingdata.jsp" %>
</head>

<body>
<div class="container">

    <%@ include file="navbar.jsp"%>
    <%
	out.println(drawNavBar("", session));
	%>

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
        out.println("<p>"+ rset.getString(4) +"</p>");
        out.println("<h5><a href=\"listprod.jsp\">Continue Shopping</h5>");
        out.println("<h5><a href=\"addcart.jsp?id=" + productId + "&amp;name=" + rset.getString(1) + "&amp;price=" + rset.getString(2) + "\">Add to Cart</a></h5>");
    } catch (SQLException ex) {
        System.err.println(ex);
    } finally {
        closeConnection();
    }
    %>

    <h3>Write a Review:</h3>
    <form class="form-group" method="get" action="review.jsp">
        <input type="hidden" name="productId" value="<%= request.getParameter("id") %>">
        <input type="radio" id="1" name="rating" value="1">
        <label for="1">1☆</label>
        <input type="radio" id="2" name="rating" value="2">
        <label for="1">2☆</label>
        <input type="radio" id="3" name="rating" value="3">
        <label for="1">3☆</label>
        <input type="radio" id="4" name="rating" value="4">
        <label for="1">4☆</label>
        <input type="radio" id="5" name="rating" value="5">
        <label for="1">5☆</label>
        <input type="text" class="form-control form-control-lg" name="comment" placeholder="Write your review">
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>

    <h3>Reviews:</h3>
    <%
    
    try {
        getConnection();

        sql = "SELECT reviewRating, reviewDate, reviewComment FROM review WHERE productId = ?;";
        PreparedStatement pstmt = con.prepareStatement(sql);

        pstmt.setString(1, request.getParameter("id"));

        ResultSet rset = pstmt.executeQuery();

        out.println("<table class='table table-striped'><tbody><tr><th>Rating</th><th>Comment</th><th>Review Date</th></tr>");
        while(rset.next()) {
            out.println("<tr><td>");
            for(int i = 0; i < rset.getInt(1); i++){
                out.print("★");
            }
            out.print("</td><td>"+ rset.getString(3) +"</td><td>"+ rset.getString(2) +"</td></tr>");
        }
        out.println("</tbody></table>");

    } catch (SQLException ex) {
        System.err.println(ex);
    } finally {
        closeConnection();
    }

    %>
</div>
</body>
</html>

