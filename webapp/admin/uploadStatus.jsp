<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Upload Status</title>
</head>
<body>
    <h1>Upload Status</h1>
    <p>
        <% 
            String message = (String) request.getAttribute("message");
            if (message != null && !message.isEmpty()) {
                out.println(message);
            } else {
                out.println("No message to display.");
            }
        %>
    </p>
    <a href="/upload">Go back</a>
</body>
</html>
