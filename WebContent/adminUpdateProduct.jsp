<a href="admin.jsp?id=updateProduct"><button>Update Product</button></a>

<%! 
public String adminUpdateProductMenu() {
    String returnString = "";

    returnString += "<form method=\"get\" action=\"adminUpdate.jsp\">\r\n"
        + "<input type=\"text\" name=\"value1\" size=\"50\" placeholder=\"Product Id\"/><br>\r\n"
        + "<input type=\"text\" name=\"value2\" size=\"50\" placeholder=\"Value\"/><br>\r\n"
        + "<input type=\"text\" name=\"value3\" size=\"50\" placeholder=\"Column\"/>\r\n"
        + "<input type=\"Submit\" value=\"Update Product\" />\r\n"
        + "<input type=\"hidden\" name=\"action\" value=\"updateProduct\"/>\r\n"
        + "</form>\r\n";

    return returnString;
}
%>

<%!
public void adminUpdateProduct(String productId, String value, String column) {
    String sql = "";
    switch(column) {
        case "productPrice":
            sql = "UPDATE product SET productPrice = ? WHERE productId = ?;";
            break;
        case "productName":
            sql = "UPDATE product SET productName = ? WHERE productId = ?;";
            break;
        case "productDesc":
            sql = "UPDATE product SET productDesc = ? WHERE productId = ?;";
            break;
        case "categoryId":
            sql = "UPDATE product SET categoryId = ? WHERE productId = ?;";
            break;
    }

    try {
        getConnection();

        if (sql.equals("")) {
            return;
        }

        PreparedStatement pStatement = con.prepareStatement(sql);

        pStatement.setNString(1,value);
        pStatement.setNString(2,productId);

        pStatement.executeUpdate();
    } catch (SQLException e) {
    } finally {
        closeConnection();
    }
}
 %>
