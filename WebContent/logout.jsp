<%@ include file="cartDatabase.jsp" %>

<%
	// Remove the user from the session to log them out
	if (session.getAttribute("productList") != null && session.getAttribute("authenticatedUserId") != null)
		saveCart((HashMap<String, ArrayList<Object>>) session.getAttribute("productList"), (String) session.getAttribute("authenticatedUserId"));
	session.setAttribute("authenticatedUser",null);
	session.setAttribute("authenticatedUserId",null);
	session.setAttribute("productList",null);


	response.sendRedirect("index.jsp");		// Re-direct to main page
%>

