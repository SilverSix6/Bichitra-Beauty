<a href="admin.jsp?id=addProduct"><button>Add Product</button></a>

<%! 
public String adminAddProductMenu() {
    String returnString = "";

    returnString += "<form method=\"get\" action=\"adminUpdate.jsp?\">\r\n"
        + "<input type=\"text\" name=\"value1\" size=\"50\" placeholder=\"Product Name\"><br>\r\n"
        + "<input type=\"text\" name=\"value2\" size=\"50\" placeholder=\"Product Price\"><br>\r\n"
        + "<input type=\"text\" name=\"value3\" size=\"50\" placeholder=\"Product Desc\"><br>\r\n"
        + "<input type=\"text\" name=\"value4\" size=\"50\" placeholder=\"Category Id\">\r\n"
        + "<input type=\"Submit\" value=\"Add Product\" >\r\n"
        + "<input type=\"hidden\" name=\"action\" value=\"addProduct\"/></form>";

    return returnString;
}
%>

<%! 
public void adminAddProduct(String productName, String productPrice, String productDesc, String categoryId) {
    try {
        getConnection();

        String sql = "INSERT INTO product(productName, productPrice, productDesc, categoryId) VALUES (?,?,?,?);";

        PreparedStatement pStatement = con.prepareStatement(sql);

        pStatement.setNString(1, productName);
        pStatement.setNString(2, productPrice);
        pStatement.setNString(3, productDesc);
        pStatement.setNString(4, categoryId);

        pStatement.executeUpdate();

    } catch (SQLException e) {
    } finally {
        closeConnection();
    }

}
%>