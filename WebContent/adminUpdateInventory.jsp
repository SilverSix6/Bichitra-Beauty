<a href="admin.jsp?id=updateInventory"><button>Update Inventory</button></a>

<%! 
public String adminUpdateInventoryMenu() {
    String returnString = "";

    returnString = "<form method=\"get\" action=\"adminUpdate.jsp\">\r\n"
        + "<input type=\"text\" name=\"value1\" size=\"50\" placeholder=\"Warehouse Id\"/><br>\r\n"
        + "<input type=\"text\" name=\"value2\" size=\"50\" placeholder=\"Product Id\"/><br>\r\n"
        + "<input type=\"text\" name=\"value3\" size=\"50\" placeholder=\"Added Inventory\"/>\r\n"
        + "<input type=\"Submit\" value=\"Update Inventory\" />\r\n"
        + "<input type=\"hidden\" name=\"action\" value=\"updateInventory\"/>\r\n"
        + "</form>";

    return returnString;
}
%>

<%! 
public void adminUpdateInventory(String warehouseId, String productId, String quantity){
    String sql = "UPDATE productinventory SET quantity = quantity + ? WHERE warehouseId = ? AND productId = ?;";
    
    try {
    getConnection();
    
    PreparedStatement pStatement = con.prepareStatement(sql);

    pStatement.setNString(1, quantity);
    pStatement.setNString(2, warehouseId);
    pStatement.setNString(3, productId);

    pStatement.executeUpdate();

    } catch (SQLException e) {
    } finally {
        closeConnection();
    }
}
%>