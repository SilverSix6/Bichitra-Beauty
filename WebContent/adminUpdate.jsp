<%@ page import="java.text.NumberFormat" %>

<%
String action = (String) request.getParameter("action");
String value1 = (String) request.getParameter("value1");
String value2 = (String) request.getParameter("value2");
String value3 = (String) request.getParameter("value3");
String value4 = (String) request.getParameter("value4");
String value5 = (String) request.getParameter("value5");
%>

<%@ include file="adminAddCustomer.jsp" %>
<%@ include file="adminAddProduct.jsp" %>
<%@ include file="adminAddWarehouse.jsp" %>
<%@ include file="adminUpdateCustomer.jsp" %>
<%@ include file="adminUpdateProduct.jsp" %>
<%@ include file="adminUpdateWarehouse.jsp" %>
<%@ include file="adminDeleteProduct.jsp" %>
<%@ include file="adminUpdateInventory.jsp" %>


<%@ include file="jdbc.jsp"%>
<%@ include file="auth.jsp"%>


<%
if (action != null) {
    switch(action){
        case "addProduct":
            adminAddProduct(value1, value2, value3, value4);
            break;
        case "addCustomer":
            adminAddCustomer(value1,value2,value3,value4,value5);
            break;
        case "addWarehouse":
            adminAddWarehouse(value1);
            break;
        case "updateWarehouse":
            adminUpdateWarehouse(value1, value2);
            break;
        case "updateProduct":
            adminUpdateProduct(value1,value2,value3);
            break;
        case "updateCustomer":
            adminUpdateCustomer(value1,value2,value3);
            break;
        case "deleteProduct":
            adminDeleteProduct(value1);
            break;
        case "updateInventory":
            adminUpdateInventory(value1,value2,value3);
            break;
    }
}
%>
<jsp:forward page="admin.jsp"/>