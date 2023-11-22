<!DOCTYPE html>
<html lang="en">
<head>
	<title>Bichitra Beauty</title>
	
	<%@ include file="headingdata.jsp" %>
</head>
<body class="primary">
<div class="container">
	
	<%@ include file="navbar.jsp"%>
	<%
	out.println(drawNavBar("index"));
	%>


	<br><br><br><br><br><br><br>
	<div class="container-fluid text">
		<h1 class="text-center">Bichitra Beauty</h1>
		<h5 class="text-center">Diversity and Self-Expression</h5>
	</div>
	
	<br><br><br><br><br><br><br>



	<div class="container bottom-info-bar">
		<%
			String userName = (String) session.getAttribute("authenticatedUser");
			if (userName != null)
				out.println("<p>Current User: "+userName+"</p>");
		%>
		<h4 align="center" class="text"><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>

		<h4 align="center" class="text"><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>
	</div>
</div>
</body>
</head>


