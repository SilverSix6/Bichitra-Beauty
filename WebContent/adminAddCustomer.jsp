<a href="admin.jsp?id=addCustomer"><button>Add Customer</button></a>

<%! 
public String adminAddCustomerMenu() {
    String returnString = "";

    returnString = "<form method=\"get\" action=\"adminUpdate.jsp?\">\r\n"
        + "<input type=\"text\" name=\"value1\" size=\"50\" placeholder=\"Customer First Name\"/><br>\r\n"
        + "<input type=\"text\" name=\"value2\" size=\"50\" placeholder=\"Customer Last Name\"/><br>\r\n"
        + "<input type=\"text\" name=\"value3\" size=\"50\" placeholder=\"Email\"/><br>\r\n"
        + "<input type=\"text\" name=\"value4\" size=\"50\" placeholder=\"Password\"/><br>\r\n"
        + "<input type=\"text\" name=\"value5\" size=\"50\" placeholder=\"Phone Number\"/>\r\n"
        + "<input type=\"Submit\" value=\"Add Customer\" />\r\n"
        + "<input type=\"hidden\" name=\"action\" value=\"addCustomer\"/>\r\n"
        + "</form>";

    return returnString;
}
%>

<%! 
public void adminAddCustomer(String firstName, String lastName, String email, String password, String phonenum) {
    try {
        getConnection();

        String sql = "INSERT INTO customer(firstName, lastName, email, password, phonenum) VALUES (?,?,?,?,?);";

        PreparedStatement pStatement = con.prepareStatement(sql);

        pStatement.setNString(1, firstName);
        pStatement.setNString(2, lastName);
        pStatement.setNString(3, email);
        pStatement.setNString(4, password);
        pStatement.setNString(5, phonenum);

        pStatement.executeUpdate();
    } catch (SQLException e) {
    } finally {     
        closeConnection();
    }
}
%>