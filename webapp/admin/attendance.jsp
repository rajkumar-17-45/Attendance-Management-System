<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="com.example.demo.FacultyList" %>
           <%@ page import="com.example.demo.Course" %>
                      <%@ page import="com.example.demo.Student" %>
                                           <%@ page import="com.example.demo.Subject" %>
                                           <%@ page import="com.example.demo.AssignFaculty" %>
                                           <%@ page import="java.util.List" %> 
                                            <%@ page import="java.util.Map" %> 
        <%@ page import="java.io.*" %>
                <%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Attendance Details Page</title>
<link rel="stylesheet" href="/admin/attendance.css">
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
       <a href="/userhome" class="pages">Home</a>
       <a href="/admin/attendance.jsp" class="pages active">Attendance</a>
       <a href="/admin/student.jsp" class="pages">Student</a>
    </div>
    <div class="content" id="content">
        <h2>Attendance Details Page</h2>
        <div class="option-box" onclick="showAttendanceForm()">
            <i class="fas fa-plus"></i>
            <span>Add Attendance</span>
        </div>
        <div class="option-box" onclick="location.href='/admin/attendance-list.jsp'">
            <i class="fas fa-list"></i>
            <span>Attendance List</span>
        </div>
        <div class="option-box" onclick="showSemesterForm()">
            <i class="fas fa-calendar-alt"></i>
            <span>Semester Attendance</span>
        </div>
    </div>
    <div class="attendance-form" id="attendance-form">
        <form id="attendanceForm" action="mark-attendance">
            <label for="subject">Subject:</label>
            <select id="subject" name="subject">
    <%
        // Accessing facultymain session attribute to get AssignFaculty objects
        Object facultyMainObj = session.getAttribute("facultymain");
        if (facultyMainObj != null && facultyMainObj instanceof List) {
            List<AssignFaculty> assignFacultyList = (List<AssignFaculty>) facultyMainObj;
            Set<String> addedSubjects = new HashSet<>(); // Use a set to track added subjects
            for (AssignFaculty assignFaculty : assignFacultyList) {
                String subjectName = assignFaculty.getSubjectName();
                if (!addedSubjects.contains(subjectName)) { // Check if subject is already added
    %>
    <option value="<%= subjectName %>"><%= subjectName %></option>
    <% 
                    addedSubjects.add(subjectName); // Add subject to set to prevent duplicates
                }
            }
        }
    %>
</select>
            
            <label for="date">Date:</label>
            <input type="date" id="date" name="date" required>
            <div class="btn-container">
                <button type="submit">Save</button>
                <button type="reset">Reset</button>
            </div>
        </form>
    </div>
    <div id="semester-form" class="semester-form">
        <form id="semesterAttendanceForm" action="semester-attendance">
            <label for="course">Course:</label>
            <select id="course" name="coursename">
               
                <%
                    // Accessing facultymain session attribute to get AssignFaculty objects
                    Object CourseMainObj = session.getAttribute("facultymain");
                    if (CourseMainObj != null && CourseMainObj instanceof List) {
                        List<AssignFaculty> assignFacultyList = (List<AssignFaculty>) facultyMainObj;
                        for (AssignFaculty assignFaculty : assignFacultyList) {
                %>
                <option value="<%= assignFaculty.getCourseName() %>" ><%= assignFaculty.getCourseName() %></option>
                <%-- You can use other properties like course code if needed --%>
                <%
                        }
                    }
                %>
               
            </select>
            <label for="semester">Semester:</label>
          <select id="semester" name="semester">
    <%
        // Accessing subjectSemesterMap session attribute to get subject and semester pairs
        Object subjectSemesterMapObj = session.getAttribute("subjectSemesterMap");
        if (subjectSemesterMapObj != null && subjectSemesterMapObj instanceof Map) {
            Map<String, String> subjectSemesterMap = (Map<String, String>) subjectSemesterMapObj;
            for (String semester : subjectSemesterMap.values()) {
    %>
    <option value="<%= semester %>"><%= semester %></option>
    <%
            }
        }
    %>
</select>
<select id="subject" name="subject">
    <% 
    // Accessing facultymain session attribute to get AssignFaculty objects
    Object facultyMainObj1 = session.getAttribute("facultymain");
    if (facultyMainObj1 != null && facultyMainObj1 instanceof List) {
        List<AssignFaculty> assignFacultyList = (List<AssignFaculty>) facultyMainObj1;
        Set<String> addedSubjects = new HashSet<>(); // Use a set to track added subjects
        for (AssignFaculty assignFaculty : assignFacultyList) {
            String subjectName = assignFaculty.getSubjectName();
            if (!addedSubjects.contains(subjectName)) { // Check if subject is already added
    %>
    <option value="<%= subjectName %>"><%= subjectName %></option>
    <% 
                addedSubjects.add(subjectName); // Add subject to set to prevent duplicates
            }
        }
    }
    %>
</select>

          
            <div class="btn-container">
                <button type="submit">Save</button>
                <button type="reset">Reset</button>
            </div>
        </form>
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

    function showAttendanceForm() {
        document.getElementById('attendance-form').style.display = 'flex';
        document.getElementById('semester-form').style.display = 'none';
        updateBackgroundImage();
    }

    function showSemesterForm() {
        document.getElementById('semester-form').style.display = 'flex';
        document.getElementById('attendance-form').style.display = 'none';
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
