<!--
Returns an HTML string containing the nav bar
Takes the current page name as a parameter

Public methods:
- public String drawNavBar(String)
-->


<%@ page import="java.io.PrintWriter" %>

<%! 
public String drawNavBar(String active){
    StringBuilder output = new StringBuilder();
    output.append("<nav class=\"navbar navbar-inverse bg-body-tertiary\">\n" +
                "    <div class=\"container-fluid\">\n" +
                "        <ul class=\"nav navbar-nav\">");
    if(active.equals("index"))
        output.append("            <li class=\"active\"><a class=\"nav-link\" href=\"index.jsp\">Home</a></li>");
    else
        output.append("            <li><a class=\"nav-link\" href=\"index.jsp\">Home</a></li>");
    if(active.equals("login"))
        output.append("            <li class=\"active\"><a class=\"nav-link\" href=\"login.jsp\">Login</a></li>");
    else
        output.append("            <li><a class=\"nav-link\" href=\"login.jsp\">Login</a></li>");
    if(active.equals("listprod"))
        output.append("            <li class=\"active\"><a class=\"nav-link\" href=\"listprod.jsp\">Begin Shopping</a></li>");
    else
        output.append("            <li><a class=\"nav-link\" href=\"listprod.jsp\">Begin Shopping</a></li>");
    if(active.equals("listorder"))
        output.append("            <li class=\"active\"><a class=\"nav-link\" href=\"listorder.jsp\">List All Orders</a></li>");
    else
        output.append("            <li><a class=\"nav-link\" href=\"listorder.jsp\">List All Orders</a></li>");
    if(active.equals("showcart"))
        output.append("            <li class=\"active\"><a class=\"nav-link\" href=\"showcart.jsp\">Cart</a></li>");
    else
        output.append("            <li><a class=\"nav-link\" href=\"showcart.jsp\">Cart</a></li>");
    output.append("        </ul>\n" +
                "\n" +
                "        <ul class=\"nav navbar-nav navbar-right\">");
    if(active.equals("customer"))
        output.append("            <li class=\"active\"><a class=\"nav-link text-inverse\" href=\"customer.jsp\">Customer Info</a></li>");
    else
        output.append("            <li><a class=\"nav-link text-inverse\" href=\"customer.jsp\">Customer Info</a></li>");
    if(active.equals("admin"))
        output.append("            <li class=\"active\"><a class=\"nav-link text-inverse\" href=\"admin.jsp\">Administrators</a></li>");
    else
        output.append("            <li><a class=\"nav-link text-inverse\" href=\"admin.jsp\">Administrators</a></li>");
    if(active.equals("logout"))
        output.append("            <li class=\"active\"><a class=\"nav-link text-inverse\" href=\"logout.jsp\">Log out</a></li>");
    else
        output.append("            <li><a class=\"nav-link text-inverse\" href=\"logout.jsp\">Log out</a></li>");
    output.append("        </ul>\n" +
                "    </div>\n" +
                "</nav>");
    return output.toString();
}
%>