<a href="admin.jsp?id=updateWarehouse"><button>Update warehouse</button></a>

<%! 
public String adminupdateWarehouseMenu() {
    String returnString = "";

    returnString = "<form method=\"get\" action=\"adminUpdate.jsp\">\r\n"
        + "<input type=\"text\" name=\"value1\" size=\"50\" placeholder=\"Warehouse Id\"/><br>\r\n"
        + "<input type=\"text\" name=\"value2\" size=\"50\" placeholder=\"New Warehouse Name\"/>\r\n"
        + "<input type=\"Submit\" value=\"Update Warehouse\" />\r\n"
        + "<input type=\"hidden\" name=\"action\" value=\"updateWarehouse\"/>\r\n"
        + "</form>";

    return returnString;
}
%>

<%! 
public void adminUpdateWarehouse(String warehouseId, String warehouseName){
    String sql = "UPDATE warehouse SET warehouseName = ? WHERE warehouseId = ?;";
    
    try {
    getConnection();
    
    PreparedStatement pStatement = con.prepareStatement(sql);

    pStatement.setNString(1, warehouseName);
    pStatement.setNString(2, warehouseId);

    pStatement.executeUpdate();

    } catch (SQLException e) {
    } finally {
        closeConnection();
    }
}
%>