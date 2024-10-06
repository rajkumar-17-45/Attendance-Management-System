<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.example.demo.SaveAttendanceDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance List</title>
    <link rel="stylesheet" href="/admin/attendancelist1.css">
    <link rel="stylesheet" href="/admin/attendancelist1.css" media="print">
    <style>
        /* Add your custom styles here */
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
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
    <!-- Uncomment and modify the header content as needed -->
</div>

<div class="main">
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
                <button onclick="downloadAttendance()">Download Attendance</button>
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
                        for (int i = 0; i < attendanceList.size(); i++) {
                            SaveAttendanceDTO attendance = attendanceList.get(i);
                %>
                        <tr>
                            <td><%= i + 1 %></td>
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

        let sNo = 1; // Initialize serial number

        rows.forEach(row => {
            const subject = row.querySelector('.subject').textContent.trim();
            const course = row.querySelector('td:nth-child(3)').textContent.trim();
            const date = new Date(row.querySelector('td:nth-child(6)').textContent.trim()); // Adjust according to the column index of the date

            const subjectMatch = subjectFilter === "" || subject.toLowerCase().includes(subjectFilter);
            const courseMatch = courseFilter === "" || course.toLowerCase().includes(courseFilter);
            const dateMatch = (!isNaN(startDate) ? date >= startDate : true) && (!isNaN(endDate) ? date <= endDate : true);

            if (subjectMatch && courseMatch && dateMatch) {
                row.style.display = "";
                row.querySelector('td:nth-child(1)').textContent = sNo++; // Update serial number
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
            const subject = row.querySelector('.subject').textContent.trim();
            const course = row.querySelector('td:nth-child(3)').textContent.trim();
            const date = new Date(row.querySelector('td:nth-child(6)').textContent.trim()); // Adjust according to the column index of the date

            const subjectMatch = subjectFilter === "" || subject.toLowerCase().includes(subjectFilter);
            const courseMatch = courseFilter === "" || course.toLowerCase().includes(courseFilter);
            const dateMatch = (!isNaN(startDate) ? date >= startDate : true) && (!isNaN(endDate) ? date <= endDate : true);

            if (subjectMatch && courseMatch && dateMatch) {
                filteredData.push({
                    subject: subject,
                    course: course,
                    status: row.querySelector('td:nth-child(7)').textContent.trim()
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

    async function downloadAttendance() {
        const { jsPDF } = window.jspdf;

        // Capture filter details
        const subjectFilter = document.getElementById('subject-filter').value || 'All';
        const courseFilter = document.getElementById('course-filter').value || 'All';
        const startDate = document.getElementById('start-date').value || 'Not specified';
        const endDate = document.getElementById('end-date').value || 'Not specified';

        // Create PDF
        const doc = new jsPDF({
            orientation: "p", // "p" for portrait, "l" for landscape
            unit: "mm",
            format: "a4"
        });

        // Add filter details to PDF
        doc.setFontSize(16);
        doc.text('Attendance List', 10, 10);
        doc.setFontSize(12);
        doc.text(`Subject: ${subjectFilter}`, 10, 20);
        doc.text(`Course: ${courseFilter}`, 10, 30);
        doc.text(`From: ${startDate}`, 10, 40);
        doc.text(`To: ${endDate}`, 10, 50);

        // Generate PDF from table
        const table = document.querySelector('#attendance-table');
        
        // Create a temporary clone of the table to adjust its width to fit A4 size
        const tableClone = table.cloneNode(true);
        document.body.appendChild(tableClone);
        tableClone.style.width = 'auto';

        const canvas = await html2canvas(tableClone, {
            useCORS: true, // Enable if cross-origin images are present
            scale: 2
        });

        document.body.removeChild(tableClone); // Remove the temporary clone

        const imgData = canvas.toDataURL('image/png');
        const imgProps = doc.getImageProperties(imgData);
        const pdfWidth = doc.internal.pageSize.getWidth();
        const pdfHeight = doc.internal.pageSize.getHeight();

        const imgWidth = pdfWidth;
        const imgHeight = (imgProps.height * imgWidth) / imgProps.width;

        // Adjust image height to fit within the PDF page height
        const pageHeight = pdfHeight - 60; // 60 mm for margins and header space
        let y = 60; // Start position for table

        if (imgHeight > pageHeight) {
            // Split the table if it exceeds one page height
            const totalPages = Math.ceil(imgHeight / pageHeight);
            for (let pageNum = 0; pageNum < totalPages; pageNum++) {
                const currentHeight = pageHeight * (pageNum + 1);
                const clipHeight = currentHeight > imgHeight ? imgHeight - pageHeight * pageNum : pageHeight;

                doc.addImage(imgData, 'PNG', 0, y, imgWidth, clipHeight, undefined, 'FAST');
                if (pageNum < totalPages - 1) {
                    doc.addPage();
                }
            }
        } else {
            doc.addImage(imgData, 'PNG', 0, y, imgWidth, imgHeight);
        }

        // Save the PDF
        doc.save('attendance.pdf');
    }

    // Add event listeners to the filter inputs to store their values in sessionStorage
    document.getElementById('subject-filter').addEventListener('change', function() {
        sessionStorage.setItem('subjectFilter', this.value);
    });
    document.getElementById('course-filter').addEventListener('change', function() {
        sessionStorage.setItem('courseFilter', this.value);
    });
    document.getElementById('start-date').addEventListener('change', function() {
        sessionStorage.setItem('startDate', this.value);
    });
    document.getElementById('end-date').addEventListener('change', function() {
        sessionStorage.setItem('endDate', this.value);
    });

    // Retrieve filter values from sessionStorage and set the filter inputs
    window.addEventListener('load', function() {
        if (sessionStorage.getItem('subjectFilter')) {
            document.getElementById('subject-filter').value = sessionStorage.getItem('subjectFilter');
        }
        if (sessionStorage.getItem('courseFilter')) {
            document.getElementById('course-filter').value = sessionStorage.getItem('courseFilter');
        }
        if (sessionStorage.getItem('startDate')) {
            document.getElementById('start-date').value = sessionStorage.getItem('startDate');
        }
        if (sessionStorage.getItem('endDate')) {
            document.getElementById('end-date').value = sessionStorage.getItem('endDate');
        }
    });


    setInterval(updateTime, 1000);
</script>
</body>
</html>
