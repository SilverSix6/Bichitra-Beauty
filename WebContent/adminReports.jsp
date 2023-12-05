<a href="admin.jsp?id=adminReports"><button>Admin Reports</button></a>

<%!
public String adminReports(){
    String string = "";
    string += "<h1>Sales Reports By Day</h1>";
    // TODO: Write SQL query that prints out total order amount by day
    String sql = "SELECT CAST(orderDate AS DATE) AS date, SUM(totalAmount) AS totalOrderAmount FROM orderSummary GROUP BY CAST(orderDate AS DATE) ORDER BY date DESC;";

    try {
        getConnection();

        ResultSet rset = con.createStatement().executeQuery(sql);

        NumberFormat currFormat = NumberFormat.getCurrencyInstance();

        string += "<table class=\"table table-striped\">";
        string += "<tr><th>Order Date</td><th>Total Order Amount</td></tr>";
        while (rset.next()){
            string += "<tr><td>"+ rset.getString(1) +"</td><td>"+ currFormat.format(rset.getInt(2)) +"</td></tr>";
        }
        string += "</table>";


  
    string += "<br><br><br><br><br><h1>Number of Orders By Day</h1>";
    // TODO: Write SQL query that prints out total order amount by day
    sql = "SELECT CAST(orderDate AS DATE) AS date, COUNT(orderId) AS totalOrderAmount FROM orderSummary GROUP BY CAST(orderDate AS DATE) ORDER BY date DESC;";

    rset = con.createStatement().executeQuery(sql);

    string += "<table class=\"table table-striped\">";
    string += "<tr><th>Order Date</td><th>Number of Orders</td></tr>";
    while (rset.next()){
        string += "<tr><td>"+ rset.getString(1) +"</td><td>"+ rset.getInt(2) +"</td></tr>";
    }
    string += "</table>";


    } catch(SQLException ex) {
        System.err.println(ex);
    } finally {
        closeConnection();
    }
    
    
    return string;
}
%>
