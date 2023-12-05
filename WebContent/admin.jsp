<%@ page import="java.text.NumberFormat" %>

<!DOCTYPE html>
<html>
<head>
    <title>Administrator Page</title>

    <%@ include file="headingdata.jsp" %>
</head>
<body class="primary">
<div class="container">

    <%@ include file="jdbc.jsp"%>
    <%@ include file="auth.jsp"%>

    <%@ include file="navbar.jsp"%>
	<%
	out.println(drawNavBar("admin", session));
	%>

    <%@ include file="adminReports.jsp" %>
    <%@ include file="adminUsers.jsp" %>
    <%@ include file="adminAddCustomer.jsp" %>
    <%@ include file="adminAddProduct.jsp" %>
    <%@ include file="adminAddWarehouse.jsp" %>
    <%@ include file="adminUpdateCustomer.jsp" %>
    <%@ include file="adminUpdateProduct.jsp" %>
    <%@ include file="adminUpdateWarehouse.jsp" %>
    <%@ include file="adminDeleteProduct.jsp" %>
    <%@ include file="adminDisplayInventory.jsp" %>
    <%@ include file="adminUpdateInventory.jsp" %>

    <% 
        String menu = (String) request.getParameter("id");

        if (menu != null) {
            switch(menu) {
                case "adminReports":
                    out.println(adminReports());
                    break;
                case "adminUsers":
                    out.println(adminUsers());
                    break;
                case "addProduct":
                    out.println(adminAddProductMenu());
                    break;
                case "addCustomer":
                    out.println(adminAddCustomerMenu());
                    break;
                case "addWarehouse":
                    out.println(adminAddWarehouseMenu());
                    break;
                case "updateProduct":
                    out.println(adminUpdateProductMenu());
                    break;
                case "updateCustomer":
                    out.println(adminUpdateCustomerMenu());
                    break;
                case "updateWarehouse":
                    out.println(adminupdateWarehouseMenu());
                    break;
                case "deleteProduct":
                    out.println(adminDeleteProductMenu());
                    break;
                case "displayInventory":
                    out.println(adminDisplayInventory());
                    break;
                case "updateInventory":
                    out.println(adminUpdateInventoryMenu());
                    break;
                default:
                    break;
            } 
        }
    %>
</div>
</body>
</html>

