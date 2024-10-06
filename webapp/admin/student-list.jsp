<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*" %>
<%@ page import="com.example.demo.Student" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="/admin/student-list.css" >
<title>Student List</title>
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

<div class="main">
    <div class="sidebar">
        <a href="/admin/userhome.jsp" class="pages">Home</a>
        <a href="/admin/attendance.jsp" class="pages active">Attendance</a>
        <a href="/admin/student.jsp" class="pages">Student</a>
    </div>
    <div class="content" id="content">
        <h2>Student List</h2>
        <table class="student-table" id="student-table">
            <thead>
                <tr>
                    <th>Course Name</th>
                    <th>Semester</th>
                    <th>Roll No</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Date of Birth</th>
                    <th>Gender</th>
                    <th>Mobile No</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Student> students = (List<Student>) session.getAttribute("studentmanagedetails");
                    if (students != null) {
                        for (Student student : students) {
                %>
                <tr>
                    <td><%= student.getCoursename() %></td>
                    <td><%= student.getSemester() %></td>
                    <td><%= student.getRollno() %></td>
                    <td><%= student.getName() %></td>
                    <td><%= student.getEmail() %></td>
                    <td><%= student.getRollno() %></td>
                    <td><%= student.getGender() %></td>
                    <td><%= student.getMobileno() %></td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
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
