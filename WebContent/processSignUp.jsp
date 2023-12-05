<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<%
String sql = "INSERT INTO customer (firstName, lastName, email, phonenum, userid, password) VALUES (?,?,?,?,?,?);";

try {
    getConnection();

    PreparedStatement pstmt = con.prepareStatement(sql);
    System.out.println("Creating a new user" + (String) request.getParameter("userName"));
    pstmt.setString(1,(String) request.getParameter("firstName"));
    pstmt.setString(2,(String) request.getParameter("lastName"));
    pstmt.setString(3,(String) request.getParameter("email"));
    pstmt.setString(4,(String) request.getParameter("phonenum"));
    pstmt.setString(5,(String) request.getParameter("userName"));
    pstmt.setString(6,(String) request.getParameter("password"));

    pstmt.executeUpdate();
} catch (SQLException ex){
    System.err.println(ex);
} finally {
    closeConnection();
}

response.sendRedirect("login.jsp");
%>


