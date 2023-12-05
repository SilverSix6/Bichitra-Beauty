<a href="admin.jsp?id=addWarehouse"><button>Add Warehouse</button></a>

<%! 
public String adminAddWarehouseMenu() {
    String returnString = "";

    returnString += "<form method=\"get\" action=\"adminUpdate.jsp\">\r\n"
        + "<input type=\"text\" name=\"value1\" size=\"50\" placeholder=\"Warehouse Name\"/>\r\n"
        + "<input type=\"Submit\" value=\"Add Warehouse\" />\r\n"
        + "<input type=\"hidden\" name=\"action\" value=\"addWarehouse\"/>\r\n"
        + "</form>";

    return returnString;
}
%>

<%! 
public void adminAddWarehouse(String warehouseName) {
    try {
        getConnection();

        String sql = "INSERT INTO warehouse(warehouseName) VALUES (?);";

        PreparedStatement pStatement = con.prepareStatement(sql);

        pStatement.setNString(1, warehouseName);

        pStatement.executeUpdate();
    } catch (SQLException e) {
    } finally {
        closeConnection();
    }
}
%>