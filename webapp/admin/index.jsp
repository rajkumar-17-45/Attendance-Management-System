<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Upload CSV File</title>
</head>
<body>
<h2>Upload CSV File</h2>

<% String message = (String) request.getAttribute("message"); %>
<% if (message != null) { %>
    <p><%= message %></p>
<% } %>

<form method="post" action="/upload" enctype="multipart/form-data">
    <input type="file" name="file" />
    <button type="submit">Upload</button>
</form>
</body>
</html>
