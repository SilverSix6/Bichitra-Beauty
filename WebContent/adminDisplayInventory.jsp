<a href="admin.jsp?id=displayInventory"><button>Display Inventory</button></a>

<%!
public String adminDisplayInventory(){
    String string = "";
    string += "<h1>Sales Reports By Day</h1>";
    // TODO: Write SQL query that prints out total order amount by day
    String sql = "SELECT I.productId, P.productName, I.warehouseId, W.warehouseName, I.quantity\r\n"
        + "FROM productInventory AS I JOIN product AS P ON I.productId =  P.productId\r\n"
        + "JOIN warehouse AS W ON W.warehouseId = I.warehouseId;";

    try {
        getConnection();

        ResultSet rset = con.createStatement().executeQuery(sql);

        string += "<table class=\"table table-striped\">";
        string += "<tr><th>Product ID</td><th>Product Name</td><th>Warehouse ID</td><th>Warehouse Name</td><th>Quantity</td></tr>";
        while (rset.next()){
            string += "<tr><td>"+ rset.getString(1) +"</td><td>"+ rset.getString(2) +"</td><td>"+ rset.getString(3) +"</td><td>"+ rset.getString(4) +"</td><td>"+ rset.getString(5) + "</td></tr>";
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
