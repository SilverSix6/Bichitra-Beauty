<%@ page import="java.text.NumberFormat" %>

<!DOCTYPE html>
<html>
<head>
    <title>Administrator Page</title>

    <%@ include file="headingdata.jsp" %>
</head>
<body class="primary">
<div class="container">

    <%@ include file="jdbc.jsp"%>
    <%@ include file="auth.jsp"%>

    <%@ include file="navbar.jsp"%>
	<%
	out.println(drawNavBar("admin"));
	%>

    <h1>Administrator Sales Reports By Day</h1>
    <%

    // TODO: Write SQL query that prints out total order amount by day
    String sql = "SELECT CAST(orderDate AS DATE) AS date, SUM(totalAmount) AS totalOrderAmount FROM orderSummary GROUP BY CAST(orderDate AS DATE) ORDER BY date DESC;";

    try {
        getConnection();

        ResultSet rset = con.createStatement().executeQuery(sql);

        NumberFormat currFormat = NumberFormat.getCurrencyInstance();

        out.println("<table class=\"table table-striped\">");
        out.println("<tr><th>Order Date</td><th>Total Order Amount</td></tr>");
        while (rset.next()){
            out.println("<tr><td>"+ rset.getString(1) +"</td><td>"+ currFormat.format(rset.getInt(2)) +"</td></tr>");
        }
        out.println("</table>");


    } catch(SQLException ex) {
        System.err.println(ex);
    } finally {
        closeConnection();
    }
    
    %>
</div>
</body>
</html>

