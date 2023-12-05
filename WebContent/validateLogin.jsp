<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ page import="java.util.Objects"%>
<%@ include file="cartDatabase.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else if (Objects.equals(request.getParameter("button"), "Sign Up"))
		response.sendRedirect("signup.jsp");		// Failed login - redirect back to login page with a message 
	else 
		response.sendRedirect("login.jsp");
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;
		String customerId = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;

		try 
		{
			getConnection();
	
			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
			String sql = "SELECT customerId FROM customer WHERE userid = ? AND password = ?;";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setString(2, password);

			ResultSet rset = pstmt.executeQuery();
			rset.next();

			if(rset.getString(1) != null){
				retStr = username;			
				customerId = rset.getString(1);
			}
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}	
		
		if(retStr != null)
		{	session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
			session.setAttribute("authenticatedUserId",customerId);
			session.setAttribute("productList",loadCart(customerId));
		}
		else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");

		return retStr;
	}
%>

