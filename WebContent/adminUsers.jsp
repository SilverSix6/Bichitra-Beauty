<a href="admin.jsp?id=adminUsers"><button>Site Users</button></a>
<%!
public String adminUsers() {
    String string = "";
    string += "<h1>Administrator Sales Reports By Day</h1>";
    // TODO: Write SQL query that prints out total order amount by day
    String sql = "SELECT customerId, firstName, lastName, email FROM customer;";

    try {
        getConnection();

        ResultSet rset = con.createStatement().executeQuery(sql);

        string += "<table class=\"table table-striped\">";
        string += "<tr><th>Customer Id</th><th>Customer Name</th><th>Email</th></tr>";
        while (rset.next()){
            string += "<tr><td>"+ rset.getString(1) +"</td><td>"+ rset.getString(2) +" "+ rset.getString(3) +"</td><td>"+ rset.getString(4) +"</td></tr>";
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

