<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>


<%@ include file="jdbc.jsp"%>
<%@ include file="auth.jsp"%>
<h1>Administrator Sales Reports By Day</h1>
<%

// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT CAST(orderDate AS DATE) AS date, SUM(totalAmount) AS totalOrderAmount FROM orderSummary GROUP BY CAST(orderDate AS DATE) ORDER BY date DESC;";

try {
    getConnection();

    ResultSet rset = con.createStatement().executeQuery(sql);

    out.println("<table><tbody>");
    out.println("<tr><th>Order Date</td><th>Total Order Amount</td></tr>");
    while (rset.next()){
        out.println("<tr><th>"+ rset.getString(1) +"</td><th>"+ rset.getString(2) +"</td></tr>");
    }
    out.println("</tbody></table>");


} catch(SQLException ex) {
    System.err.println(ex);
} finally {
    closeConnection();
}



%>

</body>
</html>

