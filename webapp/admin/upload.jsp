<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.AssignFaculty" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Home</title>
<link rel="stylesheet" href="/admin/upload.css">
<link href="https://fonts.googleapis.com/css2?family=Martian+Mono:wght@300&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<script>
    function displayMessage(message, isError) {
        var messageDiv = document.getElementById("message");
        if (isError) {
            messageDiv.className = "error";
        } else {
            messageDiv.className = "message";
        }
        messageDiv.innerText = message;
    }
</script>
<style>
/* admin/userhome.css */

body {
    font-family: 'Roboto', sans-serif;
}







.main {
    margin-left: 220px; /* Adjust for the width of the sidebar */
    padding: 20px;
}

.content {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.content h2 {
    font-family: 'Martian Mono', monospace;
    font-weight: 500;
    color: #481E14; /* Adjust color to match the theme */
    margin-bottom: 20px;
}

.content form {
    margin-top: 20px;
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.content form input[type="file"] {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.content form button {
    background-color: #F2613F;
    color: #fff;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    border-radius: 5px;
    font-family: 'Roboto', sans-serif;
    font-weight: 500;
}

.content form button:hover {
    background-color: #9B3922;
}

#message {
    margin-top: 20px;
    padding: 10px;
    border-radius: 5px;
    font-family: 'Roboto', sans-serif;
}

.message {
    background-color: #d4edda;
    color: #155724;
}

.error {
    background-color: #f8d7da;
    color: #721c24;
}

.upload-section {
    margin-bottom: 20px;
    width: 100%;
    max-width: 400px;
}

/* Responsive Styles */
@media screen and (max-width: 1000px) {
    .main {
        margin-left: 0;
        padding: 10px;
    }

}

@media screen and (max-width: 800px) {
    .content {
        padding: 10px;
    }
    .upload-section {
 
        width: 100%;
    }
          .faculty
        {
          margin-top:150px;
        }
        
}
@media screen and (max-width: 500px) {
    .content {
        padding: 10px;
    }
    .upload-section {
 
        width: 85%;
    }
          .faculty
        {
          margin-top:150px;
        }
        
}

</style>
</head>
<body>

<div id="header">
    <div id="logo">
        <img src="https://storage.googleapis.com/ezap-prod/colleges/4549/karpagam-college-of-engineering-logo.jpg" alt="Karpagam College of Engineering Logo">
    </div>
    <div id="date-time">
        <div id="current-date"></div>
        <div id="current-time"></div>
    </div>
</div>

<div class="sidebar">
    <div class="pages">Home</div>
    <div class="pages" id="faculty-details" onclick="location.href='/admin/adminfaculty.jsp'">Faculty</div>
    <div class="pages" id="student-details" onclick="location.href='/admin/adminstudent.jsp'">Student</div>
    <div class="pages" id="course-details" onclick="location.href='/admin/admincourse.jsp'">Course</div>
    <div class="pages" id="subject-details" onclick="location.href='/admin/adminsubject.jsp'">Subject</div>
    <div class="pages" id="assign-faculty-details" onclick="location.href='/admin/adminassign.jsp'">Assign Faculty</div>
     <div class="pages" id="assign-faculty-details" onclick="location.href='/admin/upload.jsp'">Upload</div>
</div>

<div class="main">
    <div class="content">
        <div class="upload-section faculty">
            <h2>Upload Faculty CSV File</h2>
            <form method="POST" action="/upload" enctype="multipart/form-data">
                <input type="file" name="file" required />
                <button type="submit">Upload</button>
            </form>
        </div>

        <div class="upload-section student">
            <h2>Upload Student CSV File</h2>
            <form method="POST" action="/uploadStudent" enctype="multipart/form-data">
                <input type="file" name="file" required />
                <button type="submit">Upload</button>
            </form>
        </div>

        <div class="upload-section course">
            <h2>Upload Course CSV File</h2>
            <form method="POST" action="/uploadCourse" enctype="multipart/form-data">
                <input type="file" name="file" required />
                <button type="submit">Upload</button>
            </form>
        </div>

        <div class="upload-section subject">
            <h2>Upload Subject CSV File</h2>
            <form method="POST" action="/uploadSubject" enctype="multipart/form-data">
                <input type="file" name="file" required />
                <button type="submit">Upload</button>
            </form>
        </div>

        <div id="message"></div>
    </div>
</div>

<script>
    function updateTime() {
        const now = new Date();
        const date = now.toLocaleDateString();
        const time = now.toLocaleTimeString();
        document.getElementById('current-date').innerText = date;
        document.getElementById('current-time').innerText = time;
    }

    setInterval(updateTime, 1000);
    updateTime();

    var message = "<%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>";
    var isError = "<%= request.getAttribute("isError") != null ? request.getAttribute("isError") : false %>";
    if (message) {
        displayMessage(message, isError === 'true');
    }
</script>

</body>
</html>
