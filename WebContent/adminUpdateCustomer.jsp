<a href="admin.jsp?id=updateCustomer"><button>Update Customer</button></a>

<%! 
public String adminUpdateCustomerMenu() {
    String returnString = "";

    returnString += "<form method=\"get\" action=\"adminUpdate.jsp\">\r\n"
        + "<input type=\"text\" name=\"value1\" size=\"50\" placeholder=\"Customer Id\"/><br>\r\n"
        + "<input type=\"text\" name=\"value2\" size=\"50\" placeholder=\"Value\"/><br>\r\n"
        + "<input type=\"text\" name=\"value3\" size=\"50\" placeholder=\"Column\"/>\r\n"
        + "<input type=\"Submit\" value=\"Update Customer\" />\r\n"
        + "<input type=\"hidden\" name=\"action\" value=\"updateCustomer\"/>\r\n"
        + "</form>";

    return returnString;
}
%>

<%!
public void adminUpdateCustomer(String customerId, String value, String column) {
    String sql = "";
    switch(column) {
        case "firstName":
            sql = "UPDATE customer SET firstName = ? WHERE productId = ?;";
            break;
        case "lastName":
            sql = "UPDATE customer SET lastName = ? WHERE productId = ?;";
            break;
        case "email":
            sql = "UPDATE customer SET email = ? WHERE productId = ?;";
            break;
        case "phonenum":
            sql = "UPDATE customer SET phonenum = ? WHERE productId = ?";
            break;
        case "password":
            sql = "UPDATE customer SET password = ? WHERE productId = ?;";
            break;
    }
    try {
    getConnection();

    if (sql.equals("")) {
        return;
    }

    PreparedStatement pStatement = con.prepareStatement(sql);

    pStatement.setNString(1,value);
    pStatement.setNString(2,customerId);

    pStatement.executeUpdate();

    } catch (SQLException e) {
    } finally {
        closeConnection();
    }
}
 %>
