<a href="admin.jsp?id=deleteProduct"><button>Delete Product</button></a>

<%! 
public String adminDeleteProductMenu() {
    String returnString = "";

    returnString += "<form method=\"get\" action=\"adminUpdate.jsp\">\r\n"
        + "<input type=\"text\" name=\"value1\" size=\"50\" placeholder=\"Product Id\"/>\r\n"
        + "<input type=\"Submit\" value=\"Delete Product\" />\r\n"
        + "<input type=\"hidden\" name=\"action\" value=\"deleteProduct\"/>\r\n"
        + "</form>";

    return returnString;
}
%>

<%! 
public void adminDeleteProduct(String productId){
    String sql = "DELETE product WHERE productId = ?;";

    try {
    getConnection();

    PreparedStatement pStatement = con.prepareStatement(sql);

    pStatement.setNString(1, productId);

    pStatement.executeUpdate();

    } catch (SQLException e) {
    } finally {
        closeConnection();
    }
}
%>