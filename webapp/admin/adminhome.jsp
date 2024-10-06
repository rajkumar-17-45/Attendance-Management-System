<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@ page import="com.example.demo.FacultyList" %>
           <%@ page import="com.example.demo.Course" %>
                      <%@ page import="com.example.demo.Student" %>
                                           <%@ page import="com.example.demo.Subject" %>
                                           <%@ page import="com.example.demo.AssignFaculty" %>
                                           
        <%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>College Website</title>
    <link href="https://fonts.googleapis.com/css2?family=Martian+Mono:wght@300&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Martian+Mono:wght@300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="/admin/admincss.css" >
    <title>Document</title>
    <style>

    </style>
</head>
<body>
 
   <div id="header">
        <div id="logo">
            <img src="https://storage.googleapis.com/ezap-prod/colleges/4549/karpagam-college-of-engineering-logo.jpg" alt="Karpagam College of Engineering Logo">
        </div>
        <div id="date-time">
            <div id="current-time"></div>
            <div id="current-date"></div>
        </div>
    </div>

    <div class="main">
        <div class="sidebar">
            <div class="pages">Home</div>
            <div href="#" class="pages" id="faculty-details"  onclick="location.href='/admin/adminfaculty.jsp'" >Faculty</div>
            <div href="#" class="pages" id="student-details" onclick="location.href='/admin/adminstudent.jsp'">Student</div>
            <div href="#" class="pages" id="course-details"   onclick="location.href='/admin/admincourse.jsp'">Course</div>
            <div href="#" class="pages" id="subject-details" onclick="location.href='/admin/adminsubject.jsp'" >Subject</div>
            <div href="#" class="pages"  id="assign-faculty-details" onclick="location.href='/admin/adminassign.jsp'">Assign Faculty</div>
        </div>

        <div id="content">
            <div class="details" id="faculty-section">
                <div class="options" id="faculty-dis">
                    <div class="faculty">
                        <i class="fas fa-user-tie" id="faculty-icon"></i>
                    </div>
                    <div class="faculty-list-but">
                        <button  id="display-faculty-table">Faculty List</button>
                    </div>
                    <div class="add-faculty-but">
                        <button id="display-add-faculty">
                            <i class="fas fa-plus" id="plus"></i> Add Faculty
                        </button>
                    </div>
                    
                </div>
              <div id="faculty-content" class="scroll-stop">
    <h3>Faculty List</h3>    
    <form id="faculty-form" method="POST" data-save-url="/save-faculty" data-delete-url="/delete-faculty">
        <input type="hidden" name="action" id="form-action" value="">
        <table>
            <thead>
                <tr>
                    <th><input type="checkbox" id="select-all" class="select-check"></th>
                    <th>S.No</th>
                    <th>Name</th>
                    <th>Login</th>
                    <th>Mobile</th>
                    <th>Date</th>
                    <th>Gender</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Iterable<FacultyList> facultyList = (Iterable<FacultyList>) request.getAttribute("facultytable");
                    if (facultyList != null) {
                        for (FacultyList faculty : facultyList) {
                %>
                <tr>
                    <td><input type="checkbox" class="select-checkbox"></td>
                    <td>
                        <input type="number" name="id" class="sno-input" value="<%= faculty.getId() %>" readonly style="text-align: center;">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= faculty.getName() %></div>
                        <input type="hidden" name="name" class="multiline-input" value="<%= faculty.getName() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= faculty.getLoginid() %></div>
                        <input type="hidden" name="loginid" class="multiline-input" value="<%= faculty.getLoginid() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= faculty.getMobileno() %></div>
                        <input type="hidden" name="mobileno" class="multiline-input" value="<%= faculty.getMobileno() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= faculty.getDob() %></div>
                        <input type="hidden" name="dob" class="multiline-input" value="<%= faculty.getDob() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= faculty.getGender() %></div>
                        <input type="hidden" name="gender" class="multiline-input" value="<%= faculty.getGender() %>">
                    </td>
                    <td>
                        <button type="button" class="edit-btn">Edit</button>
                        <button type="button" class="delete-btn">Delete</button>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </form>
</div>
              
               
            
                <div class="add-faculty" id="add-faculty">
                    <h3>Add Faculty</h3>
                    <form action="addfaculty">
                             <label for="id">Id </label>
                            <input type="number" id="id" name="id" required>
                            
                            <label for="name">Name:</label>
                            <input type="text" id="name" name="name" required>
                            
                            <label for="login-id">Login ID:</label>
                            <input type="text" id="login-id" name="loginid" required>
                            
                            <label for="password">Password:</label>
                            <input type="password" id="password" name="password" required>
                            
                     
                            
                            <label for="gender">Gender:</label>
                            <select id="gender" name="gender" required>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                            
                            <label for="dob">Date of Birth:</label>
                            <input type="date" id="dob" name="dob" required>
                            
                            <label for="mobile">Mobile No:</label>
                            <input type="text" id="mobile" name="mobileno" required>
                            
                            <button type="submit">Save</button>
                            <button type="reset">Reset</button>
                        
                    </form>
                </div>
            </div>

            <div class="details" id="student-section">
                <div class="options" id="student-dis">
                    <div class="student">
                        <i class="fas fa-user-graduate" id="student-icon"></i>
                    </div>
                    <div class="student-list-but">
                        <button id="display-student-table">Student List</button>
                    </div>
                    <div class="add-student-but">
                        <button id="display-add-student">
                            <i class="fas fa-plus" id="plus"></i> Add Student
                        </button>
                    </div>
                </div>
                <div id="student-content" class="scroll-stop">
    <h3>Student List</h3>
    <form id="student-form" method="POST" data-save-url="/save-student" data-delete-url="/delete-student">
        <input type="hidden" name="action" id="student-form-action" value="">
        <table>
            <thead>
                <tr>
                    <th><input type="checkbox" id="select-all-student" class="select-check"></th>
                    <th>Roll no</th>
                    <th>Course Name</th>
                    <th>Semester</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>DOB</th>
                    <th>Gender</th>
                    <th>Mobile No</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% Iterable<Student> studentList = (Iterable<Student>) request.getAttribute("studenttable");
                if (studentList != null) {
                    for (Student student : studentList) { %>
                <tr>
                    <td><input type="checkbox" class="select-checkbox"></td>
                    <td><input type="text" name="rollno" class="sno-input" value="<%= student.getRollno() %>" readonly></td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= student.getCoursename() %> </div>
                        <input type="hidden" name="coursename" class="multiline-input" value="<%= student.getCoursename() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= student.getSemester() %> </div>
                        <input type="hidden" name="semester" class="multiline-input" value="<%= student.getSemester() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= student.getName() %></div>
                        <input type="hidden" name="name" class="multiline-input" value="<%= student.getName() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= student.getEmail() %></div>
                        <input type="hidden" name="email" class="multiline-input" value="<%= student.getEmail() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= student.getDob() %> </div>
                        <input type="hidden" name="dob" class="multiline-input" value="<%= student.getDob() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= student.getGender() %></div>
                        <input type="hidden" name="gender" class="multiline-input" value="<%= student.getGender() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= student.getMobileno() %></div>
                        <input type="hidden" name="mobileno" class="multiline-input" value="<%= student.getMobileno() %>">
                    </td>
                    <td>
                        <button type="button" class="edit-btn">Edit</button>
                        <button type="button" class="delete-btn">Delete</button>
                    </td>
                </tr>
                <% }} %>
            </tbody>
        </table>
    </form>
</div>

                
                <div class="add-student" id="add-student">
                    <h3>Add Student</h3>
                    <form action="addstudent">
                            <label for="roll-no">Roll No:</label>
                            <input type="text" id="rollno" name="rollno" required>
                            
                           <label for="coursename">Course Name:</label>
                        <select id="coursename" name="coursename" required>
                            <% Iterable<Course> courseList = (Iterable<Course>) request.getAttribute("coursetable");
            if (courseList != null) {
                for (Course course : courseList) {
            %>
            <option value="<%= course.getCoursename() %>" ><%= course.getCoursename() %></option>
            <% }
            } %>
                        </select>
                            
                            <label for="semester">Semester:</label>
                            <input type="number" id="semester" name="semester" required>
                            
                    
                            
                            <label for="name">Name:</label>
                            <input type="text" id="name" name="name" required>
                            
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" required>
                            
                            <label for="dob">Date of Birth:</label>
                            <input type="date" id="dob" name="dob" required>
                            
                            <label for="gender"
                            
                            
                            >Gender:</label>
                            <select id="gender" name="gender" required>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                            
                            <label for="mobileno">Mobile No:</label>
                            <input type="text" id="mobileno" name="mobileno" required>
                            
                            <button type="submit">Save</button>
                            <button type="reset">Reset</button>
                    </form>
                </div>
            </div>
            <div class="details" id="course-section" >
                <div class="options" id="course-dis">
                    <div class="course" >
                        <i class="fas fa-graduation-cap" id="course-icon"></i>
                    </div>
                    <div class="course-list-but"><button id="display-course-table" >Course List</button></div>
                    <div class="add-course-but"><button id="display-add-course" ><i class="fas fa-plus" id="plus"></i></button></div>
                </div>
               <div id="course-content" class="scroll-stop">
    <h3>Course List</h3>
    <form id="course-form" method="POST" data-save-url="/save-course" data-delete-url="/delete-course">
        <input type="hidden" name="action" id="course-form-action" value="">
        <table>
            <thead>
                <tr>
                    <th><input type="checkbox" id="select-all-course" class="select-check"></th>
                    <th>S.No</th>
                    <th>Course Name</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% Iterable<Course> courses = (Iterable<Course>) request.getAttribute("coursetable");
                if (courses != null) {
                    for (Course course : courses) { %>
                <tr>
                    <td><input type="checkbox" class="select-checkbox"></td>
                    <td><input type="text" name="id" class="sno-input" value="<%= course.getId() %>" readonly style="text-align: center;"></td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= course.getCoursename() %></div>
                        <input type="hidden" name="coursename" class="multiline-input" value="<%= course.getCoursename() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= course.getCoursedescription() %></div>
                        <input type="hidden" name="coursedescription" class="multiline-input" value="<%= course.getCoursedescription() %>">
                    </td>
                    <td>
                        <button type="button" class="edit-btn">Edit</button>
                        <button type="button" class="delete-btn">Delete</button>
                    </td>
                </tr>
                <% }} %>
            </tbody>
        </table>
    </form>
</div>

                <div class="add-course" id="add-course" >
                        <h3>Add Course</h3>
                        <form action="addcourse">
                           <label for="id">Course Id</label>
                            <input type="text" id="id" name="id" required>
                            <label for="course-name">Course Name:</label>
                            <input type="text" id="course-name" name="coursename" required>
                            
                            <label for="description">Description:</label>
                            <textarea id="description" name="coursedescription" rows="4" required></textarea>
                            <br><br>
                            <button type="submit">Save</button>
                            <button type="reset">Reset</button>
                        </form>
                    </div>
                    
                </div>
            </div>
            <div id="content">
                <div class="details" id="subject-section">
                    <div class="options" id="subject-dis">
                        <div class="subject">
                            <i class="fas fa-book" id="subject-icon"></i>
                        </div>
                        <div class="subject-list-but">
                            <button  id="display-subject-table">Subject List</button>
                        </div>
                        <div class="add-subject-but">
                            <button id="display-add-subject">
                                <i class="fas fa-plus" id="plus"></i> Add Subject
                            </button>
                        </div>
                    </div>
                   <div id="subject-content" class="scroll-stop">
        <h3>Subject List</h3>
        <form id="subject-form" method="POST" data-save-url="/save-subject" data-delete-url="/delete-subject">
            <input type="hidden" name="action" id="subject-form-action" value="">
            <table>
                <thead>
                    <tr>
                        <th><input type="checkbox" id="select-all-subjects" class="select-check"></th>
                        <th>S.No</th>
                        <th>Course Name</th>
                        <th>Semester</th>
                        <th>Subject</th>
                        <th>Description</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    Iterable<Subject> subjects = (Iterable<Subject>) request.getAttribute("subjecttable");
                    if (subjects != null) {
                        for (Subject subject : subjects) { 
                    %>
                    <tr data-subject-code="<%= subject.getSubjectCode() %>">
                        <td><input type="checkbox" class="select-checkbox"></td>
                        <td><input type="text" name="subjectCode" class="sno-input" value="<%= subject.getSubjectCode() %>" readonly style="text-align: center;"></td>
                        <td>
                            <div class="multiline-display" contenteditable="false"><%= subject.getCourseName() %></div>
                            <input type="hidden" name="courseName" class="multiline-input" value="<%= subject.getCourseName() %>">
                        </td>
                        <td>
                            <div class="multiline-display" contenteditable="false"><%= subject.getSemester() %></div>
                            <input type="hidden" name="semester" class="multiline-input" value="<%= subject.getSemester() %>">
                        </td>
                        <td>
                            <div class="multiline-display" contenteditable="false"><%= subject.getName() %></div>
                            <input type="hidden" name="name" class="multiline-input" value="<%= subject.getName() %>">
                        </td>
                        <td>
                            <div class="multiline-display" contenteditable="false"><%= subject.getDescription() %></div>
                            <input type="hidden" name="description" class="multiline-input" value="<%= subject.getDescription() %>">
                        </td>
                        <td>
                            <button type="button" class="edit-btn">Edit</button>
                            <button type="button" class="delete-btn">Delete</button>
                        </td>
                    </tr>
                    <% }} %>
                </tbody>
            </table>
        </form>
    </div>


                  <div class="add-subject" id="add-subject">
    <h3>Add Subject</h3>
    <form action="addsubject" method="post">
        <label for="subject-code">Subject Code:</label>
        <input type="text" id="subject-code" name="subjectCode" required>
        
        <label for="course-name">Course Name:</label>
        <select id="course-name" name="courseName" required>
            <%
                Iterable<Course> crs= (Iterable<Course>) request.getAttribute("coursetable");
                if (crs != null) {
                    for (Course course : crs) {
            %>
                        <option value="<%=course.getCoursename() %>" > <%= course.getCoursename() %></option>
            <%
                    }
                }
            %>
        </select>

        <label for="semester">Semester:</label>
        <select id="semester" name="semester" required>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
        </select>

        <label for="subject-name">Name:</label>
        <input type="text" id="name" name="name" required>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required></textarea>
        
        <br><br><br>
        <button type="submit">Save</button>
        <button type="reset">Reset</button>
    </form>
</div>
                  
                </div>
            </div>
            <div class="details" id="assign-faculty-section">
                <div class="options" id="assign-faculty-dis">
                    <div class="assign-faculty">
                        <i class="fas fa-chalkboard-teacher" id="assign-faculty-icon"></i>
                    </div>
                    <div class="assign-faculty-list-but">
                        <button id="display-assign-faculty-table">Assign Faculty List</button>
                    </div>
                    <div class="add-assign-faculty-but">
                        <button id="display-add-assign-faculty">
                            <i class="fas fa-plus" id="plus"></i> Add Assign Faculty
                        </button>
                    </div>
                </div>
                <div id="assign-faculty-content" class="scroll-stop">
    <h3>Assign Faculty List</h3>
    <form id="assign-faculty-form" method="POST" data-save-url="/save-assign-faculty" data-delete-url="/delete-assign-faculty">
        <input type="hidden" name="action" id="assign-faculty-form-action" value="">
        <table>
            <thead>
                <tr>
                    <th><input type="checkbox" id="select-all-assign-faculty" class="select-check"></th>
                    <th>S.No</th>
                    <th>Faculty Name</th>
                    <th>Course Name</th>
                    <th>Subject Name</th>
                    <th>Semester</th>
                    <th>Total Classes</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                Iterable<AssignFaculty> assignFacultyList = (Iterable<AssignFaculty>) request.getAttribute("assignfacultytable");
                Iterable<Subject> subject = (Iterable<Subject>) request.getAttribute("subjecttable");
                if (assignFacultyList != null) {
                    int sno = 1;
                    for (AssignFaculty assignFaculty : assignFacultyList) { 
                    	out.println(assignFaculty.getCourseName());
                        String semester = "";
                        for (Subject subject1 : subject) {
                            if (subject1.getName().equals(assignFaculty.getSubjectName())) {
                                semester = subject1.getSemester();
                                break;
                            }
                        }
                %>
                <tr data-faculty-name="<%= assignFaculty.getFacultyName() %>">
                    <td><input type="checkbox" class="select-checkbox"></td>
                    <td><input type="text"  class="sno-input" value="<%= sno++ %>" readonly style="text-align: center;"></td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= assignFaculty.getFacultyName() %></div>
                        <input type="hidden" name="facultyName" class="multiline-input" value="<%= assignFaculty.getFacultyName() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= assignFaculty.getCourseName() %></div>
                        <input type="hidden" name="courseName" class="multiline-input" value="<%= assignFaculty.getCourseName() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= assignFaculty.getSubjectName() %></div>
                        <input type="hidden" name="subjectName" class="multiline-input" value="<%= assignFaculty.getSubjectName() %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= semester %></div>
                        <input type="hidden" name="semester" class="multiline-input" value="<%= semester %>">
                    </td>
                    <td>
                        <div class="multiline-display" contenteditable="false"><%= assignFaculty.getTotalClasses() %></div>
                        <input type="hidden" name="totalClasses" class="multiline-input" value="<%= assignFaculty.getTotalClasses() %>">
                    </td>
                    <td>
                        <button type="button" class="edit-btn">Edit</button>
                        <button type="button" class="delete-btn">Delete</button>
                    </td>
                </tr>
                <% }} %>
            </tbody>
        </table>
    </form>
</div>

                
                <div class="add-assign-faculty" id="add-assign-faculty">
    <h3>Add Assign Faculty</h3>
    <form action="add-assignfaculty" method="POST"> <!-- Ensure correct action and method -->

        <!-- Faculty Name dropdown -->
        <label for="faculty-name">Faculty Name:</label>
        <select id="faculty-name" name="facultyName" required>
            <% 
            Iterable<FacultyList> fac = (Iterable<FacultyList>) request.getAttribute("facultytable");
            if (fac != null) {
                for (FacultyList faculty : facultyList) { %>
                    <option value="<%= faculty.getName() %>"><%= faculty.getName() %></option>
                <% }
            } %>
        </select>

        <!-- Course Name dropdown -->
        <label for="course-name">Course Name:</label>
        <select id="course-name" name="courseName" required>
            <% 
            Iterable<Course> course2 = (Iterable<Course>) request.getAttribute("coursetable");
            if (course2 != null) {
                for (Course course : course2) { %>
                    <option value="<%= course.getCoursename() %>"><%= course.getCoursename() %></option>
                <% }
            } %>
        </select>

        <!-- Subject Name dropdown -->
        <label for="subject-name">Subject Name:</label>
        <select id="subject-name" name="subjectName" required>
            <% 
            Iterable<Subject> subjectList = (Iterable<Subject>) request.getAttribute("subjecttable");
            if (subjectList != null) {
                for (Subject subject5 : subjectList) { %>
                    <option value="<%= subject5.getName() %>"><%= subject5.getName() %></option>
                <% }
            } %>
        </select>

        <!-- Total Classes input -->
        <label for="total-classes">Total Classes:</label>
        <input type="number" id="total-classes" name="totalClasses" required>

        <!-- Submit and Reset buttons -->
        <button type="submit">Save</button>
        <button type="reset">Reset</button>
    </form>
</div>

            </div>
            
        </div>
    </div>
    <script>
        function displayDateTime() {
            const now = new Date();

            let hours = now.getHours();
            const minutes = now.getMinutes().toString().padStart(2, '0');
            const seconds = now.getSeconds().toString().padStart(2, '0');
            const ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12;
            const timeString = `${hours.toString().padStart(2, '0')}:${minutes}:${seconds} ${ampm}`;
            document.getElementById('current-time').textContent = timeString;

            const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
            const dayName = days[now.getDay()];
            const day = now.getDate().toString().padStart(2, '0');
            const month = (now.getMonth() + 1).toString().padStart(2, '0');
            const year = now.getFullYear();
            const dateString = `${dayName}, ${day}/${month}/${year}`;
            document.getElementById('current-date').textContent = dateString;
        }

      setInterval(displayDateTime, 1000);
displayDateTime();
let check = 1;
let flag = 0;
let x=0;

document.addEventListener('click', function(event) {
    if (event.target.classList.contains('edit-btn')) {
        const row = event.target.closest('tr');
        const form = row.closest('form');
        const formAction = form.getAttribute('data-save-url');
        const divs = row.querySelectorAll('.multiline-display');
        const checkbox = row.querySelector('.select-checkbox');

        divs.forEach(div => {
            div.contentEditable = true;
            div.style.border = '1px solid black';
            div.style.borderRadius = '10px';
        });

        checkbox.checked = true;

        event.target.textContent = 'Save';
        event.target.classList.remove('edit-btn');
        event.target.classList.add('save-btn');
        event.target.dataset.originalText = 'Edit';
        event.target.type = 'button';  // Change button type to prevent form submission on click
    } else if (event.target.classList.contains('save-btn')) {
        const row = event.target.closest('tr');
        const form = row.closest('form');
        const formAction = form.getAttribute('data-save-url');
        const divs = row.querySelectorAll('.multiline-display');
        const inputs = row.querySelectorAll('.multiline-input');

        divs.forEach((div, index) => {
            div.contentEditable = false;
            div.style.border = '1px solid #ccc';
            inputs[index].value = div.textContent.trim();
        });

        const clonedRow = row.cloneNode(true);
        clonedRow.querySelectorAll('.edit-btn').forEach(btn => {
            btn.textContent = 'Edit';
            btn.classList.remove('save-btn');
            btn.classList.add('edit-btn');
            btn.type = 'button';  // Change button type to prevent form submission on click
        });

        const formClone = document.createElement('form');
        formClone.method = 'POST';
        formClone.action = formAction;

        clonedRow.querySelectorAll('.multiline-input, .sno-input').forEach(input => {
            const clonedInput = input.cloneNode(true);
            formClone.appendChild(clonedInput);
        });

        document.body.appendChild(formClone);
        formClone.submit();
    } else if (event.target.classList.contains('delete-btn')) {
        const row = event.target.closest('tr');
        const form = row.closest('form');
        const formAction = form.getAttribute('data-delete-url');

        const formDelete = document.createElement('form');
        formDelete.method = 'POST';
        formDelete.action = formAction;

        row.querySelectorAll('.multiline-input, .sno-input').forEach(input => {
            const clonedInput = input.cloneNode(true);
            formDelete.appendChild(clonedInput);
        });

        document.body.appendChild(formDelete);
        formDelete.submit();
    }
});

document.addEventListener('keydown', function(event) {
    if (event.target.classList.contains('multiline-display') && event.key === 'Enter') {
        event.preventDefault();
        event.target.blur();
    }
});

</script>
 
 
 

 
 
 
 
 
 
</body>
    
 
    
</html>