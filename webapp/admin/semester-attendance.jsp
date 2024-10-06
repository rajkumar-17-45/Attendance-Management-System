<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.example.demo.SaveAttendanceDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Semester Attendance Details</title>
    <link rel="stylesheet" href="/admin/semester-attendance.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
    <div class="content">
        <h2>Semester Attendance Details</h2>
        <div>
            <button onclick="generatePieChart()">Generate Pie Chart</button>
        </div>
        <table class="attendance-table">
            <thead>
                <tr>
                    <th>Roll No</th>
                    <th>Student Name</th>
                    <th>OS (Total Hours | Present Hours)</th>
                    <th>Total Percentage</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Retrieve attributes from request
                    HashMap<String, Integer> present = (HashMap<String, Integer>) request.getAttribute("presentlist");
                    HashMap<String, Integer> absent = (HashMap<String, Integer>) request.getAttribute("absentlist");
                    int totalHours = (int) request.getAttribute("totalhours");
                    List<SaveAttendanceDTO> filteredList = (List<SaveAttendanceDTO>) request.getAttribute("filteredList");
                    HashMap<String, String> studentNames = (HashMap<String, String>) request.getAttribute("studentnames");

                    // Initialize a set to track displayed roll numbers
                    Set<String> displayedRollNumbers = new HashSet<>();

                    // Iterate over filteredList to display attendance details
                    for (SaveAttendanceDTO attendance : filteredList) {
                        String rollNo = attendance.getRollno();
                        
                        // Check if roll number has already been displayed
                        if (displayedRollNumbers.contains(rollNo)) {
                            continue; // Skip this iteration to avoid duplicate display
                        }
                        
                        // Mark roll number as displayed
                        displayedRollNumbers.add(rollNo);
                        
                        // Retrieve other details
                        int presentHours = present.getOrDefault(rollNo, 0);
                        int totalPercentage = (totalHours > 0) ? (presentHours * 100 / totalHours) : 0;
                %>
                <tr>
                    <td><%= rollNo %></td>
                    <td><%= studentNames.get(rollNo) %></td>
                    <td>Total Hours: <%= totalHours %> | Present Hours: <%= presentHours %></td>
                    <td><%= totalPercentage %>%</td>
                </tr>
                <% 
                    } // End of for loop
                %>
            </tbody>
        </table>
    </div>
</div>

<div class="footer">
    <p>Karpagam College of Engineering, Coimbatore, Tamil Nadu, India | Phone: +91 422 2619000 | Email: <a href="mailto:info@karpagamtech.ac.in">info@karpagamtech.ac.in</a></p>
</div>

<script>
    // JavaScript function to update current date and time
    function updateTime() {
        const now = new Date();
        const date = now.toLocaleDateString();
        const time = now.toLocaleTimeString();
        document.getElementById('current-date').innerText = date;
        document.getElementById('current-time').innerText = time;
    }

    // Update time every second
    setInterval(updateTime, 1000);
    updateTime(); // Initial call to display time immediately

    function generatePieChart() {
        const rows = document.querySelectorAll('.attendance-table tbody tr');

        const filteredData = [];

        rows.forEach(row => {
            const rollNo = row.querySelector('td:nth-child(1)').innerText;
            const studentName = row.querySelector('td:nth-child(2)').innerText;
            const presentHours = parseInt(row.querySelector('td:nth-child(3)').innerText.split('|')[1].trim());
            const totalPercentage = parseInt(row.querySelector('td:nth-child(4)').innerText.replace('%', ''));

            filteredData.push({
                rollNo: rollNo,
                studentName: studentName,
                presentHours: presentHours,
                totalPercentage: totalPercentage
            });
        });

        // Store the filtered data in session storage to pass it to the next page
        sessionStorage.setItem('filteredAttendanceData', JSON.stringify(filteredData));

        // Redirect to the chart page
        window.location.href = '/admin/semesterattendancechart.jsp';
    }
</script>
</body>
</html>
