<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Average Attendance Chart</title>
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
        <a href="/admin/attendance.jsp" class="pages">Attendance</a>
        <a href="/admin/student.jsp" class="pages">Student</a>
    </div>
    <div class="content">
        <h2>Average Attendance Chart</h2>
        <div class="chart-container">
            <canvas id="averageAttendanceChart"></canvas>
        </div>
    </div>
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

    // Function to parse data from JSP attributes
    function parseChartData() {
        const totalHours = parseInt('<%= request.getParameter("totalHours") %>');
        const presentMapString = '<%= request.getParameter("presentMap") %>';
        const studentNamesMapString = '<%= request.getParameter("studentNamesMap") %>';

        // Convert presentMapString and studentNamesMapString to JavaScript objects
        const presentMap = JSON.parse(presentMapString.replace(/=/g, ':').replace(/\{/g, '{\"').replace(/\}/g, '\"}'));
        const studentNamesMap = JSON.parse(studentNamesMapString.replace(/=/g, ':').replace(/\{/g, '{\"').replace(/\}/g, '\"}'));

        // Calculate absent hours
        const totalStudents = Object.keys(studentNamesMap).length;
        let totalPresentHours = 0;
        for (const rollNo in presentMap) {
            totalPresentHours += presentMap[rollNo];
        }
        const totalAbsentHours = totalHours * totalStudents - totalPresentHours;

        return {
            labels: ['Present Hours', 'Absent Hours'],
            data: [totalPresentHours, totalAbsentHours],
            backgroundColor: ['#4BC0C0', '#FF6384']
        };
    }

    // Function to render the average attendance chart
    function renderAverageAttendanceChart() {
        const chartData = parseChartData();

        const config = {
            type: 'pie',
            data: {
                labels: chartData.labels,
                datasets: [{
                    label: 'Average Attendance',
                    data: chartData.data,
                    backgroundColor: chartData.backgroundColor,
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        enabled: true,
                        animation: {
                            duration: 500,
                            easing: 'easeOutBounce'
                        }
                    },
                    animation: {
                        animateScale: true,
                        animateRotate: true
                    }
                }
            }
        };

        // Render the chart
        const ctx = document.getElementById('averageAttendanceChart').getContext('2d');
        new Chart(ctx, config);
    }

    // Wait for the DOM to be fully loaded
    document.addEventListener('DOMContentLoaded', function () {
        renderAverageAttendanceChart();
        updateTime(); // Initial call to display time immediately
    });
</script>
</body>
</html>
