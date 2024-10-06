<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="/admin/userlogin.css"  >
<title>Insert title here</title>
</head>
<body>
<div class="login-background">
        <div class="login-container">
            <form class="login-form" action="userhome" method="POST">
                <legend>Login Here</legend>
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" name="username" id="username" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" id="password" class="form-control" required>
                </div>
                <button type="submit" class="login">Login</button>
            </form>
        </div>
    </div>
</body>
</html>