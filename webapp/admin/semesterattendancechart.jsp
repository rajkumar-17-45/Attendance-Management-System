<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Semester Attendance Chart</title>
    <link rel="stylesheet" href="/admin/semester-attendance.css">
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
            <h3>Semester Attendance Chart</h3>
            <h4 id="averagePercentage"></h4>
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
            // Calculate the average attendance percentage
            const totalPercentage = filteredData.reduce((acc, item) => acc + item.totalPercentage, 0);
            const averagePercentage = (totalPercentage / filteredData.length).toFixed(2);

            // Display the average attendance percentage
            document.getElementById('averagePercentage').innerText = 'Average Attendance Percentage: ' + averagePercentage + '%';

            // Calculate the proportion of attendance
            const presentPercentage = filteredData.reduce((acc, item) => acc + item.totalPercentage, 0) / filteredData.length;
            const absentPercentage = 100 - presentPercentage;

            // Prepare the data for the chart
            const data = {
                labels: ['Present', 'Absent'],
                datasets: [{
                    label: 'Attendance Percentage',
                    data: [presentPercentage, absentPercentage],
                    backgroundColor: [
                        '#36A2EB', // Blue for Present
                        '#FF6384', // Red for Absent
                    ],
                    borderColor: [
                        '#36A2EB',
                        '#FF6384',
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

    // Retrieve filtered data from session storage
    const filteredData = JSON.parse(sessionStorage.getItem('filteredAttendanceData')) || [];

    // Wait for the DOM to be fully loaded
    document.addEventListener('DOMContentLoaded', function () {
        renderChart(filteredData);
    });

    setInterval(updateTime, 1000);
    updateTime();
</script>
</body>
</html>
