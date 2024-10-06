<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.example.demo.SaveAttendanceDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance List</title>
    <link rel="stylesheet" href="/admin/attendancelist1.css">
    <link rel="stylesheet" href="/admin/attendancelist1.css" media="screen">
   
    
    <style>
        /* Add your custom styles here */
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<%
    List<SaveAttendanceDTO> attendanceList = (List<SaveAttendanceDTO>) session.getAttribute("saveAttendanceList");
    Set<String> subjects = new HashSet<>();
    Set<String> courses = new HashSet<>();

    if (attendanceList != null) {
        for (SaveAttendanceDTO attendance : attendanceList) {
            subjects.add(attendance.getSubject());
            courses.add(attendance.getCourseName());
        }
    }
%>

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
        <h2>Attendance List</h2>
        <div class="filter-container">
            <div>
                <label for="subject-filter">Subject:</label>
                <select id="subject-filter" onchange="filterTable()">
                    <option value="">All</option>
                    <% for (String subject : subjects) { %>
                        <option value="<%= subject %>"><%= subject %></option>
                    <% } %>
                </select>
            </div>
            <div>
                <label for="course-filter">Course:</label>
                <select id="course-filter" onchange="filterTable()">
                    <option value="">All</option>
                    <% for (String course : courses) { %>
                        <option value="<%= course %>"><%= course %></option>
                    <% } %>
                </select>
            </div>
            <div>
                <label for="start-date">From:</label>
                <input type="date" id="start-date" onchange="filterTable()">
            </div>
            <div>
                <label for="end-date">To:</label>
                <input type="date" id="end-date" onchange="filterTable()">
            </div>
            <div>
                <button onclick="generatePieChart()">Generate Pie Chart</button>
            </div>
                        <div>
                <button onclick="location.href='/admin/filteredattendance.jsp'">Report</button>
            </div>
            
        </div>
        <table class="attendance-table" id="attendance-table">
            <thead>
                <tr>
                    <th>S.No</th>
                    <th>Subject</th>
                    <th>Course Name</th>
                    <th>Student Name</th>
                    <th>Semester</th>
                    <th>Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if (attendanceList != null) {
                        int sNo = 1;
                        for (SaveAttendanceDTO attendance : attendanceList) {
                %>
                        <tr>
                            <td><%= sNo++ %></td>
                            <td class="subject"><%= attendance.getSubject() %></td>
                            <td><%= attendance.getCourseName() %></td>
                            <td><%= attendance.getStudentname() %></td>
                            <td><%= attendance.getSemester() %></td>
                            <td><%= attendance.getDate() %></td>
                            <td><%= attendance.getStatus() %></td>
                        </tr>
                <%      }
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

    function filterTable() {
        const subjectFilter = document.getElementById('subject-filter').value.toLowerCase();
        const courseFilter = document.getElementById('course-filter').value.toLowerCase();
        const startDate = new Date(document.getElementById('start-date').value);
        const endDate = new Date(document.getElementById('end-date').value);
        const rows = document.querySelectorAll('#attendance-table tbody tr');

        rows.forEach(row => {
            const subject = row.querySelector('.subject').innerText.toLowerCase();
            const course = row.querySelector('td:nth-child(3)').innerText.toLowerCase();
            const date = new Date(row.querySelector('td:nth-child(6)').innerText); // Adjust according to the column index of the date

            const subjectMatch = subjectFilter === "" || subject.includes(subjectFilter);
            const courseMatch = courseFilter === "" || course.includes(courseFilter);
            const dateMatch = (!isNaN(startDate) ? date >= startDate : true) && (!isNaN(endDate) ? date <= endDate : true);

            if (subjectMatch && courseMatch && dateMatch) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    }

    function generatePieChart() {
        const subjectFilter = document.getElementById('subject-filter').value.toLowerCase();
        const courseFilter = document.getElementById('course-filter').value.toLowerCase();
        const startDate = new Date(document.getElementById('start-date').value);
        const endDate = new Date(document.getElementById('end-date').value);
        const rows = document.querySelectorAll('#attendance-table tbody tr');

        const filteredData = [];

        rows.forEach(row => {
            const subject = row.querySelector('.subject').innerText.toLowerCase();
            const course = row.querySelector('td:nth-child(3)').innerText.toLowerCase();
            const date = new Date(row.querySelector('td:nth-child(6)').innerText); // Adjust according to the column index of the date

            const subjectMatch = subjectFilter === "" || subject.includes(subjectFilter);
            const courseMatch = courseFilter === "" || course.includes(courseFilter);
            const dateMatch = (!isNaN(startDate) ? date >= startDate : true) && (!isNaN(endDate) ? date <= endDate : true);

            if (subjectMatch && courseMatch && dateMatch) {
                filteredData.push({
                    subject: row.querySelector('.subject').innerText,
                    course: row.querySelector('td:nth-child(3)').innerText,
                    status: row.querySelector('td:nth-child(7)').innerText
                });
            }
        });

        // Store the filtered data in session storage to pass it to the next page
        sessionStorage.setItem('filteredAttendanceData', JSON.stringify(filteredData));

        sessionStorage.setItem('courseName', courseFilter);
        sessionStorage.setItem('subjectName', subjectFilter);
        // Redirect to the chart page
        window.location.href = '/admin/attendancechart.jsp';
    }

    setInterval(updateTime, 1000);
    updateTime();
</script>
</body>
</html>
