<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="/admin/student.css"  >
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
            <h2>Student Details Page</h2>
            <div class="option-box" onclick="showStudentForm()">
                <i class="fas fa-user-plus"></i>
                <span>Add Student</span>
            </div>
            <div class="option-box" onclick="location.href='/admin/student-list.jsp'">
                <i class="fas fa-list"></i>
                <span>Student List</span>
            </div>
        </div>
        <div class="student-form" id="student-form">
            <form id="addStudentForm" action="student-details" method="POST">
                <label for="course">Course:</label>
                <select id="course" name="course" required>
                    <option value="">Select Course</option>
                    <option value="btech">B.Tech</option>
                    <option value="mtech">M.Tech</option>
                    <option value="phd">Ph.D.</option>
                </select>
                <label for="semester">Semester:</label>
                <select id="semester" name="semester" required>
                    <option value="">Select Semester</option>
                    
                    
                    
                    
                    
                    <option value="1">1st Semester</option>
                    <option value="2">2nd Semester</option>
                    <option value="3">3rd Semester</option>
                    <option value="4">4th Semester</option>
                </select>
                <label for="roll">Roll Number:</label>
                <input type="text" id="roll" name="roll" required>
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" required>
                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="">Select Gender</option>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                </select>
                <label for="mobile">Mobile Number:</label>
                <input type="text" id="mobile" name="mobile" required>
                <div class="btn-container">
                    <button type="submit">Save</button>
                    <button type="reset">Reset</button>
                </div>
            </form>
        </div>
    </div>

    <div class="footer" id="footer">
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

        function showStudentForm() {
            document.getElementById('student-form').style.display = 'flex';
        
            updateBackgroundImage();
        }

        function updateBackgroundImage() {
            var content = document.getElementById('content');
            if (window.innerWidth > 800) {
                content.style.backgroundImage = "none";
            } else {
                content.style.backgroundImage = "url('https://img.freepik.com/free-vector/businessman-planning-events-deadlines-agenda_74855-6274.jpg')";
            }
        }

        setInterval(updateTime, 1000);
        updateTime();
    </script>
</body>
</html>