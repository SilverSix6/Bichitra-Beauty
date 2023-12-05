<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<% 
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	// No products currently in list.  Create a list.
	productList = new HashMap<String, ArrayList<Object>>();
} else {
    String id = request.getParameter("id");

    // If the id is in the productList decrease the quantity
    productList.remove(id);
}

session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />