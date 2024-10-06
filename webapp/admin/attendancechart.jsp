<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Attendance List</title>
    <link rel="stylesheet" href="/admin/attendancelist1.css">
    <style>
        .container {
            background: linear-gradient(to bottom right, #ffffff, #f0f0f0); /* Gradient background */
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            padding: 20px;
            width: 80%;
            max-width: 600px;
        }

        .info-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .info-container h3 {
            margin: 5px 0;
        }

        .chart-container {
            width: 300px;
            height: 300px;
            margin-right: auto;
            margin-left: auto;
            text-align: center;
        }
    </style>
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
    <div class="container">
        <div class="info-container">
            <h3>Attendance Chart</h3>
            <h4 id="courseName"></h4>
            <h4 id="subjectName"></h4>
        </div>
        <div class="chart-container">
            <canvas id="attendanceChart"></canvas>
        </div>
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

    function renderChart(filteredData) {
        // Ensure data is available
        if (filteredData.length > 0) {
            // Count the occurrences of each status
            const statusCounts = filteredData.reduce((acc, item) => {
                acc[item.status] = (acc[item.status] || 0) + 1;
                return acc;
            }, {});

            // Prepare the data for the chart
            const data = {
                labels: Object.keys(statusCounts),
                datasets: [{
                    label: 'Attendance Status',
                    data: Object.values(statusCounts),
                    backgroundColor: [
                        '#FF6384', // Red
                        '#36A2EB', // Blue
                        '#FFCE56', // Yellow
                        '#4BC0C0', // Turquoise
                        '#9966FF', // Purple
                        '#FF99FF', // Pink
                        '#FF9933', // Orange
                    ],
                    borderColor: [
                        '#FF6384',
                        '#36A2EB',
                        '#FFCE56',
                        '#4BC0C0',
                        '#9966FF',
                        '#FF99FF',
                        '#FF9933',
                    ],
                    borderWidth: 1
                }]
            };

            // Configure the chart
            const config = {
                type: 'pie',
                data: data,
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
            const ctx = document.getElementById('attendanceChart').getContext('2d');
            new Chart(ctx, config);
        } else {
            // No data found message
            const noDataMessage = document.createElement('p');
            noDataMessage.textContent = 'No attendance data available for the selected course and subject.';
            noDataMessage.style.textAlign = 'center';
            noDataMessage.style.color = '#FF0000'; // Red color for emphasis

            // Append the message to the chart container
            const chartContainer = document.querySelector('.chart-container');
            chartContainer.appendChild(noDataMessage);
        }
    }

    // Retrieve filtered data and course/subject info from session storage
    const filteredData = JSON.parse(sessionStorage.getItem('filteredAttendanceData')) || [];
    const courseName = sessionStorage.getItem('courseName') || 'All Courses';
    const subjectName = sessionStorage.getItem('subjectName') || 'All Subjects';

    // Display course and subject names in the DOM
    document.getElementById('courseName').innerText = 'Course: ' + courseName;
    document.getElementById('subjectName').innerText = 'Subject: ' + subjectName;

    // Wait for the DOM to be fully loaded
    document.addEventListener('DOMContentLoaded', function () {
        renderChart(filteredData);
    });

    setInterval(updateTime, 1000);
    updateTime();
</script>
</body>
</html>
