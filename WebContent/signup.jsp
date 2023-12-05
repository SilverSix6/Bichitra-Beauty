<!DOCTYPE HTML>
<html>
<head>
	<title>Signup Screen</title>
	
	<%@ include file="headingdata.jsp" %>
</head>
<body class="primary">
<div class="container">
<h1>Sign up</h1>

<form method=post action="processSignUp.jsp">
    <div class="row">
        <div class="form-group col-xs-4">
            <label for="firstName">First Name</label>
            <input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name">
        </div>
        <div class="form-group col-xs-4">
            <label for="lastName">Last Name</label>
            <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name">
        </div>
        <div class="form-group col-xs-4">
            <label for="userName">Username</label>
            <input type="text" class="form-control" id="userName" name="userName" placeholder="Username">
        </div>
        <div class="form-group col-xs-4">
            <label for="email">Email address</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="Enter email">
        </div>
        <div class="form-group col-xs-4">
            <label for="phonenum">Phone Number</label>
            <input type="text" class="form-control" id="phonenum" name="phonenum" placeholder="(123) 456-890">
        </div>
        <div class="form-group col-xs-4">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Password">
        </div>
    </div>
    <div class="row justify-content-md-center">
        <button type="submit" class="btn btn-primary col-md-4 col-md-offset-4">Sign Up</button>
    </div>
</form>

</div>
</body>
</html>