<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.example.demo.FacultyList" %>
<%@ page import="com.example.demo.Course" %>
<%@ page import="com.example.demo.Student" %>
<%@ page import="com.example.demo.Subject" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="/admin/mark-attendance.css">
<title>Mark Attendance</title>
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
        <h2>Mark Attendance</h2>
        <form id="attendance-form" action="/save-attendance" method="post">
            <%
                Integer facultyId = (Integer) session.getAttribute("facultyid");
                List<String> courseNames = (List<String>) request.getAttribute("courseNames");
                String semester = (String) request.getAttribute("semester");
                String subject = (String) request.getAttribute("subject");
                String date = (String) request.getAttribute("date");
                List<Student> students = (List<Student>) request.getAttribute("students");
            %>
            <input type="hidden" name="facultyId" value="<%= facultyId %>">
            <input type="hidden" name="semester" value="<%= semester %>">
            <input type="hidden" name="subject" value="<%= subject %>">
            <input type="hidden" name="date" value="<%= date %>">
            <div class="attendance-box" id="attendance-box">
                <div>Subject: <span><%= subject %></span></div>
                <div>Date: <span><%= date %></span></div>
                <div>Semester: <span><%= semester %></span></div>
                <div>
                    Course: 
                   <select name="courseName" id="courseName" onchange="filterStudents()">
    <option value="all">All</option>
    <% 
        // Use a Set to store unique course names
        Set<String> uniqueCourses = new HashSet<>();
        if (courseNames != null) {
            for (String courseName : courseNames) {
                uniqueCourses.add(courseName);
            }
            // Iterate through unique course names and render options
            for (String uniqueCourse : uniqueCourses) {
    %>
    <option value="<%= uniqueCourse %>"><%= uniqueCourse %></option>
    <% 
            }
        }
    %>
</select>
                   
                </div>
            </div>
            <table class="attendance-table">
                <thead>
                    <tr>
                        <th>Roll No</th>
                        <th>Name</th>
                        <th>Course</th>
                        <th>Present</th>
                        <th>Absent</th>
                    </tr>
                </thead>
                <tbody id="studentsTableBody">
                    <%
                        if (students != null) {
                            for (Student student : students) {
                    %>
                    <tr data-course="<%= student.getCoursename() %>">
                        <td><%= student.getRollno() %></td>
                        <td><%= student.getName() %></td>
                        <td><%= student.getCoursename() %></td>
                        <td><input type="checkbox" name="Present_<%= student.getRollno() %>" onclick="toggleCheckbox(this, 'Absent_<%= student.getRollno() %>')"></td>
                        <td><input type="checkbox" name="Absent_<%= student.getRollno() %>" onclick="toggleCheckbox(this, 'Present_<%= student.getRollno() %>')"></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
            <button type="submit" id="save">Save</button>
        </form>
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

    function toggleCheckbox(current, otherName) {
        const otherCheckbox = document.getElementsByName(otherName)[0];
        if (current.checked) {
            otherCheckbox.checked = false;
        }
    }

    function filterStudents() {
        const selectedCourse = document.getElementById('courseName').value;
        const rows = document.querySelectorAll('#studentsTableBody tr');
        
        rows.forEach(row => {
            const studentCourse = row.getAttribute('data-course');
            if (selectedCourse === 'all' || studentCourse === selectedCourse) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    setInterval(updateTime, 1000);
    updateTime();
</script>
</body>
</html>
