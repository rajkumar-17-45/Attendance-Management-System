<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.AssignFaculty" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Home</title>
<link rel="stylesheet" href="/admin/userhome.css">
<link href="https://fonts.googleapis.com/css2?family=Martian+Mono:wght@300&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
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

<%
    List<AssignFaculty> facultyDetails = (List<AssignFaculty>) request.getAttribute("facultydetails");
    int courseCount = 0;
    int subjectCount = 0;
    String facultyName = "";
    
    if (facultyDetails != null && !facultyDetails.isEmpty()) {
        // Count unique courses
        courseCount = facultyDetails.stream().map(AssignFaculty::getCourseName).distinct().toArray().length;
        
        // Count unique subjects
        subjectCount = facultyDetails.stream().map(AssignFaculty::getSubjectName).distinct().toArray().length;
        
        // Assuming all records have the same faculty name
        facultyName = facultyDetails.get(0).getFacultyName();
    }
%>

<div class="main">
    <div class="sidebar">
        <a href="/admin/userhome.jsp" class="pages active">Home</a>
        <a href="/admin/attendance.jsp" class="pages">Attendance</a>
        <a href="/admin/student.jsp" class="pages">Student</a>
        <a href="/admin/upload.jsp" class="pages">Upload</a>
    </div>
  
    <div class="content">
        <div class="icons-container">
            <div class="icon-box">
                <i class="fas fa-chalkboard"></i>
                <span>Course Count: <%= courseCount %></span>
            </div>
            <div class="icon-box">
                <i class="fas fa-book-open"></i>
                <span>Subject Count: <%= subjectCount %></span>
            </div>
            <div class="icon-box">
                <i class="fas fa-user"></i>
                <span>Faculty Name: <%= facultyName %></span>
            </div>
        </div>
        <img src="https://img.freepik.com/free-vector/businessman-planning-events-deadlines-agenda_74855-6274.jpg" class="background-image" alt="Background Image">
    </div>
</div>

<div class="footer">
    <p>Karpagam College of Engineering, Coimbatore, Tamil Nadu, India | Phone: +91 422 2619000 | Email: <a href="mailto:info@karpagamtech.ac.in">info@karpagamtech.ac.in</a></p>
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
</script>

</body>
</html>
